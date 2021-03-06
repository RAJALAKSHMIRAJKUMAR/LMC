-- VERSION:0.1 --SDATE:18/04/2015 --DESC: LMC_MACHINERY_ITEM TABLE TICKLER TRIGGER --DONE BY:RL


DROP TRIGGER IF EXISTS TRG_LMC_MACHINERY_ITEM_UPDATE;
CREATE TRIGGER TRG_LMC_MACHINERY_ITEM_UPDATE
AFTER UPDATE ON LMC_MACHINERY_ITEM
FOR EACH ROW
BEGIN 

	DECLARE OLD_VALUE TEXT DEFAULT '';
	DECLARE NEW_VALUE TEXT DEFAULT '';

	IF (OLD.MI_ITEM!=NEW.MI_ITEM) THEN
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MI_ID=', OLD.MI_ID,','); 
	END IF;

	IF (OLD.MI_ITEM!= NEW.MI_ITEM) THEN 
		SET OLD_VALUE = CONCAT(OLD_VALUE,'MI_ITEM=', OLD.MI_ITEM,',');  
		SET NEW_VALUE = CONCAT(NEW_VALUE,'MI_ITEM=', NEW.MI_ITEM,','); 
	END IF;

	IF (OLD.MI_ITEM!=NEW.MI_ITEM) THEN	

		IF (OLD.ULD_ID!= NEW.ULD_ID) THEN  
			SET OLD_VALUE = CONCAT(OLD_VALUE,'ULD_ID=', OLD.ULD_ID,','); 
		END IF;

		IF (OLD.MI_TIMESTAMP!= NEW.MI_TIMESTAMP) THEN 
			SET OLD_VALUE = CONCAT(OLD_VALUE,'MI_TIMESTAMP=', OLD.MI_TIMESTAMP,','); 
		END IF;

	END IF;

	IF (OLD_VALUE!='' AND NEW_VALUE!='') THEN		
			
		IF(OLD_VALUE!=NEW_VALUE)THEN			
				
			SET OLD_VALUE = SUBSTRING(OLD_VALUE,1,CHAR_LENGTH(OLD_VALUE)-1);
			SET NEW_VALUE = SUBSTRING(NEW_VALUE,1,CHAR_LENGTH(NEW_VALUE)-1);			
				
			INSERT INTO LMC_TICKLER_HISTORY(TP_ID,TTIP_ID,TH_OLD_VALUE,TH_NEW_VALUE,TH_USERSTAMP_ID)VALUES
			((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='UPDATION'),
			(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_MACHINERY_ITEM'),OLD_VALUE,NEW_VALUE,
			(SELECT ULD_ID FROM LMC_MACHINERY_ITEM WHERE MI_ID=NEW.MI_ID));
			
		END IF;		
		
	END IF;
	
END;