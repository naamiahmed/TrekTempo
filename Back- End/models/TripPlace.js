const mongoose = require('mongoose');

const TripPlaceSchema = new mongoose.Schema({

    district: {
        type: String,
        required: true,
    },
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    weather: {
        type: String,
        required: true
    },
    locationLink: {
            type: String,
            required: true
    },
    images: {
        type: Array,
        required: false,
    },
});

const TripPlace = mongoose.model('TripPlace', TripPlaceSchema);
module.exports = TripPlace;