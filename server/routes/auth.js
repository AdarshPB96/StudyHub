const express = require("express");
const bcrypt = require('bcrypt');
const authRouter = express.Router();
// const bcrypt = require('bcrypt');
const User = require("../models/user_model");
const jwt = require('jsonwebtoken');

authRouter.post('/api/users', async (req, res) => {
    try {
      // Extract user details from request body
      
      
      const {
        firstName,
        lastName,
        dateOfBirth,
        email,
        country,
        state,
        city,
        studyingFor,
        schoolOrCollegeOrInsti,
        interests,
        password,
        profilePicUrl,
        termsAgreed
      } = req.body;

      console.log(req.body);
      const hashedPassword = await bcrypt.hash(password,10)

      const defaultProfilePicUrl = 'https://www.ommel.fi/content/uploads/2019/03/dummy-profile-image-male-768x768.jpg';
      const finalProfilePicUrl = profilePicUrl || defaultProfilePicUrl;

      const newUser = new User({
        firstName,
        lastName,
        dateOfBirth,
        email,
        country,
        state,
        city,
        studyingFor,
        schoolOrCollegeOrInsti,
        interests,
        password:hashedPassword ,
     
        termsAgreed,
        profilePicUrl:finalProfilePicUrl 
      });
  
      const savedUser = await newUser.save();
      
  
      // Return success response
      res.status(201).json({ message: 'User created successfully' });
    } catch (error) {
      // Return error response
      res.status(500).json({ message: 'Failed to create user', error: error.message });
    }
  });


    // Login endpoint
authRouter.post('/api/login', async (req, res) => {
    try {
        // Extract email and password from request body
        const { email, password } = req.body;
        console.log(req.body);

        // Find user by email in the database
        const user = await User.findOne({ email });
        console.log('User:', user);

        // If user does not exist, return error
        if (!user) {
            return res.status(404).json({success: false, message: 'User not found' });
            
        }
        const passwordMatch = await bcrypt.compare(password,user.password);
        console.log('Password Match:', passwordMatch);
        if(!passwordMatch){
          return res.status(404).json({success:false,message:"Wrong password"});
        }

        // Check if the password matches
        // if (user.password !== password) {
        //     return res.status(401).json({success: false, message: 'Incorrect password' });
        // }

        // Generate JWT token
        const token = jwt.sign({ userId: user._id }, 'your_secret_key_here', { expiresIn: '1h' });

        // Return token to the client
        res.status(200).json({ success: true, token, userId: user._id, message: 'Login successful' });
        console.log('User ID:', user._id);
    } catch (error) {
        // Return error response
        res.status(500).json({  success: false,message: 'Login failed', error: error.message });
    }
});

// Update profile picture endpoint
authRouter.put('/api/users/profilePic', async (req, res) => { 
  try {
      const { userId, profilePicUrl } = req.body;

      // Find user by ID in the database
      const user = await User.findById(userId);

      // If user does not exist, return error
      if (!user) {
          return res.status(404).json({ success: false, message: 'User not found' });
      }

      // Update profile picture URL
      user.profilePicUrl = profilePicUrl;
      await user.save();

      res.status(200).json({ success: true, message: 'Profile picture updated successfully' });
  } catch (error) {
      res.status(500).json({ success: false, message: 'Failed to update profile picture', error: error.message });
  }
});

  module.exports = authRouter;