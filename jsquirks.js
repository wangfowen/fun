//this is an object
var myObject1 = {
	Blob: "b",
	//this is a method (function property of the object)
	blah: function() {
			this.Blob = "a";
	}
}

console.log("Blob of an object:" + myObject1.Blob);
myObject1.blah();
console.log("after blah:" + myObject1.Blob);

//this is a constructor function to create objects
function myObject2() {
	this.Blob = "b";
	this.blah = function() {
		this.Blob = "a";
	}
}

var a = new myObject2();
console.log("Blob of an instantiated object:" + a.Blob);
a.blah();
console.log("after blah:" + a.Blob);

function myObject3() {
	this.Blob = "b";
	this.blah = function() {
		//"this" in the inner function now targets global
		var helper = function() {
			this.Blob = "a";
		}
		helper();
	}
}

var b = new myObject3();
console.log("Blob of instantiated object with 'this' in an inner function:" + b.Blob);
b.blah();
console.log("after blah:" + b.Blob);
console.log("window's Blob however:" + window.Blob);

var Orig = function() {};
var c = new Orig();
c.newFunction = function() { return "a"; };
Orig.prototype.newFunction = function() { return "b"; };
//the function's new function overpowers the prototype's, despite being called before
console.log("c's newFunction:" + c.newFunction());

var d = new Orig();
console.log("d's newFunction:" + d.newFunction());
