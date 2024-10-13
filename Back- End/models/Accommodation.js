const mongoose = require('mongoose');

const AccommodationSchema = new mongoose.Schema({

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

    location: {
        type: String,
        required: true
    },
    images: {
        type: Array,
        required: false,
    },
    weather: {
        type: String,
        required: false,
    },
    budget: {
        type: String,
        required: false,
    },
    tripPersonType: {
        type: String,
        required: false,
    },
    tripType: {
        type: String,
        required: false,
    },
    locationLink: {
        type: String,
        required: false,
    },
});

const Accommodation = mongoose.model('Accommodation', AccommodationSchema);
module.exports = Accommodation;