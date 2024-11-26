const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const http = require("http");
const initializeSocket = require("./socket");
const authRoutes = require("./routes/auth");
const placeRoutes = require("./routes/place");
const tripPlaceRoutes = require("./routes/tripPlace");
const accommodationRoutes = require("./routes/accommodation");
const adminEventRoutes = require("./routes/adminEvent");
const adminAcceptedEventRoutes = require("./routes/adminAcceptedEvent");
const newPlacesRoutes = require("./routes/newPlace");
const eventRoutes = require("./routes/event");
const ReqAccommodationRoutes = require("./routes/reqAccommodation");
const notificationRoutes = require("./routes/notification");
const adminAccommodationRoutes = require("./routes/adminAccommodationRoutes");
const adminUserRoutes = require("./routes/adminUser");
const collaborationRoutes = require("./routes/collaborationTrip");
const connectDB = require("./config/db");

require("dotenv").config();

const app = express();
const server = http.createServer(app);

// Initialize Socket.IO
const io = initializeSocket(server);


// Middleware
app.use(cors());
app.use(express.json());
app.use("/uploads", express.static("uploads"));

// MongoDB connection
mongoose
  .connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("MongoDB connected successfully"))
  .catch((err) => console.error("MongoDB connection error:", err));

// Add after MongoDB connection
io.on('connection', (socket) => {
  console.log('New client connected:', socket.id);
  
  socket.on('disconnect', () => {
    console.log('Client disconnected:', socket.id);
  });
});

// Routes
app.use("/api/auth", authRoutes);
app.use("/api", placeRoutes);
app.use("/api", tripPlaceRoutes);
app.use("/api", accommodationRoutes);
app.use("/api", adminEventRoutes);
app.use("/api", adminAcceptedEventRoutes);
app.use("/api", newPlacesRoutes);
app.use("/api", eventRoutes);
app.use("/api", ReqAccommodationRoutes);
app.use("/api", adminAccommodationRoutes);
app.use("/api", adminUserRoutes);
app.use("/api/notifications", notificationRoutes);
app.use("/api/collaboration", collaborationRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: "Something went wrong!" });
});

// Handle undefined routes
app.use((req, res) => {
  res.status(404).json({ message: "Route not found" });
});

const PORT = process.env.PORT || 5000;

// server.listen(PORT, () => {
//   console.log(`Server running on http://192.168.1.5:${PORT}`);
// });
server.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on port ${PORT}`);
  });

// Handle server shutdown
process.on("SIGTERM", () => {
  console.log("SIGTERM received. Shutting down gracefully");
  server.close(() => {
    console.log("Server closed");
    mongoose.connection.close(false, () => {
      console.log("MongoDB connection closed");
      process.exit(0);
    });
  });
});

module.exports = { app, server };
