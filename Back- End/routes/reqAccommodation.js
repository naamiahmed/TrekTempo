const express = require('express');
const router = express.Router();
const { addAccommodation, upload,getAccommodationCount } = require('../controllers/reqAccommodationController');

router.post('/addAccommodation', upload.single('image'), addAccommodation);
router.get('/getAccommodationCount', getAccommodationCount);

module.exports = router;