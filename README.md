# simpleAPI

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
This endpoint returns a list of students with their name and enrolled program.
#### Example of a Response:
```json
[
  { "id":1, "first_name": "Josi",  "last_name": "Bolton","course": "Computer Science" },
  { "id":2, "first_name": "Gaston",  "last_name": "Salliere","course": "Software Engineering" },
...
]
```
The /students endpoint can be accessed through [13.60.255.70/students](http://13.60.255.70/students)

### 2. /subjects
This endpoint returns a list of subjects for the Software Engineering program, categorized by academic year.
### Example of a Response:
```json
  [
    {"id":1,"course_name":"Introduction to Computer Science","year":1},
    {"id":2,"course_name":"Programming Fundamentals","year":1}
    {"id":3,"course_name":"Discrete Mathematics","year":1},
    ...
  ]
```
The /subjects endpoint can be accessed through [13.60.255.70/subjects](http://13.60.255.70/subjects)

### Setup Instructions
### Prerequisites:
Node.js: Install Node.js if you haven't already.

MySQL: Install XAMPP for MySQL and Apache or Nginx, or use your preferred MySQL setup.

1. Clone the Repository
Clone the repository to your local machine:
```bash
git clone https://github.com/yourusername/simpleAPI.git
cd simpleAPI
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
node server.js
```
## Understanding Backup Schemes
A backup is a copy of data that is made to protect against data loss. It’s a way to make sure that if something goes wrong—like a system crash, accidental deletion, hardware failure, or a cyberattack—you can restore your important files, systems, or databases.
### The following are the common backup schemes.
#### 1. Full Backup.
A full backup involves the creation of a complete copy of an organization’s files, folders, SaaS data and hard drives. Essentially, all the data is backed up into a single version and moved to a storage device. It’s the perfect protection against data loss when you factor in recovery speed and simplicity. However, the time and expense required to copy all the data (all the time) may make it an undesirable option for many IT professionals.

#### Advantages
- Easy to restore since all data is in one backup.

- Provides complete protection at a single point in time.

#### Disadvantages
- Takes the most time to perform.

- Requires large storage space.

### 2. Incremental Backup
Incremental backup involves backing up all the files, folders, SaaS data and hard drives that have changed since the last backup activity. This could be the most recent full backup in the chain or the last incremental backup. Only the recent changes (increments) are backed up, consuming less storage space and resulting in a speedy backup. However, the recovery time is longer since more backup files will need to be accessed.

#### Advantages
- Saves time and storage by only backing up changed files.
  
- Efficient for frequent backups.

#### Disadvantages
- Slower recovery time since it needs the last full backup and all incrementals.

- More complex to manage.

### 3. Differential Backup
Differential backup falls between full backup and incremental backup. It involves backing up files, folders and hard drives that were created or changed since the last full backup (compared to just the changes since the last incremental backup). Only a small volume of data is backed up between the time interval of the last backup and the current one, consuming less storage space and requiring less time and investment.

#### Advantages
- Faster to restore than incremental backup (only need last full + differential).

- Easier to manage than incremental.

#### Disadvantages
- Takes more space than incremental backup.

- Grows larger each day until the next full backup.

### License
This project is licensed under the MIT License - see the LICENSE file for details.   
