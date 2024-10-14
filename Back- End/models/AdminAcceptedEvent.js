const mongoose = require('mongoose');

const AcceptedEventSchema = new mongoose.Schema({

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
});

const acceptedevent = mongoose.model('acceptedevent', AcceptedEventSchema);
module.exports = acceptedevent;
