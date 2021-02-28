-- 1

-- SELECT         Person.first_name
--               , Person.last_name
--               , Person.date_of_birth
--               , Person.email_address
--               , Person.telephone_number
--               , Person.city
-- FROM Person, Person_zone_junction
-- WHERE Person.Person_ID = Person_zone_junction.Person_ID  
-- AND Person_zone_junction.Zone_ID = 1 ;
SELECT first_name, last_name, date_of_birth, email_address, telephone_number, city
FROM Person,Person_zone_junction
WHERE Person.Person_ID = Person_zone_junction.Person_ID 
AND Person_zone_junction.Zone_ID = (SELECT Zone_ID 
									From GroupZone 
									WHERE Group_name = 'MontrealPrimaryGrade1_Group_1');
-- 2
/* Get details (first-name, last-name, date of birth, email, phone, city) of
all the people who tested positive for the COVID-19 on January 10th, 2021
 */

SELECT  DISTINCT
		 Person.first_name
	   , Person.last_name
       , Person.date_of_birth
       , Person.email_address
       , Person.telephone_number
       , Person.city
FROM Person, Diagnostic
WHERE Diagnostic.Person_id=Person.Person_ID
AND date(Diagnostic.Result_date)='2021.01.10'
AND Diagnostic.PCR_Test_Results='P' ;

-- 3

/* Give details of the diagnosis of the people who live at 95 Robert St. (first-
name, last-name, date of birth, email, phone, date of diagnosis, test result, Include the history of the diagnosis if a person have been tested more than once).
 */

SELECT   Person.first_name
	   , Person.last_name
       , Person.date_of_birth
       , Person.email_address
       , Person.telephone_number
       , Diagnostic.Result_Date
       , Diagnostic.PCR_Test_Results
FROM Person, Diagnostic
WHERE Person.Person_ID = Diagnostic.Person_id
AND Person.address='95 Robert St.'
ORDER BY Person.Person_ID ,Diagnostic.Result_Date  ;

-- 4
/* Provide a list of all the people who live with Roger Macdonald (first- name, last-name, date of birth, email, phone). */

SELECT   Person.first_name
	   , Person.last_name
       , Person.date_of_birth
       , Person.email_address
       , Person.telephone_number
FROM Person 
WHERE concat(Person.first_name,Person.last_name)<>'RogerMacdonald'
AND Person.address = (SELECT Person.address 
					  FROM Person 
					  WHERE Person.first_name= 'Roger' 
					  AND Person.last_name='Macdonald' ) ;
-- 5

/* Provide a list of all the people who are members of the same GroupZones of Roger Macdonald 
(If he is a member of more than on GroupZone, give the name of each GroupZone and the list of people in that specific GroupZone). */

SELECT  Person.first_name
	   ,Person.last_name
       ,GroupZone.Group_Name
FROM Person, Person_zone_junction, GroupZone
WHERE Person.Person_ID=Person_zone_junction.Person_ID
AND GroupZone.Zone_ID=Person_zone_junction.Zone_ID
AND concat(Person.first_name,Person.last_name)<>'RogerMacdonald'
AND Person_zone_junction.Zone_ID IN ( SELECT Person_zone_junction.Zone_ID
									  FROM Person, Person_zone_junction
									  WHERE Person_zone_junction.Person_ID=Person.Person_ID
									  AND Person.first_name='Roger'
									  AND Person.last_name='Macdonald' ) ;

-- 6 
/* Get details of all Public Health Workers who work in Viau Public Health Center 
   (first-name, last-name, date of birth, email, phone, city). */
   
SELECT   Person.first_name
	   , Person.last_name
       , Person.date_of_birth
       , Person.email_address
       , Person.telephone_number
       , Person.city
FROM Person, PublicHealthWorker, HealthFacility
WHERE Person.Person_ID = PublicHealthWorker.Person_ID
AND HealthFacility.Facility_ID=PublicHealthWorker.Serving_Facility
AND HealthFacility.Name='Viau Public Health Center'
AND PublicHealthWorker.Leaving_Date is null  ;