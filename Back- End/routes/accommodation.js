const express = require('express');
const router = express.Router();
const { createAccommodation, getAccommodation, getAccommodationByDistrictandBudget, getAllAccommodations,deleteAcceptedAccommodation, upload } = require('../controllers/accommodationController');

router.post("/createAccommodation", upload.single('image'), createAccommodation);
router.post("/getAccommodation", getAccommodation);
router.get("/getAccommodation/:district?/:budget?", getAccommodationByDistrictandBudget);
router.get("/getAllAccommodations", getAllAccommodations);
router.delete("/deleteAcceptedAccommodation/:id", deleteAcceptedAccommodation);
module.exports = router;