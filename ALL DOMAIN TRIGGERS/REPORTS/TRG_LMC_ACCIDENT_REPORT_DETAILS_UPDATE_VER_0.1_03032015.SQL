
DROP TRIGGER IF EXISTS TRG_LMC_ACCIDENT_REPORT_DETAILS_UPDATE;
CREATE TRIGGER TRG_LMC_ACCIDENT_REPORT_DETAILS_UPDATE
AFTER UPDATE ON LMC_ACCIDENT_REPORT_DETAILS
FOR EACH ROW

BEGIN 

	DECLARE OLD_VALUE TEXT DEFAULT '';
	DECLARE NEW_VALUE TEXT DEFAULT '';

	IF((OLD.ARD_DATE!=NEW.ARD_DATE) OR (OLD.ARD_PLACE!=NEW.ARD_PLACE) OR
	(OLD.ARD_TYPE_OF_INJURY!=NEW.ARD_TYPE_OF_INJURY) OR (OLD.ARD_NATURE_OF_INJURY!=NEW.ARD_NATURE_OF_INJURY) OR
	(OLD.ARD_TIME!=NEW.ARD_TIME) OR (OLD.ARD_LOCATION!=NEW.ARD_LOCATION) OR
	(OLD.ARD_INJURED_PART IS NULL AND NEW.ARD_INJURED_PART IS NOT NULL) OR
	(OLD.ARD_INJURED_PART IS NOT NULL AND NEW.ARD_INJURED_PART IS NULL) OR
	(OLD.ARD_INJURED_PART!=NEW.ARD_INJURED_PART) OR
	(OLD.ARD_MACHINERY_TYPE IS NULL AND NEW.ARD_MACHINERY_TYPE IS NOT NULL) OR
	(OLD.ARD_MACHINERY_TYPE IS NOT NULL AND NEW.ARD_MACHINERY_TYPE IS NULL) OR
	(OLD.ARD_MACHINERY_TYPE!=NEW.ARD_MACHINERY_TYPE) OR
	(OLD.ARD_LM_NO IS NULL AND NEW.ARD_LM_NO IS NOT NULL) OR
	(OLD.ARD_LM_NO IS NOT NULL AND NEW.ARD_LM_NO IS NULL) OR
	(OLD.ARD_LM_NO!=NEW.ARD_LM_NO) OR
	(OLD.ARD_OPERATOR_NAME IS NULL AND NEW.ARD_OPERATOR_NAME IS NOT NULL) OR
	(OLD.ARD_OPERATOR_NAME IS NOT NULL AND NEW.ARD_OPERATOR_NAME IS NULL) OR
	(OLD.ARD_OPERATOR_NAME!=NEW.ARD_OPERATOR_NAME) OR
	(OLD.ARD_NAME!=NEW.ARD_NAME) OR (OLD.ARD_AGE!=NEW.ARD_AGE) OR
	(OLD.ARD_ADDRESS!=NEW.ARD_ADDRESS) OR (OLD.ARD_NRIC_NO!=NEW.ARD_NRIC_NO) OR
	(OLD.ARD_FIN_NO!=NEW.ARD_FIN_NO) OR (OLD.ARD_WORK_PERMIT_NO!=NEW.ARD_WORK_PERMIT_NO) OR
	(OLD.ARD_PASSPORT_NO!=NEW.ARD_PASSPORT_NO) OR (OLD.ARD_NATIONALITY!=NEW.ARD_NATIONALITY) OR
	(OLD.ARD_SEX!=NEW.ARD_SEX) OR (OLD.ARD_DOB!=NEW.ARD_DOB) OR
	(OLD.ARD_MARTIAL_STATUS!=NEW.ARD_MARTIAL_STATUS) OR (OLD.ARD_DESIGNATION!=NEW.ARD_DESIGNATION) OR
	(OLD.ARD_LENGTH_OF_SERVICE!=NEW.ARD_LENGTH_OF_SERVICE) OR (OLD.ARD_WORK_COMMENCEMENT!=NEW.ARD_WORK_COMMENCEMENT) OR
	(OLD.ARD_DESCRIPTION!=NEW.ARD_DESCRIPTION)) THEN
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_ID=', OLD.ARD_ID,','); 
	END IF;

	IF (OLD.ARD_DATE!= NEW.ARD_DATE) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_DATE=', OLD.ARD_DATE,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_DATE=', NEW.ARD_DATE,','); 
	END IF;

	IF (OLD.ARD_PLACE!= NEW.ARD_PLACE) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_PLACE=', OLD.ARD_PLACE,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_PLACE=', NEW.ARD_PLACE,','); 
	END IF;

	IF (OLD.ARD_TYPE_OF_INJURY!= NEW.ARD_TYPE_OF_INJURY) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_TYPE_OF_INJURY=', OLD.ARD_TYPE_OF_INJURY,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_TYPE_OF_INJURY=', NEW.ARD_TYPE_OF_INJURY,','); 
	END IF;

	IF (OLD.ARD_NATURE_OF_INJURY!= NEW.ARD_NATURE_OF_INJURY) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_NATURE_OF_INJURY=', OLD.ARD_NATURE_OF_INJURY,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_NATURE_OF_INJURY=', NEW.ARD_NATURE_OF_INJURY,','); 
	END IF;

	IF (OLD.ARD_TIME!= NEW.ARD_TIME) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_TIME=', OLD.ARD_TIME,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_TIME=', NEW.ARD_TIME,','); 
	END IF;

	IF (OLD.ARD_LOCATION!= NEW.ARD_LOCATION) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_LOCATION=', OLD.ARD_LOCATION,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_LOCATION=', NEW.ARD_LOCATION,','); 
	END IF;

	IF (OLD.ARD_INJURED_PART IS NULL AND NEW.ARD_INJURED_PART IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_INJURED_PART=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_INJURED_PART=',NEW.ARD_INJURED_PART,',');
	ELSEIF(OLD.ARD_INJURED_PART IS NOT NULL AND NEW.ARD_INJURED_PART IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_INJURED_PART=',OLD.ARD_INJURED_PART,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_INJURED_PART=','<NULL>,');
	ELSEIF (OLD.ARD_INJURED_PART!= NEW.ARD_INJURED_PART) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_INJURED_PART=', OLD.ARD_INJURED_PART,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_INJURED_PART=', NEW.ARD_INJURED_PART,','); 
	END IF;

	IF (OLD.ARD_MACHINERY_TYPE IS NULL AND NEW.ARD_MACHINERY_TYPE IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_MACHINERY_TYPE=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_MACHINERY_TYPE=',NEW.ARD_MACHINERY_TYPE,',');
	ELSEIF(OLD.ARD_MACHINERY_TYPE IS NOT NULL AND NEW.ARD_MACHINERY_TYPE IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_MACHINERY_TYPE=',OLD.ARD_MACHINERY_TYPE,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_MACHINERY_TYPE=','<NULL>,');
	ELSEIF (OLD.ARD_MACHINERY_TYPE!= NEW.ARD_MACHINERY_TYPE) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_MACHINERY_TYPE=', OLD.ARD_MACHINERY_TYPE,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_MACHINERY_TYPE=', NEW.ARD_MACHINERY_TYPE,','); 
	END IF;

	IF (OLD.ARD_LM_NO IS NULL AND NEW.ARD_LM_NO IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_LM_NO=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_LM_NO=',NEW.ARD_LM_NO,',');
	ELSEIF(OLD.ARD_LM_NO IS NOT NULL AND NEW.ARD_LM_NO IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_LM_NO=',OLD.ARD_LM_NO,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_LM_NO=','<NULL>,');
	ELSEIF (OLD.ARD_LM_NO!= NEW.ARD_LM_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_LM_NO=', OLD.ARD_LM_NO,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_LM_NO=', NEW.ARD_LM_NO,','); 
	END IF;

	IF (OLD.ARD_OPERATOR_NAME IS NULL AND NEW.ARD_OPERATOR_NAME IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_OPERATOR_NAME=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_OPERATOR_NAME=',NEW.ARD_OPERATOR_NAME,',');
	ELSEIF(OLD.ARD_OPERATOR_NAME IS NOT NULL AND NEW.ARD_OPERATOR_NAME IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'ARD_OPERATOR_NAME=',OLD.ARD_OPERATOR_NAME,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'ARD_OPERATOR_NAME=','<NULL>,');
	ELSEIF (OLD.ARD_OPERATOR_NAME!= NEW.ARD_OPERATOR_NAME) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_OPERATOR_NAME=', OLD.ARD_OPERATOR_NAME,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_OPERATOR_NAME=', NEW.ARD_OPERATOR_NAME,','); 
	END IF;

	IF (OLD.ARD_NAME!= NEW.ARD_NAME) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_NAME=', OLD.ARD_NAME,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_NAME=', NEW.ARD_NAME,','); 
	END IF;

	IF (OLD.ARD_AGE!= NEW.ARD_AGE) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_AGE=', OLD.ARD_AGE,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_AGE=', NEW.ARD_AGE,','); 
	END IF;

	IF (OLD.ARD_ADDRESS!= NEW.ARD_ADDRESS) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_ADDRESS=', OLD.ARD_ADDRESS,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_ADDRESS=', NEW.ARD_ADDRESS,','); 
	END IF;

	IF (OLD.ARD_NRIC_NO!= NEW.ARD_NRIC_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_NRIC_NO=', OLD.ARD_NRIC_NO,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_NRIC_NO=', NEW.ARD_NRIC_NO,','); 
	END IF;

	IF (OLD.ARD_FIN_NO!= NEW.ARD_FIN_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_FIN_NO=', OLD.ARD_FIN_NO,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_FIN_NO=', NEW.ARD_FIN_NO,','); 
	END IF;

	IF (OLD.ARD_WORK_PERMIT_NO!= NEW.ARD_WORK_PERMIT_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_WORK_PERMIT_NO=', OLD.ARD_WORK_PERMIT_NO,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_WORK_PERMIT_NO=', NEW.ARD_WORK_PERMIT_NO,','); 
	END IF;

	IF (OLD.ARD_PASSPORT_NO!= NEW.ARD_PASSPORT_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_PASSPORT_NO=', OLD.ARD_PASSPORT_NO,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_PASSPORT_NO=', NEW.ARD_PASSPORT_NO,','); 
	END IF;

	IF (OLD.ARD_NATIONALITY!= NEW.ARD_NATIONALITY) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_NATIONALITY=', OLD.ARD_NATIONALITY,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_NATIONALITY=', NEW.ARD_NATIONALITY,','); 
	END IF;

	IF (OLD.ARD_SEX!= NEW.ARD_SEX) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_SEX=', OLD.ARD_SEX,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_SEX=', NEW.ARD_SEX,','); 
	END IF;

	IF (OLD.ARD_DOB!= NEW.ARD_DOB) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_DOB=', OLD.ARD_DOB,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_DOB=', NEW.ARD_DOB,','); 
	END IF;

	IF (OLD.ARD_MARTIAL_STATUS!= NEW.ARD_MARTIAL_STATUS) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_MARTIAL_STATUS=', OLD.ARD_MARTIAL_STATUS,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_MARTIAL_STATUS=', NEW.ARD_MARTIAL_STATUS,','); 
	END IF;

	IF (OLD.ARD_DESIGNATION!= NEW.ARD_DESIGNATION) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_DESIGNATION=', OLD.ARD_DESIGNATION,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_DESIGNATION=', NEW.ARD_DESIGNATION,','); 
	END IF;

	IF (OLD.ARD_LENGTH_OF_SERVICE!= NEW.ARD_LENGTH_OF_SERVICE) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_LENGTH_OF_SERVICE=', OLD.ARD_LENGTH_OF_SERVICE,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_LENGTH_OF_SERVICE=', NEW.ARD_LENGTH_OF_SERVICE,','); 
	END IF;

	IF (OLD.ARD_WORK_COMMENCEMENT!= NEW.ARD_WORK_COMMENCEMENT) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_WORK_COMMENCEMENT=', OLD.ARD_WORK_COMMENCEMENT,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_WORK_COMMENCEMENT=', NEW.ARD_WORK_COMMENCEMENT,','); 
	END IF;

	IF (OLD.ARD_DESCRIPTION!= NEW.ARD_DESCRIPTION) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_DESCRIPTION=', OLD.ARD_DESCRIPTION,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'ARD_DESCRIPTION=', NEW.ARD_DESCRIPTION,','); 
	END IF;

	IF((OLD.ARD_DATE!=NEW.ARD_DATE) OR (OLD.ARD_PLACE!=NEW.ARD_PLACE) OR
	(OLD.ARD_TYPE_OF_INJURY!=NEW.ARD_TYPE_OF_INJURY) OR (OLD.ARD_NATURE_OF_INJURY!=NEW.ARD_NATURE_OF_INJURY) OR
	(OLD.ARD_TIME!=NEW.ARD_TIME) OR (OLD.ARD_LOCATION!=NEW.ARD_LOCATION) OR
	(OLD.ARD_INJURED_PART IS NULL AND NEW.ARD_INJURED_PART IS NOT NULL) OR
	(OLD.ARD_INJURED_PART IS NOT NULL AND NEW.ARD_INJURED_PART IS NULL) OR
	(OLD.ARD_INJURED_PART!=NEW.ARD_INJURED_PART) OR
	(OLD.ARD_MACHINERY_TYPE IS NULL AND NEW.ARD_MACHINERY_TYPE IS NOT NULL) OR
	(OLD.ARD_MACHINERY_TYPE IS NOT NULL AND NEW.ARD_MACHINERY_TYPE IS NULL) OR
	(OLD.ARD_MACHINERY_TYPE!=NEW.ARD_MACHINERY_TYPE) OR
	(OLD.ARD_LM_NO IS NULL AND NEW.ARD_LM_NO IS NOT NULL) OR
	(OLD.ARD_LM_NO IS NOT NULL AND NEW.ARD_LM_NO IS NULL) OR
	(OLD.ARD_LM_NO!=NEW.ARD_LM_NO) OR
	(OLD.ARD_OPERATOR_NAME IS NULL AND NEW.ARD_OPERATOR_NAME IS NOT NULL) OR
	(OLD.ARD_OPERATOR_NAME IS NOT NULL AND NEW.ARD_OPERATOR_NAME IS NULL) OR
	(OLD.ARD_OPERATOR_NAME!=NEW.ARD_OPERATOR_NAME) OR
	(OLD.ARD_NAME!=NEW.ARD_NAME) OR (OLD.ARD_AGE!=NEW.ARD_AGE) OR
	(OLD.ARD_ADDRESS!=NEW.ARD_ADDRESS) OR (OLD.ARD_NRIC_NO!=NEW.ARD_NRIC_NO) OR
	(OLD.ARD_FIN_NO!=NEW.ARD_FIN_NO) OR (OLD.ARD_WORK_PERMIT_NO!=NEW.ARD_WORK_PERMIT_NO) OR
	(OLD.ARD_PASSPORT_NO!=NEW.ARD_PASSPORT_NO) OR (OLD.ARD_NATIONALITY!=NEW.ARD_NATIONALITY) OR
	(OLD.ARD_SEX!=NEW.ARD_SEX) OR (OLD.ARD_DOB!=NEW.ARD_DOB) OR
	(OLD.ARD_MARTIAL_STATUS!=NEW.ARD_MARTIAL_STATUS) OR (OLD.ARD_DESIGNATION!=NEW.ARD_DESIGNATION) OR
	(OLD.ARD_LENGTH_OF_SERVICE!=NEW.ARD_LENGTH_OF_SERVICE) OR (OLD.ARD_WORK_COMMENCEMENT!=NEW.ARD_WORK_COMMENCEMENT) OR
	(OLD.ARD_DESCRIPTION!=NEW.ARD_DESCRIPTION)) THEN

		IF (OLD.ULD_ID!= NEW.ULD_ID) THEN  

			SET OLD_VALUE = CONCAT(OLD_VALUE,'ULD_ID=', OLD.ULD_ID,','); 
		END IF;

		IF (OLD.ARD_TIMESTAMP!= NEW.ARD_TIMESTAMP) THEN 
			SET OLD_VALUE = CONCAT(OLD_VALUE,'ARD_TIMESTAMP=', OLD.ARD_TIMESTAMP,','); 
		END IF;

	END IF;
	
	IF (OLD_VALUE!='' AND NEW_VALUE!='') THEN
		
		IF(OLD_VALUE!=NEW_VALUE)THEN
			
			SET OLD_VALUE = SUBSTRING(OLD_VALUE,1,CHAR_LENGTH(OLD_VALUE)-1);
			SET NEW_VALUE = SUBSTRING(NEW_VALUE,1,CHAR_LENGTH(NEW_VALUE)-1);
			INSERT INTO LMC_TICKLER_HISTORY(TP_ID,TTIP_ID,TH_OLD_VALUE,TH_NEW_VALUE,TH_USERSTAMP_ID)VALUES
			((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='UPDATION'),
			(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_ACCIDENT_REPORT_DETAILS'),OLD_VALUE,NEW_VALUE,
			(SELECT ULD_ID FROM LMC_ACCIDENT_REPORT_DETAILS WHERE ARD_ID=NEW.ARD_ID));

		END IF;
		
	END IF;

END;