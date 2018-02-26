Event scheduling is a big task at SUTD and in any organization. In this project, we will design a web-based framework or an Android app for smart event scheduling.

[![Build Status](https://travis-ci.com/causztic/smart-events.svg?branch=master)](https://travis-ci.com/causztic/smart-events)

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
- Create a database **smart_events_dev**
- Update database.yml

Run tests with
```
rspec
```