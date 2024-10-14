const express = require('express');
const router = express.Router();
const { addEvent, upload } = require('../controllers/eventController');

router.post('/addEvent', upload.single('image'), addEvent);

module.exports = router;