-- VERSION:0.3 --DATE:07/04/2015 --DESC:CHANGED TRIGGER AS PER TABLE DESIGN --DONE BY:RL
-- VERSION:0.2 --DATE:26/03/2015 --DESC:EMP_ID CHANGED AS ULD_ID IN TICKLER HISTORY,LMC_TEAM_REPORT_DETAILS --DONE BY:RL

DROP TRIGGER IF EXISTS TRG_LMC_EQUIPMENT_USAGE_DETAILS;
CREATE TRIGGER TRG_LMC_EQUIPMENT_USAGE_DETAILS
AFTER UPDATE ON LMC_EQUIPMENT_USAGE_DETAILS
FOR EACH ROW

BEGIN 

	DECLARE OLD_VALUE TEXT DEFAULT '';
	DECLARE NEW_VALUE TEXT DEFAULT '';

	IF((OLD.TRD_ID!= NEW.TRD_ID) OR 
	(OLD.EUD_EQUIPMENT IS NULL AND NEW.EUD_EQUIPMENT IS NOT NULL) OR
	(OLD.EUD_EQUIPMENT IS NOT NULL AND NEW.EUD_EQUIPMENT IS NULL) OR
	(OLD.EUD_EQUIPMENT!=NEW.EUD_EQUIPMENT) OR
	(OLD.EUD_LORRY_NO IS NULL AND NEW.EUD_LORRY_NO IS NOT NULL) OR
	(OLD.EUD_LORRY_NO IS NOT NULL AND NEW.EUD_LORRY_NO IS NULL) OR
	(OLD.EUD_LORRY_NO!=NEW.EUD_LORRY_NO) OR
	(OLD.EUD_START_TIME IS NULL AND NEW.EUD_START_TIME IS NOT NULL) OR
	(OLD.EUD_START_TIME IS NOT NULL AND NEW.EUD_START_TIME IS NULL) OR
	(OLD.EUD_START_TIME!=NEW.EUD_START_TIME) OR
	(OLD.EUD_END_TIME IS NULL AND NEW.EUD_END_TIME IS NOT NULL) OR
	(OLD.EUD_END_TIME IS NOT NULL AND NEW.EUD_END_TIME IS NULL) OR
	(OLD.EUD_END_TIME!=NEW.EUD_END_TIME) OR
	(OLD.EUD_REMARK IS NULL AND NEW.EUD_REMARK IS NOT NULL) OR
	(OLD.EUD_REMARK IS NOT NULL AND NEW.EUD_REMARK IS NULL) OR
	(OLD.EUD_REMARK!=NEW.EUD_REMARK)) THEN
		SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_ID=', OLD.EUD_ID,','); 
	END IF;

	IF (OLD.TRD_ID!= NEW.TRD_ID) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'TRD_ID=', OLD.TRD_ID,','); 
	END IF;
	IF (OLD.TRD_ID!= NEW.TRD_ID) THEN   
		SET NEW_VALUE = CONCAT(NEW_VALUE,'TRD_ID=', NEW.TRD_ID,','); 
	END IF;

	IF (OLD.EUD_EQUIPMENT IS NULL AND NEW.EUD_EQUIPMENT IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_EQUIPMENT=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_EQUIPMENT=',NEW.EUD_EQUIPMENT,',');
	ELSEIF(OLD.EUD_EQUIPMENT IS NOT NULL AND NEW.EUD_EQUIPMENT IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_EQUIPMENT=',OLD.EUD_EQUIPMENT,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_EQUIPMENT=','<NULL>,');
	ELSEIF (OLD.EUD_EQUIPMENT!= NEW.EUD_EQUIPMENT) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_EQUIPMENT=', OLD.EUD_EQUIPMENT,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'EUD_EQUIPMENT=', NEW.EUD_EQUIPMENT,','); 
	END IF;

	IF (OLD.EUD_LORRY_NO IS NULL AND NEW.EUD_LORRY_NO IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_LORRY_NO=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_LORRY_NO=',NEW.EUD_LORRY_NO,',');
	ELSEIF(OLD.EUD_LORRY_NO IS NOT NULL AND NEW.EUD_LORRY_NO IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_LORRY_NO=',OLD.EUD_LORRY_NO,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_LORRY_NO=','<NULL>,');
	ELSEIF (OLD.EUD_LORRY_NO!= NEW.EUD_LORRY_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_LORRY_NO=', OLD.EUD_LORRY_NO,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'EUD_LORRY_NO=', NEW.EUD_LORRY_NO,','); 
	END IF;

	IF (OLD.EUD_START_TIME IS NULL AND NEW.EUD_START_TIME IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_START_TIME=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_START_TIME=',NEW.EUD_START_TIME,',');
	ELSEIF(OLD.EUD_START_TIME IS NOT NULL AND NEW.EUD_START_TIME IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_START_TIME=',OLD.EUD_START_TIME,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_START_TIME=','<NULL>,');
	ELSEIF (OLD.EUD_START_TIME!= NEW.EUD_START_TIME) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_START_TIME=', OLD.EUD_START_TIME,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'EUD_START_TIME=', NEW.EUD_START_TIME,','); 
	END IF;

	IF (OLD.EUD_END_TIME IS NULL AND NEW.EUD_END_TIME IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_END_TIME=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_END_TIME=',NEW.EUD_END_TIME,',');
	ELSEIF(OLD.EUD_END_TIME IS NOT NULL AND NEW.EUD_END_TIME IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_END_TIME=',OLD.EUD_END_TIME,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_END_TIME=','<NULL>,');
	ELSEIF (OLD.EUD_END_TIME!= NEW.EUD_END_TIME) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_END_TIME=', OLD.EUD_END_TIME,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'EUD_END_TIME=', NEW.EUD_END_TIME,','); 
	END IF;

	IF (OLD.EUD_REMARK IS NULL AND NEW.EUD_REMARK IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_REMARK=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_REMARK=',NEW.EUD_REMARK,',');
	ELSEIF(OLD.EUD_REMARK IS NOT NULL AND NEW.EUD_REMARK IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'EUD_REMARK=',OLD.EUD_REMARK,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'EUD_REMARK=','<NULL>,');
	ELSEIF (OLD.EUD_REMARK!= NEW.EUD_REMARK) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_REMARK=', OLD.EUD_REMARK,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'EUD_REMARK=', NEW.EUD_REMARK,','); 
	END IF;

	IF((OLD.TRD_ID!= NEW.TRD_ID) OR 
	(OLD.EUD_EQUIPMENT IS NULL AND NEW.EUD_EQUIPMENT IS NOT NULL) OR
	(OLD.EUD_EQUIPMENT IS NOT NULL AND NEW.EUD_EQUIPMENT IS NULL) OR
	(OLD.EUD_EQUIPMENT!=NEW.EUD_EQUIPMENT) OR
	(OLD.EUD_LORRY_NO IS NULL AND NEW.EUD_LORRY_NO IS NOT NULL) OR
	(OLD.EUD_LORRY_NO IS NOT NULL AND NEW.EUD_LORRY_NO IS NULL) OR
	(OLD.EUD_LORRY_NO!=NEW.EUD_LORRY_NO) OR
	(OLD.EUD_START_TIME IS NULL AND NEW.EUD_START_TIME IS NOT NULL) OR
	(OLD.EUD_START_TIME IS NOT NULL AND NEW.EUD_START_TIME IS NULL) OR
	(OLD.EUD_START_TIME!=NEW.EUD_START_TIME) OR
	(OLD.EUD_END_TIME IS NULL AND NEW.EUD_END_TIME IS NOT NULL) OR
	(OLD.EUD_END_TIME IS NOT NULL AND NEW.EUD_END_TIME IS NULL) OR
	(OLD.EUD_END_TIME!=NEW.EUD_END_TIME) OR
	(OLD.EUD_REMARK IS NULL AND NEW.EUD_REMARK IS NOT NULL) OR
	(OLD.EUD_REMARK IS NOT NULL AND NEW.EUD_REMARK IS NULL) OR
	(OLD.EUD_REMARK!=NEW.EUD_REMARK)) THEN

		IF (OLD.ULD_ID!= NEW.ULD_ID) THEN  
			SET OLD_VALUE = CONCAT(OLD_VALUE,'ULD_ID=', OLD.ULD_ID,','); 
		END IF;

		IF (OLD.EUD_TIMESTAMP!= NEW.EUD_TIMESTAMP) THEN 
			SET OLD_VALUE = CONCAT(OLD_VALUE,'EUD_TIMESTAMP=', OLD.EUD_TIMESTAMP,','); 
		END IF;

	END IF;
	
	IF (OLD_VALUE!='' AND NEW_VALUE!='') THEN
		
		IF(OLD_VALUE!=NEW_VALUE)THEN
			
			SET OLD_VALUE = SUBSTRING(OLD_VALUE,1,CHAR_LENGTH(OLD_VALUE)-1);
			SET NEW_VALUE = SUBSTRING(NEW_VALUE,1,CHAR_LENGTH(NEW_VALUE)-1);
			INSERT INTO LMC_TICKLER_HISTORY(TP_ID,ULD_ID,TTIP_ID,TH_OLD_VALUE,TH_NEW_VALUE,TH_USERSTAMP_ID)VALUES
			((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='UPDATION'),(SELECT ULD_ID FROM LMC_TEAM_REPORT_DETAILS WHERE TRD_ID=NEW.TRD_ID),
			(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_EQUIPMENT_USAGE_DETAILS'),OLD_VALUE,NEW_VALUE,
			(SELECT ULD_ID FROM LMC_EQUIPMENT_USAGE_DETAILS WHERE EUD_ID=NEW.EUD_ID));
		
		END IF;
		
	END IF;

END;