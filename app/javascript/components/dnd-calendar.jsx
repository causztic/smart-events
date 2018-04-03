import React, { PureComponent, Component } from "react";
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
      {`${event.title} (${event.location.name})`}
      <br />
      {event.instructor && event.instructor.name}
    </span>
  );
}

function styleEvent({ type }) {
  return { className: type };
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
      originalEvents: [],
      selectedEvent: null,
      cohort: -1,
      show: false,
      affectAll: false
    };
    this.moveSession = this.moveSession.bind(this);
    this.handleAffectAll = this.handleAffectAll.bind(this);
    this.showModal = this.showModal.bind(this);
    this.hideModal = this.hideModal.bind(this);
    this.instance = axios.create({
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content
      }
    });
  }

  getEventsFromProps() {
    return this.props.events.map(event => {
      event.start = new Date(event.start_time);
      event.end = new Date(event.end_time);
      return event;
    });
  }

  componentDidMount() {
    this.setState({
      events: this.getEventsFromProps(),
      originalEvents: this.getEventsFromProps()
    });
  }

  showModal(event) {
    this.setState({
      show: true,
      selectedEvent: event
    });
  }

  hideModal() {
    this.setState({
      show: false
    });
  }

  handleAffectAll() {
    this.setState({
      affectAll: !this.state.affectAll
    });
  }

  handleErrors(error, originalEvents) {
    this.setState({
      errors: error.response.data.status,
      originalEvents: originalEvents
    });
    handleCohort(this.state.cohort);
  }

  handleCohorts(index) {
    let events = [...this.state.originalEvents];
    if (index !== -1) {
      events = events.filter(event =>
        this.props.cohorts[index].includes(event.id)
      );
    }

    this.setState({
      events: events,
      cohort: index
    });
  }

  moveSession({ event, start, end }) {
    if (this.props.dnd) {
      const { events, originalEvents } = this.state;
      if (this.state.affectAll && event.type === "session") {
        const timeDifference = event.start - start;
        const eventsToMove = [...originalEvents].map(e => {
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
          originalEvents: eventsToMove,
          errors: null
        });

        this.instance
          .put(this.props.batch_url, {
            group: event.group,
            difference: timeDifference
          })
          .then(success => {
            this.handleCohorts(this.state.cohort);
          })
          .catch(error => {
            this.handleErrors(error, originalEvents);
          });
      } else {
        const idx = originalEvents.indexOf(event);
        const updatedEvent = { ...event, start, end };

        const nextEvents = [...originalEvents];
        nextEvents.splice(idx, 1, updatedEvent);

        this.setState({
          originalEvents: nextEvents,
          errors: null
        });
        this.instance
          .put(this.props.url, {
            id: event.id,
            start_time: start,
            end_time: end,
            type: event.type
          })
          .then(success => {
            this.handleCohorts(this.state.cohort);
          })
          .catch(error => {
            this.handleErrors(error, originalEvents);
          });
      }
    }
  }

  render() {
    const { events, affectAll, errors, show, selectedEvent } = this.state;
    return (
      <div>
        {errors && (
          <div className="alert alert-danger">{Object.values(errors)}</div>
        )}
        {this.props.dnd && (
          <div className="btn btn-info" onClick={this.handleAffectAll}>
            {affectAll
              ? "Modify Individual Sessions"
              : "Modify Sessions Across Weeks"}
          </div>
        )}
        <div
          className="btn-group btn-group-toggle"
          data-toggle="buttons"
          style={{ float: "right" }}
        >
          <label
            className="btn btn-secondary active"
            onClick={() => this.handleCohorts(-1)}
          >
            <input type="radio" name="options" autoComplete="off" />ALL
          </label>
          {this.props.cohorts.map((cohort, index) => (
            <label
              className="btn btn-secondary"
              key={index}
              onClick={() => this.handleCohorts(index)}
            >
              <input type="radio" name="options" autoComplete="off" />F0{index +
                1}
            </label>
          ))}
        </div>
        { show &&
          <Modal show={show} onClose={this.hideModal} event={selectedEvent} instance={this.instance} locationUrl={this.props.available_url}/>
        }
        <div style={{ height: "80vh" }}>
          <DND
            events={events}
            views={["work_week"]}
            toolbar={!affectAll}
            defaultView="work_week"
            defaultDate={new Date(2019, 4, 13)}
            min={new Date(2000, 0, 1, 8, 30)}
            max={new Date(2000, 0, 1, 18)}
            onEventDrop={this.moveSession}
            onSelectEvent={this.showModal}
            eventPropGetter={styleEvent}
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

class Modal extends Component {

  constructor(props){
    super(props);
    this.state = {
      errors: null,
      locations: [],
      event: this.props.event,
    }
  }

  componentDidMount(){
    this.props.instance.get(this.props.locationUrl, {
      params: {
        start: this.props.event.start,
        end: this.props.event.end,
      }
    }).then((response) => {
      this.setState({
        locations: response.data
      })
    })
  }

  updateLocation(e){
    this.setState({
      event: {
        ...this.state.event,
        location: this.state.locations.find((location) => location.id == e.target.value)
      }
    })
  }

  render() {
    if (!this.props.show) {
      return null;
    }

    // The gray background
    const backdropStyle = {
      position: "fixed",
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      backgroundColor: "rgba(0,0,0,0.3)",
      zIndex: 1000,
      padding: 50
    };

    // The modal "window"
    const modalStyle = {
      backgroundColor: "#fff",
      borderRadius: 5,
      maxWidth: 600,
      minHeight: 300,
      margin: "0 auto",
      padding: 30
    };

    const { onClose } = this.props;
    const { event } = this.state;

    return (
      <div className="backdrop" style={backdropStyle}>
        <div className="modal" style={modalStyle}>
          <div onClick={onClose} className="btn" style={{padding: 0}}>
            <i className="fas fa-times"/>
          </div>
          {this.state.errors && (
          <div className="alert alert-danger">{Object.values(this.state.errors)}</div>
          )}
          <h2>{event.title}</h2>
          <select value={event.location.id} onChange={(e) => { this.updateLocation(e) }}>
            { this.state.locations.map((location) =>
              <option value={location.id} key={location.id}>{location.name}</option>
            )}
          </select>
          <br/>
          <b>{event.instructor.name}</b>
          <br/>
          Start: <b>{event.start_time}</b>
          <br/>
          End: <b>{event.end_time}</b>
        </div>
      </div>
    );
  }
}

export const DNDCalendar = DragDropContext(HTML5Backend)(Calendar);
