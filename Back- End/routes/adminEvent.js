const express = require('express');
const router = express.Router();
const { getAllEvents, deleteEvent } = require('../controllers/adminEventController');

router.get("/getAllEvents", getAllEvents);
router.delete("/deleteEvent/:id", deleteEvent);

module.exports = router;