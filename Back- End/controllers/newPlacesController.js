const NewPlace = require("../models/NewPlace");


const createNewPlace = async (req, res) => {
    try {
        const newPlacesData = req.body;
        const newPlaces = await NewPlace.insertMany(newPlacesData);
        res.send({ success: true, newPlace: newPlaces });
    } catch (error) {
      res.send({ success: false, message: error.message });
    }
  };


// Get all new places
const getAllNewPlaces = async (req, res) => {
    try {
      const newPlaces = await NewPlace.find().sort({ name: 1 });
      if (newPlaces.length === 0) {
        return res.send({
          success: false,
          message: `No New places found.`,
        });
      }
      return res.send({ success: true, places: newPlaces });
    } catch (error) {
      res.send({ success: false, message: error.message });
    }
  };

  module.exports = { getAllNewPlaces, createNewPlace };