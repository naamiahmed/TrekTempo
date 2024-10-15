const express = require('express');
const router = express.Router();
const { upload, createPlace, getPlaces, getAllPlaces, getOnePlace, deletePlace, handleLike, getOnePlaceById } = require('../controllers/placeController');

router.post("/createPlace", upload.array('images', 10), createPlace);
router.get("/getPlaces/:district?", getPlaces);
router.get("/getAllPlaces", getAllPlaces);
router.post("/getOnePlace", getOnePlace);
router.get("/getOnePlaceById/:placeId", getOnePlaceById);
router.post("/handleLike/:placeId", handleLike);
router.delete("/deletePlace/:id", deletePlace);

module.exports = router;