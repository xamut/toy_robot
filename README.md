# Toy Robot Simulator

[![Ruby](https://img.shields.io/badge/ruby-2.4.1-green.svg)](https://www.ruby-lang.org/en/downloads/)
[![Bundler](https://img.shields.io/badge/bundler-1.15.1-green.svg)](http://bundler.io)
[![Build Status](https://travis-ci.org/xamut/toy_robot.svg?branch=master)](https://travis-ci.org/xamut/toy_robot)
[![Code Climate](https://codeclimate.com/github/xamut/toy_robot/badges/gpa.svg)](https://codeclimate.com/github/xamut/toy_robot)
[![Test Coverage](https://codeclimate.com/github/xamut/toy_robot/badges/coverage.svg)](https://codeclimate.com/github/xamut/toy_robot/coverage)

### Description:
The application is a simulation of a toy robot moving on a square tabletop, of
dimensions 5 units x 5 units. There are no other obstructions on the table
surface. The robot is free to roam around the surface of the table.


- PLACE will put the toy robot on the table in position `X`,`Y` and facing
`NORTH`, `SOUTH`, `EAST` or `WEST`.
- The origin (0,0) can be considered to be the `SOUTH WEST` most corner.
- The first valid command to the robot is a `PLACE` command, after that, any
sequence of commands may be issued, in any order, including another `PLACE`
command.
- `MOVE` will move the toy robot one unit forward in the direction it is
currently facing.
- `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified
direction without changing the position of the robot.
- `REPORT` will announce the `x`,`y` and `facing` of the robot.
- Input can be from a file or from standard input.

### Installation
```bash
git clone https://github.com/xamut/toy_robot.git
cd toy_robot
bin/setup
```

### Usage
```bash
bin/toy_robot help start
bin/toy_robot start                             # Start toy robot with default settings
bin/toy_robot start -f FILE                     # Start toy robot with default settings and read commands from file
bin/toy_robot start -f examples/commands_1.txt  # Start toy robot with default settings and read commands from file
bin/toy_robot start -l 10 -w 10                 # Start toy robot with length of 10 units and width of 10 units
```

