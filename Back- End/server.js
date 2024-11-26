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
const ReqAccommodationRoutes = require('./routes/reqAccommodation');
const notificationRoutes = require('./routes/notification');
const adminAccommodationRoutes = require('./routes/adminAccommodationRoutes');
const adminUserRoutes = require('./routes/adminUser');
const connectDB = require('./config/db');

// const initializeSocket = require('./socket');
// const http = require('http');

//const connectDB = require('./config/db');
require('dotenv').config();

const app = express();
// const server = http.createServer(app);

// Middleware

// CORS Configuration
app.use(cors({
    origin: ['https://trektempo.onrender.com3000', 'https://your-frontend-domain.com'],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true
}));

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ 
        success: false,
        message: 'Internal Server Error',
        error: err.message 
    });
});

// Modify your route handlers to include proper error handling
app.use('/api', (req, res, next) => {
    try {
        // Your route logic
    } catch (error) {
        next(error);
    }
});
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
app.use('/api', ReqAccommodationRoutes);
app.use('/api', adminAccommodationRoutes);
app.use('/api', adminUserRoutes);
app.use('/api/notifications', notificationRoutes);

// Socket.io
// initializeSocket(server);

const PORT = process.env.PORT || 5001;
// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on https://trektempo.onrender.com${PORT}`);
});
