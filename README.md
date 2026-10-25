HealthConnect Rwanda - Healthcare Operations and Performance Analytics
Project Overview
This project was completed as part of the AnalystLab Africa Experience Lab, Week 6, Track 1: Data Analytics. The objective was to use SQL and Power BI to organise healthcare data into an interactive dashboard that supports review of patient activity, clinical diagnoses, financial performance, healthcare operations, and patient experience.
Dashboard Pages
The Power BI dashboard contains six pages:
1.	Executive Dashboard - registered patients, appointments, revenue, facilities, doctors, and average patient satisfaction.
2.	Patient Analytics - gender distribution, age groups, province distribution, chronic conditions, and insurance IDs.
3.	Clinical Analytics - diagnosis analysis using the available diagnosis records.
4.	Financial Dashboard - revenue trend, billed amounts by facility and department, insurance claims, and payment methods.
5.	Operational Dashboard - staff distribution, bed status, equipment records by facility, and appointment comparisons by facility and department.
6.	Patient Experience Dashboard - satisfaction ratings, feedback categories, hospital ratings, and department ratings.
Tools and Data
•	PostgreSQL: healthcare database and SQL analysis.
•	Power BI Desktop: data visualisation and dashboard development.
•	Source tables used: patients, appointments, diagnoses, doctors, departments, beds, medical equipment, laboratory scientists, pharmacists, billing, payments, insurance claims, patient feedback, revenue summary, and related facility/geographic tables.
Main Dashboard Indicators
The exported dashboard displays approximately:
•	20,000 registered patients
•	5,000 appointments
•	350 doctors
•	20 facilities
•	1,132,677,500 in reported revenue (the currency is not labelled in the dashboard export)
•	2.99 average patient satisfaction rating on the displayed 1–5 scale
These figures are reproduced from the Power BI dashboard export and should be interpreted within the scope of the data loaded into the project.
Key Insights
•	The patient gender distribution is close to even, at approximately 50.45% and 49.55%.
•	Patient records are displayed across five provinces and several chronic-condition categories, including asthma, hypertension, and diabetes.
•	Diagnosis records include gastritis, diabetes, hypertension, malaria, and upper respiratory infection.
•	The monthly revenue chart declines across the months displayed.
•	Payment records are shown across Card, Mobile Money, Insurance, and Cash.
•	The average patient rating displayed is 2.99 out of 5.
•	The operational visuals compare recorded staff, bed inventory, equipment records, and appointment activity.
Data Limitations
The imported tables used for this dashboard did not include separate transaction records for laboratory tests, prescriptions, admissions, or referrals. The inspected appointments table did not contain a referral field. The beds table showed bed status but did not contain admission records. The inspected medical-equipment fields did not include a status or usage field. The patient feedback fields inspected included feedback ID, appointment ID, comment, and rating, but no visible date field for complaint trends. Therefore, these clinical activities and time-based complaint trends are not directly measured in the current dashboard.
Some visuals use facility and department IDs rather than descriptive names. The insurance chart displays insurance IDs rather than a confirmed insured/uninsured category. The reported revenue currency is not identified in the exported dashboard.
Project Files
Organise the project folder to include the following files where available:
•	HealthConnect_Rwanda_Dashboard.pbix - editable Power BI dashboard
•	Executive_Dashboard.pdf - exported dashboard PDF
•	Business_Insights_Report.docx - business insights report
•	Executive_Presentation.pptx - 13-slide executive presentation
•	SQL_Queries.sql - SQL query script
•	HealthConnect_Rwanda_Database.sql or .backup - PostgreSQL database backup
•	README.md - this documentation file
How to Use
7.	Open the .pbix file in Power BI Desktop to explore the six dashboard pages.
8.	Use the exported dashboard PDF for a static view of the dashboard.
9.	Read the Business Insights Report for the findings and management recommendations.
10.	Use the Executive Presentation to communicate the project and its findings.
11.	Review the SQL script for the queries completed as part of the analysis.
Conclusion
This project brings together the available healthcare data in a six-page Power BI dashboard covering executive KPIs, patient analytics, diagnoses, finances, operations, and patient experience. The dashboard provides a descriptive overview of the loaded records. Additional clinical transaction data would extend the analysis to laboratory tests, prescriptions, admissions, and referrals.
