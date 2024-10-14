const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Sign Up
router.post('/signup', userController.signUp);

// Sign In
router.post('/signin', userController.signIn);

// Update User Details
router.put('/update', userController.updateUser);

module.exports = router;