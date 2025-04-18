# deploymentAPI

## Project Overview
This project involves developing and deploying a simple API for the CS 421 course, using Node.js, Express, and MySQL (via XAMPP). The API has two endpoints:

- **/students**: Returns a JSON response with a list of students and their enrolled programs.
- **/subjects**: Returns a JSON response listing subjects from Year 1 to Year 4 for a Software Engineering program.

The API is deployed on an AWS EC2 instance and is accessible publicly.

## Table of Contents
- [API Endpoints](#api-endpoints)
- [Setup Instructions](#setup-instructions)
- [Prerequisites](#prerequisties)
- [Endpoints](#endpoints)
- [License](#license)

---

## API Endpoints

### 1. `/students`
This endpoint returns a list of at least 10 students with their name and enrolled program.
#### Example Response:
```json
[
  { "name": "Oscar Kimenyi", "program": "Software Engineering" },
  { "name": "Hussein Makame", "program": "Software Engineering" },
  ...
]
```

### 2. /subjects
This endpoint returns a list of subjects for the Software Engineering program, categorized by academic year.
### Example Response:
```json
  [
    {"id":1,"name":"Principles of Programming Languages(CP 111)","year":1},
    {"id":2,"name":"Development Perspectives(DS 102)","year":1}
    {"id":3,"name":"Mathematical Foundations of Information Security-(IA 112)","year":1},
    {"id":4,"name":"Introduction to Information Technology(IT 111)", "year":1},
    ...
  ]
```
### Setup Instructions
### Prerequisites:
Node.js: Install Node.js if you haven't already.

MySQL: Install XAMPP for MySQL and Apache, or use your preferred MySQL setup.

1. Clone the Repository
Clone the repository to your local machine:
```bash
git clone https://github.com/yourusername/myapi.git
cd myapi
```
2. Install Dependencies
Run the following command to install the necessary dependencies:
```bash
npm install
```
3. Set Up the MySQL Database
Open XAMPP and start the Apache and MySQL services.

Open phpMyAdmin and create a database named cs421_db.

If you wish to use a real database, create tables for students and subjects or simply use static JSON data as shown in the code.

4. Running the Application
To run the application locally:
```bash
node index.js
```
The API will be accessible at http://localhost:3000.

### License
This project is licensed under the MIT License - see the LICENSE file for details.   
