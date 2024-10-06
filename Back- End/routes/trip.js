const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const router = express.Router();
const { getTripPlaces } = require('../controllers/tripController');

router.get("/getTripPlaces/:district?", getTripPlaces);

module.exports = router;
