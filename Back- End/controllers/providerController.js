const Provider = require('../models/Provider');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const providerController = {
    signup: async (req, res) => {
        const { name, email, password } = req.body;

        try {
            let provider = await Provider.findOne({ email });
            if (provider) {
                return res.status(400).json({ msg: "Provider already exists" });
            }

            provider = new Provider({
                name,
                email,
                password: await bcrypt.hash(password, 10),
            });

            await provider.save();
            res.status(201).json({ msg: "Provider registered successfully" });
        } catch (err) {
            console.error(err);
            res.status(500).json({ msg: "Server error" });
        }
    },

    signin: async (req, res) => {
        const { email, password } = req.body;

        try {
            const provider = await Provider.findOne({ email });
            if (!provider) {
                return res.status(400).json({ msg: "Provider not found. Please Register before login" });
            }

            const isMatch = await bcrypt.compare(password, provider.password);
            if (!isMatch) {
                return res.status(400).json({ msg: "Invalid password. Please try again." });
            }

            const token = jwt.sign({ id: provider._id }, process.env.JWT_SECRET, {
                expiresIn: "1h",
            });

            res.json({ 
                provider: {
                    id: provider._id,
                    email: provider.email,
                    password: provider.password,
                }, 
                token 
            });
        } catch (err) {
            console.error(err);
            res.status(500).json({ msg: "Server error" });
        }
    }
};

module.exports = providerController;