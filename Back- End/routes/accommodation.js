const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const router = express.Router();
const {createAccommodation, getAccommodation, getAccommodationByDistrictandBudget } = require('../controllers/accommodationController');


router.post("/createAccommodation", createAccommodation);
router.post("/getAccommodation", getAccommodation);
router.get("/getAccommodation/:district?/:budget?", getAccommodationByDistrictandBudget);


module.exports = router;