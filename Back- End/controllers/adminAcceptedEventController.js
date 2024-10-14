const AcceptedEvent = require("../models/AdminAcceptedEvent");
const Event = require('../models/AdminEvent');

// Function to move the document
const moveEventToAccepted = async (req, res) => {
    const eventId = req.params.id; // Get the ID from request params

    try {
        // Step 1: Find the document in the Event collection
        const event = await Event.findById(eventId);

        if (!event) {
            return res.status(404).json({ msg: 'Event not found' });
        }

        // Step 2: Insert the document into the AcceptedEvent collection
        const acceptedEvent = new AcceptedEvent(event.toObject());
        await acceptedEvent.save();

        // Step 3: Delete the document from the Event collection
        await Event.findByIdAndDelete(eventId);

        res.status(200).json({ msg: 'Event moved to AcceptedEvent successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const createAllAcceptedEvents = async (req, res) => {
    try {
        const AcceptedEventData = req.body;
        const AcceptedEvents = await AcceptedEvent.insertMany(AcceptedEventData);
        res.send({ success: true, AcceptedEvent: AcceptedEvents });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

const getAllAcceptedEvents = async (req, res) => {
    try {
        const events = await AcceptedEvent.find().sort({ name: 1 });
        if (events.length === 0) {
            return res.send({
                success: false,
                message: `No places found in ${district}.`,
            });
        }
        return res.send({ success: true, events: events });
    } catch (error) {
        res.send({ success: false, message: error.message });
    }
};

const deleteAcceptedEvent = async (req, res) => {
    try {
        const event = await AcceptedEvent.findByIdAndDelete(req.params.id);
        if (!event) {
            return res.status(404).json({ success: false, message: 'Event not found' });
        }
        res.json({ success: true, message: 'Event deleted successfully' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Server error' });
    }
};

module.exports = { getAllAcceptedEvents, deleteAcceptedEvent, createAllAcceptedEvents, moveEventToAccepted };