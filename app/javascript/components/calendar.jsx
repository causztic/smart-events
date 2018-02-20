import React, { Component } from 'react'
import BigCalendar from 'react-big-calendar'
import moment from 'moment'

import events from './demo-events'

// Setup the localizer by providing the moment (or globalize) Object
// to the correct localizer.
BigCalendar.momentLocalizer(moment) // or globalizeLocalizer

let allViews = Object.keys(BigCalendar.Views).map(k => BigCalendar.Views[k])

let Basic = () => (
  <BigCalendar
    events={events}
    views={allViews}
    step={60}
    showMultiDayTimes
    defaultDate={new Date(2015, 3, 1)}
  />
)

export default Basic