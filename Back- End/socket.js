// socket.js
const socketIO = require('socket.io');

const initializeSocket = (server) => {
  const io = socketIO(server, {
    cors: {
      origin: "*",
      methods: ["GET", "POST"]
    }
  });

  io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    socket.on('error', (error) => {
      console.error('Socket error:', error);
    });

    socket.on('joinRoom', (data) => {
      const room = [data.userId, data.partnerId].sort().join('-');
      socket.join(room);
      console.log(`User ${data.userId} joined room ${room}`);
    });

    socket.on('sendMessage', (data) => {
      const room = [data.userId, data.partnerId].sort().join('-');
      io.to(room).emit('message', {
        userId: data.userId,
        userName: data.userName,
        message: data.message
      });
    });

    // Handle location updates
    socket.on('locationUpdate', (data) => {
      const room = [data.userId, data.partnerId].sort().join('-');
      io.to(room).emit('locationUpdate', {
        userId: data.userId,
        latitude: data.latitude,
        longitude: data.longitude
      });
    });

    socket.on('disconnect', () => {
      console.log('User disconnected:', socket.id);
    });
  });

  return io;
};

module.exports = initializeSocket;