const mongoose = require('mongoose');

const placeSchema = new mongoose.Schema({

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
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    images: {
        type: Array,
        required: false,
    },
});

const Place = mongoose.model('Place', placeSchema);
module.exports = Place;
