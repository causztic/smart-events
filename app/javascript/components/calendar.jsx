import React, { Component } from 'react'
import BigCalendar from 'react-big-calendar'
import moment from 'moment'

function Event({ event }){
  return (
    <span>
      {`${event.title} (${event.location})`}
      <br/>
      {event.instructor}
    </span>
  )
}

export class Calendar extends Component {
  constructor(props){
    super(props)
    BigCalendar.momentLocalizer(moment) // or globalizeLocalizer
    this.state = {
      events: []
    }
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
      <BigCalendar
      events={this.state.events}
      views={Object.keys(BigCalendar.Views).map(k => BigCalendar.Views[k])}
      step={60}
      showMultiDayTimes
      defaultView='week'
      defaultDate={new Date(2019, 4, 13)}
      min={new Date(2000, 0, 1, 8, 30)}
      max={new Date(2000, 0, 1, 18)}
      components={{
        event: Event,
      }}
      />
    </div>)
  }
}