const express = require('express');
const router = express.Router();
const { getAllNewPlaces, createNewPlace } = require('../controllers/newPlacesController');

router.post("/createNewPlace", createNewPlace);
router.get("/getAllNewPlaces", getAllNewPlaces);


module.exports = router;