const CollaborationTrip = require('../models/CollaborationTrip');
const User = require('../models/User');

exports.createTrip = async (req, res) => {
  try {
    const { userId, startPoint, endPoint } = req.body;
    await CollaborationTrip.deleteMany({ userId });

    const trip = new CollaborationTrip({
      userId,
      startPoint,
      endPoint,
      status: 'searching'
    });
    
    await trip.save();
    res.status(201).json(trip);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.findMatchingUsers = async (req, res) => {
  try {
    const { startPoint, endPoint, userId } = req.query;
    const ObjectId = require('mongoose').Types.ObjectId;
    const userObjectId = new ObjectId(userId);

    const currentUserTrip = await CollaborationTrip.findOneAndUpdate(
      { userId: userObjectId },
      { 
        startPoint, 
        endPoint, 
        status: 'searching',
        partnerId: null 
      },
      { upsert: true, new: true }
    );

    const matchingTrips = await CollaborationTrip.find({
      startPoint,
      endPoint,
      userId: { $ne: userObjectId },
      status: 'searching'
    });

    const matchingUsers = await User.find({
      _id: { $in: matchingTrips.map(trip => trip.userId) }
    }).select('_id name email bio profilePicURL');
    
    res.json(matchingUsers);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.acceptPartner = async (req, res) => {
  try {
    const { userId, partnerId } = req.body;
    const userTrip = await CollaborationTrip.findOne({ userId });
    const partnerTrip = await CollaborationTrip.findOne({ userId: partnerId });

    if (!userTrip || !partnerTrip) {
      return res.status(404).json({ message: 'Trip not found' });
    }

    userTrip.partnerId = partnerId;
    userTrip.status = 'waiting';
    await userTrip.save();

    if (partnerTrip.partnerId?.toString() === userId) {
      userTrip.status = 'confirmed';
      partnerTrip.status = 'confirmed';
      await Promise.all([userTrip.save(), partnerTrip.save()]);
    }

    res.json({ status: userTrip.status });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getStatus = async (req, res) => {
  try {
    const { userId } = req.params;
    const trip = await CollaborationTrip.findOne({ userId })
      .populate('partnerId', 'name email bio profilePicURL');

    if (!trip) {
      return res.status(404).json({ message: 'Trip not found' });
    }

    res.json({
      status: trip.status,
      partnerId: trip.partnerId?._id,
      partnerName: trip.partnerId?.name,
      partnerDetails: trip.partnerId
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};