# Electoral Bonds Data Analysis (2019-2024)
## Project Overview
This project analyzes electoral bond data issued by the State Bank of India from 2019 to 2024. The objective is to gain insights into which companies and political parties are involved in the donation process. The analysis includes data cleaning, exploratory data analysis (EDA), and advanced queries using SQL. The insights are presented visually using Power BI to help stakeholders understand the flow of donations and identify major contributors.
## Dashboard Link:https://app.powerbi.com/view?r=eyJrIjoiYWQxYTAyOWEtMzg0Zi00N2YzLWEwZjYtZjQwNjU0ZjhlZTc4IiwidCI6IjRiNDY5YmYzLTdlZGYtNDU5My05Yjc3LWU0ODA3OTUzYzczMCJ9

## Tools Used
* Python (pandas): For data cleaning and exploratory data analysis (EDA).
* MySQL: To run SQL queries for deeper analysis and insights.
* Power BI: For creating dashboards that visually represent the data and insights.
## Data Sources
The dataset used for this project is publicly available and was issued by the State Bank of India regarding electoral bond transactions. The data includes details on electoral bond purchases, donations to political parties, and other relevant financial transactions from 2019 to 2024.
* These are the official Sites where the data is released by the government.
* https://www.eci.gov.in/disclosure-of-electoral-bonds
* https://enforcementdirectorate.gov.in/press-release ( Data available only since
2021 )
* https://cag.gov.in/en/audit-report ( Data extracted from 2018 )
* https://incometaxindia.gov.in/Pages/press-releases.aspx ( Data extracted from
 2010 )
* https://cbi.gov.in/press-releases ( Data extracted from 2018 )
* https://www.mca.gov.in/content/mca/global/en/mca/master-data/MDS.html
* The Bank codes details have been extracted from this website:
* All the bank banches don’t have the authority to issue electoral bonds only few branches of SBI bank can issue them and this table contains the details of banks and based 
  on the branch code we can connect to the receiver and donordata.
*  pib.gov
* Note: We obtained the dataset from Kaggle, which is available in commaseparated format (CSV). Unlike the sources above mentioned that provide data in
PDF format but they are the official sites and even the data from Kaggle is just
format converted, CSV is more accessible for analysis and processing.
## Insights Generated
* Top Donor: Future Gaming and Hotel Services Pvt. Ltd. spent the most on electoral bonds and donated heavily to political parties.
* Least Donor: Aravind S. Company made the smallest contributions to political parties.
* Top Political Party Recipient: BJP received the highest cash donations.
* Least Political Party Recipient: Goa Forward Party received the least cash.
* Second-Highest Donor: Megha Engineering and Infrastructure Pvt. Ltd. is the second-largest donor.
* Second-Highest Political Party Recipient: All India Trinamool Congress Party received the second-highest amount in donations.
## Folder Structure
* data/: Contains the cleaned and raw datasets used for analysis.
* notebooks/: Jupyter notebooks with Python code for EDA and data cleaning.
* sql_queries/: SQL scripts used to extract insights from the MySQL database.
* dashboards/: Power BI dashboard files showing key insights visually.
* reports/: Detailed reports documenting the process and findings.
## Conclusion
The analysis offers a comprehensive understanding of the donation landscape through electoral bonds in India, showcasing key donors and political party recipients. The visual insights created using Power BI highlight the financial flows from corporations to political entities.

## Contact
For any questions or feedback, feel free to reach out to me at [polamsivasankar3269@gmail.com].

