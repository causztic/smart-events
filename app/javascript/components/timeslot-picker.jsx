import React, { PureComponent } from 'react';
import AvailableTimes from 'react-available-times';

export class TimeSlotPicker extends PureComponent {
  constructor(props){
    super(props)
  }
  render() {
    return (
      <AvailableTimes
        weekStartsOn="monday"
        calendars={[
          {
            id: 'work',
            title: 'Work',
            foregroundColor: '#ff00ff',
            backgroundColor: '#f0f0f0',
            selected: true,
          }
        ]}
        onChange={(selections) => {
          selections.forEach(({ start, end }) => {
            console.log('Start:', start, 'End:', end);
          })
        }}
        recurring={true}
        availableDays={['monday', 'tuesday', 'wednesday', 'thursday', 'friday']}
        availableHourRange={{
          start: 8.5,
          end: 18
        }}
      />)
  }
}