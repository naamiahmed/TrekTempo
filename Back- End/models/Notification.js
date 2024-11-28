// models/Notification.js
const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({
    accommodationId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'Accommodation'
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    },
    message: {
        type: String,
        required: true
    },
    type: {
        type: String,
        default: 'acceptance'
    },
    createdAt: {
        type: Date,
        default: Date.now
    },
    isRead: {
        type: Boolean,
        default: false
    }
});

module.exports = mongoose.model('Notification', notificationSchema);