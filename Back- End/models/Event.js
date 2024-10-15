const mongoose = require('mongoose');

const EventSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  district: {
    type: String,
    required: true,
  },
  place: {
    type: String,
    required: true,
  },
  location: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    required: true,
  },
  imageUrl: {
    type: String,
    required: false,
  },
  description: {  // Ensure this field is present
    type: String,
    required: false,
  },
});

const Event = mongoose.model('Event', EventSchema);

module.exports = Event;