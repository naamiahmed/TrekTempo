const nodemailer = require('nodemailer');
const User = require('../models/User'); // Adjust the path as necessary
require('dotenv').config();
const multer = require('multer');
const path = require('path');
const bcrypt = require('bcryptjs');

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
  debug: true, // Enable debug logs
  logger: true // Enable logger
});

// Verify transporter connection
transporter.verify(function(error, success) {
  if (error) {
    console.log('SMTP connection error:', error);
  } else {
    console.log('SMTP server is ready to take our messages');
  }
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

    // Find user and update OTP fields
    const user = await User.findOneAndUpdate(
      { email },
      { otp, otpUsed: false },
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
      text: `Your OTP is ${otp}. It is valid for one-time use.`,
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

    // Check if OTP matches and is not used
    if (user.otp === otp && !user.otpUsed) {
      user.otp = null; // Mark OTP as used
      user.otpUsed = true;
      await user.save();
      res.status(200).json({ success: true, message: "OTP verified" });
    } else {
      res.status(400).json({ success: false, message: "Invalid or expired OTP" });
    }
  } catch (error) {
    res.status(500).json({ success: false, message: "Error verifying OTP", error: error.message });
  }
};

// Reset Password
const resetPassword = async (req, res) => {
  const { email, newPassword } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: 'Email not found' });
    }

    user.password = await bcrypt.hash(newPassword, 10);
    user.otp = null;
    await user.save();

    res.status(200).json({ message: 'Password has been reset successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error resetting password' });
  }
};

// Temporary storage for signup OTPs (in production, use Redis or similar)
const signupOTPs = new Map();

const sendSignUpOTP = async (req, res) => {
  const { email } = req.body;

  try {
    // Check if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ success: false, message: "User already exists" });
    }

    // Generate a 4-digit OTP
    const otp = Math.floor(1000 + Math.random() * 9000).toString();
    
    // Store OTP with expiry timestamp (5 minutes from now)
    const expiryTime = new Date(Date.now() + 5 * 60 * 1000).getTime();
    signupOTPs.set(email, {
      otp,
      expiryTime
    });

    const mailOptions = {
      from: process.env.EMAIL_USER,
      to: email,
      subject: "Verify Your Email",
      text: `Your verification code is ${otp}. Valid for 5 minutes from ${new Date().toLocaleString()}.`,
    };

    const info = await transporter.sendMail(mailOptions);
    
    if (info && info.messageId) {
      console.log('Email sent successfully:', info);
      return res.status(200).json({ 
        success: true, 
        message: "OTP sent successfully",
        emailInfo: {
          messageId: info.messageId,
          accepted: info.accepted,
          sentAt: new Date().toISOString()
        }
      });
    } else {
      throw new Error('Email sending failed - no message ID received');
    }
    
  } catch (error) {
    console.error('Error in sendSignUpOTP:', error);
    return res.status(500).json({ 
      success: false, 
      message: "Error sending OTP", 
      error: error.message 
    });
  }
};

const verifySignUpOTP = async (req, res) => {
  const { email, otp } = req.body;

  try {
    const storedData = signupOTPs.get(email);
    
    if (!storedData) {
      return res.status(400).json({ success: false, message: "OTP not found" });
    }

    const currentTime = Date.now();
    
    // Check if OTP has expired
    if (currentTime > storedData.expiryTime) {
      signupOTPs.delete(email);
      return res.status(400).json({ 
        success: false, 
        message: "OTP has expired",
        expiredAt: new Date(storedData.expiryTime).toISOString(),
        currentTime: new Date(currentTime).toISOString()
      });
    }

    if (storedData.otp === otp) {
      signupOTPs.delete(email); // Remove used OTP
      res.status(200).json({ success: true, message: "OTP verified successfully" });
    } else {
      res.status(400).json({ success: false, message: "Invalid OTP" });
    }
  } catch (error) {
    res.status(500).json({ success: false, message: "Error verifying OTP" });
  }
};

const getUserCount = async (req, res) => {
  try {
    const count = await User.countDocuments();
    res.json({ success: true, count });
  } catch (error) {
    res.status(500).json({ 
      success: false, 
      message: "Error getting user count",
      error: error.message 
    });
  }
};

const updateBio = async (req, res) => {
  try {
      const userId = req.params.userId;
      const { bio } = req.body;

      if (!userId) {
          return res.status(400).json({ success: false, message: "User ID Required" });
      }

      const user = await User.findByIdAndUpdate(
          userId,
          { bio },
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

const changePassword = async (req, res) => {
  try {
    const userId = req.params.userId;
    const { currentPassword, newPassword } = req.body;

    // Find user
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ success: false, message: "User not found" });
    }

    // Verify current password
    const isMatch = await bcrypt.compare(currentPassword, user.password);
    if (!isMatch) {
      return res.status(400).json({ success: false, message: "Current password is incorrect" });
    }

    // Hash new password and update
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    user.password = hashedPassword;
    await user.save();

    res.json({ success: true, message: "Password updated successfully" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { getProfile, updateProfilePicture, upload, sendOtp, verifyOtp, resetPassword, sendSignUpOTP, verifySignUpOTP , getUserCount , updateBio , changePassword};