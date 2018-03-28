import React, { Component } from 'react'
import BigCalendar from 'react-big-calendar'
import HTML5Backend from 'react-dnd-html5-backend'
import { DragDropContext } from 'react-dnd'
import withDragAndDrop from 'react-big-calendar/lib/addons/dragAndDrop'
import moment from 'moment'

const DragAndDropCalendar = withDragAndDrop(BigCalendar)

function Event({ event }){
  return (
    <span>
      {`${event.title} (${event.location})`}
      <br/>
      {event.instructor}
    </span>
  )
}

class Calendar extends Component {
  constructor(props){
    super(props)
    BigCalendar.momentLocalizer(moment) // or globalizeLocalizer
    this.state = {
      events: []
    }
    this.moveSession = this.moveSession.bind(this)
  }

  componentDidMount(){
    this.setState({ events: this.props.events.map((event) => {
        event.start = new Date(event.start_time);
        event.end = new Date(event.end_time);
        return event;
      })
    });
  }

  render() {
    return  (<div style={{height: "80vh"}}>
      <DragAndDropCalendar
      events={this.state.events}
      defaultView='week'
      defaultDate={new Date(2019, 4, 13)}
      min={new Date(2000, 0, 1, 8, 30)}
      max={new Date(2000, 0, 1, 18)}
      onEventDrop={this.moveSession}
      components={{
        event: Event,
      }}
      />
    </div>)
  }

  moveSession({ event, start, end }) {
    const { events } = this.state
    console.log("asdf");
    const idx = events.indexOf(event)
    const updatedEvent = { ...event, start, end }

    const nextEvents = [...events]
    nextEvents.splice(idx, 1, updatedEvent)

    this.setState({
      events: nextEvents,
    })

    alert(`${event.title} was dropped onto ${event.start}`)
  }

}

export default DragDropContext(HTML5Backend)(Calendar)