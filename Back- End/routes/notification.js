// routes/notificationRoutes.js
const express = require('express');
const router = express.Router();
const { getAllNotifications, markAsRead } = require('../controllers/notificationController');

router.get('/', getAllNotifications);
router.put('/:id/read', markAsRead);

module.exports = router;