import React, { PureComponent } from "react";
import BigCalendar from "react-big-calendar";
import HTML5Backend from "react-dnd-html5-backend";
import { DragDropContext } from "react-dnd";
import withDragAndDrop from "react-big-calendar/lib/addons/dragAndDrop";
import moment from "moment";
import axios from "axios";

const DAYS = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

function Event({ event }) {
  return (
    <span>
      {`${event.title} (${event.location})`}
      <br />
      {event.instructor && event.instructor}
    </span>
  );
}

function EventHeader({ date }) {
  return <div>{DAYS[date.getDay()]}</div>;
}

const DND = withDragAndDrop(BigCalendar);

class Calendar extends PureComponent {
  constructor(props) {
    super(props);
    BigCalendar.momentLocalizer(moment); // or globalizeLocalizer
    this.state = {
      events: [],
      affectAll: false
    };
    this.moveSession = this.moveSession.bind(this);
    this.instance = axios.create({
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content
      }
    });
  }

  componentDidMount() {
    this.setState({
      events: this.props.events.map(event => {
        event.start = new Date(event.start_time);
        event.end = new Date(event.end_time);
        return event;
      })
    });
  }

  moveSession({ event, start, end }) {
    if (this.props.dnd) {
      const { events } = this.state;
      const idx = events.indexOf(event);
      const updatedEvent = { ...event, start, end };

      const nextEvents = [...events];
      nextEvents.splice(idx, 1, updatedEvent);

      this.setState({
        events: nextEvents
      });
      this.instance
        .put(this.props.url, { id: event.id, start_time: start, end_time: end })
        .then()
        .catch(error => {
          alert(error.response.data.status);
          this.setState({
            events: events
          });
        });
    }
  }

  render() {
    return (
      <div style={{ height: "80vh" }}>
        <DND
          events={this.state.events}
          views={["week"]}
          toolbar={!this.state.affectAll}
          defaultView="week"
          defaultDate={new Date(2019, 4, 13)}
          min={new Date(2000, 0, 1, 8, 30)}
          max={new Date(2000, 0, 1, 18)}
          onEventDrop={this.moveSession}
          components={{
            event: Event,
            header: this.state.affectAll && EventHeader
          }}
        />
      </div>
    );
  }
}

export const DNDCalendar = DragDropContext(HTML5Backend)(Calendar);
