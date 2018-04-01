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
    this.handleAffectAll = this.handleAffectAll.bind(this);
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

  handleAffectAll() {
    this.setState({
      affectAll: !this.state.affectAll
    });
  }

  handleErrors(error, events) {
    this.setState({
      errors: error.response.data.status,
      events: events
    });
  }

  moveSession({ event, start, end }) {
    if (this.props.dnd) {
      const { events } = this.state;
      if (this.state.affectAll && this.event.type === 'session') {
        const timeDifference = event.start - start;
        const eventsToMove = [...events].map(e => {
          // don't mutate previous state.
          if (e.group === event.group) {
            return {
              ...e,
              start: new Date(e.start - timeDifference),
              end: new Date(e.end - timeDifference)
            };
          }
          return { ...e };
        });

        this.setState({
          events: eventsToMove,
          errors: null
        });

        this.instance
          .put(this.props.batch_url, {
            group: event.group,
            difference: timeDifference
          })
          .then()
          .catch(error => {
            this.handleErrors(error)
          });
      } else {
        const idx = events.indexOf(event);
        const updatedEvent = { ...event, start, end };

        const nextEvents = [...events];
        nextEvents.splice(idx, 1, updatedEvent);

        this.setState({
          events: nextEvents,
          errors: null
        });
        this.instance
          .put(this.props.url, {
            id: event.id,
            start_time: start,
            end_time: end,
            type: event.type
          })
          .then()
          .catch(error => {
            this.handleErrors(error, events)
          });
      }
    }
  }

  render() {
    const { events, affectAll, errors } = this.state;
    return (
      <div>
        { errors && <div className="alert alert-danger">{Object.values(errors)}</div>}
        { this.props.dnd &&
        <div className="btn btn-info" onClick={this.handleAffectAll}>
          {affectAll
            ? "Modify Individual Sessions"
            : "Modify Sessions Across Weeks"}
        </div> }
        <div style={{ height: "80vh" }}>
          <DND
            events={events}
            views={["week"]}
            toolbar={!affectAll}
            defaultView="week"
            defaultDate={new Date(2019, 4, 13)}
            min={new Date(2000, 0, 1, 8, 30)}
            max={new Date(2000, 0, 1, 18)}
            onEventDrop={this.moveSession}
            components={{
              event: Event,
              header: affectAll && EventHeader
            }}
          />
        </div>
      </div>
    );
  }
}

export const DNDCalendar = DragDropContext(HTML5Backend)(Calendar);
