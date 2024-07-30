const express = require('express');
const connectDB = require('./db');

const app = express();

// Connect to the database
connectDB();

// Middleware
app.use(express.json());

// Define Routes
app.use('/api/auth', require('./routes/auth'));

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
