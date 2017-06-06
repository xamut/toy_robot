# Toy Robot Simulator

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
