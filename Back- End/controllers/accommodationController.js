const Accommodation = require('../models/Accommodation');
const multer = require('multer');
const path = require('path');

// Set up multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/ReqAccommodation/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

const createAccommodation = async (req, res) => {
  try {
    const { name, description, phone, district, place, budget, locationLink, dayCost } = req.body;
    const image = req.file ? `http://localhost:5000/uploads/ReqAccommodation/${req.file.filename}` : null;

    const newAccommodation = new Accommodation({
      name,
      description,
      contact: phone,
      district,
      location: place,
      budget,
      locationLink,
      dayCost,
      images: image ? [image] : [],
    });

    await newAccommodation.save();
    res.send({ success: true, accommodation: newAccommodation });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

const getAccommodation = async (req, res) => {
  try {
    const data = req.body;
    const Accommodations = await Accommodation.find({ district: data.endPoint, budget: data.budget });
    return res.send({ success: true, Accommodations: Accommodations });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// Get Accommodation by district and budget
const getAccommodationByDistrictandBudget = async (req, res) => {
  try {
    const { district, budget } = req.params;
    let query = {};

    if (district) {
      query.district = { $regex: new RegExp("^" + district + "$", "i") };
    }
    if (budget) {
      query.budget = budget;
    }

    const accommodations = await Accommodation.find(query).sort({ name: 1 });
    return res.send({ success: true, accommodations: accommodations });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// Get all accommodations
const getAllAccommodations = async (req, res) => {
  try {
    const accommodations = await Accommodation.find().sort({ name: 1 });
    return res.send({ success: true, accommodations: accommodations });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

module.exports = { createAccommodation, getAccommodation, getAccommodationByDistrictandBudget, getAllAccommodations, upload };