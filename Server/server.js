// import express
var express = require('express');
var bodyParser = require('body-parser');
var app = express();

// configure the body parser
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

// respond to post requests
app.post('/', function(req, res){
    // get all the information
    var username = req.body.username;
    var user_id = req.body.id;
    res.send("Got it!");
});

// listen
app.listen(8888, function () {
  console.log('Listening on port 8888!');
});