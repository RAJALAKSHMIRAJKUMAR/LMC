-- VERSION:0.3 --DATE:07/04/2015 --DESC:CHANGED TRIGGER AS PER TABLE DESIGN --DONE BY:RL
-- VERSION:0.2 --DATE:26/03/2015 --DESC:EMP_ID CHANGED AS ULD_ID IN TICKLER HISTORY,LMC_TEAM_REPORT_DETAILS --DONE BY:RL
-- VER0.1 STARTDATE:29/01/2015 ENDDATE:29/01/2015 ISSUE:2 COMMENT NO:29 -- >desc:TRIGGER TO INSERT VALUES IN TICKLER HISTORY TABLE AFTER UPDATING IN LMC_MATERIAL_USAGE_DETAILS TABLE --DONE BY:DHIVYA


DROP TRIGGER IF EXISTS TRG_LMC_MATERIAL_USAGE_DETAILS_UPDATE;
CREATE TRIGGER TRG_LMC_MATERIAL_USAGE_DETAILS_UPDATE
AFTER UPDATE ON LMC_MATERIAL_USAGE_DETAILS
FOR EACH ROW

BEGIN 

	DECLARE OLD_VALUE TEXT DEFAULT '';
	DECLARE NEW_VALUE TEXT DEFAULT '';

	IF((OLD.MU_ID!= NEW.MU_ID) OR (OLD.TRD_ID!= NEW.TRD_ID) OR
 	(OLD.MUD_RECEIPT_NO IS NULL AND NEW.MUD_RECEIPT_NO IS NOT NULL) OR
 	(OLD.MUD_RECEIPT_NO IS NOT NULL AND NEW.MUD_RECEIPT_NO IS NULL) OR
 	(OLD.MUD_RECEIPT_NO!=NEW.MUD_RECEIPT_NO) OR
 	(OLD.MUD_QUANTITY IS NULL AND NEW.MUD_QUANTITY IS NOT NULL) OR
 	(OLD.MUD_QUANTITY IS NOT NULL AND NEW.MUD_QUANTITY IS NULL) OR
 	(OLD.MUD_QUANTITY!=NEW.MUD_QUANTITY))THEN
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MUD_ID=', OLD.MUD_ID,','); 
	END IF;
	
	IF (OLD.MU_ID!= NEW.MU_ID) THEN  
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MU_ID=', OLD.MU_ID,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'MU_ID=', NEW.MU_ID,','); 
	END IF;

	IF (OLD.TRD_ID!= NEW.TRD_ID) THEN  
		SET OLD_VALUE = CONCAT(OLD_VALUE,'TRD_ID=', OLD.TRD_ID,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'TRD_ID=', NEW.TRD_ID,','); 
	END IF;

	IF (OLD.MUD_RECEIPT_NO IS NULL AND NEW.MUD_RECEIPT_NO IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'MUD_RECEIPT_NO=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'MUD_RECEIPT_NO=',NEW.MUD_RECEIPT_NO,',');
	ELSEIF(OLD.MUD_RECEIPT_NO IS NOT NULL AND NEW.MUD_RECEIPT_NO IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'MUD_RECEIPT_NO=',OLD.MUD_RECEIPT_NO,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'MUD_RECEIPT_NO=','<NULL>,');
	ELSEIF (OLD.MUD_RECEIPT_NO!= NEW.MUD_RECEIPT_NO) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MUD_RECEIPT_NO=', OLD.MUD_RECEIPT_NO,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'MUD_RECEIPT_NO=', NEW.MUD_RECEIPT_NO,','); 
	END IF;

	IF (OLD.MUD_QUANTITY IS NULL AND NEW.MUD_QUANTITY IS NOT NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'MUD_QUANTITY=','<NULL>,');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'MUD_QUANTITY=',NEW.MUD_QUANTITY,',');
	ELSEIF(OLD.MUD_QUANTITY IS NOT NULL AND NEW.MUD_QUANTITY IS NULL) THEN
		SET OLD_VALUE=CONCAT(OLD_VALUE,'MUD_QUANTITY=',OLD.MUD_QUANTITY,',');
		SET NEW_VALUE=CONCAT(NEW_VALUE,'MUD_QUANTITY=','<NULL>,');
	ELSEIF (OLD.MUD_QUANTITY!= NEW.MUD_QUANTITY) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MUD_QUANTITY=', OLD.MUD_QUANTITY,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'MUD_QUANTITY=', NEW.MUD_QUANTITY,','); 
	END IF;
	
	IF((OLD.MU_ID!= NEW.MU_ID) OR (OLD.TRD_ID!= NEW.TRD_ID) OR
 	(OLD.MUD_RECEIPT_NO IS NULL AND NEW.MUD_RECEIPT_NO IS NOT NULL) OR
 	(OLD.MUD_RECEIPT_NO IS NOT NULL AND NEW.MUD_RECEIPT_NO IS NULL) OR
 	(OLD.MUD_RECEIPT_NO!=NEW.MUD_RECEIPT_NO) OR
 	(OLD.MUD_QUANTITY IS NULL AND NEW.MUD_QUANTITY IS NOT NULL) OR
 	(OLD.MUD_QUANTITY IS NOT NULL AND NEW.MUD_QUANTITY IS NULL) OR
 	(OLD.MUD_QUANTITY!=NEW.MUD_QUANTITY))THEN

		IF (OLD.ULD_ID!= NEW.ULD_ID) THEN  
			SET OLD_VALUE = CONCAT(OLD_VALUE,'ULD_ID=', OLD.ULD_ID,','); 
		END IF;

		IF (OLD.MUD_TIMESTAMP!= NEW.MUD_TIMESTAMP) THEN 
			SET OLD_VALUE = CONCAT(OLD_VALUE,'MUD_TIMESTAMP=', OLD.MUD_TIMESTAMP,','); 
		END IF;

	END IF;

	IF (OLD_VALUE!='' AND NEW_VALUE!='') THEN

		IF(OLD_VALUE!=NEW_VALUE)THEN

			SET OLD_VALUE = SUBSTRING(OLD_VALUE,1,CHAR_LENGTH(OLD_VALUE)-1);
			SET NEW_VALUE = SUBSTRING(NEW_VALUE,1,CHAR_LENGTH(NEW_VALUE)-1);			
			INSERT INTO LMC_TICKLER_HISTORY(TP_ID,ULD_ID,TTIP_ID,TH_OLD_VALUE,TH_NEW_VALUE,TH_USERSTAMP_ID)VALUES
			((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='UPDATION'),(SELECT ULD_ID FROM LMC_TEAM_REPORT_DETAILS WHERE TRD_ID=NEW.TRD_ID),
			(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_MATERIAL_USAGE_DETAILS'),OLD_VALUE,NEW_VALUE,
			(SELECT ULD_ID FROM LMC_MATERIAL_USAGE_DETAILS WHERE MUD_ID=NEW.MUD_ID));
		
		END IF;

	END IF;
	
END;