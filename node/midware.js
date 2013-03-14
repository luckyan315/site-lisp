var Person = function(){
  this.name = 'lisi';
  this.print = function(text){
    console.log(this.name + ' oriFun' + ' printed :' + text);
  };
};

var person = new Person();

var midFun = function(obj){
  var oldFun = obj.print;
  obj.print = function(text){
    text = text + '[midFun]';
    oldFun(text);
  };
};

var mid2Fun = function(obj){
  obj.age = 11;
};

var caller = function(obj){
  obj.print(obj.age);
};


console.log('mid fun print:\n');
midFun(person);
console.log('mid2 fun print:\n');
mid2Fun(person);
console.log('caller fun print:\n');
caller(person);