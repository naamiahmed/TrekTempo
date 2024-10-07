const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    console.log('MongoDB Connected'); // Log success message
  } catch (error) {
    console.error(error.message); // Log any connection errors
    process.exit(1); // Exit the application if the connection fails
  }
};

module.exports = connectDB; // Export the connectDB function for use in other files
