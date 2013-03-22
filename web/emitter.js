var util = require('util');
var Emitter = require('events').EventEmitter; //class of Event emitter 

function Server(){
  console.log('Server created');
}

util.inherits(Server, Emitter);

var server = new Server();

// define trigger event to emit event, args: text
Server.prototype.trigger = function(text){
  this.emit('trigger', text);
};

server.on('trigger', function(text){
  console.log('Event: trigger works! Msg:' + text + ' received!');
});

server.trigger('hellow world');





