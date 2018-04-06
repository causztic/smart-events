<b>Event scheduling is a big task at SUTD and in any organization. In this project, we will design a web-based framework or an Android app for smart event scheduling.</b>

[![Build Status](https://travis-ci.org/causztic/smart-events.svg?branch=master)](https://travis-ci.org/causztic/smart-events)
[![Maintainability](https://api.codeclimate.com/v1/badges/517471ecad1083fbb8b6/maintainability)](https://codeclimate.com/github/causztic/smart-events/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/517471ecad1083fbb8b6/test_coverage)](https://codeclimate.com/github/causztic/smart-events/test_coverage)

<h1>Features Implemented</h1>
<ul>
  <li> <b>Accounts</b>
  <ul>
  <li> <b>Login Page</b> for individual <b>Student, Instructor</b> or <b>Coordinator</b> accounts.</li>
  <li> <b>Chat System</b> to allow <b>Instructors</b> to send messages to <b>Coordinators</b> or vice versa. </li>
   </ul>
&nbsp;
  <li><b>Utility / Functions</b>
  <ul>
  <li> Added Link for <b>Subscription to Calendar.</b> </li>
  <li> Allow the creation of individual <b>Events</b></li>
  <li> <b>Automated duplicating of sessions</b> across the 13 weeks in a term. </li>
  <li> <b>Validation</b> added when dragging and dropping sessions. </li>
  <li> Able to <b>filter timetables by Cohort Classes.</b> </li>
    </ul>
&nbsp;

  <li> <b>Student Features</b></li>
  <ul>
  <li> Allows subscription to calendar. </li>
  <li> <b>View timetable</b> belonging to individual <b>Student</b> account. </li> 
  </ul>

  <li> <b>Instructor Features</b></li>
  <ul>
  <li> Allows subscription to calendar. </li>
  <li> Has access to <b>Chat System</b> to contact <b>Coordinator</b> on proposed changes.</li>
  <li> <b>Suggest changes</b> of specific events to <b>Coordinator</b>.</li>   
 
  <li> <b>Coordinator Features</b></li>
  <ul>
  <li> Allows subscription to calendar. </li>
  <li> <b>Coordinators</b> can <b>drag and drop</b> Events to re-order them. </li> 
  <li> <b>Coordinator</b> is able to <b>edit calendar items via an entire week or entire term.</b> </li>
  <li> Added button for <b>Coordinator</b> to <b>regenerate schedule.</b> </li>
  <li> <b> Creation of individual events</b>
  <li> <b>Coordinator</b> can have <b>many chatrooms simultaneously</b> while Instructors can only have one.</li>
    </ul>
</ul>
<h1>To be Integrated</h1>
<ul>
<li> Allowing instructors to <b>select their desired locations for specific events.</b></li>
<li> Allowing coordinators to <b>change locations of individual sessions.</b></li>
<li> Implementing <b>genetic algorithm</b> into code for efficient scheduling. </li>
</ul>

# Getting Started

Install node
```
https://www.npmjs.com/package/yarn/tutorial
```

```
git clone git@github.com:causztic/smart-events.git
bundle install
cp config/database.yml.sample config/database.yml
yarn install
```

# Testing
- Create a database **smart_events_test**
- Update database.yml


# Populating Data
```
rake db:seed
rake scrape:faculty  # this scrapes SUTD's page for faculty email
rake assign:subjects # assign subjects randomly to students based on their pillar
rake assign:faculty  # assign faculty to the subjects assigned
```

Run tests with
```
rspec
rubocop
reek
```