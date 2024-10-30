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

    const { name, tripPersonType, district, budget, tripType, location, locationLink, description, contact, dayCost } = req.body;
    const image = req.file ? `http://localhost:5000/uploads/ReqAccommodation/${req.file.filename}` : null;

    const newAccommodation = new ReqAccommodation({
      name,
      tripPersonType,
      tripType,
      district,
      budget,
      location,
      locationLink,
      images: image ? [image] : [],
      description,
      contact,
      dayCost,
    });

    await newAccommodation.save();
    res.status(201).json({ message: 'Accommodation added successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { addAccommodation, upload };