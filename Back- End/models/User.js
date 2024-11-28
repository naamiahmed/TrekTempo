const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: false,
    },
    profilePicURL: {
        type: String,
        required: false,
    },
    otp: {
        type: String,
        required: false,
    },
    otpUsed: {
        type: Boolean,
        default: false,
    },
    bio:{
        type: String,
        required: false,
    },
});

const User = mongoose.model('User', userSchema);
module.exports = User;