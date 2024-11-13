const Place = require('../models/Place');
const multer = require('multer');
const path = require('path');
const mongoose = require('mongoose');

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/places/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});
const upload = multer({ storage: storage });

// Upload new place entries in the database
const createPlace = async (req, res) => {
  try {
    const { district, city, name, location, direction, description } = req.body;
    const images = req.files.map(file => `http://localhost:5000/uploads/places/${file.filename}`);

    const newPlace = new Place({
      district,
      city,
      name,
      location,
      direction,
      description,
      images,
    });

    await newPlace.save();
    res.status(201).json({ message: 'Place created successfully!', place: newPlace });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// get places by district
const getPlaces = async (req, res) => {
  try {
    const district = req.params.district;
    if (district) {
      //ensure case-insensitive and exact matches and sort by name
      const places = await Place.find({
        district: { $regex: new RegExp("^" + district + "$", "i") },
      }).sort({ name: 1 });
      return res.send({ success: true, places: places });
    }
    // If no district is provided, return all places
    const places = await Place.find();
    res.send({ success: true, places: places });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// get one place from the database
const getOnePlace = async (req, res) => {
  try {
    const placeName = req.body.placeName;
    if (!placeName) {
      res.send({ success: false, message: "Place Name Required" });
    }
    const place = await Place.findOne({ name: placeName });
    res.send({ success: true, place: place });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// get one place by id
const getOnePlaceById = async (req, res) => {
  try {
    const placeId = req.params.placeId;
    if (!placeId) {
      res.send({ success: false, message: "Place ID Required" });
    }
    const place = await Place.findOne({ _id: placeId });
    res.send({ success: true, place: place });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// Like a place
const handleLike = async (req, res) => {
  try {
    const placeId = req.params.placeId;
    const userId = req.body.userId;

    const place = await Place.findOne({ _id: placeId });

    if (!place) {
      return res.status(404).json({ success: false, message: 'Place not found' });
    }

    const objectIdUserId = new mongoose.Types.ObjectId(userId);

    if (place.likedBy.some(id => id.equals(objectIdUserId))) {
      place.likedBy = place.likedBy.filter(id => !id.equals(objectIdUserId));
    } else {
      place.likedBy.push(objectIdUserId);
    }

    place.likes = place.likedBy.length;

    await place.save();

    const updatedPlace = await Place.findOne({ _id: placeId });
    res.status(200).json({ success: true, place: updatedPlace });

  } catch (error) {
    console.log('error: ', error);
    res.status(500).json({ success: false, message: error.message });
  }
};

// Most Liked Places
const getTopPlaces = async (req, res) => {
  try {
    const topPlaces = await Place.find().sort({ likes: -1 }).limit(5);
    res.send({ success: true, places: topPlaces });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// Get all places
const getAllPlaces = async (req, res) => {
  try {
    const tripPlaces = await Place.find().sort({ name: 1 });
    if (tripPlaces.length === 0) {
      return res.send({
        success: false,
        message: `No places found in ${district}.`,
      });
    }
    return res.send({ success: true, places: tripPlaces });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// Delete place
const deletePlace = async (req, res) => {
  try {
    const place = await Place.findByIdAndDelete(req.params.id);
    if (!place) {
      return res.status(404).json({ success: false, message: 'Place not found' });
    }
    res.json({ success: true, message: 'Place deleted successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

module.exports = { upload, createPlace, getPlaces, getOnePlace, getAllPlaces, deletePlace, handleLike, getTopPlaces, getOnePlaceById };
