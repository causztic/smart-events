import React, { Component } from 'react'
import BigCalendar from 'react-big-calendar'
import moment from 'moment'

export class Calendar extends Component {
  constructor(props){
    super(props)
    BigCalendar.momentLocalizer(moment) // or globalizeLocalizer
    this.state = {
      events: []
    }
  }

  componentDidMount(){
    // this.setState({ events: this.props.events.map((event) => {
    //     event.start = new Date(event.start);
    //     event.end = new Date(event.end);
    //     return event;
    //   })
    // });
  }

  render() {
    return  (<div style={{height: "400px"}}>
      <BigCalendar
      events={this.state.events}
      views={Object.keys(BigCalendar.Views).map(k => BigCalendar.Views[k])}
      step={60}
      showMultiDayTimes
      defaultDate={new Date()}
      />
    </div>)
  }
}