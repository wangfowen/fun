/*
write JSON.parse

input:

JSON.parse('{"foo":  {"bar" : "baz"},  "qux":  {"quux": "quuux"}, "foo2": "bar2"}')
output:
{ foo: { bar: 'baz' },
  qux: { quux: 'quuux' },
  foo2: 'bar2' }

*/

var parse = function(json_string) {
   var tokens = tokenize(json_string),
       parsed = {};
};

var tokenize = function(json_string) {
   var tokens = [],
       inString = false,
       token = "";

   var specialChars = {
       "{" : 0,
       "}" : 1,
       ":" : 2,
       "," : 3
   }

  for (var i = 0; i < json_string.length; i++) {
      if (specialChars[json_string[i]] !== undefined && !inString)
          tokens.push(specialChars[json_string[i]]);
      else if (inString && json_string[i] !== "\"") {
          token += json_string[i];
      } else if (json_string[i] === "\"") {
          if (inString) {
              tokens.push(token);
              token = "";
              inString = false;
          } else {
              inString = true;
          }
      }
  }

  return tokens;
};
