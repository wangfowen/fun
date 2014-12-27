function layOutDay(events) {
  //TODO: create evts from events
  var evts = [
    {left: 0, top: 100, height: 100, width: 100},
    {left: 0, top: 300, height: 100, width: 100}
  ];

  React.render(<Events events={evts} />, document.getElementById('events'));
}

layOutDay([{start: 30, end: 150}, {start: 540, end: 600}, {start: 560, end: 620}, {start: 610, end: 670}]);
