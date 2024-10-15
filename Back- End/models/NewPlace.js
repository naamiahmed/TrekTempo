const mongoose = require('mongoose');

const newPlaceSchema = new mongoose.Schema({

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
        required: false,
    },
    direction: {
        type: String,
        required: false,
    },
    description: {
        type: String,
        required: false,
    },
    images: {
        type: Array,
        required: false,
    },
});

const NewPlace = mongoose.model('NewPlace', newPlaceSchema);
module.exports = NewPlace;
