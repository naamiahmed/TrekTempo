const express = require('express');
const router = express.Router();
const { upload, getAllNewPlaces, createNewPlace, deleteRequestPlace,getPlaceCount } = require('../controllers/newPlacesController');

router.post("/createNewPlace", upload.array('images', 10), createNewPlace);
router.get("/getAllNewPlaces", getAllNewPlaces);
router.delete("/deleteRequestPlaces/:id", deleteRequestPlace);
router.get("/getPlaceCount", getPlaceCount);

module.exports = router;