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

// Get Accommodation by district and budget
const getAccommodationByDistrictandBudget = async (req, res) => {
    try {
        const { district, budget } = req.params;
        let query = {};

        if (district) {
            query.district = { $regex: new RegExp("^" + district + "$", "i") };
        }
        if (budget) {
            query.budget = budget;
        }

        const accommodations = await Accommodation.find(query).sort({ name: 1 });
        return res.send({ success: true, accommodations: accommodations });

    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};


module.exports = { getAccommodation, createAccommodation, getAccommodationByDistrictandBudget };