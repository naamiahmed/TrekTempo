// middleware/auth.js
const jwt = require('jsonwebtoken');
const Provider = require('../models/Provider');

const auth = async (req, res, next) => {
  try {
    const token = req.header('Authorization').replace('Bearer ', '');
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const provider = await Provider.findOne({ _id: decoded.providerId });

    if (!provider) {
      throw new Error();
    }

    req.token = token;
    req.provider = provider;
    next();
  } catch (error) {
    res.status(401).json({ message: 'Please authenticate' });
  }
};

module.exports = auth;