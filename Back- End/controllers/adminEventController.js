const Event = require("../models/AdminEvent");

const getAllEvents = async (req, res) => {
    try {
      const events = await Event.find().sort({ name: 1 });
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
  
  module.exports = { getAllEvents };