const express = require('express');
const router = express.Router();
const Notification = require('../models/Notification');

// Fetch notifications by userId
router.get('/:userId', async (req, res) => {
    try {
        const userId = req.params.userId;
        console.log(`Fetching notifications for userId: ${userId}`);
        const notifications = await Notification.find({ userId: userId });
        console.log(`Found notifications: ${JSON.stringify(notifications)}`);
        res.json(notifications);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
