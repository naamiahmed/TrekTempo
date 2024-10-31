const mongoose = require('mongoose');

const AdminUserSchema = new mongoose.Schema({
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
});

const AdminUser = mongoose.model('AdminUser', AdminUserSchema);
module.exports = AdminUser;
