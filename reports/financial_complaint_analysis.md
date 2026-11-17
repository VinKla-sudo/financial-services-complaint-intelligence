# Financial Services Complaint Intelligence
## 2025 Consumer Complaint Analysis

### 1. Executive Summary

This analysis examines 5,442,922 consumer financial complaints submitted to the Consumer Financial Protection Bureau (CFPB) between January and December 2025.

Using Python, Pandas, PostgreSQL, and SQL, the project investigates complaint trends, financial product distribution, reported issues, company concentration, response timeliness, and geographic patterns.

The analysis identifies a strong concentration of complaints in credit reporting, significant differences in response timeliness across financial products, and notable geographic variations in complaint composition.

### 2. Dataset Overview

| Attribute | Value |
|---|---|
| Data source | CFPB Consumer Complaint Database |
| Reporting period | January–December 2025 |
| Total records | 5,442,922 |
| Total columns | 15 |
| Duplicate complaint IDs | 0 |
| Earliest complaint date | 2025-01-01 |
| Latest complaint date | 2025-12-31 |

The dataset includes complaint dates, products, sub-products, issues, companies, states, submission channels, and company response information.

### 3. Data Quality Assessment

The dataset was assessed for missing values, duplicate complaint identifiers, date validity, and field consistency.

Key observations:

- No duplicate complaint IDs were identified.
- No missing values were found in the primary product, issue, company, or complaint ID fields.
- The State field contained 8,375 missing values (0.15%).
- Company public response was missing in 41.81% of records.
- Tags were missing in 97.41% of records.
- Sub-issue was missing in 2.14% of records.

Missing values were retained where appropriate rather than removing otherwise valid complaint records.

### 4. Monthly Complaint Trends

Monthly complaint volume varied throughout 2025.

| Month | Complaints |
|---|---:|
| January | 475,783 |
| February | 335,235 |
| March | 396,973 |
| April | 406,099 |
| May | 415,181 |
| June | 412,160 |
| July | 473,180 |
| August | 495,566 |
| September | 503,847 |
| October | 519,780 |
| November | 496,650 |
| December | 512,468 |

Key findings:

- October recorded the highest monthly complaint volume at 519,780.
- February recorded the lowest volume at 335,235.
- Complaint volume increased by 7.71% between January and December.
- February experienced a 29.54% decline compared with January, followed by a recovery in March.

### 5. Financial Product Analysis

Credit reporting or other personal consumer reports dominated the dataset.

| Product | Complaints | Share |
|---|---:|---:|
| Credit reporting | 4,810,286 | 88.38% |
| Debt collection | 283,193 | 5.20% |
| Credit card | 89,978 | 1.65% |
| Money transfer | 84,619 | 1.55% |
| Checking or savings account | 84,195 | 1.55% |
| Mortgage | 24,697 | 0.45% |
| Student loan | 21,281 | 0.39% |
| Vehicle loan or lease | 20,768 | 0.38% |

The remaining product categories represented a small proportion of total complaints.

**Business interpretation:** Credit reporting is the dominant area in this dataset. Further analysis should distinguish credit reporting complaints from other financial products to avoid masking patterns in smaller categories.

### 6. Complaint Issue Analysis

The three most frequently reported issues were:

| Issue | Complaints |
|---|---:|
| Incorrect information on your report | 2,834,674 |
| Improper use of your report | 1,101,566 |
| Problem with company's investigation into existing problem | 867,387 |

Together, these three issues accounted for approximately 88.26% of all complaints.

**Business interpretation:** The concentration suggests that credit-report accuracy, report usage, and investigation processes are important areas for further examination.

### 7. Company Concentration Analysis

The three companies with the highest recorded complaint volumes were:

| Company | Complaints |
|---|---:|
| Equifax, Inc. | 1,680,537 |
| TransUnion Intermediate Holdings, Inc. | 1,601,849 |
| Experian Information Solutions Inc. | 1,388,821 |

