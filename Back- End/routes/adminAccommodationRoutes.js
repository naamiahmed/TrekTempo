const express = require('express');
const router = express.Router();
const { getAllAccommodations, deleteAccommodation, moveAccommodationToAccepted } = require('../controllers/adminAccommodationController');

router.get("/getAllAccommodations", getAllAccommodations);
router.delete("/deleteAccommodation/:id", deleteAccommodation);
router.post("/moveAccommodationToAccepted/:id", moveAccommodationToAccepted);

module.exports = router;