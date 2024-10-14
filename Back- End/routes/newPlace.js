const express = require('express');
const router = express.Router();
const { getAllNewPlaces, createNewPlace, deleteRequestPlace } = require('../controllers/newPlacesController');

router.post("/createNewPlace", createNewPlace);
router.get("/getAllNewPlaces", getAllNewPlaces);
router.delete("/deleteRequestPlaces/:id", deleteRequestPlace);


module.exports = router;