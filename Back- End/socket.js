// socket.js
const socketIO = require('socket.io');

const initializeSocket = (server) => {
  const io = socketIO(server); // Bind socket.io to the server

  io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    // Listen for new request events from the mobile app
    socket.on('newRequest', (data) => {
      console.log('New request:', data);
      // Emit notification to the admin
      io.emit('adminNotification', data);
    });

    // Listen for request acceptance by admin
    socket.on('acceptRequest', (data) => {
      console.log('Request accepted:', data);
      // Emit notification to the user
      io.emit('userNotification', data);
    });

    // Handle disconnection
    socket.on('disconnect', () => {
      console.log('User disconnected:', socket.id);
    });
  });
};

module.exports = initializeSocket;
