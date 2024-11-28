const mongoose = require('mongoose');

const collaborationTripSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  startPoint: {
    type: String,
    required: true
  },
  endPoint: {
    type: String, 
    required: true
  },
  partnerId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    default: null
  },
  status: {
    type: String,
    enum: ['searching', 'waiting', 'confirmed'],
    default: 'searching'
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('CollaborationTrip', collaborationTripSchema);