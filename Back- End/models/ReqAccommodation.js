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
        required: true,
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
        required: true,
    },
    contact: {
        type: String,
        required: true,
    },
    dayCost: {
        type: Number,
        required: true,
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    }, 
});

const ReqAccommodation = mongoose.model('ReqAccommodation', ReqAccommodationSchema);
module.exports = ReqAccommodation;