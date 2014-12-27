// By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
// find the sum of the even-valued terms.

var fib = (function() {
  var cache = {};

  return function(n) {
    if (cache[n])
      return cache[n];

    if (n <= 1)
      return 1;

    return cache[n] = fib(n - 1) + fib(n - 2);
  };
}());

var count = 1,
    sum = 0,
    THRESHOLD = 4000000,
    f;

while ((f = fib(count)) < THRESHOLD) {
  if (f % 2 === 0)
    sum += f;

  count++;
}

console.log(sum);
