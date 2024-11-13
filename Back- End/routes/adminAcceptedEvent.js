const express = require('express');
const router = express.Router();
const { getAllAcceptedEvents, deleteAcceptedEvent, moveEventToAccepted, createAcceptedEvent, upload, getEventCount } = require('../controllers/adminAcceptedEventController');

router.get("/getAllAcceptedEvents", getAllAcceptedEvents);
router.delete("/deleteAcceptedEvent/:id", deleteAcceptedEvent);
router.post("/moveEventToAccepted/:id", moveEventToAccepted);
router.post("/createAcceptedEvent", upload.single('image'), createAcceptedEvent);
router.get("/getEventCount", getEventCount);

module.exports = router;