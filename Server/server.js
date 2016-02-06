/*var http = require("http");

var server = http.createServer(function(request, response){
    var queryData = url.parse(request.url, true).query;
    response.writeHead(200, {"Content-Type": "text/plain"});
    
    
});

server.listen(8888);*/

// import express
var express = require('express');
var app = express();

// import the body parser
var bodyParser = require('body-parser');
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

// respond to post requests
app.post('/operation', function(req, res){
    var username = req.body.username;
    console.log("result: " + username);
    res.send("Got it!");
});

// listen
app.listen(8888, function () {
  console.log('Example app listening on port 8888!');
});