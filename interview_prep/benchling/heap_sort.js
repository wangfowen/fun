//define a Heap
var Heap = {
  //returns min and re-sorts heap
  popMin: function(),
  initialize: function(array),
  push: function(item)
};

var mergeLists = function(sortedLists) {
  var minHeap = new Heap();
  var mergedList = [];

  for (var i = 0; i < sortedLists.length; i++) {
    minHeap.push({element: sortedLists.splice(0,1), listNum: i});
  }

  var n = sortedLists.length;
  var m = sortedLists[0].length;

  while (mergedList.length < (n * m)) {
    var popped = minHeap.popMin();
    mergedList.push(popped.element);

    if (sortedLists[popped.listNum].length > 0) {
      minHeap.push({element: sortedLists[popped.listNum].splice(0,1), listNum: popped.listNum});
    }
  }

  return mergedList;
}
