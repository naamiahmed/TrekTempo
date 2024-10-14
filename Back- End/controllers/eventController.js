const Event = require('../models/event');
const multer = require('multer');
const path = require('path');

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/ReqEvent/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

const addEvent = async (req, res) => {
  try {
    console.log('Request Body:', req.body);
    console.log('Request File:', req.file);

    const { title, phone, district, place, date, location } = req.body;
    const imageUrl = req.file ? `http://localhost:5000/uploads/ReqEvent/${req.file.filename}` : null;

    const newEvent = new Event({
      title,
      phone,
      district,
      place,
      date,
      location,
      imageUrl,
    });

    await newEvent.save();
    res.status(201).json({ message: 'Event added successfully!' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { addEvent, upload };