const express = require('express');
const router = express.Router();
const providerController = require('../controllers/providerController');

// Auth routes
router.post('/providersignup', providerController.signup);
router.post('/providersignin', providerController.signin);

module.exports = router;