var _ = require('underscore');

orfs = function(bases, circular) {
  var START = "ATG";
  var END = "TAG";
  var results = [];
  var open_pairs = [];

  for (var i = 0; i < bases.length - 2; i++) {
    var current_triplet = bases.substring(i, i+3);

    if (current_triplet === START) {
      var matched = false
      for (var pair in open_pairs) {
        if (open_pairs[pair][0] % 3 == i % 3) {
          open_pairs[pair].push(i);
          matched = true;
        }
      }

      if (!matched) {
        open_pairs.push([i]);
      }
    }

    if (current_triplet === END && open_pairs.length > 0) {
      for (var pair in open_pairs) {
        if (open_pairs[pair][0] % 3 == i % 3) {
          var start = open_pairs.splice(pair, 1)[0];
          results.push({startPositions: start, endPosition: i});
        }
      }
    }
  }

  return results;

  //if circular, loop to beginning for looking at next three. otherwise stop at length - 3
  //if flag is true, loop from beginning again to look for an end
  //return results
}

check = function(answer, expected) {
  if (!_.isEqual(answer, expected)) {
    console.log("Test case failed: ")
    console.log("... answer:   " + JSON.stringify(answer))
    console.log("... expected: " + JSON.stringify(expected))
  }
}

// console.log(_);
//base case
check(orfs('ATGAAACCCTAG', false), [{startPositions: [0], endPosition: 9}])
//multiple starts
check(orfs('ATGAAAATGTAG', false), [{startPositions: [0, 6], endPosition: 9}])
//multiple start stops
check(orfs('ATGAATGCCTAGCTAG', false), [{startPositions: [0], endPosition: 9}, {startPositions: [4], endPosition: 13}])
//multiple potential ends
check(orfs('ATGTAGATGTAG', false), [{startPositions: [0], endPosition: 3}, {startPositions: [6], endPosition: 9}])
/*
check(orfs('ATGAAAATGAAA', true), [])
check(orfs('TAGAAAATGCCC', true), [{startPositions: [6], endPosition: 0}])
check(orfs('ATGTAGAAAATGATG', true), [{startPositions: [0, 9, 12], endPosition: 3}])
check(orfs('TAGAAAGATGCCC', true), [{startPositions: [7], endPosition: 0}])
check(orfs('TAGAAAATGGCCC', true), [])
check(orfs('AAAAAAATGGGG', true), [])
*/
