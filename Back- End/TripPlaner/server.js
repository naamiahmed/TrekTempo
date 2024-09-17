const express = require('express');
const mongoose = require('mongoose');
const axios = require('axios');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors()); // Enable CORS to allow Flutter app to connect

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/travelDB/trips', { useNewUrlParser: true, useUnifiedTopology: true });

// Define the trip schema
const tripSchema = new mongoose.Schema({
  tripName: String,
  startingPoint: String,
  endingPoint: String,
  days: Number,
  places: Array,
  restaurants: Array,
  hotels: Array
});

const Trip = mongoose.model('Trip', tripSchema);

// Fetch places from external API (OpenTripMap example)
app.get('/trip/places/:location', async (req, res) => {
  const location = req.params.location;
  try {
    const response = await axios.get(`https://api.opentripmap.com/0.1/en/places/radius`, {
      params: {
        lat: '6.9271', // Example lat for Colombo
        lon: '79.8612', // Example lon for Colombo
        radius: 10000,
        apikey: 'AIzaSyCcp-n3pWlsKuIaYtzodL0AA-ZC4h9rqNw'
      }
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).send("Error fetching data from API");
  }
});

// Save a trip plan
app.post('/trip/save', async (req, res) => {
  const trip = new Trip(req.body);
  try {
    const savedTrip = await trip.save();
    res.json({ tripId: savedTrip._id });
  } catch (err) {
    res.status(500).send("Error saving trip");
  }
});

// Retrieve a trip plan with places, restaurants, and hotels
app.get('/trip/:tripId', async (req, res) => {
  try {
    const trip = await Trip.findById(req.params.tripId);
    res.json(trip);
  } catch (err) {
    res.status(404).send("Trip not found");
  }
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
