const AdminUser = require('../models/AdminUser');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const signUp = async (req, res) => {
    const { name, email, password, address, profilePicURL } = req.body;
  
    try {
      // Check if admin user already exists
      let adminUser = await AdminUser.findOne({ email });
      if (adminUser) {
        return res.status(400).json({ msg: "Admin user already exists" });
      }
  
      // Create new admin user
      adminUser = new AdminUser({
        name,
        email,
        password: await bcrypt.hash(password, 10), // Hash password
        address,
        profilePicURL
      });
  
      await adminUser.save();
      res.status(201).json({ msg: "Admin user registered successfully" });
    } catch (err) {
      res.status(500).json({ msg: "Server error" });
    }
  };



const signIn = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check for admin user
    const adminUser = await AdminUser.findOne({ email });
    if (!adminUser) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }

    // Compare passwords
    const isMatch = await bcrypt.compare(password, adminUser.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }

    // Generate JWT
    const token = jwt.sign({ id: adminUser._id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });
    res.json({ adminUser: adminUser, token: token });
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
};

module.exports = { signIn ,signUp };