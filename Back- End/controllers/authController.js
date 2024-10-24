const User = require('../models/User');
const multer = require('multer');
const path = require('path');
const mongoose = require('mongoose');

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/users/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

const getProfile = async (req, res) => {
  try {
    const userId = req.params.userId;
    if (!userId) {
      res.send({ success: false, message: "User ID Required" });
    }
    const user = await User.findOne({ _id: userId });
    res.send({ success: true, user: user });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

const updateProfilePicture = async (req, res) => {
  try {
    const userId = req.params.userId;
    if (!userId) {
      return res.status(400).json({ success: false, message: "User ID Required" });
    }

    if (!req.file) {
      return res.status(400).json({ success: false, message: "No file uploaded" });
    }

    const user = await User.findByIdAndUpdate(
      userId,
      { profilePicURL: `http://localhost:5000/uploads/users/${req.file.filename}` },
      { new: true }
    );

    if (!user) {
      return res.status(404).json({ success: false, message: "User not found" });
    }

    res.json({ success: true, user });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { getProfile, updateProfilePicture, upload };
