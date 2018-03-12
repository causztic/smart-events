Event scheduling is a big task at SUTD and in any organization. In this project, we will design a web-based framework or an Android app for smart event scheduling.

[![Build Status](https://travis-ci.org/causztic/smart-events.svg?branch=master)](https://travis-ci.org/causztic/smart-events)
[![Maintainability](https://api.codeclimate.com/v1/badges/517471ecad1083fbb8b6/maintainability)](https://codeclimate.com/github/causztic/smart-events/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/517471ecad1083fbb8b6/test_coverage)](https://codeclimate.com/github/causztic/smart-events/test_coverage)
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
```