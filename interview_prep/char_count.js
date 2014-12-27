/*Given a string, count the occurrences of each character, and print them out in descending order sorted by occurrence count.

"banana"

a 3
n 2
b 1

*/

var printDesc = function(input_string) {
    var charCount = {};

    for (var i = 0; i < input_string.length; i++) {
        if (charCount[input_string[i]] !== undefined) {
            charCount[input_string[i]] += 1;
        } else {
            charCount[input_string[i]] = 1;
        }
    }

    var alreadyCounted = {};

    for (var i in charCount) {
        var max = 0,
            maxChar;

        for (var char in charCount) {
            if (charCount[char] > max && alreadyCounted[char] === undefined) {
                max = charCount[char];
                maxChar = char;
            }
        }

        console.log(maxChar + " " + max);
        alreadyCounted[maxChar] = max;
    }
};
