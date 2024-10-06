const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Define a schema for the places under 'Colombo'
const placeSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    weather: {
        type: String,
        required: true
    },
    locationLink: {
        type: String,
        required: true
    }
});

// Define a schema for the district, with 'Colombo' being an array of places
const districtSchema = new Schema({
    Colombo: {
        type: [placeSchema],  // 'Colombo' is an array of places
        required: true
    }
});

// Create the model based on the schema
const trip = mongoose.model('trip', districtSchema);

module.exports = trip;
