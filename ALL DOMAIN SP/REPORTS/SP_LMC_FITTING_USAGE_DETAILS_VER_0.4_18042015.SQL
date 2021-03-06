-- VERSION:0.4 --DATE:18/04/2015 --DESC:ADDED ULD_ID IN LMC_FITTING_USAGE TABLE INSERT QUERY--DONE BY:RL
-- VERSION:0.3--DATE:07/04/2015 --DESC:CHANGED MANDATORY FIELD AS NON MANDATORY --DONE BY:DHIVYA
-- VERSION:0.2 --DATE:26/03/2015 --DESC:EMP_ID CHANGED AS ULD_ID IN TICKLER HISTORY,LMC_TEAM_REPORT_DETAILS --DONE BY:RL
-- VER0.1 DATE:05/03/2015 ISSUE:2 DESC:SP FOR INSERT,UPDATE & DELETE LMC_FITTING_USAGE_DETAILS done by:dhivya

DROP PROCEDURE IF EXISTS SP_LMC_FITTING_USAGE_DETAILS;
CREATE PROCEDURE SP_LMC_FITTING_USAGE_DETAILS(
IN SEARCH_OPTION INTEGER,
IN FUDID TEXT,
IN TRDID INTEGER,
IN ITEMS TEXT,
IN SIZE TEXT,
IN QUANTITY TEXT,
IN REMARK TEXT,
IN USERSTAMP VARCHAR(50),
OUT SUCCESS_MESSAGE TEXT)

