const express = require('express');
const router = express.Router();
const { 
  createTrip, 
  findMatchingUsers, 
  acceptPartner, 
  getStatus 
} = require('../controllers/CollaborationTripController');

router.post('/create', createTrip);
router.get('/matching', findMatchingUsers);
router.post('/accept', acceptPartner);
router.get('/status/:userId', getStatus);

module.exports = router;