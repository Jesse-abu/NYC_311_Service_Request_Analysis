# NYC_311_Service_Request_Analysis
This is a repository for the NYC 311 service request analysis, where the analysis was made with Jupyter, and the report on the findings has been uploaded

This project analyzes New York City's 311 service request data to identify trends in urban issues and predict the time required for city agencies to resolve them.

## Project Structure
- `NYC311_analysis.ipynb`: The main Jupyter Notebook containing data cleaning, exploratory data analysis (EDA), and machine learning model training.
- `nyc311_profile.html`: An interactive Exploratory Data Analysis report generated using `ydata-profiling`.

## Features
- **Exploratory Data Analysis**: Automated profiling of the dataset including missing value analysis, correlations, and distributions of complaints.
- **Data Preprocessing**: Handling of datetime objects and encoding of categorical variables like 'Borough' and 'Complaint Type'.
- **Machine Learning**: A regression pipeline using `scikit-learn` to predict the resolution time (in days) for new service requests.

## Setup & Installation
To run this analysis locally, you will need Python 3 and the following libraries:

```bash
pip install pandas matplotlib seaborn scikit-learn ydata_profiling
