// routes/providerRoutes.js
const express = require('express');
const router = express.Router();
const providerController = require('../controllers/providerController');

router.post('/signup', providerController.signup);
router.post('/signin', providerController.signin);

module.exports = router;