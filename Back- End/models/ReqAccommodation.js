const mongoose = require('mongoose');

const ReqAccommodationSchema = new mongoose.Schema({

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
        required: false,
    },
    images: {
        type: Array,
        required: true,
    },
    budget: {
        type: String,
        required: true,
    },
    locationLink: {
        type: String,
        required: false,
    },
});

const ReqAccommodation = mongoose.model('ReqAccommodation', ReqAccommodationSchema);
module.exports = ReqAccommodation;