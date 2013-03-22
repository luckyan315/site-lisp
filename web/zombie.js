var cluster = require('cluster');
var http = require('http');
var numCPUs = require('os').cpus().length;

var workers = {};



if(cluster.isMaster()){
  //fork works according cps num
  for(var i=0; i<numCPUS; i++){
    createWorker();
  }

  //manage zombie cpus
  setInterval(function (){
    var date = new Date();
    //kill sleep zombie per second
    for(var prop in workers){
      if(workers.hasOwnProperty(prop) &&
        workers[prop].lastCb + 5000 < date.getTime() ){
        console.log('A zombie worker Killed. pid:' + workers[prop].worker.pid);
        workers[prop].worker.kill();
        delete workers[prop];
        
      }
    }
  }, 1000);
  
} else if(cluster.isWorker()){
  //TODO: create http servers
  http.Server(function (req, res){
    res.writeHead(200);
    res.end('Hello world from pid:' + cluster.worker.pid);
  }).listen(8787);
}

function createWorker(){
  var worker = cluster.fork();
  console.log('Create worker: ' + worker.pid);
  workers[worker.pid] = {worker: worker,
                        lastCb: new Data().getTime()};
}

