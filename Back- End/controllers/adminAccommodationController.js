const ReqAccommodation = require("../models/ReqAccommodation");
const AcceptedAccommodation = require("../models/Accommodation");

const getAllAccommodations = async (req, res) => {
  try {
    const accommodations = await ReqAccommodation.find().sort({ name: 1 });
    if (accommodations.length === 0) {
      return res.send({
        success: false,
        message: `No places found in the database`,
      });
    }
    return res.send({ success: true, accommodations: accommodations });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

const deleteAccommodation = async (req, res) => {
  try {
    const accommodation = await ReqAccommodation.findByIdAndDelete(req.params.id);
    if (!accommodation) {
      return res.status(404).json({ success: false, message: 'Accommodation not found' });
    }
    res.json({ success: true, message: 'Accommodation deleted successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

const moveAccommodationToAccepted = async (req, res) => {
    const accommodationId = req.params.id; // Get the ID from request params

    try {
        // Step 1: Find the document in the ReqAccommodation collection
        const accommodation = await ReqAccommodation.findById(accommodationId);

        if (!accommodation) {
            return res.status(404).json({ msg: 'Accommodation not found' });
        }

        // Step 2: Insert the document into the AcceptedAccommodation collection
        const acceptedAccommodation = new AcceptedAccommodation(accommodation.toObject());
        await acceptedAccommodation.save();

        // Step 3: Delete the document from the ReqAccommodation collection
        await ReqAccommodation.findByIdAndDelete(accommodationId);

        res.status(200).json({ msg: 'Accommodation moved to AcceptedAccommodation successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

};

module.exports = { getAllAccommodations, deleteAccommodation, moveAccommodationToAccepted };