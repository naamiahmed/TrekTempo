const mongoose = require('mongoose');

const TripSchema = new mongoose.Schema({
  starting_point: {
    name: String,
    required: true,
    coordinates: {
      latitude: Number,
      longitude: Number,
      required:false,
    }
  },
  ending_point: {
    name: String,
    required: true,
    coordinates: {
      latitude: Number,
      longitude: Number,
      required: false,
    }
  },
  duration: Number,
  budget: { type: String, enum: ['low', 'medium', 'high'], required: true },
  trip_person_type: { type: String, enum: ['solo', 'couple', 'family', 'friends'] , required: true},
  trip_type: { type: String, enum: ['historical', 'spiritual', 'adventure', 'other'] },
  places_to_visit: [
    {
      name: String,
      description: String,
      location: {
        latitude: Number,
        longitude: Number
      },
      image_url: String,
      weather: String
    }
  ],
  accommodation: {
    hotel_name: String,
    location: {
      latitude: Number,
      longitude: Number
    },
    price_per_night: Number
  },
  restaurants: [
    {
      name: String,
      cuisine: String,
      location: {
        latitude: Number,
        longitude: Number
      }
    }
  ]
});

module.exports = mongoose.model('Trip', TripPlanSchema); // Export the TripPlan model
