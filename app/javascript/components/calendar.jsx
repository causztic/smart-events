import React, { Component } from 'react'
import BigCalendar from 'react-big-calendar'
import moment from 'moment'

import events from './demo-events'

export class Calendar extends Component {
  constructor(props){
    super(props)
    BigCalendar.momentLocalizer(moment) // or globalizeLocalizer
    this.state = {
      allViews: Object.keys(BigCalendar.Views).map(k => BigCalendar.Views[k])
    }
  }
  render() {
    return  (<div style={{minHeight: "300px"}}>
      <BigCalendar
      events={events}
      views={this.state.allViews}
      step={60}
      showMultiDayTimes
      defaultDate={new Date(2015, 3, 1)}
      />
    </div>)
  }
}