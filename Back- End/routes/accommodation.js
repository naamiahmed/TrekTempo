const express = require('express');
const router = express.Router();
const { createAccommodation, getAccommodation, getAccommodationByDistrictandBudget, upload } = require('../controllers/accommodationController');

router.post("/createAccommodation", upload.single('image'), createAccommodation);
router.post("/getAccommodation", getAccommodation);
router.get("/getAccommodation/:district?/:budget?", getAccommodationByDistrictandBudget);

module.exports = router;