-- HealthConnect Rwanda: Track 1 Data Analytics
-- SQL analysis starter for the available CSV tables.
-- Assumes PostgreSQL table names are lowercase snake_case and columns are lowercase snake_case.
-- Run queries individually. If your actual table/column names differ, adjust them to match pgAdmin.

-- PATIENT ANALYSIS (1-10)
-- 1. Retrieve all registered patients
SELECT * FROM patients;

-- 2. Count patients by gender
SELECT gender, COUNT(*) AS patient_count FROM patients GROUP BY gender ORDER BY patient_count DESC;

-- 3. Count patients by province (join geographic hierarchy)
SELECT pr.provincename, COUNT(*) AS patient_count
FROM patients p
JOIN villages v ON p.villageid = v.villageid
JOIN sectors s ON v.sectorid = s.sectorid
JOIN districts d ON s.districtid = d.districtid
JOIN provinces pr ON d.provinceid = pr.provinceid
GROUP BY pr.provincename ORDER BY patient_count DESC;

-- 4. Identify patients above 65 years
SELECT * FROM patients WHERE age::int > 65;

-- 5. Find patients with chronic diseases (exclude unknown/blank)
SELECT * FROM patients
WHERE NULLIF(TRIM(chroniccondition), '') IS NOT NULL
  AND LOWER(TRIM(chroniccondition)) NOT IN ('none', 'no', 'n/a', 'unknown');

-- 6. Retrieve patients with an insurance ID
SELECT * FROM patients WHERE NULLIF(TRIM(insuranceid), '') IS NOT NULL;

-- 7. Count patients by blood group
SELECT bloodgroup, COUNT(*) AS patient_count FROM patients GROUP BY bloodgroup ORDER BY patient_count DESC;

-- 8. Youngest and oldest patients
(SELECT 'Youngest' AS group_type, patientid, age FROM patients WHERE NULLIF(TRIM(age), '') IS NOT NULL ORDER BY age::int ASC LIMIT 1)
UNION ALL
(SELECT 'Oldest' AS group_type, patientid, age FROM patients WHERE NULLIF(TRIM(age), '') IS NOT NULL ORDER BY age::int DESC LIMIT 1);

-- 9. Identify duplicate phone numbers
SELECT phone, COUNT(*) AS occurrences
FROM patients WHERE NULLIF(TRIM(phone), '') IS NOT NULL
GROUP BY phone HAVING COUNT(*) > 1 ORDER BY occurrences DESC;

-- 10. Calculate average patient age
SELECT ROUND(AVG(NULLIF(TRIM(age), '')::numeric), 2) AS average_age FROM patients;

-- APPOINTMENT ANALYSIS (11-20)
-- 11. Count appointments by month
SELECT DATE_TRUNC('month', date::date)::date AS appointment_month, COUNT(*) AS appointment_count
FROM appointments GROUP BY 1 ORDER BY 1;

-- 12. Busiest facilities (FacilityID only; no facility master names supplied)
SELECT facilityid, COUNT(*) AS appointment_count
FROM appointments GROUP BY facilityid ORDER BY appointment_count DESC;

-- 13. Busiest departments
SELECT a.departmentid, d.departmentname, COUNT(*) AS appointment_count
FROM appointments a LEFT JOIN departments d ON a.departmentid = d.departmentid
GROUP BY a.departmentid, d.departmentname ORDER BY appointment_count DESC;

-- 14. Doctors with highest workload
SELECT doctorid, COUNT(*) AS appointment_count
FROM appointments GROUP BY doctorid ORDER BY appointment_count DESC;

-- 15. Referral patterns: unsupported because no referral-specific field/table is supplied.
-- 16. Count emergency appointments (adjust category if source uses a different spelling)
SELECT COUNT(*) AS emergency_appointments FROM appointments WHERE LOWER(TRIM(visittype)) = 'emergency';

-- 17. Average appointments per doctor
SELECT ROUND(AVG(appointment_count), 2) AS avg_appointments_per_doctor
FROM (SELECT doctorid, COUNT(*) AS appointment_count FROM appointments GROUP BY doctorid) x;

-- 18. Appointments by province
SELECT pr.provincename, COUNT(*) AS appointment_count
FROM appointments a
JOIN patients p ON a.patientid = p.patientid
JOIN villages v ON p.villageid = v.villageid
JOIN sectors s ON v.sectorid = s.sectorid
JOIN districts d ON s.districtid = d.districtid
JOIN provinces pr ON d.provinceid = pr.provinceid
GROUP BY pr.provincename ORDER BY appointment_count DESC;

-- 19. Facilities with highest patient volume (distinct patients per facility)
SELECT facilityid, COUNT(DISTINCT patientid) AS unique_patients
FROM appointments GROUP BY facilityid ORDER BY unique_patients DESC;

-- 20. Peak consultation periods
SELECT EXTRACT(HOUR FROM date::timestamp) AS appointment_hour, COUNT(*) AS appointment_count
FROM appointments GROUP BY appointment_hour ORDER BY appointment_count DESC;

