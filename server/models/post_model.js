// const mongoose = require('mongoose');

// const postSchema = new mongoose.Schema({
//     text:String,
//     file_link:[String],
//     user_id:String

// });
// const Post = mongoose.model('Post', postSchema);
// module.exports = Post;

const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
    text: String,
    file_links: [String],
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User' // Reference to the User model
    }
});

const Post = mongoose.model('Post', postSchema);

module.exports = Post;
