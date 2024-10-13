const mongoose = require('mongoose');

const EventSchema = new mongoose.Schema({

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
    date:{
        type: Date,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    images: {
        type: Array,
        required: true,
    },
    locationLink: {
        type: String,
        required: false,
    },
});

const event = mongoose.model('event', EventSchema);
module.exports = event;
