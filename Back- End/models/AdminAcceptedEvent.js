const mongoose = require('mongoose');

const AcceptedEventSchema = new mongoose.Schema({

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

const acceptedevent = mongoose.model('acceptedevent', AcceptedEventSchema);
module.exports = acceptedevent;
