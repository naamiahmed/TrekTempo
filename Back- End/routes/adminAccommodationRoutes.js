const express = require('express');
const router = express.Router();
const { getAllReqAccommodations, deleteAccommodation, moveAccommodationToAccepted } = require('../controllers/adminAccommodationController');

router.get("/getAllReqAccommodations", getAllReqAccommodations);
router.delete("/deleteAccommodation/:id", deleteAccommodation);
router.post("/moveAccommodationToAccepted/:id", moveAccommodationToAccepted);

module.exports = router;