const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const router = express.Router();
const { getTripPlaces, createTripPlace ,getOnetripPlace } = require('../controllers/tripPlaceController');


router.post("/createTripPlace", createTripPlace);
router.post("/getTripPlaces", getTripPlaces);
router.post("/getOneTripPlace", getOnetripPlace);

module.exports = router;