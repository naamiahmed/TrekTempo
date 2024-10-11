const mongoose = require('mongoose');

const placeSchema = new mongoose.Schema({

    district: {
        type: String,
        required: true,
    },
    city: {
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
    direction: {
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
});

const Place = mongoose.model('Place', placeSchema);
module.exports = Place;