BEGIN

	DECLARE FDITEMS VARCHAR(50);
	DECLARE FDSIZE INTEGER;
	DECLARE FDQUANTITY INTEGER;
	DECLARE FDREMARK TEXT;
	DECLARE FUID INTEGER;
	DECLARE T_FUD_ID TEXT;
	DECLARE TICK_T_FUDID TEXT;
	DECLARE LMC_FUDID INTEGER;
	DECLARE T_FUID INTEGER;
	DECLARE T_FUD_SIZE VARCHAR(15);
	DECLARE T_FUD_QUANTITY VARCHAR(15);
	DECLARE T_FUD_REMARK TEXT;
	DECLARE T_ULDID INTEGER;
	DECLARE T_TIMESTAMP TIMESTAMP;
	DECLARE OLDVALUE TEXT;

	SET @FD_ITEMS=ITEMS;
	SET @FD_SIZE=SIZE;
	SET @FD_QUANTITY=QUANTITY;
	SET @FD_REMARK=REMARK;
	SET @LMCFUDID=FUDID;

	SET SUCCESS_MESSAGE=0;

	IF SEARCH_OPTION=2 THEN

		SET T_FUD_ID=(SELECT REPLACE(FUDID,' ','0'));
		
		SET @SETLMC_FUID=(SELECT CONCAT('SELECT GROUP_CONCAT(FUD_ID) INTO @L_FUID FROM LMC_FITTING_USAGE_DETAILS WHERE TRD_ID=',TRDID,' AND FUD_ID NOT IN(',T_FUD_ID,')'));
		PREPARE SETLMC_FUID_STMT FROM @SETLMC_FUID;
		EXECUTE SETLMC_FUID_STMT;

		SET T_FUD_ID=@L_FUID;

		IF T_FUD_ID=' ' THEN
			SET T_FUD_ID=NULL;
		END IF;

		IF T_FUD_ID IS NOT NULL THEN
			SET @TICK_T_FUDID=T_FUD_ID;

			MAIN_LOOP : LOOP

				CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES(',',@TICK_T_FUDID,@VALUE,@REMAINING_STRING);
				SELECT @VALUE INTO LMC_FUDID;
				SELECT @REMAINING_STRING INTO @TICK_T_FUDID;

				SET T_FUID=(SELECT FU_ID FROM LMC_FITTING_USAGE_DETAILS WHERE FUD_ID=LMC_FUDID);
				
				IF T_FUID IS NULL  THEN
					SET T_FUID='<NULL>';
				END IF;

				SET T_FUD_SIZE=(SELECT FUD_SIZE FROM LMC_FITTING_USAGE_DETAILS WHERE FUD_ID=LMC_FUDID);

				IF T_FUD_SIZE IS NULL THEN
					SET T_FUD_SIZE='<NULL>';
				END IF;

				SET T_FUD_QUANTITY=(SELECT FUD_QUANTITY FROM LMC_FITTING_USAGE_DETAILS WHERE FUD_ID=LMC_FUDID);

				IF T_FUD_QUANTITY IS NULL THEN
					SET T_FUD_QUANTITY='<NULL>';
				END IF;

				SET T_FUD_REMARK=(SELECT FUD_REMARK FROM LMC_FITTING_USAGE_DETAILS WHERE FUD_ID=LMC_FUDID);

				IF T_FUD_REMARK IS NULL THEN
					SET T_FUD_REMARK='<NULL>';
				END IF;

				SET T_ULDID=(SELECT ULD_ID FROM LMC_FITTING_USAGE_DETAILS WHERE FUD_ID=LMC_FUDID);
				SET T_TIMESTAMP=(SELECT FUD_TIMESTAMP FROM LMC_FITTING_USAGE_DETAILS WHERE FUD_ID=LMC_FUDID);

				SET OLDVALUE=(SELECT CONCAT('FUD_ID=',LMC_FUDID,',TRD_ID=',TRDID,',FU_ID=',T_FUID,',FUD_SIZE=',T_FUD_SIZE,',FUD_QUANTITY=',T_FUD_QUANTITY,
				',FUD_REMARK=',T_FUD_REMARK,',ULD_ID=',T_ULDID,',MET_TIMESTAMP=',T_TIMESTAMP));
				
				INSERT INTO LMC_TICKLER_HISTORY(TP_ID,ULD_ID,TTIP_ID,TH_OLD_VALUE,TH_USERSTAMP_ID)VALUES
				((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='DELETION'),(SELECT ULD_ID FROM LMC_TEAM_REPORT_DETAILS WHERE TRD_ID=TRDID),
				(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_FITTING_USAGE_DETAILS'),OLDVALUE,
				(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
				
				DELETE FROM LMC_FITTING_USAGE_DETAILS WHERE  FUD_ID=LMC_FUDID;

				IF @TICK_T_FUDID IS NULL THEN
					LEAVE  MAIN_LOOP;
				END IF;

			END LOOP;

		END IF;

	END IF;

	MAIN_LOOP : LOOP
		
		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^',@FD_ITEMS,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO FDITEMS;
		SELECT @REMAINING_STRING INTO @FD_ITEMS;
		
		IF FDITEMS='' THEN
			SET FDITEMS=NULL;
		END IF;
		
		IF NOT EXISTS(SELECT FU_ID FROM LMC_FITTING_USAGE WHERE FU_ITEMS=FDITEMS)THEN
			INSERT INTO LMC_FITTING_USAGE(FU_ITEMS,ULD_ID)VALUES(FDITEMS,(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
			SET FUID=(SELECT FU_ID FROM LMC_FITTING_USAGE WHERE FU_ITEMS=FDITEMS);
		ELSE
			SET FUID=(SELECT FU_ID FROM LMC_FITTING_USAGE WHERE FU_ITEMS=FDITEMS);
		END IF;

		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^',@FD_SIZE,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO FDSIZE;
		SELECT @REMAINING_STRING INTO @FD_SIZE;
		
		IF FDSIZE='' THEN
			SET FDSIZE=NULL;
		END IF;

		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^', @FD_QUANTITY,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO FDQUANTITY;
		SELECT @REMAINING_STRING INTO @FD_QUANTITY;
		
		IF FDQUANTITY='' THEN
			SET FDQUANTITY=NULL;
		END IF;

		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^',@FD_REMARK,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO FDREMARK;
		SELECT @REMAINING_STRING INTO @FD_REMARK;
		
		IF FDREMARK='' THEN
			SET FDREMARK=NULL;
		END IF;
		
		IF SEARCH_OPTION=2 THEN
			CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES(',',@LMCFUDID,@VALUE,@REMAINING_STRING);
			SELECT @VALUE INTO LMC_FUDID;
			SELECT @REMAINING_STRING INTO @LMCFUDID;
		END IF;

		IF LMC_FUDID=' ' THEN
			SET LMC_FUDID=NULL;
		END IF; 

		IF SEARCH_OPTION=1 THEN

			IF FDITEMS IS NOT NULL  THEN

				IF NOT EXISTS(SELECT FUD_ID FROM LMC_FITTING_USAGE_DETAILS WHERE TRD_ID=TRDID AND FU_ID=FUID)THEN

					INSERT INTO LMC_FITTING_USAGE_DETAILS(TRD_ID,FU_ID,FUD_SIZE,FUD_QUANTITY,FUD_REMARK,ULD_ID)VALUES 
					(TRDID,(SELECT FU_ID FROM LMC_FITTING_USAGE WHERE FU_ITEMS=FDITEMS),FDSIZE,FDQUANTITY,FDREMARK,(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
				
				END IF;	
			
			END IF;
		
		END IF;

		IF SEARCH_OPTION=2 THEN

			IF LMC_FUDID IS NULL AND FDITEMS IS NOT NULL  THEN
			
				IF NOT EXISTS(SELECT FUD_ID FROM LMC_FITTING_USAGE_DETAILS WHERE TRD_ID=TRDID AND FU_ID=FUID)THEN

					INSERT INTO LMC_FITTING_USAGE_DETAILS(TRD_ID,FU_ID,FUD_SIZE,FUD_QUANTITY,FUD_REMARK,ULD_ID)VALUES 
					(TRDID,(SELECT FU_ID FROM LMC_FITTING_USAGE WHERE FU_ITEMS=FDITEMS),FDSIZE,FDQUANTITY,FDREMARK,(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
				
				END IF;	
		
			END IF;

			IF LMC_FUDID IS NOT NULL AND FDITEMS IS NOT NULL  THEN

				UPDATE LMC_FITTING_USAGE_DETAILS SET TRD_ID=TRDID,FU_ID=(SELECT FU_ID FROM LMC_FITTING_USAGE WHERE FU_ITEMS=FDITEMS),FUD_SIZE=FDSIZE,
				FUD_QUANTITY=FDQUANTITY,FUD_REMARK=FDREMARK,ULD_ID=(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP) WHERE FUD_ID=LMC_FUDID;
		
			END IF;	
	
		END IF;

		IF  @FD_ITEMS IS NULL THEN
			LEAVE  MAIN_LOOP;
		END IF;

	END LOOP;

	SET SUCCESS_MESSAGE=1;

END;