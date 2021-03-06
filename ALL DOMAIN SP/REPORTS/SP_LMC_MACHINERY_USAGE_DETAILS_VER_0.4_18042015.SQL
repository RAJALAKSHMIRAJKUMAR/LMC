-- VERSION:0.4 --DATE:18/04/2015 --DESC:ADDED ULD_ID IN LMC_MACHINERY_USAGE TABLE INSERT QUERY--DONE BY:RL
-- VERSION:0.3--DATE:07/04/2015 --DESC:CHANGED MANDATORY FIELD AS NON MANDATORY --DONE BY:DHIVYA
-- VERSION:0.2 --DATE:26/03/2015 --DESC:EMP_ID CHANGED AS ULD_ID IN TICKLER HISTORY,LMC_TEAM_REPORT_DETAILS --DONE BY:RL
-- VER0.1 DATE:05/03/2015 ISSUE:2 DESC:SP FOR INSERT,UPDATE & DELETE LMC_MACHINERY_USAGE_DETAILS done by:dhivya


DROP PROCEDURE IF EXISTS SP_LMC_MACHINERY_USAGE_DETAILS;
CREATE PROCEDURE SP_LMC_MACHINERY_USAGE_DETAILS(
IN SEARCH_OPTION INTEGER,
IN MACID TEXT,
IN TRDID INTEGER,
IN MACH_TYPE TEXT,
IN STARTTIME TEXT,
IN ENDTIME TEXT,
IN REMARK TEXT,
IN USERSTAMP VARCHAR(50),
OUT SUCCESS_MESSAGE TEXT)

