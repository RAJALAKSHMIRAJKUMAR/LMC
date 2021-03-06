-- VERSION:0.1 --SDATE:13/03/2015 --EDATE:13/03/2015 --DESC: LMC_MEETING_TOPIC TABLE TICKLER TRIGGER --DONE BY:RL


DROP TRIGGER IF EXISTS TRG_LMC_MEETING_TOPIC_UPDATE;
CREATE TRIGGER TRG_LMC_MEETING_TOPIC_UPDATE
AFTER UPDATE ON LMC_MEETING_TOPIC
FOR EACH ROW

BEGIN 
	
	DECLARE OLD_VALUE TEXT DEFAULT '';
	DECLARE NEW_VALUE TEXT DEFAULT '';
	
	IF (OLD.MT_TOPIC!=NEW.MT_TOPIC)  THEN
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MT_ID=', OLD.MT_ID,','); 
	END IF;

	IF (OLD.MT_TOPIC!= NEW.MT_TOPIC) THEN  
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MT_TOPIC=', OLD.MT_TOPIC,','); 
		SET NEW_VALUE = CONCAT(NEW_VALUE,'MT_TOPIC=', NEW.MT_TOPIC,','); 
	END IF;
	
	IF (OLD.MT_TOPIC!=NEW.MT_TOPIC)  THEN

		IF (OLD.ULD_ID!= NEW.ULD_ID) THEN  
			SET OLD_VALUE = CONCAT(OLD_VALUE,'ULD_ID=', OLD.ULD_ID,','); 
		END IF;

		IF (OLD.MT_TIMESTAMP!= NEW.MT_TIMESTAMP) THEN 
			SET OLD_VALUE = CONCAT(OLD_VALUE,'MT_TIMESTAMP=', OLD.MT_TIMESTAMP,','); 
		END IF;

	END IF;

	IF (OLD_VALUE!='' AND NEW_VALUE!='') THEN

		IF(OLD_VALUE!=NEW_VALUE)THEN	

			SET OLD_VALUE = SUBSTRING(OLD_VALUE,1,CHAR_LENGTH(OLD_VALUE)-1);
			SET NEW_VALUE = SUBSTRING(NEW_VALUE,1,CHAR_LENGTH(NEW_VALUE)-1);

			INSERT INTO LMC_TICKLER_HISTORY(TP_ID,TTIP_ID,TH_OLD_VALUE,TH_NEW_VALUE,TH_USERSTAMP_ID)VALUES
			((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='UPDATION'),
			(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_MEETING_TOPIC'),OLD_VALUE,NEW_VALUE,
			NEW.ULD_ID);

		END IF;		

	END IF;
	
END;