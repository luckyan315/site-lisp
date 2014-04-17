var http = require('http');
var fs = require('fs');
var path = require('path');
var port = 3000;
var pid_file = path.join(__dirname, 'app.pid');


fs.writeFileSync(pid_file, process.pid);

var server = http.createServer(function(req, res, next){
  res.writeHead(200, {'Content-Type' : 'text/plain'});
  res.end('hello world');
}).listen(port, function(){
  console.log('Server is listening on port ' + port);
});

process.on('SIGTERM', function(){
  console.log('[SIGTERM][pid_file] ' + pid_file);
  
  if (fs.existsSync(pid_file)) {
    fs.unlinkSync(pid_file);
    console.log('delete success app.pid');
    return process.exit(0);
  }
  
  return process.exit(1);
});
