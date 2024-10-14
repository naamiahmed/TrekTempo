const express = require('express');
const router = express.Router();
const { createPlace, getPlaces, getAllPlaces, getOnePlace, deletePlace } = require('../controllers/placeController');

router.post("/createPlace", createPlace);
router.get("/getPlaces/:district?", getPlaces);
router.get("/getAllPlaces", getAllPlaces);
router.post("/getOnePlace", getOnePlace);
router.delete("/deletePlace/:id", deletePlace);


module.exports = router;