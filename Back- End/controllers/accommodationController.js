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
        const district = req.params.district;

        // Check if district is provided in the URL parameters
        if (district) {
            const accommodations = await Accommodation.find({ district: district });
            if (accommodations.length === 0) {
                return res.send({ success: false, message: `No accommodations found in ${district}.` });
            }
            return res.send({ success: true, accommodations });
        }

        // If no district is provided, return all accommodations
        const accommodations = await Accommodation.find();
        if (accommodations.length === 0) {
            return res.send({ success: false, message: 'No accommodations found.' });
        }

        res.send({ success: true, accommodations });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

module.exports = { getAccommodation, createAccommodation };