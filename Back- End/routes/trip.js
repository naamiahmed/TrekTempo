const express = require('express');
const router = express.Router();
const { createTripPlan, matchTripPlans } = require('../controllers/tripController');

// Create a trip plan
//router.post('/', createTripPlan);

// Match trip plans
router.post('/match', matchTripPlans);

module.exports = router;
