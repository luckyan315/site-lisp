var http =  require('http');

var server = http.createServer();

server.on('connection', function(client){

  client.write('Msg from server!');

  client.on('data', function(data){
    if(data.toString() == 'q\n'){
      client.end();
    }
    console.log(data.toString());
  });

});

server.listen(8787);