Together, these companies accounted for approximately 85.83% of all recorded complaints.

**Business interpretation:** The distribution is heavily concentrated among the three major credit reporting companies. Company complaint counts should not be interpreted as standalone measures of company performance or misconduct.

### 8. Company Response Timeliness

Overall response timeliness:

| Response status | Complaints | Share |
|---|---:|---:|
| Timely | 5,418,414 | 99.55% |
| Untimely | 24,508 | 0.45% |

Product-level differences were more pronounced:

| Product | Untimely responses | Untimely rate |
|---|---:|---:|
| Student loan | 6,460 | 30.36% |
| Debt or credit management | 328 | 7.69% |
| Prepaid card | 309 | 4.75% |
| Payday/personal loan | 589 | 4.48% |
| Debt collection | 8,185 | 2.89% |
| Vehicle loan or lease | 364 | 1.75% |
| Mortgage | 373 | 1.51% |
| Money transfer | 1,028 | 1.21% |
| Checking or savings | 609 | 0.72% |
| Credit card | 345 | 0.38% |
| Credit reporting | 5,918 | 0.12% |

Key observations:

- Student loans recorded the highest untimely response rate at 30.36%.
- Debt collection contributed the largest absolute number of untimely responses.
- Credit reporting had a relatively low untimely response rate of 0.12%.

**Business interpretation:** Student loan and debt collection complaints warrant further investigation into response processes. Rate and absolute volume should both be considered when prioritizing operational improvements.

### 9. Geographic Analysis

The five states with the highest complaint volumes were:

| State | Complaints |
|---|---:|
| Florida | 791,231 |
| Texas | 789,895 |
| California | 505,426 |
| Georgia | 426,934 |
| New York | 300,036 |

Additional observations:

- Florida and Texas had very similar annual complaint volumes.
- Texas overtook Florida in monthly complaint volume beginning in August.
- Credit reporting accounted for between 87.1% and 91.9% of complaints across these five states.
- Texas recorded the highest debt collection share among the five states at approximately 6.67%.

**Business interpretation:** State-level product composition provides more insight than raw complaint volume alone. Further analysis using population, customer, or product-usage denominators would be needed to estimate relative complaint rates.

### 10. Key Business Recommendations

Based on the observed patterns:

1. **Prioritize credit reporting analysis:** Investigate the recurring themes around inaccurate information and report usage.
2. **Review student loan response processes:** Examine the factors contributing to the high recorded untimely response rate.
3. **Investigate debt collection workflows:** Focus on the large absolute number of untimely responses.
4. **Use product-level segmentation:** Avoid relying exclusively on overall complaint metrics.
5. **Improve geographic monitoring:** Track changes in complaint composition across states over time.
6. **Introduce normalized performance metrics:** Where appropriate, use customer-base or product-volume denominators for fairer company comparisons.

These recommendations identify areas for further investigation; they do not establish causation.

### 11. Limitations

- CFPB complaints are submitted by consumers and are not necessarily representative of the entire consumer population.
- Complaint counts do not establish wrongdoing, actual financial harm, or company performance.
- Differences in customer base and product mix can affect company-level comparisons.
- Missing values exist in several optional fields.
- The available dataset does not contain a complaint resolution timestamp, so resolution duration cannot be calculated.
- A timely response does not necessarily indicate consumer satisfaction or successful resolution.
- Geographic complaint counts are not population-adjusted rates.

### 12. Conclusion

This project demonstrates an end-to-end analytical workflow using a large public financial services dataset.

By combining data extraction, data quality assessment, PostgreSQL, SQL analysis, Python EDA, and visualization, the analysis identifies significant patterns in complaint volume, product concentration, reported issues, response timeliness, and geographic distribution.

The findings demonstrate how large-scale data analysis can support operational monitoring, identify areas requiring deeper investigation, and translate raw data into meaningful business insights.

### Data Source

Consumer Financial Protection Bureau (CFPB):  
https://www.consumerfinance.gov/data-research/consumer-complaints/