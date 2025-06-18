# _**Fleet Management**_
> **Last Updated:** June 18th, 2025

## Project Summary
Fleet and Maintenance Management Database System Project is a comprehensive database system designed to manage and track operations for Fleet Masters Inc., a company with multiple branches overseeing a fleet of vehicles, drivers, and maintenance operations. 

### Core Elements
- Branch Management: Records information for each company branch, including contact details and geographic location
- Vehicle Tracking: Stores vehicle details such as type, make, model, year, purchase price, and history across branches
- Driver Records: Maintains driver personal details and license types
- Usage Tracking: Logs driver-vehicle connections, travel destinations, and mileage data
- Maintenance & Expenses: Tracks all maintenance services, providers, and costs, along with other vehicle-related expenses
- Employment Records: Links managers to branches, including hiring and leave dates to monitor staff mobility
- Historical Movement Tracking: Vehicles and managers can be reassigned between branches, with archival of assignment dates to maintain operational history
- Dual-System Archival: A built-in archive mechanism automatically stores historical data (e.g., past vehicle assignments or employment records), preserving data integrity and enabling long-term analytics
  
#### Key Features
- Normalized relational schema, to the Third Normal Form (3NF), to ensure data integrity
- Triggers and procedures to automate archival and logging
- Custom SQL queries to generate reports such as:
  - Total expenses per vehicle or branch
  - Maintenance history
  - Driver usage patterns
  - Identification of underutilized or unmaintained vehicles

> This was a project assigned specifically to me from my professor for a more advanced experience due to being in the Honors Program section of the course, Database Design & Implementation course. Also, the system is preloaded with three months of realistic sample data, simulating operations across all major tables to enable testing and validation.

---

### Coding Languages Uses:
- **MySQL Workbench** (SQL)

---

## Getting Started
Within this respiratory includes three files from the project:
- Screenshot of the projects ERD Diagram in 3NF
- 
To run this project locally, follow the instructions below. The project is built using MySQL Workbench.

### Prerequisites
Ensure that **MySQL** is installed on your system. If not, refer to the [official MySQL installation guide](https://www.mysql.com/downloads/).

## Usage 
**Fleet Management** could be used by logistics companies, car rental businesses, delivery fleets, or any organization that operates and maintains multiple vehicles across different locations. It helps ensure:
- Better decision-making through analytics
- Compliance with maintenance and operational standards
- Reduction of operational costs via transparency and planning

## Contact
### Created by: Isaiah Adams
>LinkedIn: www.linkedin.com/in/isaiah-j-adams
>
>Email: IJAdams1@outlook.com

Hi there! I'm Isaiah, an undergraduate Computer Science major at Arkansas Tech University with a minor in Business Administration. My passion lies in developing meaningful software that connects people and solves real-world problems. Projects like this one allow me to apply classroom knowledge in a practical and impactful way, as I work toward a career in software engineering.

Feel free to reach out—I’d love to connect or answer any questions you may have.
