const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const router = express.Router();
const { createPlace, getPlaces, getOnePlace } = require('../controllers/placeController');

router.post("/createPlace", createPlace);
router.get("/getPlaces/:district?", getPlaces);
router.post("/getOnePlace", getOnePlace);






module.exports = router;