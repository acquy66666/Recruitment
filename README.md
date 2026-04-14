# JobHub - SWP391 Job Board Manager

A comprehensive job board management system built with Java EE (Jakarta EE).

## Features

- **Candidate Features**
  - Job search and application
  - CV management (upload, create, edit)
  - Interview scheduling
  - Test taking system
  - Job bookmarking

- **Recruiter Features**
  - Job posting management
  - Candidate filtering (AI-powered CV filtering)
  - Application management
  - Interview scheduling with video meeting
  - Service packages management
  - Revenue statistics

- **Admin Features**
  - Account management
  - Job post approval
  - Service management
  - Statistics and reporting

## Technology Stack

- **Backend**: Java, Jakarta EE, Servlet/JSP
- **Database**: MySQL
- **Payment**: VNPAY Gateway
- **Authentication**: Google OAuth, OTP verification
- **Video Meeting**: Jitsi Integration
- **AI Features**: Gemini AI for CV filtering
- **Build Tool**: Maven

## Setup

### Prerequisites

- JDK 11+
- Apache Tomcat 10.1+
- MySQL 8.0+
- Maven 3.6+

### Configuration

1. Clone the repository
2. Create a MySQL database and import the SQL schema
3. Configure database connection in `DBcontext.java`
4. Set up Google OAuth credentials as environment variables:
   ```
   GOOGLE_CLIENT_ID=your_client_id
   GOOGLE_CLIENT_SECRET=your_client_secret
   ```

### Build & Run

```bash
mvn clean package
# Deploy the WAR file to Tomcat
```

## Project Structure

```
Recruitment/
├── src/
│   ├── main/
│   │   ├── java/com/recruitment/
│   │   │   ├── controller/     # Servlet controllers
│   │   │   ├── dao/            # Data access objects
│   │   │   ├── model/          # Entity classes
│   │   │   ├── dto/            # Data transfer objects
│   │   │   └── utils/          # Utility classes
│   │   └── webapp/             # JSP files and web resources
│   └── test/                   # Test files
├── pom.xml                     # Maven configuration
└── README.md
```

## Database

The project uses MySQL database. Import the SQL schema from the provided database file.

## License

This project is for educational purposes as part of the SWP391 course.
