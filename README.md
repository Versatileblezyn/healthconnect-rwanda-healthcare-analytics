# HealthConnect Rwanda: Healthcare Analytics & AI Transformation

## Project Overview

HealthConnect Rwanda is a healthcare analytics project focused on using data to support better decision-making in healthcare. The project analyses patient information, appointments, diagnoses, revenue, staffing, healthcare operations, and patient satisfaction.

The aim is to turn healthcare data into meaningful insights that can help healthcare managers identify trends, understand operational performance, and make evidence-based decisions.

## Project Objectives

- Analyse patient demographics and healthcare service usage.
- Examine appointment and diagnosis patterns.
- Evaluate revenue and payment trends.
- Explore healthcare staffing and operational indicators.
- Understand patient satisfaction and feedback.
- Develop actionable recommendations for healthcare decision-makers.

## Tools and Technologies

- **SQL:** Data querying, validation, and analysis.
- **Power BI:** Dashboard development, data visualisation, and reporting.
- **DAX:** Measures and key performance indicators (KPIs).
- **PostgreSQL:** Database querying and data analysis.
- **Microsoft Word and PowerPoint:** Business reporting and executive communication.

## Key Performance Indicators

The dashboard reports the following headline indicators:

| KPI | Reported Value |
|---|---:|
| Registered Patients | 20,000 |
| Appointments | 5,000 |
| Doctors | 350 |
| Healthcare Facilities | 20 |
| Average Patient Satisfaction | 2.99 |
| Total Revenue | 1,132,677,500 |

*Note: The revenue currency is not specified in the available project data. Figures should be interpreted in the context of the available dataset and validated before being used for operational decisions.*

## Project Deliverables

The project includes:

1. SQL scripts for healthcare data analysis.
2. An interactive Power BI dashboard.
3. An executive dashboard exported as PDF.
4. A Business Insights Report.
5. An Executive Presentation.

## Key Areas of Analysis

### Patient Analytics
Explores patient demographics, age groups, gender distribution, geographical distribution, and recorded chronic conditions.

### Clinical Analytics
Examines recorded diagnoses, including malaria, hypertension, diabetes, gastritis, and upper respiratory infections.

### Financial Analytics
Reviews revenue trends, billing by department, payment methods, and insurance claim providers.

### Healthcare Operations
Explores staffing records, bed-status records, equipment records, and appointment activity.

### Patient Experience
Examines patient ratings, feedback categories, and average ratings across available facility and department identifiers.

## Business Recommendations

The analysis highlights several areas for further investigation:

- Investigate changes in monthly revenue and validate the trend against the underlying financial records.
- Use patient demographics and recorded chronic conditions to support healthcare service planning.
- Review patient feedback and satisfaction results to identify opportunities to improve the patient experience.
- Improve data labelling so that facility and department information is easier to interpret.
- Validate bed-status information before drawing conclusions about overall bed availability.
- Improve the availability of clinical and operational data to support more comprehensive analysis.

## Data Limitations

The findings should be interpreted with care because:

- Some facility information is represented by identifiers rather than descriptive names.
- The reported bed-status distribution requires validation before being interpreted as overall bed availability.
- Equipment records do not necessarily measure equipment utilisation.
- The available feedback data does not show a clear date field for analysing changes in complaints over time.
- Some detailed clinical transaction data, such as laboratory tests, prescriptions, admissions, and referrals, was not available in the imported tables.
- The currency associated with the reported revenue figure was not specified.

## Project Structure

The repository is intended to contain the following files:

```text
healthconnect-rwanda-healthcare-analytics/
├── README.md
├── sql/
│   └── healthcare_analysis.sql
├── dashboard/
│   └── HealthConnect_Rwanda_Dashboard.pbix
├── reports/
│   ├── Executive_Dashboard.pdf
│   └── Business_Insights_Report.docx
└── presentation/
    └── Executive_Presentation.pptx
```

*The folder structure above is a suggested organisation for the repository. File names can be adjusted to match the final uploaded files.*

## Conclusion

This project demonstrates how SQL, data modelling, data visualisation, and business analysis can be combined to examine healthcare performance. It also highlights the importance of data quality, clear reporting, and validation when using analytics to support decision-making.

## Author

**Osazuwa Ngozi Blessing**

Healthcare Analytics | SQL | Power BI | Business Intelligence
