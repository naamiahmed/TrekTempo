const express = require('express');
const router = express.Router();
const { addAccommodation, upload } = require('../controllers/reqAccommodationController');

router.post('/addAccommodation', upload.single('image'), addAccommodation);

module.exports = router;