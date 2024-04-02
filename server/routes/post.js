const express = require("express");
const postRouter = express.Router();

const Post = require("../models/post_model");
postRouter.post('/api/post',async(req,res)=>{
    try {
        const {
            text,
            file_link
        } = req.body
    console.log(req.body);
    const newpost = new Post({
        text,
        file_link

    });
    const savePost = await newpost.save();
    res.status(201).json({message:"post created"})
        
    } catch (error) {
        res.status(500).json({message:"Failed to create post",error:error.message});
    }
});

module.exports = postRouter;