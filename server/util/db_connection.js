const db = require("mongoose")
const dbconnections = ()=>{
    db.connect("mongodb+srv://adarshpbkaveri:UcFRuYqiw25jhL3v@my-project.dl4ebip.mongodb.net/",{
        dbName:"StudyHub",
    }).then(()=>{
        console.log("db connect successfully")

    }).catch((e)=>{
        console.log(`dbconnect unsuccessful ${e.message}`)
    })
}

module.exports = dbconnections;