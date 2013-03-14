

window.color = "red";

var o = {
    color: "blue"
};

//shallow copy
function object(o){
    function fn(){};
    fn.prototype = o;
    return new fn();
}

function SuperType(name){
    this.name = name;
    this.color = ["red", "blue", "green"];
}

SuperType.prototype.sayName = function () {
    alert(this.name);
};


function closureTest2(){
    var arr = new Array();
    for(var i=0; i<10; i++){
	arr[i] = function(num){
	    return function(){
		return num
	    };
	}(i);

    }
    return arr;
}



function closureTest(){
    var arr = new Array();
    for(var i=0; i<10; i++){
	arr[i] = function(){
	    return i;
	}();

    }
    return arr;
}

function Person(name, age){
    this.name = name;
    this.age = age;
    this.getName = function(){
	return this.name;
    };
    this.getAge = function(){
	return this.age;
    };
}



Person.prototype = {
    sayHi: 'sayHi'
};

var person = new Person(123,1231);
Person.prototype = {
    sayHi: 'sayHello'
};

function saycolor(){
    alert(this.color);
}

function onclickbtn(){

    // var p = new Person("zhangsan", "12"); 
    
    var arr3 = closureTest2 ();

   
    alert(arr3[9]());
   
    // alert(arr);

    // alert(p.getAge());
    
    // var num = 0;
    // flag:
    // for(var i = 0; i < 10; i++){
    // 	for(var j = 0; j < 10; j++){
    // 	    if( i == 5 && j == 5 ){
    // 		continue flag;
    // 	    }
    // 	    num++;
    // 	}
    // }
    // var s = '';


    // test('hello', ' world');

    // var obj1 = new Array();
    // obj1.push('hell');
    // var cnt = obj1.push('asdfa');

    // alert(calSam(10));
    // obj1.age = 20;
    // var obj2 = obj1;
    // obj2.age = 15;
    // alert(obj1.age);

    // var obj3 = new Array();
    // alert(obj3 instanceof RegExp);

    // if(true) {
    // 	var i = 10;
    // }
    // alert(i);
    

    // saycolor.apply(o, arguments);
    
    // var str = "https://www.baidu.com/ig.html#start"; // 
    
    // alert(encodeURIComponent(str)); // 
    
}

function test(){
    alert(arguments[0] + arguments[1]);
    
}


function calSam(num){
    if( num == 0 ){
	return 0;
    }

    return num + arguments.callee(num-1);
}
