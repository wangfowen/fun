function layOutDay(events) {
  var evts = [];

  for (var i = 0; i < events.length; i++) {
    var event = events[i];
    var start = event.start;
    var end = event.end;

    if (end < start) {
      console.log("End (" + end + ") can't be earlier than start (" + start + ")");
      continue;
    }

    if (start < 0) {
      console.log("Start (" + start + ") can't be earlier than 0 minutes from now");
      start = 0;
    }

    if (end > 720) {
      console.log("End (" + end + ") can't be later than 720 minutes from now");
      end = 720;
    }

    //TODO: left, numOverlap
    var numOverlap = 0;

    evts.push({
      left: 0,
      top: start,
      height: end - start,
      width: 600 / (numOverlap + 1)
    });
  };

  React.render(React.createElement(Events, {events: evts}), document.getElementById('events'));
}

layOutDay([{start: 30, end: 150}, {start: 540, end: 600}, {start: 560, end: 620}, {start: 610, end: 670}]);
