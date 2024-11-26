// controllers/providerController.js
const Provider = require('../models/Provider');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

exports.signup = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    
    // Check if provider already exists
    const existingProvider = await Provider.findOne({ email });
    if (existingProvider) {
      return res.status(400).json({ message: 'Email already registered' });
    }

    // Create new provider
    const provider = new Provider({
      name,
      email,
      password
    });
    
    await provider.save();

    // Generate JWT token
    const token = jwt.sign(
      { providerId: provider._id },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.status(201).json({
      message: 'Provider registered successfully',
      token,
      provider: {
        id: provider._id,
        name: provider.name,
        email: provider.email
      }
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};

exports.signin = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find provider
    const provider = await Provider.findOne({ email });
    if (!provider) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Check password
    const isMatch = await bcrypt.compare(password, provider.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign(
      { providerId: provider._id },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({
      message: 'Logged in successfully',
      token,
      provider: {
        id: provider._id,
        name: provider.name,
        email: provider.email
      }
    });
  } catch (error) {
    res.status(500).json({ message: 'Server error', error: error.message });
  }
};