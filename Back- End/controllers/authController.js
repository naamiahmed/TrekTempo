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


module.exports = { getProfile };
