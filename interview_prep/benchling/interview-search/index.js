var fs = require('fs'),
    walk = require('fs-walk'),
    path = require('path');

var trigram_map = {};
var file_map = {};

/**
 * stdin loop - calls indexFile on esprima.js and then processes
 * user input, printing results.
 */
function run() {
    walk.filesSync('./resources', function(basedir, filename, stat, next) {
        filepath = path.join(basedir, filename);
        data = fs.readFileSync(filepath, {encoding: 'utf-8'});
        indexFile(filepath, data);
    }, function(err) {
        if (err) console.log(err);
    });
    console.info(trigram_map);
    process.stdout.write('> ');
    process.stdin.on('data', function(query) {
        results = search(query.toString().trim());
        process.stdout.write(results.length + ' result(s)\n');
        results.forEach(function(result) {
            console.log(result);
        })
        process.stdout.write('> ');
    });
}

/**
 * Processes `data` corresponding to file `filename` for search.
 */
function indexFile(filename, data) {
    console.info('indexFile', filename, data.length);
    for (var i = 0; i < data.length - 2; i++) {
      var trigram = data.substring(i, i+3).toLowerCase();
      if (!trigram_map[trigram]) {
        trigram_map[trigram] = {};
      }
      trigram_map[trigram][filename] = true;
    }

    file_map[filename] = data;
}

/**
 * Given seach query, returns array of objects with
 * `filename`, `lineno`, and `col` corresponding to matches.
 */
function search(query) {
    var intersection_list = null;

    for (var i = 0; i < query.length - 2; i++) {
      var trigram = query.substring(i, i+3).toLowerCase();
      //get filenames list for trigram
      if (!intersection_list) {
        intersection_list = trigram_map[trigram];
      } else {
        intersection_list = intersection(trigram_map[trigram], intersection_list);
      }
    }

    var matched_list = [];

    for (var filename in intersection_list) {
      var index = file_map[filename].indexOf(query);

      if (index !== -1) {
        matched_list.push({filename: filename});
      }
    }

    return matched_list;
}

function intersection(dictionary1, dictionary2) {
  var intersection_list = {};

  for (var key in dictionary1) {
    if (dictionary2[key]) {
      intersection_list[key] = dictionary1[key];
    }
  }

  return intersection_list;
}

run();

