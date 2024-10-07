const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const router = express.Router();
const { getTripPlaces, createTripPlace } = require('../controllers/tripPlaceController');


router.post("/createTripPlace", createTripPlace);
router.get("/getTripPlaces/:district?", getTripPlaces);

module.exports = router;