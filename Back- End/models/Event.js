const mongoose = require('mongoose');

const eventSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    required: true,
  },
  location: {
    type: String,
    required: false,
  },
  imageUrl: {
    type: String,
    required: false,
  },
});

const Event = mongoose.model('Event', eventSchema);

module.exports = Event;