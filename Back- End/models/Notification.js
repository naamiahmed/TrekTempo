const mongoose = require('mongoose');

const NotificationSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    },
    title: {
        type: String,
        required: true
    },
    subtitle: {
        type: String,
        required: true
    },
    time: {
        type: String,
        required: true
    }
});

const Notification = mongoose.model('Notification', NotificationSchema);

module.exports = Notification;