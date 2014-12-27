var indexToTime = function(i) {
  if (i <= 3) {
    return i + 9;
  } else {
    return i - 3;
  }
  return i;
};

var Hour = React.createClass({displayName: 'Hour',
  render: function() {
    return (
      React.createElement("p", {className: "hour"}, 
        React.createElement("span", {className: "big"}, indexToTime(this.props.index), ":00 "), 
        React.createElement("span", {className: "small"}, this.props.index > 2 ? "PM" : "AM")
      )
    );
  }
});

var HalfHour = React.createClass({displayName: 'HalfHour',
  render: function() {
    return (
      React.createElement("p", {className: "half-hour small"}, indexToTime(this.props.index), ":30")
    );
  }
});

var Timeline = React.createClass({displayName: 'Timeline',
  render: function() {
    var rows = [];

    for (var i = 0; i < 12; i++) {
      rows.push(React.createElement(Hour, {index: i}));
      rows.push(React.createElement(HalfHour, {index: i}));
    }

    rows.push(React.createElement(Hour, {index: 12}));

    return React.createElement("div", null, rows);
  }
});

React.render(Timeline(), document.getElementById('time'));

var Event = React.createClass({displayName: 'Event',
  render: function() {
    var style = {
      left: this.props.left + "px",
      top: this.props.top + "px",
      height: this.props.height + "px",
      width: this.props.width + "px"
    };

    //{this.props.title} and {this.props.location} for dynamic content
    return (React.createElement("div", {className: "event", style: style}, 
        React.createElement("p", {className: "title"}, "Sample Item"), 
        React.createElement("p", {className: "location"}, "Sample Location")
      )
    );
  }
});

var Events = React.createClass({displayName: 'Events',
  render: function() {
    var events = [];

    this.props.events.forEach(function(event) {
      events.push(React.createElement(Event, {left: event.left, top: event.top, height: event.height, width: event.width}));
    });

    return React.createElement("div", {className: "events-container"}, events);
  }
});

