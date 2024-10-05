const TripPlan = require('../models/Trip');

// Create a new trip plan

// exports.createTripPlan = async (req, res) => {
//   try {
//     const tripPlan = new TripPlan(req.body);
//     await tripPlan.save();
//     res.status(201).json(tripPlan);
//   } catch (error) {
//     res.status(500).json({ error: error.message });
//   }
// };

// Match trip plans based on user input
exports.matchTripPlans = async (req, res) => {
  try {
    const { starting_point, ending_point, duration, budget, trip_person_type, trip_type } = req.body;

    // Query for matching trip plans
    const matchedPlans = await TripPlan.find({
      starting_point: starting_point,
      ending_point: ending_point,
      duration: duration,
      budget: budget,
      trip_person_type: trip_person_type,
      trip_type: trip_type
    });

    res.json(matchedPlans);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
