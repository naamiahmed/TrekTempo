const Trip = require('../models/Trip'); // Adjust the path according to your project structure

const getTripPlaces = async (req, res) => {
    try {
        const district = req.params.district;

        // Check if district is provided in the URL parameters
        if (district) {
            // Find places in the district (only 'Colombo' in this case, as per your schema)
            if (district.toLowerCase() === 'colombo') {
                const tripData = await Trip.findOne();
                if (!tripData || !tripData.Colombo) {
                    return res.send({ success: false, message: 'No places found in Colombo.' });
                }

                // Send only the places in Colombo
                return res.send({ success: true, places: tripData.Colombo });
            } else {
                return res.send({ success: false, message: `District ${district} is not available.` });
            }
        }

        // If no district is provided, return all places in Colombo
        const tripData = await Trip.findOne();
        if (!tripData || !tripData.Colombo) {
            return res.send({ success: false, message: 'No places found.' });
        }

        res.send({ success: true, places: tripData.Colombo });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

module.exports = { getTripPlaces };

