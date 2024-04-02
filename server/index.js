const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');
const dbconnections = require('./util/db_connection');
const postRouter = require('./routes/post');
const app = express();
const PORT = 3000;

app.use(express.json());

//midleware
app.use(authRouter);
app.use(postRouter);


dbconnections();
app.listen(PORT,()=>{
  console.log(`Server connected at port ${PORT}`); 
})
