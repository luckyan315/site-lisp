var Person = function(){
  this.name = 'lisi';
  this.print = function(text){
    console.log(this.name + 'oriFun' + 'printed:' + text);
  };
};

var person = new Person();

var midFun = function(obj){
  var oldFun = obj.print();
  obj.print = function(text){
    text = text + ' [midFun]';
    obj.print(text);
  };
};

var mid2Fun = function(obj){
  obj.age = 11;
};

var caller = function(obj){
  obj.print(obj.age);
};

midFun(person);
mid2Fun(person);
caller(person);