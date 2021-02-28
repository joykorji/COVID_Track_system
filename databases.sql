/*
DROP TABLE IF EXISTS Person_zone_junction ;
DROP TABLE IF EXISTS GroupZone;
DROP TABLE IF EXISTS Diagnostic ;
DROP TABLE IF EXISTS PublicHealthWorker ;
DROP TABLE IF EXISTS HealthFacility ;
DROP TABLE IF EXISTS parent_child_relationship ;
DROP TABLE IF EXISTS Person ;
*/

--
-- Table structure for table `Person`
--
-- DROP TABLE IF EXISTS `Person`;
CREATE TABLE `Person` (
  `Person_ID`       varchar(20) NOT NULL,
  `first_name`      varchar(200) DEFAULT NULL,
  `last_name`       varchar(200)  DEFAULT NULL,
  `date_of_birth`     datetime DEFAULT NULL,
  `medicare_number`   varchar(20) DEFAULT NULL,
  `telephone_number` varchar(20) DEFAULT NULL,
  `address`       varchar(45)  DEFAULT NULL,
  `city`        varchar(45)  DEFAULT NULL,
  `province`      varchar(45) DEFAULT NULL,
  `postal_code`     varchar(45) DEFAULT NULL,
  `citizenship`     varchar(45) DEFAULT NULL,
  `email_address`     varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Person_ID`)
);

--
-- Table structure for table `parent_child_relationship`
--
-- DROP TABLE IF EXISTS `parent_child_relationship`;
CREATE TABLE `parent_child_relationship` (
  `parent`  varchar(20) NOT NULL,
  `child`   varchar(20) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `ParentKey_idx` (`Parent`),
  CONSTRAINT `parent_fk` FOREIGN KEY (`parent`) REFERENCES `Person` (`Person_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `child_fk` FOREIGN KEY (`child`) REFERENCES `Person` (`Person_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

--
-- Table structure for table `GroupZone`
--
-- DROP TABLE IF EXISTS `GroupZone`;
CREATE TABLE `GroupZone` (
  `Zone_ID`   int NOT NULL,
  `Group_name`  varchar(45)  DEFAULT NULL,
  PRIMARY KEY (`Zone_ID`)
) ;

--
-- Table structure for table `Person_zone_junction`
--
-- DROP TABLE IF EXISTS `Person_zone_junction`;
CREATE TABLE `Person_zone_junction` (
  `Person_ID` varchar(20) NOT NULL,
  `Zone_ID`   int NOT NULL,
  PRIMARY KEY (`Person_ID`,`Zone_ID`),
  KEY `Zone_ID_fk` (`Zone_ID`),
  CONSTRAINT `Person_fk` FOREIGN KEY (`Person_ID`) REFERENCES `Person` (`Person_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Zone_fk` FOREIGN KEY (`Zone_ID`) REFERENCES `GroupZone` (`Zone_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

--
-- Table structure for table `HealthFacility`
--
-- DROP TABLE IF EXISTS `HealthFacility`;
CREATE TABLE `HealthFacility` (
  `Facility_ID` int NOT NULL,
  `Name`    varchar(200)  DEFAULT NULL,
  `Address`   varchar(45) DEFAULT NULL,
  `Phone`     varchar(20) DEFAULT NULL,
  `Web_Address` varchar(200) DEFAULT NULL,
  `Type`    varchar(200)  DEFAULT NULL,
  PRIMARY KEY (`Facility_ID`),
  KEY `fk1_idx` (`Address`)
) ;

--
-- Table structure for table `PublicHealthWorker`
--
-- DROP TABLE IF EXISTS `PublicHealthWorker`;
CREATE TABLE `PublicHealthWorker` (
  `Person_ID`      varchar(20) NOT NULL,
  `Serving_facility` int NOT NULL,
  `Position`     varchar(45)  not NULL,
  `Joining_Date`   datetime not null,
  `Leaving_Date`   datetime DEFAULT NULL,
  `working_schedule` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Person_ID`,`Serving_facility`,`Joining_Date`),
  KEY `FacilityID_idx` (`Serving_Facility`),
  CONSTRAINT `Facility_ID` FOREIGN KEY (`Serving_facility`) REFERENCES `HealthFacility` (`Facility_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Person_ID` FOREIGN KEY (`Person_ID`) REFERENCES `Person` (`Person_ID`)
) ;

--
-- Table structure for table `Diagnostic`
--
-- DROP TABLE IF EXISTS `Diagnostic`;
CREATE TABLE `Diagnostic` (
  `Person_ID`               varchar(20) NOT NULL,
  `test_date`               datetime NOT NULL,
  `Public_health_worker_Performed_PCR`  varchar(20) ,
  `PCR_test_results`          char(1)  ,
  `Result_date`             datetime ,
  `Facility_Tested`           int ,
  PRIMARY KEY (`Person_id`,`test_date`),
  KEY `Facility_ID_idx` (`Facility_tested`),
  KEY `FacilityID_Diagnostics_idx` (`Facility_Tested`),
  KEY `Health_worker_Diagnostic_idx` (`Public_health_worker_Performed_PCR`),
  CONSTRAINT `Facility_id_Diagnostics` FOREIGN KEY (`Facility_Tested`) REFERENCES `HealthFacility` (`Facility_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `HealthWorker_Diagnostic` FOREIGN KEY (`Public_health_worker_Performed_PCR`) REFERENCES `Person` (`Person_ID`),
  CONSTRAINT `PersonTested_diagnostics` FOREIGN KEY (`Person_ID`) REFERENCES `Person` (`Person_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ;


-- Populate the tables ==

insert into Person (`Person_ID`,
          `first_name`,     
          `last_name` ,   
          `date_of_birth`,  
          `medicare_number`,  
          `telephone_number`,
          `address`,      
          `city`,        
          `province`,      
          `postal_code`,   
          `citizenship`,   
          `email_address` )
values ('0123','Roger','Macdonald',now() - interval 15000 day,514115,'995591932747','95 Robert St.','Adelaide','whatever','0171','US','Roger.Macdonald@gmail.com' ),
     ('0321','Elizabeth','Macdonald',now() - interval 13000 day,42153,'995591932748','95 Robert St.','Adelaide','whatever','0171','US','Elizabeth.Macdonald@gmail.com' ),
     ('0643','Stevie','Macdonald',now() - interval 8000 day,421513,'995591932749','95 Robert St.','Adelaide','whatever','0171','US','Stevie.Macdonald@gmail.com' ),
       ('0746','Tarya','Macdonald',now() - interval 5000 day,65464,'995591932750','95 Robert St.','Adelaide','whatever','0171','US','Tarya.Macdonald@gmail.com' ),
       ('123','George','Griffith',now() - interval 25000 day,34573457,'843574534643','4373 Some St.','SomeCity','whatever','0171','US','George.Griffith@gmail.com' ),
     ('234','Michael','Pheradze',now() - interval 17000 day,74374,'2456543735','435 Some St.','SomeCity','whatever','0171','US','Michael.Pheradze@gmail.com' ),
     ('345','Joe','Rogan',now() - interval 11000 day,421513,'573474357','354 Some St.','Adelaide','SomeCity2','0171','US','Stevie.Macdonald@gmail.com' ),
       ('456','Fredy','Venus',now() - interval 19000 day,56342,'64355435747','Some35 St.','Adelaide','SomeCity4','0171','US','Fredy.Venus@gmail.com' ) ,
       ('567','Albert','Tesla',now() - interval 99000 day,534745,'6543743547','Some44 St.','Adelaide','SomeCity65','0171','US','Albert.Tesla@gmail.com' ),
     ('678','Einhezard','Lancaster',now() - interval 18000 day,547457,'435743754','Some14 St.','SomeCity','whatever','0171','US','Elizabeth.Lancaster@gmail.com' ),
     ('789','Avant','Garde',now() - interval 22000 day,7453765,'54375477456','Some1 St.','SomeCity23','whatever','0171','US','Avant.Garde@gmail.com' ),
       ('890','Micle','Tyson',now() - interval 32000 day,7347,'0969696969','Some St.','City Of Mars','Center','0171','Unnamed','Tarya.Tyson@gmail.com' ),
       ('52333','Markus','Griffith',now() - interval 25000 day,34573457,'843574534643','4373 Some St.','SomeCity','whatever','0171','US','Markus.Griffith@gmail.com' ),
     ('2355623','Michaela','Pheradze',now() - interval 17000 day,74374,'2456543735','435 Some St.','SomeCity','whatever','0171','US','Michaela.Pheradze@gmail.com' ),
     ('432523','Dmtre','Rogan',now() - interval 11000 day,421513,'573474357','354 Some St.','Adelaide','SomeCity2','0171','US','Dmtre.Macdonald@gmail.com' ),
       ('12345','Fender','Venus',now() - interval 19000 day,56342,'64355435747','Some35 St.','Adelaide','SomeCity4','0171','US','Fender.Venus@gmail.com' ) ,
       ('124552','Alberton','Tesla',now() - interval 99000 day,534745,'6543743547','Some44 St.','Adelaide','SomeCity65','0171','US','Alberton.Tesla@gmail.com' ),
     ('6372','Kernon','Lancaster',now() - interval 18000 day,547457,'435743754','Some14 St.','SomeCity','whatever','0171','US','Kernon.Lancaster@gmail.com' ),
     ('234623','Elan','Garde',now() - interval 22000 day,7453765,'54375477456','Some1 St.','SomeCity23','whatever','0171','US','Elan.Garde@gmail.com' ) ;

insert into `parent_child_relationship` ( `parent` ,`child` )
values ('890','789'),('890','678'),('890','567'),('890','456'),('890','345'),
     ('890','234'),('890','123'),('890','0746'),('890','0643'),('890','0321'),
       ('890','0123'),('0123','0643'),('0123','0746'),('0321','0643'),('0321','0746') ;
       
insert into `GroupZone` ( `Zone_ID`,`Group_name`)
values (1,'MontrealPrimaryGrade1_Group_1'),(2,'SomeGroup2'),(3,'SomeGroup3'),(4,'SomeGroup4'),(5,'SomeGroup5'),
     (6,'SomeGroup6'),(7,'SomeGroup7'),(8,'SomeGroup8'),(9,'SomeGroup9'),(10,'SomeGroup10'),(11,'SomeGroup11');
       
insert into `Person_zone_junction` ( `Person_ID` , `Zone_ID` )
values  ('0643',1),('0746',1),('345',1),('124552',1),('234623',1),('890',1),
    ('0123',2),('234',2),('890',2),('456',3),('124552',3),('678',3),('432523',3),
        ('6372',4),('345',4),('890',5),('0123',5),('6372',5),('12345',6),('2355623',6);            
       
insert into `HealthFacility` (`Facility_ID`,
                `Name`,
                `Address`,
                `Phone`,
                `Web_Address`,
                `Type`)
values (1000,'Viau Public Health Center','Viau 876','62352134522','valu.com','Hospital'),
     (1010,'Adelaide Public Health Center','Adelaide 87','6346337225','Adelaide.com','Hospital'),
       (1020,'Adelaide Public Health Center2','Adelaide 88','6346337225','Adelaide.com','Hospital'),
       (1030,'Adelaide Public Health Center3','Adelaide 89','6346337225','Adelaide.com','Hospital'),
       (1040,'Adelaide Public Health Center4','Adelaide 90','6346337225','Adelaide.com','Hospital'),
       (1050,'Adelaide Public Health Center5','Adelaide 91','6346337225','Adelaide.com','Hospital'),
       (1060,'Adelaide Public Health Center6','Adelaide 92','6346337225','Adelaide.com','Hospital'),
       (1070,'Adelaide Public Health Center7','Adelaide 93','6346337225','Adelaide.com','Hospital'),
       (1080,'Adelaide Public Health Center8','Adelaide 94','6346337225','Adelaide.com','Hospital'),
       (1090,'Adelaide Public Health Center9','Adelaide 95','6346337225','Adelaide.com','Hospital') ;
       
insert into `PublicHealthWorker` (`Person_ID`,     
                  `Serving_facility`, 
                  `Position` ,     
                  `Joining_Date`,    
                  `Leaving_Date`,    
                  `working_schedule` )
values ('0321',1000,'Nurse','2017.06.01',null,'9:00AM to 5:00PM'),
     ('234',1000,'Nurse','2020.06.01',null,'9:00AM to 5:00PM'),
     ('890',1000,'Doctor','2020.06.01','2020.06.02','9:00AM to 5:00PM'),
     ('890',1010,'Statue','2020.06.03','2020.06.04','10:00AM to 6:00PM'), 
       ('678',1010,'Nurse','2017.06.01',null,'9:00AM to 5:00PM'),
     ('52333',1000,'Nurse','2020.07.01',null,'9:00AM to 5:00PM'),
     ('890',1000,'Doctor','2020.06.05','2020.06.06','9:00AM to 5:00PM'),
     ('890',1010,'Statue','2020.06.06','2020.06.07','10:00AM to 6:00PM'), 
       ('6372',1020,'Nurse','2017.06.01',null,'9:00AM to 5:00PM'),
     ('234',1020,'Nurse','2020.06.01',null,'9:00AM to 5:00PM'),
     ('890',1080,'Doctor','2020.06.07',null,'9:00AM to 5:00PM'),
     ('890',1080,'Statue','2020.06.08','2020.06.09','10:00AM to 6:00PM')  ;
 
       
insert into   `Diagnostic` (  `Person_ID` ,             
                `test_date` ,         
                `Public_health_worker_Performed_PCR` , 
                `PCR_test_results` ,          
                `Result_date`   ,         
                `Facility_Tested` )
values ('0123','2021.01.10','0321','N','2021.01.10', 1000),
     ('0123','2021.01.11','0321','N','2021.01.12', 1000),
       ('0123','2021.02.10','0321','P','2021.02.11',1000),
       ('0321','2021.01.10','0321','P', '2021.01.11',1000),              
     ('0643','2021.01.10','0321','P','2021.01.10',1000),
       ('0746','2021.01.10','0321','P','2021.01.10',1000),
       ('123','2021.01.10','0321','P','2021.01.10',1000),
       ('234','2021.01.10','0321','P','2021.01.12',1000),
       ('345','2021.01.10','0321','P', '2021.01.11',1000),
       ('456','2021.01.10','0321','P', '2021.01.11',1000),
       ('567','2021.01.10','0321','P','2021.01.10',1000),
       ('678','2021.01.10','0321','P','2021.01.10',1000),
       ('789','2021.01.14','234','N','2021.01.15',1000),
       ('890','2021.01.14','234','P','2021.01.15',1000),
       ('2355623','2021.01.14','678','P','2021.01.15',1010),
       ('234623','2021.01.14','678','N','2021.01.15',1010),
       ('6372','2021.01.14','678','P','2021.01.15',1010)  ;