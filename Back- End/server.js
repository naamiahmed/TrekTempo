const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRoutes = require('./routes/auth');
const placeRoutes = require('./routes/place');
const tripPlaceRoutes = require('./routes/tripPlace');
const accommodationRoutes = require('./routes/accommodation');
const adminEventRoutes = require('./routes/adminEvent');
const adminAcceptedEventRoutes = require('./routes/adminAcceptedEvent');
const newPlacesRoutes = require('./routes/newPlace');
const eventRoutes = require('./routes/event');

//const connectDB = require('./config/db');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

// MongoDB connection
mongoose.connect(process.env.MONGODB_URI)
    .then(() => console.log('MongoDB connected'))
    .catch(err => console.log(err));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api', placeRoutes);
app.use('/api', tripPlaceRoutes);
app.use('/api', accommodationRoutes);
app.use('/api', adminEventRoutes);
app.use('/api', adminAcceptedEventRoutes);
app.use('/api', newPlacesRoutes);
app.use('/api', eventRoutes);

const PORT = process.env.PORT || 5001;
// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
