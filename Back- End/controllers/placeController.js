const Place = require("../models/Place");

// creating new place entries in the database
const createPlace = async (req, res) => {
  try {
    //const data = req.body;
    //const place = new Place(data);
    const placesData = req.body;
    const places = await Place.insertMany(placesData);
    //await places.save();
    res.send({ success: true, place: places });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// get all places from the database or get places by district
const getPlaces = async (req, res) => {
  try {
    const district = req.params.district;
    if (district) {
      //ensure case-insensitive and exact matches and sort by name
      const places = await Place.find({
        district: { $regex: new RegExp("^" + district + "$", "i") },
      }).sort({ name: 1 });
      return res.send({ success: true, places: places });
    }
    // If no district is provided, return all places
    const places = await Place.find();
    res.send({ success: true, places: places });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

// get one place from the database
const getOnePlace = async (req, res) => {
  try {
    const placeName = req.body.placeName;
    if (!placeName) {
      res.send({ success: false, message: "Place Name Required" });
    }
    const place = await Place.findOne({ name: placeName });
    res.send({ success: true, place: place });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

const getAllPlaces = async (req, res) => {
  try {
    const tripPlaces = await Place.find().sort({ name: 1 });
    if (tripPlaces.length === 0) {
      return res.send({
        success: false,
        message: `No places found in ${district}.`,
      });
    }
    return res.send({ success: true, places: tripPlaces });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

module.exports = { createPlace, getPlaces, getOnePlace, getAllPlaces };
