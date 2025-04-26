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
- [Understanding Backup Schemes](understanding-backup-schemes)
- [bash_scripts Overview](bash-scripts-overview)
- [Dependencies](dependencies)
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
The /students endpoint can be accessed through [51.20.34.197/students](http://51.20.34.197/students)

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
The /subjects endpoint can be accessed through [51.20.34.197/subjects](http://51.20.34.197/subjects)

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
---

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
---

##  bash_scripts Overview

This folder contains three Bash scripts used for monitoring, backing up, and updating the server hosting this API.

### 1. `health_check.sh`

- **Purpose**: Monitors the server’s health and verifies API functionality.
- **Checks performed**
  - CPU usage
  - Memory usage
  - Disk usage
  - Status of Nginx web server
  - Availability of `/students` and `/subjects` endpoints using `curl`
- **Logs to**: `/var/log/server_health.log`
- **Warnings** are recorded if:
  - Nginx is inactive
  - API endpoints return non-200 status
  - Disk usage is ≥ 90%
    

### 2. `backup_api.sh`

- **Purpose**: Creates a backup of:
  - The Node.js API project directory (`/var/www/my_node_api`)
  - If using a database (e.g., MySQL, PostgreSQL), export the database to /home/ubuntu/backups/db_backup_$(date +%F).sql.
- **Backup location**: `/home/ubuntu/backups/`
- **Format**
  - API files: `api_backup_YYYY-MM-DD.tar.gz`
  - Database: `mongo_backup_YYYY-MM-DD/`
- **Old backups (older than 7 days)** are deleted automatically.
- **Logs to**: `/var/log/backup.log`


### 3. `update_server.sh`

- **Purpose**
  - Updates Ubuntu packages
  - Pulls the latest code from GitHub
  - Restarts the Nginx web server
- **Logs to**: `/var/log/update.log`
- If `git pull` fails, the script logs the error and aborts without restarting the server.

---

##  Setup Instructions

1. **Upload the scripts to your EC2 instance**
   ```bash
   scp bash_scripts/*.sh ubuntu@<your-server-ip>:/home/ubuntu/
   ```
2. **Set executable permissions**
   ```bash
   chmod +x /home/ubuntu/health_check.sh
   chmod +x /home/ubuntu/backup_api.sh
   chmod +x /home/ubuntu/update_server.sh
   ```
3. **Run scripts manually for testing**
    ```bash
    ./health_check.sh
   ./backup_api.sh
    ./update_server.sh
    
    ```
4. **Schedule scripts via cron**
   ```bash
    crontab -e

   ```
   Add the following lines
    ```bash
    # Health check every 6 hours
    0 */6 * * * /home/ubuntu/health_check.sh
    
    # Daily backup at 2 AM
    0 2 * * * /home/ubuntu/backup_api.sh
    
    # Update server every 3 days at 3 AM
    0 3 */3 * * * /home/ubuntu/update_server.sh

   ```
---

## Dependencies
Make sure the following tools are installed on your server:

- curl – for endpoint checking
  ```bash
  sudo apt install curl
  
  ```
- git – for pulling the latest code
  ```bash
  sudo apt install git

  ```
- mongodump – if you're using MongoDB
   ```bash
  sudo apt install mongodb-clients

  ```
- tar – for file backups
  ```bash
  sudo apt install tar
  ```
- nginx – the web server
  ```bash
  sudo apt install nginx
  ```
---

# Simple API with Docker and MySQL

This project demonstrates how to containerize a simple Node.js API using Docker and Docker Compose. It exposes two endpoints:

- `/students`
- `/subjects`

## 🐳 Docker Setup

### 1. Build Docker Image

```bash
docker build -t assig-api .
```
### 2. Run the Container

```bash
docker run -d -p 5000:5000 --name  old-assign-api old-assign-api
```
Then visit:

http://localhost:5000/students

http://localhost:5000/subjects

## ⚙️ Docker Compose (API + MySQL)

### 1. Start with Docker Compose

```bash
docker-compose up --build
```

This will:

- Start a MySQL database container (db)

- Start the Node.js API container (api)

- Setup volumes for data persistence

### 2. Visit Endpoints
http://localhost:5000/students

http://localhost:5000/subjects

## ☁️ Deployment on AWS EC2

### 1. Launch an EC2 Ubuntu instance.

### 2. SSH into your instance:

```bash
ssh -i kim.pem ubuntu@51.20.34.197
```

### 3. Install Docker and Docker Compose:
```bash
sudo apt update
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker ubuntu
```
### 4. Clone this repo and run:
```bash
git clone https://github.com/OscarKimenyi/simpleAPI.git
cd simpleAPI
docker-compose up --build -d
```

### 5. Open security group ports:

- TCP 5000 (your app)

- TCP 3306 (if you want DB exposed—optional)

## 🐙 Docker Hub
The Docker image is available on Docker Hub:
-link required

```bash
docker pull oscar1210/assign-api
docker run -p 5000:5000 oscar1210/assign-api
```

## 🐞 Troubleshooting Tips
- Make sure MySQL has finished starting before the API attempts to connect.

- Use docker logs to check container logs:

```bash
docker logs assign-api
```
- Use docker exec -it mysql-db bash and mysql -u root -p to access the MySQL container.

## License
This project is licensed under the MIT License - see the LICENSE file for details.   
