const ReqAccommodation = require("../models/ReqAccommodation");
const AcceptedAccommodation = require("../models/Accommodation");
const Notification = require("../models/Notification");

const getAllReqAccommodations = async (req, res) => {
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
  const accommodationId = req.params.id;
  const { userId } = req.body;

  console.log('Starting moveAccommodationToAccepted...');
  console.log('AccommodationId:', accommodationId);
  console.log('Request body:', req.body);

  try {
      if (!accommodationId || !userId) {
          return res.status(400).json({
              success: false,
              message: 'Both Accommodation ID and User ID are required'
          });
      }

      const accommodation = await ReqAccommodation.findById(accommodationId);
      console.log('Found accommodation:', accommodation);

      if (!accommodation) {
          return res.status(404).json({
              success: false,
              message: 'Accommodation not found'
          });
      }

      // Convert to plain object and remove _id
      const accommodationData = accommodation.toObject();
      delete accommodationData._id;
      delete accommodationData.__v;

      // Save to accepted accommodations with new _id
      const acceptedAccommodation = new AcceptedAccommodation(accommodationData);
      const savedAcceptedAccommodation = await acceptedAccommodation.save();
      console.log('Saved accepted accommodation:', savedAcceptedAccommodation);

      // Create notification
      const notification = new Notification({
          accommodationId: savedAcceptedAccommodation._id,
          userId: userId,
          message: `Accommodation ${accommodation.name} has been accepted`,
          type: 'acceptance'
      });
      await notification.save();

      // Delete from requests
      await ReqAccommodation.findByIdAndDelete(accommodationId);

      return res.status(200).json({
          success: true,
          message: 'Accommodation moved successfully',
          acceptedAccommodation: savedAcceptedAccommodation
      });

  } catch (error) {
      console.error('Error in moveAccommodationToAccepted:', error);
      return res.status(500).json({
          success: false,
          message: error.code === 11000 ? 'Duplicate entry found' : 'Server error',
          error: error.message
      });
  }
};

module.exports = { getAllReqAccommodations, deleteAccommodation, moveAccommodationToAccepted };