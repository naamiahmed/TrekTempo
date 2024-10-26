const nodemailer = require('nodemailer');
const User = require('../models/User'); // Adjust the path as necessary
require('dotenv').config();
const multer = require('multer');
const path = require('path');

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

// Configure Nodemailer
const transporter = nodemailer.createTransport({
  service: 'gmail',
  host: 'smtp.gmail.com',
  port: 587,
  secure: false,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
  tls: {
    rejectUnauthorized: false,
  },
});

const getProfile = async (req, res) => {
  try {
    const userId = req.params.userId;
    if (!userId) {
      return res.status(400).json({ success: false, message: "User ID Required" });
    }
    const user = await User.findOne({ _id: userId });
    res.json({ success: true, user: user });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
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

// Send OTP to user's email for password reset
const sendOtp = async (req, res) => {
  const { email } = req.body;

  try {
    console.log('Email:', email);

    // Generate a 4-digit OTP
    const otp = Math.floor(1000 + Math.random() * 9000).toString();
    const otpExpiry = Date.now() + 10 * 60 * 1000;

    // Find user and update OTP fields
    const user = await User.findOneAndUpdate(
      { email },
      { otp, otpExpiry },
      { new: true }
    );

    if (!user) {
      return res.status(404).json({ success: false, message: "User not found" });
    }

    console.log('User found:', user);

    // Email the OTP to the user
    const mailOptions = {
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Your OTP for Password Reset",
      text: `Your OTP is ${otp}. It is valid for 10 minutes.`,
    };

    await transporter.sendMail(mailOptions);
    res.status(200).json({ success: true, message: "OTP sent to email" });
  } catch (error) {
    console.error('Error sending OTP:', error);
    res.status(500).json({ success: false, message: "Error sending OTP", error: error.message });
  }
};

// Verify OTP for password reset
const verifyOtp = async (req, res) => {
  const { email, otp } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ success: false, message: "User not found" });
    }

    // Check if OTP matches and is within the expiry time
    if (user.otp === otp && user.otpExpiry > Date.now()) {
      user.otp = null;
      user.otpExpiry = null;
      await user.save();
      res.status(200).json({ success: true, message: "OTP verified" });
    } else {
      res.status(400).json({ success: false, message: "Invalid or expired OTP" });
    }
  } catch (error) {
    res.status(500).json({ success: false, message: "Error verifying OTP", error: error.message });
  }
};

module.exports = { getProfile, updateProfilePicture, upload, sendOtp, verifyOtp };