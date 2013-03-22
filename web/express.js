var exp = require('express');

var server = exp.createServer();

server.get('/', function(req, res){
    res.send('hello world');
});

server.listen(8787);