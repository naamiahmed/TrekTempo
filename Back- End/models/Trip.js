const mongoose = require('mongoose');

const tripSchema = new mongoose.Schema({
    name: {
        type: String,
        required: false,
    },
    starting_point: {
        type: String,
        required: true,
    },
    ending_point: {
        type: String,
        required: true,
    },
    budget: {
        type: String,
        required: true,
    },
    trip_person_type: {
        type: String,
        required: true,
    },
    trip_type: {
        type: String,
        required: true,
    },
    trip_duration: {
        type: Number,
        required: true,
    },
    intrested_in: {
        type: String,
        required: true,
    },
});

const Trip = mongoose.model('Trip', tripSchema);
module.exports = Trip;
