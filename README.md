# Spaulding-Ridge-Employee-analysis-application
Spaulding Ridge employee compensation application 
This Power BI dashboard was developed as part of the Spaulding Ridge technical case study and is built upon a clean and structured data foundation prepared using SQL.
I used SQL for data preparation and PowerBI for creating the application
Data Preparation Workflow
1.	Data Import & Cleaning (SQL)
o	Raw datasets were imported into a SQL environment for cleaning and transformation.
o	Created and cleaned the following tables:
	employee_data
	employee_rating
	average_industry_compensation
o	These tables were joined using a unique Employee ID to form a consolidated dataset.
2.	Master Table Creation
o	A final table named employee_master was created by joining the three source tables.
o	This master table includes all relevant employee attributes, ratings, and industry compensation for use in Power BI.
3.	Power BI Import
o	The table were exported to CSV and imported into Power BI for dashboard development.

This Power BI dashboard addresses the requirements of the Spaulding Ridge technical case study by providing interactive visualizations and tools that satisfy all four user stories, enabling business users to explore and analyze employee data efficiently.
Implemented User Stories
User Story 1: Filter and Display Active Employees by Role
•	Filters for Role, Location, and Employment Status (Y/N)
•	Card visual showing average compensation based on selections
•	Bar chart comparing average compensation across Locations
•	Table showing Employee Name, Role, Location, and Compensation
User Story 2: Group Employees by Years of Experience

•	Categorized employees into experience buckets 
•	Column chart showing count of employees per experience range
•	Optional grouping by Location or Role created chart by location and role one can also use slicers to check number of employees at a particular location for a particular experience like wise for role
 User Story 3: Simulate Compensation Increments
 
•	Global input field for applying a fixed % compensation increase
•	Custom input for applying different % increases by Location by using the location slicer on top you can filter the table according to location and then change the global input
•	Display of both current and updated compensation values

User Story 4: Download Filtered Employee Data
•	Button to export filtered employee dataset to CSV
•	Export includes: Name, Role, Location, Experience, Compensation, Status
•	Export reflects incremented compensation values if applied


