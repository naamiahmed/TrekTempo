const NewPlace = require("../models/NewPlace");
const multer = require('multer');
const path = require('path');

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/request_places_images/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

// user Creating new place entries in the database
const createNewPlace = async (req, res) => {
  try {
    const { district, city, name, location, direction, description } = req.body;
    const images = req.files.map(file => `http://localhost:5000/uploads/request_places_images/${file.filename}`);

    const newPlace = new NewPlace({
      district,
      city,
      name,
      location,
      direction,
      description,
      images,
    });

    await newPlace.save();
    res.status(201).json({ message: 'New place created successfully!', place: newPlace });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get all new places
const getAllNewPlaces = async (req, res) => {
  try {
    const newPlaces = await NewPlace.find().sort({ name: 1 });
    if (newPlaces.length === 0) {
      return res.send({
        success: false,
        message: `No New places found.`,
      });
    }
    return res.send({ success: true, places: newPlaces });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// Delete Request place
const deleteRequestPlace = async (req, res) => {
  try {
    const requestedPlace = await NewPlace.findByIdAndDelete(req.params.id);
    if (!requestedPlace) {
      return res.status(404).json({ success: false, message: 'Place not found' });
    }
    res.json({ success: true, message: 'Requested Place deleted successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Add this function to newPlacesController.js
const getPlaceCount = async (req, res) => {
  try {
      const count = await NewPlace.countDocuments();
      res.json({ success: true, count });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
};


module.exports = { upload, createNewPlace, getAllNewPlaces, deleteRequestPlace, getPlaceCount };