const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/User");
const router = express.Router();
const { 
  getProfile, 
  updateProfilePicture, 
  upload, 
  sendOtp, 
  verifyOtp, 
  resetPassword,
  sendSignUpOTP,
  verifySignUpOTP 
} = require("../controllers/authController");



// Sign Up
router.post("/signup", async (req, res) => {
  const { name, email, password } = req.body;

  try {
    let user = await User.findOne({ email });
    if (user) {
      return res.status(400).json({ msg: "User already exists" });
    }

    user = new User({
      name,
      email,
      password: await bcrypt.hash(password, 10),
    });

    await user.save();
    res.status(201).json({ msg: "User registered successfully" });
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});

// Sign In
router.post("/signin", async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check for user
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }

    // Compare passwords
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Invalid credentials" });
    }

    // Generate JWT
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });
    res.json({ user: user, token: token });
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});

// Get user profile
router.get("/getProfile/:userId", getProfile);
router.post("/updateProfilePicture/:userId", upload.single('profilePic'), updateProfilePicture);

router.post('/sendOtp', sendOtp);
router.post('/verifyOtp', verifyOtp);
router.post('/resetPassword', resetPassword);

// Add new routes before the signup route
router.post("/send-signup-otp", sendSignUpOTP);
router.post("/verify-signup-otp", verifySignUpOTP);


module.exports = router;
