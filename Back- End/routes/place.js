const express = require('express');
const router = express.Router();
const { createPlace, getPlaces, getOnePlace } = require('../controllers/placeController');

router.post("/createPlace", createPlace);
router.get("/getPlaces/:district?", getPlaces);
router.post("/getOnePlace", getOnePlace);






module.exports = router;