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

// Delete Request place
const deleteRequestPlace = async (req, res) => {
  try {
    const reqestedPlace = await NewPlace.findByIdAndDelete(req.params.id);
    if (!reqestedPlace) {
      return res.status(404).json({ success: false, message: 'Place not found' });
    }
    res.json({ success: true, message: 'Rereqested Place deleted successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

module.exports = { getAllNewPlaces, createNewPlace, deleteRequestPlace };