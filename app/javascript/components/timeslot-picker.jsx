import React, { PureComponent } from "react";
import AvailableTimes from "react-available-times";
import axios from "axios";

export class TimeSlotPicker extends PureComponent {
  constructor(props) {
    super(props);
    this.days = ["monday", "tuesday", "wednesday", "thursday", "friday"];
  }

  getTime(rawValue) {
    const hour = (rawValue / 60) % 24;
    const day = this.days[~~(rawValue / 60 / 24)];
    return { day: day, hour: `${~~hour}:${60 * (hour % 1)}` };
  }

  updateSelectedTimes(selections) {
    times = selections.map(({ start, end }) => {
      const { day, startHour: hour } = this.getTime(start);
      const { endHour: hour } = this.getTime(end);
      let obj = new Object();
      obj[day] = { start: startHour, end: endHour };
      console.log(obj);
      return obj;
    });
  }

  render() {
    return (
      <AvailableTimes
        weekStartsOn="monday"
        calendars={[
          {
            id: "work",
            title: "Work",
            foregroundColor: "#ff00ff",
            backgroundColor: "#f0f0f0",
            selected: true
          }
        ]}
        onChange={selections => this.updateSelectedTimes(selections)}
        recurring={true}
        availableDays={this.days}
        availableHourRange={{
          start: 8.5,
          end: 18
        }}
      />
    );
  }
}
