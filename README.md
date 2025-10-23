# Dental Clinic Management System

මෙය සරල dental clinic management system එකකි. Doctor සහ Patient යන roles දෙක සඳහා daily appointments view කිරීමේ පහසුකම් සපයයි.

## System Requirements

- Java 21
- Maven 3.8+
- MySQL Server 8.0
- Apache Tomcat 10.1+

## Setup Instructions

### 1. Database Setup

MySQL Workbench හෝ command line භාවිතා කර database setup කරන්න:

```sql
mysql -u root -p < database.sql
```

Database එක manually setup කරන්න නම්:
1. MySQL Workbench open කරන්න
2. `database.sql` file එක run කරන්න
3. මෙය `dental_clinic` database එක සහ අවශ්‍ය tables create කරයි

### 2. Database Connection Configuration

`src/main/java/lk/clinic/dentalmanagementsystem/util/DBConnection.java` file එකේ database credentials update කරන්න:

```java
private static final String URL = "jdbc:mysql://localhost:3306/dental_clinic";
private static final String USERNAME = "root";
private static final String PASSWORD = ""; // ඔබේ MySQL password එක දෙන්න
```

### 3. Build and Deploy

Terminal එකේ:

```bash
# Project build කරන්න
mvn clean package

# Generated WAR file එක Tomcat වෙත copy කරන්න
cp target/dental-management-system-1.0-SNAPSHOT.war [TOMCAT_HOME]/webapps/
```

### 4. Run Application

1. Tomcat server එක start කරන්න
2. Browser එකේ යන්න: `http://localhost:8080/dental-management-system-1.0-SNAPSHOT/`
3. Login page එකට redirect වේ

## Demo Credentials

### Doctor Login:
- Username: `doctor1`
- Password: `password123`

### Patient Login:
- Username: `patient1` හෝ `patient2`
- Password: `password123`

## Features

### Doctor Dashboard:
- දෛනික appointments schedule බැලීම
- Date picker මගින් විවිධ දින සඳහා appointments බැලීම
- Pending appointment requests අනුමත/ප්‍රතික්ෂේප කිරීම
- Appointment status update කිරීම (In Progress, Completed)
- Patient treatment notes ඇතුළත් කිරීම

### Patient Dashboard:
- තමන්ගේ appointments history බැලීම
- Appointment statistics (Total, Upcoming, Completed)
- නව appointments request කිරීම (feature එක implement කල යුතුයි)
- Pending/Approved appointments cancel කිරීම

## Project Structure

```
dental-management-system/
├── src/main/java/
│   └── lk/clinic/dentalmanagementsystem/
│       ├── model/          # Data models (User, Appointment)
│       ├── dao/            # Database access objects
│       ├── servlet/        # HTTP servlets
│       └── util/           # Utility classes (DBConnection)
├── src/main/webapp/
│   ├── doctor/             # Doctor JSP pages
│   ├── patient/            # Patient JSP pages
│   └── login.jsp           # Login page
├── database.sql            # Database schema and sample data
└── pom.xml                 # Maven configuration
```

## Technologies Used

- **Backend:** Java 21, Jakarta Servlets
- **Frontend:** JSP, HTML5, CSS3
- **Database:** MySQL 8.0
- **Build Tool:** Maven
- **Server:** Apache Tomcat 10.1+

## Additional Features to Implement

- Patient appointment request form
- Email notifications
- Report generation
- User registration
- Password encryption
- File upload for medical records
- Advanced search and filtering