var CALENDAR_WIDTH = 600;
var CALENDAR_HEIGHT = 720;

function layOutDay(events) {
  var eventRenders = [];
  var eventsQueue = [];
  var maxQueuedEnd = 0;

  var placeQueued = function() {
    if (eventsQueue.length == 0) {
      return;
    }

    var earliestOverlapEnd = eventsQueue[0].end;
    var W = eventsQueue.length;
    var currW = 0;

    //loop through to figure out max W
    _.each(eventsQueue, function(event) {
      if (event.start > earliestOverlapEnd) {
        earliestOverlapEnd = event.end;
        if (currW < W) {
          W = currW;
        }
        currW = 0;
      } else {
        currW++;
      }
    });

    var num = 0;
    _.each(eventsQueue, function(event) {
      eventRenders.push({
        top: event.start,
        height: event.end - event.start,
        width: CALENDAR_WIDTH / W,
        left: num * CALENDAR_WIDTH / W
      });

      num = (num + 1) % W;
    });

    eventsQueue = [];
  };

  _.chain(events)
    //input valid so assumed to have start and end
    //drop ones that aren't correctly formatted or take 0 time
    .filter(function(event) { return event.end > event.start; })
    //shorten ones that are too long
    .map(function(event) {
      var start = event.start;
      var end = event.end;

      if (start < 0) {
        console.log("Start (" + start + ") can't be earlier than 0 minutes from now");
        start = 0;
      }

      if (end > CALENDAR_HEIGHT) {
        console.log("End (" + end + ") can't be later than " + CALENDAR_HEIGHT + " minutes from now");
        end = CALENDAR_HEIGHT;
      }

      return { start: start, end: end };
    })
    //sort by start time
    .sortBy(function(event) { return event.start; })
    //main logic of laying out
    .each(function(currEvent) {
      if (eventsQueue.length > 0 && currEvent.start >= maxQueuedEnd) {
        placeQueued();
      }

      eventsQueue.push(currEvent);
      if (currEvent.end > maxQueuedEnd) {
        maxQueuedEnd = currEvent.end;
      }
    });

  //place remaining ones
  placeQueued();

  React.render(React.createElement(Events, {events: eventRenders}), document.getElementById('events'));
}

layOutDay([{start: 30, end: 150}, {start: 540, end: 600}, {start: 560, end: 620}, {start: 610, end: 670}]);
//large overlapping two as first - should all be thirds
//layOutDay([{start: 80, end: 100}, {start: 50, end: 400}, {start: 200, end: 300}, {start: 210, end: 320}]);
//large overlapping two as second - should all be thirds
//layOutDay([{start: 30, end: 100}, {start: 50, end: 400}, {start: 200, end: 300}, {start: 210, end: 320}]);
//super chained overlaps - should be 4ths
//layOutDay([{start: 50, end: 100}, {start: 70, end: 120}, {start: 90, end: 140}, {start: 100, end: 120}, {start: 110, end: 130}]);
//double chained overlaps - should be thirds
//layOutDay([{start: 50, end: 100}, {start: 70, end: 120}, {start: 90, end: 140}, {start: 100, end: 120}, {start: 120, end: 130}]);
//first and third and fifth touching
//layOutDay([{start: 30, end: 100}, {start: 50, end: 200}, {start: 100, end: 150}, {start: 100, end: 170}, {start: 150, end: 200}]);
//four in a row, no overlap
//layOutDay([{start: 50, end: 100}, {start: 100, end: 200}, {start: 200, end: 300}, {start: 300, end: 500}]);
