# Volunteer Tracker

Ruby week 3 code review covering database basics and psql

## Description

This website is built for the humble non-profit employee! You can create, view, update, and delete projects! You can create volunteer profiles and assign them to projects as well to help keep track of progress. Hours can be added and edited for an individual volunteer, and project hours are totaled as well. Sort volunteers and projects alphabetically or by hours contributed. Website uses postgres and psql for databases and data queries.

### Prerequisites

Web browser with ES6 compatibility
Examples: Chrome, Safari

Ruby 2.2.2
Bundler
Postgres

### Installing

Installation is not quick, nor particularly easy. First ensure you have Postgres installed. Then:

* Navigate to terminal and run the following commands to set up your databases:
  * CREATE DATABASE volunteer_tracker;
  * \c volunteer_tracker;
  * CREATE TABLE projects (id serial PRIMARY KEY, name varchar);
  * CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar);
  * CREATE DATABASE volunteer_tracker_test with template volunteer_tracker;

Second, clone this repository to your machine, navigate to the file path in your terminal, and run 'app.rb' by typing '$ruby app.rb'. Now just copy the localhost path into your web browser. The standard localhost for Sinatra is port 4567 (eg: localhost:4567)

## Built With

* Ruby
* Sinatra
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Jquery https://jquery.com/
* Postgres
* PSQL
Full list of gems can be found in the Gemfile

## Specifications

| behavior |  input   |  output  |
|----------|:--------:|:--------:|
|add project| project name: "riparian restoration"| |new project: riparian restoration|
|add volunteer| volunteer name: "Christine"| Volunteer: "Christine" |
|add hours| update hours: 8 | hours volunteered: 8 |


## Authors

* Grady L Shelton

## Known Bugs
Names with apostrophes are not yet welcomed.

## Contact

Please contact Grady L Shelton at gradyish@gmail.com if you have any questions.

### Legal

Copyright © 2017 **Grady L Shelton**

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
