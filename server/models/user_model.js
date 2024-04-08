// models/User.js
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    firstName: String,
    lastName: String,
    dateOfBirth: String,
    email: {
      type: String,
      required: true,
      unique: true
    },
    country: String,
    state: String,
    city: String,
    studyingFor: String, 
    profilePicUrl:String,
    schoolOrCollegeOrInsti: String, 
    interests: [String],
    password: {
      type: String,
      required: true
    },

    termsAgreed: Boolean
  });
  
  const User = mongoose.model('User', userSchema);

module.exports = User;
