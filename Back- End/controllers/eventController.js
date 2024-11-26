const Event = require("../models/Event");
const multer = require("multer");
const path = require("path");

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/ReqEvent/");
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

const addEvent = async (req, res) => {
  try {
    console.log("Request Body:", req.body);
    console.log("Request File:", req.file);

    const { title, phone, district, place, date, location, description } =
      req.body;
    const dateRange = req.body.dateRange;
    const imageUrl = req.file
      ? `http://192.168.1.5:5000/uploads/ReqEvent/${req.file.filename}`
      : null;

    const newEvent = new Event({
      title,
      phone,
      district,
      place,
      location,
      imageUrl,
      description,
      date: date ? new Date(date) : undefined,
      dateRange: dateRange
        ? {
            start: new Date(dateRange.start),
            end: new Date(dateRange.end),
          }
        : undefined,
    });

    await newEvent.save();
    res.status(201).json({ message: "Event added successfully!" });
  } catch (error) {
    // console.log('Error:', error.message);
    res.status(500).json({ error: error.message });
  }
};

module.exports = { addEvent, upload };
