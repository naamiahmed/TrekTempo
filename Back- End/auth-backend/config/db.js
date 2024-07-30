const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect('YOUR_MONGODB_CONNECTION_STRING', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB connected');
  } catch (err) {
    console.error(err.message);
    process.exit(1);
  }
};

module.exports = connectDB;