BEGIN

	DECLARE MACHTYPE VARCHAR(30);
	DECLARE MACH_STARTTIME TIME;
	DECLARE MACH_ENDTIME TIME;
	DECLARE MACH_REMARK TEXT;
	DECLARE MCUID INTEGER;
	DECLARE T_MACID TEXT;
	DECLARE LMC_MACID INTEGER;
	DECLARE T_MCUID INTEGER;
	DECLARE T_STARTTIME TIME;
	DECLARE T_ENDTIME TIME;
	DECLARE T_REMARK TEXT;
	DECLARE T_ULDID INTEGER;
	DECLARE T_TIMESTAMP TIMESTAMP;
	DECLARE OLDVALUE TEXT;

	SET @TYPE=MACH_TYPE;
	SET @S_TIME=STARTTIME;
	SET @E_TIME=ENDTIME;
	SET @MACHREMARK=REMARK;
	SET @LMCMACID=MACID;

	SET SUCCESS_MESSAGE=0;

	IF SEARCH_OPTION=2 THEN

		SET T_MACID=(SELECT REPLACE(MACID,' ','0'));
		
		SET @SETLMC_MACID=(SELECT CONCAT('SELECT GROUP_CONCAT(MAC_ID) INTO @L_MAC_ID FROM LMC_MACHINERY_USAGE_DETAILS WHERE TRD_ID=',TRDID,' AND MAC_ID NOT IN(',T_MACID,')'));
		PREPARE SETLMC_MACID_STMT FROM @SETLMC_MACID;
		EXECUTE SETLMC_MACID_STMT;

		SET T_MACID=@L_MAC_ID;

		IF T_MACID=' ' THEN
			SET T_MACID=NULL;
		END IF;

		IF T_MACID IS NOT NULL THEN
			SET @TICK_MACID=T_MACID;

			MAIN_LOOP : LOOP

				CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES(',',@TICK_MACID,@VALUE,@REMAINING_STRING);
				SELECT @VALUE INTO LMC_MACID;
				SELECT @REMAINING_STRING INTO @TICK_MACID;

				SET T_MCUID=(SELECT MCU_ID FROM LMC_MACHINERY_USAGE_DETAILS WHERE MAC_ID=LMC_MACID);
				
				IF T_MCUID IS NULL  THEN
					SET T_MCUID='<NULL>';
				END IF;

				SET T_STARTTIME=(SELECT MAC_START_TIME FROM LMC_MACHINERY_USAGE_DETAILS WHERE MAC_ID=LMC_MACID);
				
				IF T_STARTTIME IS NULL  THEN
					SET T_STARTTIME='<NULL>';
				END IF;

				
				SET T_ENDTIME=(SELECT MAC_END_TIME FROM LMC_MACHINERY_USAGE_DETAILS WHERE MAC_ID=LMC_MACID);
				
				IF T_ENDTIME IS NULL THEN
					SET T_ENDTIME='<NULL>';
				END IF;

				SET T_REMARK=(SELECT MAC_REMARK FROM LMC_MACHINERY_USAGE_DETAILS WHERE MAC_ID=LMC_MACID);
				
				IF T_REMARK IS NULL THEN
					SET T_REMARK='<NULL>';
				END IF;
				
				SET T_ULDID=(SELECT ULD_ID FROM LMC_MACHINERY_USAGE_DETAILS WHERE MAC_ID=LMC_MACID);
				SET T_TIMESTAMP=(SELECT MAC_TIMESTAMP FROM LMC_MACHINERY_USAGE_DETAILS WHERE MAC_ID=LMC_MACID);

				SET OLDVALUE=(SELECT CONCAT('MAC_ID=',LMC_MACID,',TRD_ID=',TRDID,',MCU_ID=',T_MCUID,',MAC_START_TIME=',T_STARTTIME,',MAC_END_TIME=',T_ENDTIME
				,',MAC_REMARK=',T_REMARK,',ULD_ID=',T_ULDID,',MAC_TIMESTAMP=',T_TIMESTAMP));

				INSERT INTO LMC_TICKLER_HISTORY(TP_ID,ULD_ID,TTIP_ID,TH_OLD_VALUE,TH_USERSTAMP_ID)VALUES
				((SELECT TP_ID FROM LMC_TICKLER_PROFILE WHERE TP_TYPE='DELETION'),(SELECT ULD_ID FROM LMC_TEAM_REPORT_DETAILS WHERE TRD_ID=TRDID),
				(SELECT TTIP_ID FROM LMC_TICKLER_TABID_PROFILE WHERE TTIP_DATA='LMC_MACHINERY_USAGE_DETAILS'),OLDVALUE,
				(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
				DELETE FROM LMC_MACHINERY_USAGE_DETAILS WHERE  MAC_ID=LMC_MACID;

				IF @TICK_MACID IS NULL THEN
					LEAVE  MAIN_LOOP;
				END IF;

			END LOOP;

		END IF;

	END IF;

	MAIN_LOOP : LOOP
		
		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^',@TYPE,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO MACHTYPE;
		SELECT @REMAINING_STRING INTO @TYPE;
		
		IF NOT EXISTS(SELECT MCU_ID FROM LMC_MACHINERY_USAGE WHERE MCU_MACHINERY_TYPE=MACHTYPE)THEN
			INSERT INTO LMC_MACHINERY_USAGE(MCU_MACHINERY_TYPE,ULD_ID)VALUES(MACHTYPE,(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
			SET MCUID=(SELECT MCU_ID FROM LMC_MACHINERY_USAGE WHERE MCU_MACHINERY_TYPE=MACHTYPE);
		ELSE
			SET MCUID=(SELECT MCU_ID FROM LMC_MACHINERY_USAGE WHERE MCU_MACHINERY_TYPE=MACHTYPE);
		END IF;

		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^',@S_TIME,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO MACH_STARTTIME;
		SELECT @REMAINING_STRING INTO @S_TIME;

		IF MACH_STARTTIME=' ' THEN
			SET MACH_STARTTIME=NULL;
		END IF;

		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^', @E_TIME,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO MACH_ENDTIME;
		SELECT @REMAINING_STRING INTO @E_TIME;

		IF MACH_ENDTIME= ' ' THEN
			SET MACH_ENDTIME=NULL;
		END IF;

		CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES('^',@MACHREMARK,@VALUE,@REMAINING_STRING);
		SELECT @VALUE INTO MACH_REMARK;
		SELECT @REMAINING_STRING INTO @MACHREMARK;

		IF MACH_REMARK='' THEN
			SET MACH_REMARK=NULL;
		END IF;

		IF SEARCH_OPTION=2 THEN
			CALL SP_LMC_GET_SPECIAL_CHARACTER_SEPERATED_VALUES(',',@LMCMACID,@VALUE,@REMAINING_STRING);
			SELECT @VALUE INTO LMC_MACID;
			SELECT @REMAINING_STRING INTO @LMCMACID;
		END IF;

		IF LMC_MACID=' ' THEN
			SET LMC_MACID=NULL;
		END IF; 

		IF SEARCH_OPTION=1 THEN

			IF MACHTYPE IS NOT NULL THEN
			
				IF NOT EXISTS(SELECT MAC_ID FROM LMC_MACHINERY_USAGE_DETAILS WHERE TRD_ID=TRDID AND MCU_ID=MCUID)THEN
				
					INSERT INTO LMC_MACHINERY_USAGE_DETAILS(TRD_ID,MCU_ID,MAC_START_TIME,MAC_END_TIME,MAC_REMARK,ULD_ID)VALUES 
					(TRDID,MCUID,MACH_STARTTIME,MACH_ENDTIME,MACH_REMARK,(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
			
				END IF;
		
			END IF;
		END IF;

		IF SEARCH_OPTION=2 THEN
		
			IF LMC_MACID IS NULL AND MACHTYPE IS NOT NULL THEN
			
				IF NOT EXISTS(SELECT MAC_ID FROM LMC_MACHINERY_USAGE_DETAILS WHERE TRD_ID=TRDID AND MCU_ID=MCUID)THEN
				
					INSERT INTO LMC_MACHINERY_USAGE_DETAILS(TRD_ID,MCU_ID,MAC_START_TIME,MAC_END_TIME,MAC_REMARK,ULD_ID)VALUES 
					(TRDID,MCUID,MACH_STARTTIME,MACH_ENDTIME,MACH_REMARK,(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP));
			
				END IF;
		
			END IF;
		
			IF LMC_MACID IS NOT NULL AND MACHTYPE IS NOT NULL THEN
				
				UPDATE LMC_MACHINERY_USAGE_DETAILS SET TRD_ID=TRDID,MCU_ID=MCUID,MAC_START_TIME=MACH_STARTTIME,MAC_END_TIME=MACH_ENDTIME,MAC_REMARK=MACH_REMARK,ULD_ID=(SELECT ULD_ID FROM LMC_USER_LOGIN_DETAILS WHERE ULD_USERNAME=USERSTAMP)
				WHERE MAC_ID=LMC_MACID;
		
			END IF;
	
		END IF;
		
		IF  @TYPE IS NULL THEN
			LEAVE  MAIN_LOOP;
		END IF;

	END LOOP;

	SET SUCCESS_MESSAGE=1;

END;