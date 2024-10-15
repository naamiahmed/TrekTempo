const AdminEvent = require("../models/AdminEvent");

const getAllEvents = async (req, res) => {
  try {
    const events = await AdminEvent.find().sort({ name: 1 });
    if (events.length === 0) {
      return res.send({
        success: false,
        message: `No places found in the database`,
      });
    }
    return res.send({ success: true, events: events });
  } catch (error) {
    res.send({ success: false, message: error.message });
  }
};

const deleteEvent = async (req, res) => {
  try {
    const event = await AdminEvent.findByIdAndDelete(req.params.id);
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found' });
    }
    res.json({ success: true, message: 'Event deleted successfully' });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

module.exports = { getAllEvents, deleteEvent };