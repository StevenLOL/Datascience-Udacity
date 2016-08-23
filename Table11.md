#11. Hospital_Data.csv

The Hospital_Data.csv table contains thirteen (13) fields. This table provides general Hospital information in response to a Hospital Compare search.
```{R}
1. Provider Number: varchar (6) Lists the hospitals by their provider identification number. 
2. 2. Hospital Name: varchar (50) Lists the name of the hospital.
3. Address 1: varchar (50) Lists the first line of the street address of the hospital.
4. Address 2: varchar (50) Lists the second line of the street address of the hospital.
5. Address 3: varchar (50) Lists the third line of the street address of the hospital. 
6. 6. City: varchar (28) Lists the city in which the hospital is located.
7. State: varchar (2) Lists the 2 letter State code in which the hospital is located. 
8. 8. ZIP Code: char (5) Lists the 5 digit numeric ZIP for the hospital.
9. County Name: char (15) Lists the county in which the hospital is located.
10. Phone Number: char (10) Lists the 10-digit numeric telephone number, including area code, for the Hospital.
11. Hospital Type: char (25) Lists the type of hospital. 

The values are: 
* Acute Care Hospital
* Acute Care – VA Medical Center 
* Critical Access Hospital
* Children’s Hospital

12. Hospital Owner: varchar (44) Lists the type of ownership the Hospital falls under. 

The values are:
* Government – Federal
* Government – Hospital District or Authority 
* Government – Local
* Government – State
* Proprietary
* Voluntary non-profit – Church
* Voluntary non-profit – Other
* Voluntary non-profit – Private
* Not Available

13. Emergency Services: char (3) Returns “Yes” or “No” to specify whether or not the hospital provides emergency services.
```