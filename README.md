DocAlertPro – Personal Document Expiry Alert System
DocAlertPro is a web application designed to help users securely store important personal documents—such as PAN cards, driving licenses, and ID proofs—and receive timely reminders via email or SMS before these documents expire. It ensures you never miss a renewal date and avoids penalties or service interruptions.

⦿ Key Features
• User Registration & Login with CAPTCHA – Secure access with bot protection.
• Document Upload & Expiry Tracking – Add scanned documents and monitor expiry dates.
• Interactive Dashboard – Visual status of all documents with color coding for expiries.
• Automated Email Notifications – Alerts sent before expiry to registered email addresses.
• Secure File Management – Safely stores document file paths and handles uploads.
• Full CRUD Support – Create, read, update, and delete documents with ease.

⦿ Technologies Used
This project leverages modern and reliable technologies for smooth operation:

⦿ Component	Technology
Frontend	ASP.NET Web Forms (ASPX)
Backend	C# (Visual Studio 2012)
Database	SQL Server 2022
Notifications	SMTP (for email alerts)
File Handling	ASP.NET FileUpload Control

⦿ Database Design Overview
•The system uses a relational database with the following tables:
•Users – Stores user credentials and contact details.
•Documents – Tracks document names, expiry dates, and uploaded file paths.

1.Getting Started
Follow these steps to set up the project locally:

1.Clone the repository:
    git clone https://github.com/Bdshetty/DocAlertPro.git

2.Open the solution in Visual Studio 2012 or higher.

3.Configure web.config:
• Add your database connection string.
• Set up SMTP credentials for email alerts.

4.Set up the database:
• Run the SQL script located in /Database/ to create necessary tables.
