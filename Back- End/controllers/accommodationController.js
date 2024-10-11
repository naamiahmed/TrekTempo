const Accommodation = require('../models/Accommodation'); // Adjust the path according to your project structure

const createAccommodation = async (req, res) => {
  try {
      const accommodationData = req.body; 
      const accommodations = await Accommodation.insertMany(accommodationData);
      res.send({ success: true, accommodations });
  } catch (error) {
      res.send({ success: false, message: error.message }); 
  }
};

const getAccommodation = async (req, res) => {
    try {
        const data = req.body;
        const Accommodations = await Accommodation.find({district: data.endPoint, budget: data.budget});
        return res.send({ success: true, Accommodations: Accommodations });

    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

module.exports = { getAccommodation, createAccommodation };