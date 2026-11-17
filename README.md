# Financial Services Complaint Intelligence

## Project Overview

An end-to-end data analytics project exploring consumer financial complaints submitted to the **Consumer Financial Protection Bureau (CFPB)** during 2025.

The project uses Python, PostgreSQL, SQL, and data visualization to investigate complaint trends, product-level patterns, company concentration, response timeliness, and geographic distribution.

The objective is to transform a large public dataset into meaningful business insights that can support data-driven decision-making.

## Business Questions

This analysis focuses on the following questions:

1. How did consumer complaint volumes change throughout 2025?
2. Which financial products generated the highest complaint volumes?
3. What were the most frequently reported complaint issues?
4. How concentrated were complaints among financial institutions?
5. How frequently did companies provide untimely responses?
6. Which financial products had the highest untimely response rates?
7. How did complaint patterns vary across states?

## Dataset

- **Source:** [CFPB Consumer Complaint Database](https://www.consumerfinance.gov/data-research/consumer-complaints/)
- **Period:** January 1 – December 31, 2025
- **Records analyzed:** 5,442,922
- **Format:** CSV
- **Data type:** Consumer financial complaints

The dataset contains complaint dates, financial products, issues, company names, geographic information, submission channels, and company response information.

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data extraction, cleaning and analysis |
| Pandas | Data manipulation and exploratory analysis |
| NumPy | Numerical operations |
| Matplotlib | Data visualization |
| Seaborn | Statistical visualization |
| PostgreSQL | Data storage and querying |
| SQL | Data validation and analytical queries |
| Jupyter Notebook | Exploratory data analysis |
| Git & GitHub | Version control and project hosting |

## Project Workflow

1. **Data acquisition:** Downloaded the official CFPB bulk complaint dataset.
2. **Data extraction:** Processed the source archive in chunks and extracted 2025 records.
3. **Data quality assessment:** Examined missing values, duplicate complaint IDs, date ranges, and field consistency.
4. **Database loading:** Loaded 5.44 million records into PostgreSQL.
5. **SQL analysis:** Performed trend, product, issue, company, response, and geographic analysis.
6. **Python EDA:** Reproduced and extended the analysis using Pandas and visualizations.
7. **Business interpretation:** Identified significant patterns and analytical limitations.

## Key Findings

### 1. Complaint Volume and Trends

- Analyzed 5,442,922 complaints across 2025.
- October recorded the highest monthly volume, with 519,780 complaints.
- February recorded the lowest monthly volume, with 335,235 complaints.
- Complaint volume increased by approximately 7.71% between January and December.

### 2. Product Concentration

- Credit reporting or other personal consumer reports accounted for 4,810,286 complaints, approximately 88.38% of the dataset.
- Debt collection was the second-largest category, representing approximately 5.20%.
- The remaining financial product categories accounted for approximately 11.62% combined.

### 3. Company Concentration

The three largest companies by recorded complaint volume were:

- Equifax: 1,680,537
- TransUnion: 1,601,849
- Experian: 1,388,821

Together, they represented approximately 85.83% of all recorded complaints.

### 4. Complaint Issues

The three most frequently reported issues were:

- Incorrect information on your report: 2,834,674
- Improper use of your report: 1,101,566
- Problem with company's investigation into existing problem: 867,387

Combined, these issues accounted for approximately 88.26% of complaints.

### 5. Company Response Timeliness

- 99.55% of complaints were marked as receiving a timely response.
- 24,508 complaints, approximately 0.45%, were marked as untimely.
- Student loans had the highest untimely response rate at 30.36%.
- Debt collection contributed the largest absolute number of untimely responses, with 8,185.

### 6. Geographic Analysis

- Florida and Texas recorded the highest complaint volumes, with approximately 791,231 and 789,895 complaints respectively.
- Texas overtook Florida in monthly complaint volume from August onward.
- Credit reporting dominated complaint volumes across the five most represented states.
- Texas had a higher debt-collection complaint share than the other four states in this comparison.

## Visualizations

The project includes visualizations covering:

- Monthly complaint trends
- Month-over-month complaint growth
- Financial product distribution
- Product distribution excluding credit reporting
- Top complaint issues
- Top companies
- Company distribution excluding the three largest credit bureaus
- Company response timeliness
- Untimely response rates by product
- State-level complaint distribution
- Product distribution across the five highest-volume states

Visualizations are available in the `visualizations/` directory.

## Data Quality and Limitations

- The analysis identified zero duplicate complaint IDs.
- The dataset contains missing values in fields such as company public response, sub-issue, tags, and state.
- Missing values were assessed rather than indiscriminately removed.
- Complaint counts represent submitted complaints, not the prevalence of financial problems across the population.
- Complaint volume alone does not establish company misconduct or poor performance.
- Company comparisons should account for differences in customer base, product mix, and business scale.
- A timely response does not necessarily mean that the consumer's issue was resolved or that the consumer was satisfied.
- The dataset does not provide a complaint resolution timestamp, so resolution duration cannot be calculated from these fields.

## Repository Structure

```text
financial-services-complaint-intelligence/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   └── 01_financial_complaints_eda.ipynb
│
├── sql/
│   ├── 01_data_validation.sql
│   ├── 02_monthly_trends.sql
│   ├── 03_product_analysis.sql
│   ├── 04_product_cohort_analysis.sql
│   ├── 05_company_analysis.sql
│   ├── 06_issue_analysis.sql
│   ├── 07_response_analysis.sql
│   └── 08_geographic_analysis.sql
│
├── src/
│   └── extract_cfpb_2025.py
│
├── reports/
│
├── visualizations/
│
├── README.md
└── requirements.txt
```

## Reproducing the Analysis

1. Download the CFPB Consumer Complaint Database bulk archive.
2. Place the downloaded archive in `data/raw/`.
3. Run the extraction script in `src/` to prepare the 2025 dataset.
4. Load the processed CSV into PostgreSQL using the table schema documented in the SQL scripts.
5. Execute the SQL analyses.
6. Open the Jupyter notebook and run the exploratory analysis.

Python dependencies and database configuration are required to reproduce the workflow.

## Conclusion

This project demonstrates an analytical workflow involving large-scale public data, data quality assessment, SQL-based analysis, Python EDA, and business interpretation.

It highlights how structured analytical techniques can uncover patterns in consumer financial complaints and translate them into actionable areas for further investigation.

---

**Data source:** Consumer Financial Protection Bureau (CFPB)  
**Project type:** Data Analytics | Financial Services | Exploratory Data Analysis | SQL | Python