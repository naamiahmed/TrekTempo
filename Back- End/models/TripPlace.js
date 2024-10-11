const mongoose = require('mongoose');

const tripplaceSchema = new mongoose.Schema({

    district: {
        type: String,
        required: true,
    },
    name: {
        type: String,
        required: true,
    },
    location: {
        type: String,
        required: true,
    },
    likes: {
        type: Number,
        default: 0,
    },
    description: {
        type: String,
        required: true,
    },
    images: {
        type: Array,
        required: true,
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

const TripPlace = mongoose.model('TripPlace', tripplaceSchema);
module.exports = TripPlace;
