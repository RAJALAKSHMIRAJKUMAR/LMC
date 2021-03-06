-- VERSION:0.4 --SDATE:18/04/2015 --DESC:ADDED LMC_MACHINERY_ITEM CREATE QUERY & ADDED ULD_ID , TIMESTAMP IN LMC_MACHINERY_USAGE,LMC_FITTING_USAGE,LMC_MATERIAL_USAGE TABLE & ADDED MT_ID IN LMC_MACHINERY_EQUIPMENT_TRANSFER TABLE--DONE BY:RL
-- VERSION:0.3 --DATE:26/03/2015 --DESC:REMOVED TRD_LOCATION,TRD_CONTRACT_NO & ADDED CLD_ID, EMP_ID CHANGED AS ULD IN LMC_TEAM_REPORT_DETAILS EMP_ID CHANGED AS ULD_ID IN LMC_TEAM_EMPLOYEE_REPORT_DETAILS TABLE --DONE BY:RL
-- VERSION:0.2 --SDATE:14/03/2015 --EDATE:14/03/2015 --DESC: ADDED LMC_TEAM_REPORT_ATTACHMENT_DETAILS N REMOVED TRD_DOC_FILE_NAME IN LMC_TEAM_REPORT_DETAILS TABLE --DONE BY RL

DROP PROCEDURE IF EXISTS SP_LMC_REPORT_TABLE_CREATION;
CREATE PROCEDURE SP_LMC_REPORT_TABLE_CREATION(
OUT SUCCESS_MESSAGE TEXT)

BEGIN

-- QUERY FOR ROLLBACK COMMAND
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN 
		SET SUCCESS_MESSAGE=0;
	END;
	START TRANSACTION;

	SET FOREIGN_KEY_CHECKS = 0;
	SET SUCCESS_MESSAGE=0;
	SET AUTOCOMMIT=0;

