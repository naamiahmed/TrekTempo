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
      description: {  // Updated field name
        type: String,
        required: false,
      },
});

const event = mongoose.model('event', EventSchema);
module.exports = event;
