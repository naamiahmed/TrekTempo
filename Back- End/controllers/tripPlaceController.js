const TripPlace = require('../models/TripPlace'); // Adjust the path according to your project structure
const Place = require('../models/Place'); // Adjust the path according to your project structure

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
        const data = req.body;
        const TripPlaces = await Place.find({district: data.endPoint, budget: data.budget, tripPersonType: data.tripPersonType, tripType: data.tripType});
        return res.send({ success: true, TripPlaces: TripPlaces });

    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

const getOnetripPlace = async (req, res) => {
    try {
        const TripPlaceName = req.body.TripPlace;
        if (!TripPlace) {
            res.send({ success: false, message: "Place Name Required" });
        }
        const place = await Place.findOne({ name: TripPlaceName });
        res.send({ success: true, TripPlace: TripPlace });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};



module.exports = { getTripPlaces, createTripPlace , getOnetripPlace };