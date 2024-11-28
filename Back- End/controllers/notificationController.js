// controllers/notificationController.js
const Notification = require('../models/Notification');

const getAllNotifications = async (req, res) => {
    try {
        const notifications = await Notification.find()
            .sort({ createdAt: -1 })
            .populate('accommodationId');
        res.status(200).json({ success: true, notifications });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
};

const markAsRead = async (req, res) => {
    try {
        const notification = await Notification.findByIdAndUpdate(
            req.params.id,
            { isRead: true },
            { new: true }
        );
        if (!notification) {
            return res.status(404).json({ success: false, message: 'Notification not found' });
        }
        res.status(200).json({ success: true, notification });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
};

module.exports = { getAllNotifications, markAsRead };