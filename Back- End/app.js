const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRoutes = require('./routes/auth');

const app = express();

app.use(express.json());
app.use(cors());

// MongoDB connection
mongoose.connect('mongodb+srv://TrekTempo:<db_password>@userdb.tr2b3.mongodb.net/?retryWrites=true&w=majority&appName=UserDB', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));

// Routes
app.use('/api', authRoutes);

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
