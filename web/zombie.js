var cluster = require('cluster');
var http = require('http');
var numCPUs = require('os').cpus().length;

var workers = {};

if(cluster.isMaster()){
  //fork works according cps num
  for(var i=0; i<numCPUS; i++){
    createServer();
  }

  //manage zombie cpus
  setInterval(function (){
    //kill sleep zombie per second
    
  }, 1000);
  
} else if(cluster.isWorker()){
  //TODO: create http servers

}

function createServer(){
  var worker = cluster.fork();
  console.log('Create worker: ' + worker.pid);
  workers[worker.pid] = {worker: worker,
                        lastCb: new Data().getTime()};
}


