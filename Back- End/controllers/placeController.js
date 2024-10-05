const Place = require('../models/Place'); 

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
const getPlaces = async (req, res) => {
    try {
        const district = req.params.district;

        // Case-insensitive exact match using regex with ^ and $
        if (district) {
            const places = await Place.find({ district: { $regex: new RegExp('^' + district + '$', 'i') } });//ensure case-insensitive and exact matches
            return res.send({ success: true, places: places });
        }

        // If no district is provided, return all places
        const places = await Place.find();
        res.send({ success: true, places: places });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};


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

module.exports = { createPlace, getPlaces, getOnePlace };


