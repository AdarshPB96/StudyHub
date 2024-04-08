const express = require("express");
const postRouter = express.Router();

const Post = require("../models/post_model");
const User = require("../models/user_model");

postRouter.post('/api/post',async(req,res)=>{
    try {
        const {
            text,
            file_links,
            user_id
        } = req.body
    console.log(req.body);
    const newpost = new Post({
        text,
        file_links,
        user_id

    });
    const savePost = await newpost.save();
    res.status(201).json({message:"post created"})
        
    } catch (error) {
        res.status(500).json({message:"Failed to create post",error:error.message});
    }
});

postRouter.get('/api/getpost', async (req, res) => {
    try {
        const posts = await Post.find().populate({
            path: 'user_id',
            select: 'firstName lastName profilePicUrl'
        }).lean(); 

        res.status(200).json(posts); 
    } catch (error) {
        res.status(500).json({ message: "Failed to retrieve posts with user details", error: error.message });
    }
});

module.exports = postRouter;