-- LMC_TYPE_OF_JOB
	DROP TABLE IF EXISTS LMC_TYPE_OF_JOB;
	CREATE TABLE LMC_TYPE_OF_JOB(
	TOJ_ID INTEGER NOT NULL AUTO_INCREMENT,
	TOJ_JOB VARCHAR(50) NOT NULL,
	ULD_ID INTEGER NOT NULL,
	TOJ_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(TOJ_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
	
	SET @ALTER_LMC_TYPE_OF_JOB = (SELECT CONCAT('ALTER TABLE LMC_TYPE_OF_JOB AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_TYPE_OF_JOB_STMT FROM @ALTER_LMC_TYPE_OF_JOB;
	EXECUTE ALTER_LMC_TYPE_OF_JOB_STMT;

-- LMC_MEETING_TOPIC
	DROP TABLE IF EXISTS LMC_MEETING_TOPIC;
	CREATE TABLE LMC_MEETING_TOPIC(
	MT_ID INTEGER NOT NULL AUTO_INCREMENT,
	MT_TOPIC VARCHAR(50) NOT NULL,
	ULD_ID INTEGER NOT NULL,
	MT_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MT_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
	
	SET @ALTER_LMC_MEETING_TOPIC = (SELECT CONCAT('ALTER TABLE LMC_MEETING_TOPIC AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MEETING_TOPIC_STMT FROM @ALTER_LMC_MEETING_TOPIC;
	EXECUTE ALTER_LMC_MEETING_TOPIC_STMT;

-- LMC_TEAM_REPORT_DETAILS
	DROP TABLE IF EXISTS LMC_TEAM_REPORT_DETAILS;
	CREATE TABLE LMC_TEAM_REPORT_DETAILS(
	TRD_ID INTEGER NOT NULL AUTO_INCREMENT,
	ULD_ID INTEGER NOT NULL,
	TRD_DATE DATE NOT NULL,
	TRD_LOCATION TEXT  NULL,
	TRD_CONTRACT_NO VARCHAR(10) NULL,
	TC_ID INTEGER NOT NULL,
	TRD_REACH_SITE TIME NULL,
	TRD_LEAVE_SITE TIME NULL,
	TOJ_ID VARCHAR(12) NULL,
	TRD_WEATHER_REASON VARCHAR(30) NULL,
	TRD_WEATHER_FROM_TIME TIME NULL,
	TRD_WEATHER_TO_TIME TIME NULL,
	TRD_PIPE_TESTING VARCHAR(50)  NULL,
	TRD_START_PRESSURE TEXT  NULL,
	TRD_END_PRESSURE TEXT  NULL,
	TRD_REMARK TEXT NULL,
	TRD_IMG_FILE_NAME TEXT NULL,
	TRD_USERSTAMP_ID INTEGER NOT NULL,
	TRD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(TRD_ID),
	FOREIGN KEY(TC_ID) REFERENCES LMC_TEAM_CREATION (TC_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID),
	FOREIGN KEY(TRD_USERSTAMP_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_TEAM_REPORT_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_TEAM_REPORT_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_TEAM_REPORT_DETAILS_STMT FROM @ALTER_LMC_TEAM_REPORT_DETAILS;
	EXECUTE ALTER_LMC_TEAM_REPORT_DETAILS_STMT;

-- LMC_REPORT_DOCUMENT_CATEGORY
	DROP TABLE IF EXISTS LMC_REPORT_DOCUMENT_CATEGORY;
	CREATE TABLE LMC_REPORT_DOCUMENT_CATEGORY(
	RDC_ID INTEGER NOT NULL AUTO_INCREMENT,
	RDC_CATEGORY VARCHAR(50) NOT NULL,	
	ULD_ID INTEGER NOT NULL,
	RDC_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(RDC_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));

	SET @ALTER_LMC_LMC_REPORT_DOCUMENT_CATEGORY = (SELECT CONCAT('ALTER TABLE LMC_REPORT_DOCUMENT_CATEGORY AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_LMC_REPORT_DOCUMENT_CATEGORY_STMT FROM @ALTER_LMC_LMC_REPORT_DOCUMENT_CATEGORY;
	EXECUTE ALTER_LMC_LMC_REPORT_DOCUMENT_CATEGORY_STMT;

-- LMC_REPORT_ATTACHMENT_DETAILS
	DROP TABLE IF EXISTS LMC_REPORT_ATTACHMENT_DETAILS;
	CREATE TABLE LMC_REPORT_ATTACHMENT_DETAILS(
	RAD_ID INTEGER NOT NULL AUTO_INCREMENT,
	RDC_ID INTEGER NOT NULL,	
	RAD_DATE DATE NOT NULL,
	RAD_DOC_FILE_NAME TEXT NOT NULL,
	ULD_ID INTEGER NOT NULL,
	RAD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(RAD_ID),
	FOREIGN KEY(RDC_ID) REFERENCES LMC_REPORT_DOCUMENT_CATEGORY (RDC_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));

	SET @ALTER_LMC_REPORT_ATTACHMENT_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_REPORT_ATTACHMENT_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_REPORT_ATTACHMENT_DETAILS_STMT FROM @ALTER_LMC_REPORT_ATTACHMENT_DETAILS;
	EXECUTE ALTER_LMC_REPORT_ATTACHMENT_DETAILS_STMT;

-- LMC_MEETING_DETAILS
	DROP TABLE IF EXISTS LMC_MEETING_DETAILS;
	CREATE TABLE LMC_MEETING_DETAILS(
	MD_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	MT_ID VARCHAR(20) NOT NULL,
	MD_REMARKS TEXT  NULL,
	ULD_ID INTEGER NOT NULL,
	MD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MD_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS (TRD_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_MEETING_DETAILS= (SELECT CONCAT('ALTER TABLE LMC_MEETING_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MEETING_DETAILS_STMT FROM @ALTER_LMC_MEETING_DETAILS;
	EXECUTE ALTER_LMC_MEETING_DETAILS_STMT;

-- LMC_TEAM_JOB
	DROP TABLE IF EXISTS LMC_TEAM_JOB;
	CREATE TABLE LMC_TEAM_JOB(
	TJ_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	TJ_PIPE_LAID VARCHAR(20) NULL,
	TJ_SIZE INTEGER NULL,
	TJ_LENGTH INTEGER NULL,
	ULD_ID INTEGER NOT NULL,
	TJ_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(TJ_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS (TRD_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_TEAM_JOB = (SELECT CONCAT('ALTER TABLE LMC_TEAM_JOB AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_TEAM_JOB_STMT FROM @ALTER_LMC_TEAM_JOB;
	EXECUTE ALTER_LMC_TEAM_JOB_STMT;

-- LMC_TEAM_EMPLOYEE_REPORT_DETAILS
	DROP TABLE IF EXISTS LMC_TEAM_EMPLOYEE_REPORT_DETAILS;
	CREATE TABLE LMC_TEAM_EMPLOYEE_REPORT_DETAILS(
	TERD_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	ULD_ID INTEGER NOT NULL,
	TERD_START_TIME TIME NULL,
	TERD_END_TIME TIME NULL,
	TERD_OT DECIMAL(3,1) NULL,
	TERD_REMARK TEXT NULL,
	TERD_USERSTAMP_ID INTEGER NOT NULL,
	TERD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(TERD_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS (TRD_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID),
	FOREIGN KEY(TERD_USERSTAMP_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_TEAM_EMPLOYEE_REPORT_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_TEAM_EMPLOYEE_REPORT_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_TEAM_EMPLOYEE_REPORT_DETAILS_STMT FROM @ALTER_LMC_TEAM_EMPLOYEE_REPORT_DETAILS;
	EXECUTE ALTER_LMC_TEAM_EMPLOYEE_REPORT_DETAILS_STMT;

-- LMC_SITE_VISIT_DETAILS
	DROP TABLE IF EXISTS LMC_SITE_VISIT_DETAILS;
	CREATE TABLE LMC_SITE_VISIT_DETAILS(
	SVD_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	SVD_NAME CHAR(50)  NULL,
	SVD_DESIGNATION VARCHAR(50) NULL,
	SVD_START_TIME TIME NULL,
	SVD_END_TIME TIME NULL,
	SVD_REMARK TEXT NULL,
	ULD_ID INTEGER NOT NULL,
	SVD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(SVD_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_SITE_VISIT_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_SITE_VISIT_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_SITE_VISIT_DETAILS_STMT FROM @ALTER_LMC_SITE_VISIT_DETAILS;
	EXECUTE ALTER_LMC_SITE_VISIT_DETAILS_STMT;

-- LMC_MACHINERY_ITEM
	DROP TABLE IF EXISTS LMC_MACHINERY_ITEM;
	CREATE TABLE LMC_MACHINERY_ITEM(
	MI_ID INTEGER NOT NULL AUTO_INCREMENT,
	MI_ITEM VARCHAR(50) NOT NULL,
	ULD_ID INTEGER NOT NULL,
	MI_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MI_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
	
	SET @ALTER_LMC_MACHINERY_ITEM = (SELECT CONCAT('ALTER TABLE LMC_MACHINERY_ITEM AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MACHINERY_ITEM_STMT FROM @ALTER_LMC_MACHINERY_ITEM;
	EXECUTE ALTER_LMC_MACHINERY_ITEM_STMT;

-- LMC_MACHINERY_EQUIPMENT_TRANSFER
	DROP TABLE IF EXISTS LMC_MACHINERY_EQUIPMENT_TRANSFER;
	CREATE TABLE LMC_MACHINERY_EQUIPMENT_TRANSFER(
	MET_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	MET_FROM_LORRY_NO VARCHAR(20) NULL,
	MET_TO_LORRY_NO VARCHAR(20) NULL,
	MI_ID INTEGER NOT NULL,
	MET_REMARK TEXT NULL,
	ULD_ID INTEGER NOT NULL,
	MET_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MET_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY(MI_ID) REFERENCES LMC_MACHINERY_ITEM(MI_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
	
	SET @ALTER_LMC_MACHINERY_EQUIPMENT_TRANSFER = (SELECT CONCAT('ALTER TABLE LMC_MACHINERY_EQUIPMENT_TRANSFER AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MACHINERY_EQUIPMENT_TRANSFER_STMT FROM @ALTER_LMC_MACHINERY_EQUIPMENT_TRANSFER;
	EXECUTE ALTER_LMC_MACHINERY_EQUIPMENT_TRANSFER_STMT;

-- LMC_MACHINERY_USAGE
	DROP TABLE IF EXISTS LMC_MACHINERY_USAGE;
	CREATE TABLE LMC_MACHINERY_USAGE(
	MCU_ID INTEGER NOT NULL AUTO_INCREMENT,
	MCU_MACHINERY_TYPE VARCHAR(30) NOT NULL,
	ULD_ID INTEGER NOT NULL,
	MCU_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MCU_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_MACHINERY_USAGE = (SELECT CONCAT('ALTER TABLE LMC_MACHINERY_USAGE AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MACHINERY_USAGE_STMT FROM @ALTER_LMC_MACHINERY_USAGE;
	EXECUTE ALTER_LMC_MACHINERY_USAGE_STMT;

-- LMC_FITTING_USAGE
	DROP TABLE IF EXISTS LMC_FITTING_USAGE;
	CREATE TABLE LMC_FITTING_USAGE(
	FU_ID INTEGER NOT NULL AUTO_INCREMENT,
	FU_ITEMS VARCHAR(50) NOT NULL,
	ULD_ID INTEGER NOT NULL,
	FU_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(FU_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
	
	SET @ALTER_LMC_FITTING_USAGE = (SELECT CONCAT('ALTER TABLE LMC_FITTING_USAGE AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_FITTING_USAGE_STMT FROM @ALTER_LMC_FITTING_USAGE;
	EXECUTE ALTER_LMC_FITTING_USAGE_STMT;

-- LMC_MATERIAL_USAGE
	DROP TABLE IF EXISTS LMC_MATERIAL_USAGE;
	CREATE TABLE LMC_MATERIAL_USAGE(
	MU_ID INTEGER NOT NULL AUTO_INCREMENT, 
	MU_ITEMS VARCHAR(50) NOT NULL,
	ULD_ID INTEGER NOT NULL,
	MU_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MU_ID),
	FOREIGN KEY(ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_MATERIAL_USAGE = (SELECT CONCAT('ALTER TABLE LMC_MATERIAL_USAGE AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MATERIAL_USAGE_STMT FROM @ALTER_LMC_MATERIAL_USAGE;
	EXECUTE ALTER_LMC_MATERIAL_USAGE_STMT;

-- LMC_MACHINERY_USAGE_DETAILS
	DROP TABLE IF EXISTS LMC_MACHINERY_USAGE_DETAILS;
	CREATE TABLE LMC_MACHINERY_USAGE_DETAILS(
	MAC_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	MCU_ID INTEGER NOT NULL,
	MAC_START_TIME TIME NULL,
	MAC_END_TIME TIME NULL,
	MAC_REMARK TEXT NULL,	
	ULD_ID INTEGER NOT NULL,
	MAC_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MAC_ID),
	FOREIGN KEY (MCU_ID) REFERENCES LMC_MACHINERY_USAGE(MCU_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY (ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_MACHINERY_USAGE_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_MACHINERY_USAGE_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MACHINERY_USAGE_DETAILS_STMT FROM @ALTER_LMC_MACHINERY_USAGE_DETAILS;
	EXECUTE ALTER_LMC_MACHINERY_USAGE_DETAILS_STMT;

-- LMC_FITTING_USAGE_DETAILS
	DROP TABLE IF EXISTS LMC_FITTING_USAGE_DETAILS;
	CREATE TABLE LMC_FITTING_USAGE_DETAILS(
	FUD_ID INTEGER NOT NULL AUTO_INCREMENT,
	FU_ID INTEGER NOT NULL,
	TRD_ID INTEGER NOT NULL,
	FUD_SIZE VARCHAR(15) NULL,
	FUD_QUANTITY VARCHAR(15) NULL,
	FUD_REMARK TEXT NULL,	
	ULD_ID INTEGER NOT NULL,
	FUD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(FUD_ID),
	FOREIGN KEY (FU_ID) REFERENCES LMC_FITTING_USAGE(FU_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY (ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_FITTING_USAGE_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_FITTING_USAGE_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_FITTING_USAGE_DETAILS_STMT FROM @ALTER_LMC_FITTING_USAGE_DETAILS;
	EXECUTE ALTER_LMC_FITTING_USAGE_DETAILS_STMT;

-- LMC_MATERIAL_USAGE_DETAILS
	DROP TABLE IF EXISTS LMC_MATERIAL_USAGE_DETAILS;
	CREATE TABLE LMC_MATERIAL_USAGE_DETAILS(
	MUD_ID INTEGER NOT NULL AUTO_INCREMENT,
	MU_ID INTEGER NOT NULL,
	TRD_ID INTEGER NOT NULL,
	MUD_RECEIPT_NO	VARCHAR(25) NULL,
	MUD_QUANTITY INTEGER NULL,
	ULD_ID INTEGER NOT NULL,
	MUD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(MUD_ID),
	FOREIGN KEY (MU_ID) REFERENCES LMC_MATERIAL_USAGE (MU_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY (ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_MATERIAL_USAGE_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_MATERIAL_USAGE_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_MATERIAL_USAGE_DETAILS_STMT FROM @ALTER_LMC_MATERIAL_USAGE_DETAILS;
	EXECUTE ALTER_LMC_MATERIAL_USAGE_DETAILS_STMT;

-- LMC_RENTAL_MACHINERY_DETAILS
	DROP TABLE IF EXISTS LMC_RENTAL_MACHINERY_DETAILS;
	CREATE TABLE LMC_RENTAL_MACHINERY_DETAILS(
	RMD_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	RMD_LORRY_NO VARCHAR(20) NULL,
	RMD_THROWEARTH_STORE INTEGER NULL,
	RMD_THROWEARTH_OUTSIDE INTEGER NULL,
	RMD_START_TIME TIME NULL,
	RMD_END_TIME TIME  NULL,
	RMD_REMARK TEXT NULL,		
	ULD_ID INTEGER NOT NULL,
	RMD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(RMD_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY (ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_RENTAL_MACHINERY_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_RENTAL_MACHINERY_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_RENTAL_MACHINERY_DETAILS_STMT FROM @ALTER_LMC_RENTAL_MACHINERY_DETAILS;
	EXECUTE ALTER_LMC_RENTAL_MACHINERY_DETAILS_STMT;

-- LMC_EQUIPMENT_USAGE_DETAILS
	DROP TABLE IF EXISTS LMC_EQUIPMENT_USAGE_DETAILS;
	CREATE TABLE LMC_EQUIPMENT_USAGE_DETAILS(
	EUD_ID INTEGER NOT NULL AUTO_INCREMENT,
	TRD_ID INTEGER NOT NULL,
	EUD_EQUIPMENT VARCHAR(30)  NULL,		
	EUD_LORRY_NO VARCHAR(30) NULL,
	EUD_START_TIME TIME  NULL,	
	EUD_END_TIME TIME NULL,	
	EUD_REMARK TEXT	 NULL,
	ULD_ID INTEGER NOT NULL,
	EUD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(EUD_ID),
	FOREIGN KEY(TRD_ID) REFERENCES LMC_TEAM_REPORT_DETAILS(TRD_ID),
	FOREIGN KEY (ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_EQUIPMENT_USAGE_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_EQUIPMENT_USAGE_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_EQUIPMENT_USAGE_DETAILS_STMT FROM @ALTER_LMC_EQUIPMENT_USAGE_DETAILS;
	EXECUTE ALTER_LMC_EQUIPMENT_USAGE_DETAILS_STMT;

-- LMC_ACCIDENT_REPORT_DETAILS
	DROP TABLE IF EXISTS LMC_ACCIDENT_REPORT_DETAILS;
	CREATE TABLE LMC_ACCIDENT_REPORT_DETAILS(
	ARD_ID INTEGER NOT NULL AUTO_INCREMENT,
	ARD_DATE DATE NOT NULL,
	ARD_PLACE VARCHAR(50) NOT NULL,
	ARD_TYPE_OF_INJURY VARCHAR(50) NOT NULL,
	ARD_NATURE_OF_INJURY VARCHAR(50) NOT NULL,
	ARD_TIME TIME NOT NULL,
	ARD_LOCATION VARCHAR(50) NOT NULL,
	ARD_INJURED_PART VARCHAR(50) NOT NULL,
	ARD_MACHINERY_TYPE VARCHAR(50),
	ARD_LM_NO VARCHAR(25),
	ARD_OPERATOR_NAME CHAR(30),
	ARD_NAME CHAR(30) NOT NULL,
	ARD_AGE INTEGER NOT NULL,
	ARD_ADDRESS TEXT NOT NULL,
	ARD_NRIC_NO VARCHAR(10) NOT NULL,
	ARD_FIN_NO VARCHAR(10) NOT NULL,
	ARD_WORK_PERMIT_NO INTEGER NOT NULL,
	ARD_PASSPORT_NO VARCHAR(15) NOT NULL,
	ARD_NATIONALITY VARCHAR(30) NOT NULL,
	ARD_SEX VARCHAR(6) NOT NULL,
	ARD_DOB DATE NOT NULL,
	ARD_MARTIAL_STATUS VARCHAR(10) NOT NULL,
	ARD_DESIGNATION VARCHAR(25) NOT NULL,
	ARD_LENGTH_OF_SERVICE VARCHAR(50) NOT NULL,
	ARD_WORK_COMMENCEMENT VARCHAR(3) NOT NULL,
	ARD_DESCRIPTION TEXT NOT NULL,
	ULD_ID INTEGER NOT NULL,
	ARD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(ARD_ID),
	FOREIGN KEY (ULD_ID) REFERENCES LMC_USER_LOGIN_DETAILS (ULD_ID));
		
	SET @ALTER_LMC_ACCIDENT_REPORT_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_ACCIDENT_REPORT_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_ALTER_LMC_ACCIDENT_REPORT_DETAILS_STMT FROM @ALTER_LMC_ACCIDENT_REPORT_DETAILS;
	EXECUTE ALTER_ALTER_LMC_ACCIDENT_REPORT_DETAILS_STMT;
	
	DROP TABLE IF EXISTS LMC_TEMP_TABLE_DETAILS;
	CREATE TABLE LMC_TEMP_TABLE_DETAILS(
	TTD_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	TTD_DATE DATE,
	TTD_TABLE_NAME TEXT,
	TTD_TIMESTAMP TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

	SET @ALTER_LMC_TEMP_TABLE_DETAILS = (SELECT CONCAT('ALTER TABLE LMC_TEMP_TABLE_DETAILS AUTO_INCREMENT = 0'));
	PREPARE ALTER_LMC_TEMP_TABLE_DETAILS_STMT FROM @ALTER_LMC_TEMP_TABLE_DETAILS;
	EXECUTE ALTER_LMC_TEMP_TABLE_DETAILS_STMT;

	SET SUCCESS_MESSAGE = 1;
		
	SET FOREIGN_KEY_CHECKS = 1;

	COMMIT;

END;

CALL SP_LMC_REPORT_TABLE_CREATION(@SUCCESS_MESSAGE);
SELECT @SUCCESS_MESSAGE;

DROP PROCEDURE IF EXISTS SP_LMC_REPORT_TABLE_CREATION;