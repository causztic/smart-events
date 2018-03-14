import React, { Component } from 'react'
import BigCalendar from 'react-big-calendar'
import moment from 'moment'

export class Calendar extends Component {
  constructor(props){
    super(props)
    BigCalendar.momentLocalizer(moment) // or globalizeLocalizer
    this.state = {
      allViews: ['month', 'work_week'],
      events: this.props.events
    }
  }
  render() {
    return  (<div style={{height: "400px"}}>
      <BigCalendar
      events={this.state.events}
      views={this.state.allViews}
      step={60}
      showMultiDayTimes
      />
    </div>)
  }
}