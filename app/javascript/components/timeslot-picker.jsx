import React, { PureComponent } from "react";
import AvailableTimes from "react-available-times";
import axios from "axios";

export class TimeSlotPicker extends PureComponent {
  constructor(props) {
    super(props);
    this.days = ["monday", "tuesday", "wednesday", "thursday", "friday"];
    this.instance = axios.create({
      headers: { 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content }
    });
    let preferences = (this.props.preferences || []).map((p) => {
      let key = Object.keys(p)[0];
      let [ hour, minute ] = p[key].start.split(':');
      let [ endHour, endMinute ] = p[key].end.split(':');

      return {
        start: new Date(2018, 2, this.days.indexOf(key) + 1, hour, minute),
        end: new Date(2018, 2, this.days.indexOf(key) + 1, endHour, endMinute),
      }
    });

    console.log(preferences)
    this.state = {
      preferences: preferences
    };
  }

  getTime(rawValue) {
    const hour = (rawValue / 60) % 24;
    const day = this.days[~~(rawValue / 60 / 24)];
    return { day: day, hour: `${~~hour}:${60 * (hour % 1)}` };
  }

  updateSelectedTimes(selections) {
    let times = selections.map(({ start, end }) => {
      const { day, hour: startHour } = this.getTime(start);
      const { hour: endHour } = this.getTime(end);
      let obj = new Object();
      obj[day] = { start: startHour, end: endHour };
      return obj;
    });
    console.log(times);
    this.instance.put(this.props.url, times, );
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
        initialSelections={this.state.preferences}
        availableDays={this.days}
        availableHourRange={{
          start: 8.5,
          end: 18
        }}
      />
    );
  }
}
