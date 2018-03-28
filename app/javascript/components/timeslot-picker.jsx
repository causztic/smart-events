import React, { PureComponent } from "react";
import AvailableTimes from "react-available-times";
import axios from "axios";

export class TimeSlotPicker extends PureComponent {
  constructor(props) {
    super(props);
    this.days = ["monday", "tuesday", "wednesday", "thursday", "friday"];
    this.instance = axios.create({
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content
      }
    });
    if (this.props.preferences) {
      let preferences = this.props.preferences.map(p => {
        let key = Object.keys(p)[0];
        let [hour, minute] = p[key].start.split(":");
        let [endHour, endMinute] = p[key].end.split(":");

        minute = parseInt(minute);
        endMinute = parseInt(endMinute);
        return {
          start: this.days.indexOf(key) * 24 * 60 + hour * 60 + minute,
          end: this.days.indexOf(key) * 24 * 60 + endHour * 60 + endMinute
        };
      });
      this.state = { preferences: preferences };
    } else {

      const baseStart = 8 * 60 + 30;
      const baseEnd = 18 * 60;

      let preferences = [0,1,2,3,4].map(day => ({
        start: baseStart + day * 24 * 60,
        end: baseEnd + day * 24 * 60
      }))

      this.state = {
        preferences: preferences
      }
    }
  }

  componentDidMount() {}

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
    this.instance.put(this.props.url, times);
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
        height={600}
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
