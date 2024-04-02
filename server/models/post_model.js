const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
    text:String,
    file_link:String

});
const Post = mongoose.model('Post', postSchema);
module.exports = Post;