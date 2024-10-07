const TripPlace = require('../models/TripPlace'); // Adjust the path according to your project structure

const createTripPlace = async (req, res) => {
  try {
      const tripPlacesData = req.body; 
      const tripPlaces = await TripPlace.insertMany(tripPlacesData);
      res.send({ success: true, tripPlaces });
  } catch (error) {
      res.send({ success: false, message: error.message }); 
  }
};

const getTripPlaces = async (req, res) => {
    try {
        const district = req.params.district;

        // Check if district is provided in the URL parameters
        if (district) {
            const tripPlaces = await TripPlace.find({ district: district });
            if (tripPlaces.length === 0) {
                return res.send({ success: false, message: `No places found in ${district}.` });
            }
            return res.send({ success: true, places: tripPlaces });
        }

        // If no district is provided, return all places
        const tripPlaces = await TripPlace.find();
        if (tripPlaces.length === 0) {
            return res.send({ success: false, message: 'No places found.' });
        }

        res.send({ success: true, places: tripPlaces });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

module.exports = { getTripPlaces, createTripPlace };