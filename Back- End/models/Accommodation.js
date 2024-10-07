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

    locationLink: {
        type: String,
        required: true
    },
    images: {
        type: Array,
        required: false,
    },
});

const Accommodation = mongoose.model('Accommodation', AccommodationSchema);
module.exports = Accommodation;