const multer = require('multer');
const path = require('path');
const AcceptedEvent = require("../models/AdminAcceptedEvent");
const Event = require('../models/AdminEvent');
const Notification = require('../models/Notification');

// Set up Multer storage and file filter
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/ReqEvent/');
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const fileFilter = (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
    if (allowedTypes.includes(file.mimetype)) {
        cb(null, true);
    } else {
        cb(new Error('Only JPEG, JPG, and PNG files are allowed'), false);
    }
};

const upload = multer({ storage, fileFilter });

const createAcceptedEvent = async (req, res) => {
    try {
        const { title, phone, district, place, location, date, description, dateRange } = req.body;
        const imageUrl = req.file ? `http://localhost:5000/uploads/ReqEvent/${req.file.filename}` : '';

        const newAcceptedEvent = new AcceptedEvent({
            title,
            phone,
            district,
            place,
            location,
            date,
            imageUrl,
            description,
            dateRange
        });

        await newAcceptedEvent.save();

        res.status(201).json({ success: true, message: 'Accepted event created successfully', event: newAcceptedEvent });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};


// Function to move the document
const moveEventToAccepted = async (req, res) => {
    const eventId = req.params.id;
  
    try {
      const event = await Event.findById(eventId);
  
      if (!event) {
        return res.status(404).json({ msg: 'Event not found' });
      }
  
      const acceptedEvent = new AcceptedEvent(event.toObject());
      await acceptedEvent.save();
  
      await Event.findByIdAndDelete(eventId);
  
      const notification = new Notification({
        userId: event.userId,
        title: event.title,
        subtitle: 'Your event has been accepted',
        time: new Date().toLocaleString()
      });
      await notification.save();
  
      res.status(200).json({ msg: 'Event moved to AcceptedEvent successfully' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

const createAllAcceptedEvents = async (req, res) => {
    try {
        const AcceptedEventData = req.body;
        const AcceptedEvents = await AcceptedEvent.insertMany(AcceptedEventData);
        res.send({ success: true, AcceptedEvent: AcceptedEvents });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

const getAllAcceptedEvents = async (req, res) => {
    try {
        const events = await AcceptedEvent.find().sort({ name: 1 });
        if (events.length === 0) {
            return res.send({
                success: false,
                message: `No places found in ${district}.`,
            });
        }
        return res.send({ success: true, events: events });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

const deleteAcceptedEvent = async (req, res) => {
    try {
        const event = await AcceptedEvent.findByIdAndDelete(req.params.id);
        if (!event) {
            return res.status(404).json({ success: false, message: 'Event not found' });
        }
        res.json({ success: true, message: 'Event deleted successfully' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Server error' });
    }
};

// Add this function in adminAcceptedEventController.js after the existing imports
const getEventCount = async (req, res) => {
    try {
        const count = await Event.countDocuments();
        res.json({ success: true, count });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

module.exports = { getAllAcceptedEvents, deleteAcceptedEvent, createAllAcceptedEvents, moveEventToAccepted, createAcceptedEvent, upload, getEventCount

 };