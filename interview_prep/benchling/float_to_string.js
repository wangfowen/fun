var numToStringMap = {
  0: "0",
  1: "1",
  2: "2",
  3: "3"
};

var floatToString = function(float, numDec) {
  var currString = "";
  var currFloat = float;

  while (currFloat > 1) {
    var num = null;

    num = parseInt((currFloat % 10), 10);
    currFloat = currFloat / 10;
    currString = numToStringMap[num] + currString;
  }

  if (numDec > 0) {
    currString = currString + ".";
    currFloat = float - parseInt(float, 10);
  }

  for (var i = 0; i < numDec; i++) {
    currFloat = currFloat * 10;
    num = parseInt((currFloat), 10);
    currFloat = currFloat % 1;
    currString = currString + numToStringMap[num];
  }

  return currString;
};

var test = function(float, numDec) {
  console.log(floatToString(float, numDec));
};

test(123.2, 1);
test(123, 1);
test(123.32, 1);
test(0.123, 3);
test(123, 0);
