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
        if (district) {
            //ensure case-insensitive and exact matches and sort by name
            const TripPlaces = await TripPlace.find({ district: { $regex: new RegExp('^' + district + '$', 'i') } }).sort({ name: 1 });
            return res.send({ success: true, TripPlaces: TripPlaces });
        }
        // If no district is provided, return all places
        const places = await Place.find();
        res.send({ success: true, TripPlaces: TripPlaces });
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



module.exports = { getTripPlaces, createTripPlace , getOnetripPlace };