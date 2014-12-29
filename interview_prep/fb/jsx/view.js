var indexToTime = function(i) {
  if (i <= 3) {
    return i + 9;
  } else {
    return i - 3;
  }
  return i;
};

var Hour = React.createClass({
  render: function() {
    return (
      <p className="hour">
        <span className="big">{indexToTime(this.props.index)}:00 </span>
        <span className="small">{this.props.index > 2 ? "PM" : "AM"}</span>
      </p>
    );
  }
});

var HalfHour = React.createClass({
  render: function() {
    return (
      <p className="half-hour small">{indexToTime(this.props.index)}:30</p>
    );
  }
});

var Timeline = React.createClass({
  render: function() {
    var rows = [];

    for (var i = 0; i < 12; i++) {
      rows.push(<Hour index={i} />);
      rows.push(<HalfHour index={i} />);
    }

    rows.push(<Hour index={12} />);

    return <div>{rows}</div>;
  }
});

React.render(Timeline(), document.getElementById('time'));

var Event = React.createClass({
  render: function() {
    var style = {
      left: this.props.left + "px",
      top: this.props.top + "px",
      height: this.props.height + "px",
      width: this.props.width + "px"
    };

    //{this.props.title} and {this.props.location} for dynamic content
    return (
      <div className="event" style={style}>
        <p className="title">Sample Item</p>
        <p className="location">Sample Location</p>
      </div>
    );
  }
});

var Events = React.createClass({
  render: function() {
    var events = [];

    this.props.events.forEach(function(event) {
      events.push(<Event left={event.left} top={event.top} height={event.height} width={event.width} />);
    });

    return <div className="events-container">{events}</div>;
  }
});

