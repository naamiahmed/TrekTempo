const express = require('express');
const router = express.Router();
const { getAllAcceptedEvents, deleteAcceptedEvent , moveEventToAccepted } = require('../controllers/adminAcceptedEventController');

router.get("/getAllAcceptedEvents", getAllAcceptedEvents);
router.delete("/deleteAcceptedEvent/:id", deleteAcceptedEvent);
router.post("/moveEventToAccepted/:id", moveEventToAccepted);

module.exports = router;