# Project Brainstorm - Group 3
###### Team members: Russell Eng, Anne Lin, Xinmeng Zhang, Neil Sun 

### [Mid-point Deliverable](https://github.com/INFO-201-SUM-21/final-project-group-3/blob/fd0bf19c41fa084ab4c3c87a80dc209674203015/index.html)

### Domain of interest
#### Why are you interested in this field/domain?
> We are interested in knowing how Americans of different groups react to vaccination. Given that the Delta variant is causing a *new surge* of COVID-19 cases, it is key that all people get their **vaccination** as soon as possible. By breaking down the vaccinated population by state, demographic, and vaccine brands, it would be easier to create targeting incentives, promoting vaccination to fight against the more transmissible Delta variant. 

#### What other examples of data driven project have you found related to this domain (share at least 3)?
- [The Sex, Gender and COVID-19 Project](https://globalhealth5050.org/the-sex-gender-and-covid-19-project/the-data-tracker/?explore=variable&variable=Vaccinations)
> This project deals with global covid data and analyzes regional gender differences in multiple aspects such as confirmed cases, test rate, ICU admission, etc. This is essential in helping to understand which gender group is more impacted by the pandemic and has access to medical resources or intended to be tested. One defect of the project is that many countries don’t provide gender segregated data.

- [KFF COVID-19 Vaccine Monitor](https://www.kff.org/coronavirus-covid-19/dashboard/kff-covid-19-vaccine-monitor-dashboard)
> This project mainly focuses on identifying the attitude of people in the U.S towards being vaccinated, and identifies certain racial groups, parents, and groups with political standings that still hold against position toward vaccination. The researchers also analyzed reasons behind such hesitant attitudes, and found that worry about vaccination side effects is the main reason stopping people getting vaccinated.

- [Coping With Covid: Two-Wave Survey](https://rpubs.com/benwansell/729135)
> This project takes survey data that is collected on September 30th / October 1st 2020 and February 1st 2021 of UK citizens and  compares differences in the results. The analysis can be categorized in eight aspects: Willingness to take the vaccine, Vaccine Rollout, Vaccine Refusal, Demographics, Political factors, Vaccine Nationalism, Vaccine policy approval, Vaccine policy group differences.

#### What data-driven questions do you hope to answer and communicate about this domain (share at least 3)?
- How many people are vaccinated in a given state during a period of time?
- What state has the highest vaccination rate? The lower vaccination rate? 
- What demographic group has the highest vaccination rate? The lowest vaccination rate?
- How does the vaccination number develop over time? Where are the peak and the nadir?

### Finding Data
#### 1. CDC Vaccination Progress Data
- Where did you download the data (e.g., a web URL)
> https://ourworldindata.org/us-states-vaccinations
- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
> The data was collected by the CDC to keep track of the vaccination progress in the U.S. In an effort to monitor the total doses of vaccines being administered in a period of time. The dataset is about the total number of vaccinations for each state, which CDC uses its own data for a public use purpose. 
- How many observations (rows) are in your data?
> 13348
- How many features (columns) are in the data?
> 14
- What questions (from above) can be answered using the data in this dataset?
> The total number of people in the U.S. are vaccinated in a given state during a period of time. For each state to track the highest vaccination rate, as well as the lowest vaccination rate. This dataset varies regionally and can be helpful in answering the first question above.  

#### 2. Vaccine Demographics Data 
- Where did you download the data (e.g., a web URL)?
> https://covid.cdc.gov/covid-data-tracker/#vaccination-demographic
- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
> This data was collected by the CDC in cooperation with local state agencies to track the vaccination progress of different demographic groups. For this particular dataset only the fully vaccinated group is taken into consideration as for different geographic areas the data can vary. The given public information helps to analyze for different racial, gender and age groups for the purpose of helping the local government alter their vaccine strategies.  
- How many observations (rows) are in your data?
> Sex_of_people_fully_vaccinated.csv: 2

> Age_groups_of_people_fully_vaccinated.csv: 9

> Race_ethnicity_of_people_fully_vaccinated.csv: 7
- How many features (columns) are in the data?
> Sex_of_people_fully_vaccinated.csv: 5

> Age_groups_of_people_fully_vaccinated.csv: 5

> Race_ethnicity_of_people_fully_vaccinated.csv: 5
- What questions (from above) can be answered using the data in this dataset?
> The dataset provides a variety of information about the vaccination progress for  different demographic groups in the U.S. According to those data, we are able to analyze the gender, age, and race of the people who have the highest and lowest vaccination rate. 

#### 3. Total Vaccination in the U.S Data
- Where did you download the data (e.g., a web URL)?
> https://covid.cdc.gov/covid-data-tracker/#vaccination-trends
- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
> This data contains a daily count of total doses administered and reported to CDC in the U.S. from the date of Dec. 2020 to the present. It was generated by CDC’s reports from local governments indicating a clear trend of slowing vaccination rate in the U.S. This data helps both vaccination developers and the federal government tracking and learning the model of vaccination studies. 
- How many observations (rows) are in your data?
> 28670
- How many features (columns) are in the data?
> 15
- What questions (from above) can be answered using the data in this dataset?
> This data includes a variety of information related to the trend of vaccination being administered in the U.S. It answers the fourth question about how vaccination developed over the time and helps to learn the model as well. 