-- CLINICAL ANALYSIS (21-30)
-- 21. Top diagnoses
SELECT diagnosis, COUNT(*) AS diagnosis_count FROM diagnoses
GROUP BY diagnosis ORDER BY diagnosis_count DESC LIMIT 20;

-- 22. Laboratory tests: unsupported; no laboratory test records supplied.
-- 23. Prescribed medications: unsupported; no prescription records supplied.
-- 24. Average admission duration: unsupported; no admissions table supplied.

-- 25. Disease severity distribution
SELECT severity, COUNT(*) AS diagnosis_count FROM diagnoses
GROUP BY severity ORDER BY diagnosis_count DESC;

-- 26. Laboratory test utilization: unsupported; no laboratory test records supplied.
-- 27. Prescription trends: unsupported; no prescription records supplied.
-- 28. Referral destinations: unsupported; no referral records supplied.

-- 29. Admission rate by diagnosis: unsupported; no admissions table supplied.

-- 30. Clinical workload by department
SELECT a.departmentid, d.departmentname, COUNT(DISTINCT a.appointmentid) AS appointments,
       COUNT(di.diagnosisid) AS diagnosis_records
FROM appointments a
LEFT JOIN departments d ON a.departmentid = d.departmentid
LEFT JOIN diagnoses di ON a.appointmentid = di.appointmentid
GROUP BY a.departmentid, d.departmentname
ORDER BY appointments DESC;

-- FINANCIAL ANALYSIS (31-40)
-- 31. Revenue/billed amount by facility
SELECT a.facilityid, SUM(b.amount::numeric) AS billed_amount
FROM billing b JOIN appointments a ON b.appointmentid = a.appointmentid
GROUP BY a.facilityid ORDER BY billed_amount DESC;

-- 32. Billed amount by department
SELECT a.departmentid, d.departmentname, SUM(b.amount::numeric) AS billed_amount
FROM billing b JOIN appointments a ON b.appointmentid = a.appointmentid
LEFT JOIN departments d ON a.departmentid = d.departmentid
GROUP BY a.departmentid, d.departmentname ORDER BY billed_amount DESC;

-- 33. Revenue by service: unsupported at transaction level; service records are not linked to billing.

-- 34. Insurance claims by provider
SELECT provider, COUNT(*) AS claim_count, SUM(claimamount::numeric) AS claimed_amount
FROM insurance_claims GROUP BY provider ORDER BY claimed_amount DESC;

-- 35. Outstanding payments (billing amount less recorded payments; grouped by bill)
SELECT b.billingid, b.amount::numeric AS billed_amount,
       COALESCE(SUM(p.amountpaid::numeric), 0) AS paid_amount,
       b.amount::numeric - COALESCE(SUM(p.amountpaid::numeric), 0) AS outstanding_amount
FROM billing b LEFT JOIN payments p ON b.billingid = p.billingid
GROUP BY b.billingid, b.amount
HAVING b.amount::numeric - COALESCE(SUM(p.amountpaid::numeric), 0) > 0
ORDER BY outstanding_amount DESC;

-- 36. Average billing amount
SELECT ROUND(AVG(NULLIF(TRIM(amount), '')::numeric), 2) AS average_billing_amount FROM billing;

-- 37. Monthly revenue trend (revenue summary file contains Month and Revenue)
SELECT month, SUM(revenue::numeric) AS revenue FROM revenue_summary
GROUP BY month ORDER BY month;

-- 38. Payment methods
SELECT method, COUNT(*) AS payment_count, SUM(amountpaid::numeric) AS total_paid
FROM payments GROUP BY method ORDER BY total_paid DESC;

-- 39. Top revenue-generating facilities (based on billing amounts)
SELECT a.facilityid, SUM(b.amount::numeric) AS billed_amount
FROM billing b JOIN appointments a ON b.appointmentid = a.appointmentid
GROUP BY a.facilityid ORDER BY billed_amount DESC LIMIT 10;

-- 40. Financial performance ranking (available proxy: billed amount by facility)

WITH payment_totals AS (
    SELECT
        billingid,
        SUM(amountpaid::numeric) AS paid_amount
    FROM payments
    GROUP BY billingid
),
facility_totals AS (
    SELECT
        a.facilityid,
        SUM(b.amount::numeric) AS billed_amount,
        SUM(COALESCE(p.paid_amount, 0)) AS paid_amount
    FROM billing b
    JOIN appointments a
        ON a.appointmentid = b.appointmentid
    LEFT JOIN payment_totals p
        ON p.billingid = b.billingid
    GROUP BY a.facilityid
)
SELECT
    RANK() OVER (ORDER BY billed_amount DESC) AS facility_rank,
    facilityid,
    billed_amount,
    paid_amount
FROM facility_totals
ORDER BY facility_rank;

-- IMPORTANT VALIDATION NOTES:
-- * The supplied files do not include separate Health Facilities, Laboratory Tests,
--   Prescriptions, Admissions, or Referrals tables.
-- * Some analyses above are therefore marked unsupported rather than fabricated.
-- * Confirm that imported column names match the snake_case names used here.
-- * Text-to-number/date casts may fail if the source contains non-numeric or invalid values.
