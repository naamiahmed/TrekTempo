const ReqAccommodation = require('../models/ReqAccommodation');
const multer = require('multer');
const path = require('path');

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/ReqAccommodation/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

const addAccommodation = async (req, res) => {
  try {
    console.log('Request Body:', req.body);
    console.log('Request File:', req.file);

    const { name, district, budget, location, locationLink, description, contact, dayCost , userId} = req.body;
    const image = req.file ? `http://localhost:5000/uploads/ReqAccommodation/${req.file.filename}` : null;

    const newAccommodation = new ReqAccommodation({
      name,
      district,
      budget,
      location,
      locationLink,
      images: image ? [image] : [],
      description,
      contact,
      dayCost,
      userId,
    });

    await newAccommodation.save();
    res.status(201).json({ message: 'Accommodation added successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Add this new function to reqAccommodationController.js
const getAccommodationCount = async (req, res) => {
  try {
      const count = await ReqAccommodation.countDocuments();
      res.json({ success: true, count });
  } catch (error) {
      res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { addAccommodation, upload, getAccommodationCount };