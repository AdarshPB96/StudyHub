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
        confirmPassword,
        termsAgreed
      } = req.body;

      console.log(req.body);
      const hashedPassword = await bcrypt.hash(password,10)


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
        confirmPassword,
        termsAgreed
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

        // If user does not exist, return error
        if (!user) {
            return res.status(404).json({success: false, message: 'User not found' });
            
        }
        const passwordMatch = await bcrypt.compare(password,user.password)
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
        res.status(200).json({success: true, token,message:"Login successfull"});
    } catch (error) {
        // Return error response
        res.status(500).json({  success: false,message: 'Login failed', error: error.message });
    }
});


  module.exports = authRouter;