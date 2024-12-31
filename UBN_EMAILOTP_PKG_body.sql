create or replace PACKAGE BODY UBN_EMAILOTP_PKG
IS


  FUNCTION saveemailotprequest(
      p_ACCOUNT_NUMBER IN VARCHAR2,
      p_AMOUNT         IN VARCHAR2,
       p_CUSTOMER_NUMBER      IN VARCHAR2,
      p_CHANNEL        IN VARCHAR2,
      p_REQUEST_OBJECT IN VARCHAR2 ,
      p_REQUEST_TYPE IN VARCHAR2)
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
     V_OTP_ID VARCHAR2(300);
    V_REFERENCE VARCHAR2(300);
  BEGIN
  
  select otp_channel_id into V_OTP_ID from CUSTOMER_DIASPORA_NEW where customer_number=LOWER(p_CUSTOMER_NUMBER) and account_number=p_ACCOUNT_NUMBER;
    
      V_RECORD_ID   := EMAILOTP.NEXTVAL;
      INSERT
      INTO NEWIBANK.EMAIL_OTP_REQUEST
        (
          ID,
          ACCOUNT_NUMBER,
          AMOUNT,
          CUSTOMER_NUMBER,
          CHANNEL,
          REQUEST_OBJECT,
          REQUEST_TYPE
        )
        VALUES
        (
          V_RECORD_ID,
          p_ACCOUNT_NUMBER,
          p_AMOUNT,
          p_CUSTOMER_NUMBER,
          p_CHANNEL,
          p_REQUEST_OBJECT,
          p_REQUEST_TYPE
        );
      COMMIT;
      
      
      NEWIBANK.UBN_RIBANK_UTIL_PKG.GENERATE_OTP_NEW(p_CUSTOMER_NUMBER,p_ACCOUNT_NUMBER,p_AMOUNT);
      RETURN V_RECORD_ID  || '--' || 'SUCCESSFULLY SAVED' || '--' || V_OTP_ID;
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (
          error_date,
          error_msg,
          error_point
        )
        VALUES
        (
          SYSDATE,
          V_RESPONSE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.saveemailotprequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (
          error_date,
          error_msg,
          error_point
        )
        VALUES
        (
          SYSDATE,
          V_RESPONSE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.saveemailotprequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
   END;
  END saveemailotprequest;
  
 
  FUNCTION validateemailotp
    (
      preference  IN VARCHAR2,
      pacctnumber IN VARCHAR2,
      potp        IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    v_count         INTEGER;
    v_count3        INTEGER;
    v_err_message   VARCHAR2 (3000);
    v_ref           VARCHAR2 (3000);
    v_message       VARCHAR2 (2);
    pcustomernumber VARCHAR2 (20);
    v_uid           VARCHAR2 (100) := NULL;
  BEGIN
    SELECT COUNT (*)
    INTO v_count
    FROM NEWIBANK.OTP_GENERATED_VALUES_NEW
    WHERE otpvalues  = potp
    AND customernumber = preference
    AND accountnumber=pacctnumber
    AND dateadded BETWEEN
      (SELECT SYSDATE - INTERVAL '8' MINUTE FROM DUAL
      )
    AND (SYSDATE);
    IF (v_count  = 0) THEN
      v_message := '03';
      RETURN v_message;
    ELSE
      IF (v_count  > 0) THEN
        v_message := '00';
        RETURN v_message;
      END IF;
    END IF;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_err_message := SQLERRM;
    INSERT
    INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
      (
        error_date,
        error_msg,
        error_point
      )
      VALUES
      (
        SYSDATE,
        DBMS_UTILITY.format_error_backtrace
        || v_err_message,
        'NEWIBANK.UBN_EMAILOTP_PKG.validateemailotp'
      );
    COMMIT;
    RETURN '07';
  END validateemailotp;
  FUNCTION update_email_otp_request
    (
      p_ID              IN VARCHAR2,
      p_RESPONSE_OBJECT IN VARCHAR2
    )
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE NEWIBANK.EMAIL_OTP_REQUEST
    SET
      RESPONSE_OBJECT = p_RESPONSE_OBJECT
    WHERE ID          = p_ID;
    COMMIT;
    RETURN '00' || '--' || 'Successful';
  EXCEPTION
  WHEN OTHERS THEN
    RETURN '99' || '--' || 'unsuccessful';
  END update_email_otp_request;
  
 
 
  FUNCTION update_emailotp_gen_values
    (
      p_ID              IN VARCHAR2,
      p_RESP_CODE            IN VARCHAR2
    )
    RETURN VARCHAR2
  AS
  
  V_STATUS VARCHAR2(10) := 'N';
  BEGIN
  
  IF(p_RESP_CODE = '00') THEN 
  V_STATUS := 'Y';
  END IF;
  
    UPDATE NEWIBANK.OTP_GENERATED_VALUES_NEW
    SET 
      STATUS= V_STATUS,
      COUNTER= COUNTER + 1
    WHERE ID          = p_ID;
    COMMIT;
    RETURN '00' || '--' || 'Successful';
  EXCEPTION
  WHEN OTHERS THEN
    RETURN '99' || '--' || 'unsuccessful';
  END update_emailotp_gen_values;
 
 
 PROCEDURE FETCH_RECORD(c_result         OUT SYS_REFCURSOR,
                                        P_RESP_CODE    OUT VARCHAR2,
                                        P_RESP_MESSAGE OUT VARCHAR2)
   AS
   
    
    V_ID integer;
  BEGIN
  
  SELECT COUNT(1)
      INTO V_ID
      FROM OTP_GENERATED_VALUES_NEW r
     WHERE r.STATUS = 'N'
     AND r.COUNTER < 3
       AND r.EMAILADDRESS IS NOT NULL
       AND r.ISEMAIL ='Y'
       AND r.DATEADDED >= (sysdate - (30 / 1440))
       AND ROWNUM = 1;
  IF (V_ID = 1) THEN
    OPEN c_result FOR
	SELECT r.ID,
               r.CUSTOMERNUMBER,
               r.ACCOUNTNUMBER,
               r.EMAILADDRESS,
               F_DECRYPT(r.OTPVALUES) AS OTPVALUES,
               r.TRANSACTIONAMOUNT,
               r.STATUS
          FROM OTP_GENERATED_VALUES_NEW r
         WHERE r.status = 'N'
          AND r.COUNTER < 3
          AND r.ISEMAIL ='Y'
           AND r.EMAILADDRESS IS NOT NULL
           AND r.DATEADDED >= (sysdate - (30 / 1440))
           AND ROWNUM < 1000;
	
   P_RESP_CODE    := '00';
      P_RESP_MESSAGE := 'SUCCESSFUL';
	ELSE 
   P_RESP_CODE    := '22';
      P_RESP_MESSAGE := 'NO PENDING RECORD';
 
	END IF;
   EXCEPTION
    WHEN OTHERS THEN
      P_RESP_CODE    := '99';
      P_RESP_MESSAGE := 'Error occured: ' ||
                        DBMS_UTILITY.format_error_backtrace;
      INSERT INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (error_date, error_msg, error_point)
      VALUES
        (SYSDATE,
          P_RESP_MESSAGE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.FETCH_RECORD');
      COMMIT;
  
  END FETCH_RECORD;
  
  FUNCTION F_DECRYPT (p_input VARCHAR2)
   RETURN VARCHAR2
AS
   v_decrypted_raw     RAW (2000);
   v_key               RAW (320);
   v_encryption_type   PLS_INTEGER := DBMS_CRYPTO.DES_CBC_PKCS5;
   v_iv                RAW (320);
BEGIN
   SELECT P_VALUE
     INTO v_key
     FROM EMAIL_OTP_PROC_PROPERTIES
    WHERE P_KEY_NAME = 'key';
   SELECT P_VALUE
     INTO v_iv
     FROM EMAIL_OTP_PROC_PROPERTIES
    WHERE P_KEY_NAME = 'iv';
   v_decrypted_raw :=
      DBMS_CRYPTO.DECRYPT (
         src   => UTL_ENCODE.base64_decode (UTL_RAW.CAST_TO_RAW (p_input)),
         typ   => v_encryption_type,
         key   => v_key,
         iv    => v_iv);
   RETURN UTL_I18N.RAW_TO_CHAR (v_decrypted_raw, 'AL32UTF8');
END;
  
 FUNCTION addOtpChannel(
  P_CUSTOMER_NUMBER IN VARCHAR2,
  P_ACCOUNT_NUMBER  IN VARCHAR2,
  P_OTP_CHANNEL_ID  IN VARCHAR2,
  P_CREATED_BY      IN VARCHAR2,
  P_INDEMNITY_FLAG  IN VARCHAR2
  )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
    V_REFERENCE VARCHAR2(300);
    V_EMAIL_ADDRESS VARCHAR2(200);
    V_PHONE_NUMBER VARCHAR2(100);
  BEGIN
    BEGIN
      SELECT CUSTOMER_NUMBER
      INTO V_REFERENCE
      FROM NEWIBANK.CUSTOMER_DIASPORA_NEW
      WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
    END;
    IF (V_REFERENCE IS NULL) THEN
      V_RECORD_ID   := CUSTOMERS_DIASPORA_ID_SEQ.NEXTVAL;
      IF (P_OTP_CHANNEL_ID = '1' OR P_OTP_CHANNEL_ID = 1) THEN
            BEGIN
                SELECT NVL(TELEPHONE, MOBILE_NUMBER)
                INTO V_PHONE_NUMBER
                FROM STTM_CUST_ACCOUNT A,
                STTM_CUST_PERSONAL B
                WHERE A.CUST_NO = B.CUSTOMER_NO
                AND CUST_AC_NO  = P_ACCOUNT_NUMBER;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                NULL;
            END;
            IF (V_PHONE_NUMBER IS NULL OR V_PHONE_NUMBER = '') THEN
                V_RESPONSE := '25'  || '--' || 'NO RECORD OF PHONE NUMBER, KINDLY UPDATE PHONE NUMBER';
            ELSE
              INSERT
              INTO NEWIBANK.CUSTOMER_DIASPORA_NEW
                (
                  ID,
                  CUSTOMER_NUMBER,
                  ACCOUNT_NUMBER,
                  OTP_CHANNEL_ID,
                  CREATED_BY,
                  EMAIL_ADDRESS,
                  PHONE_NUMBER,
                  INDEMNITY_FLAG
                )
                VALUES
                (
                  V_RECORD_ID,
                  LOWER(P_CUSTOMER_NUMBER),
                  P_ACCOUNT_NUMBER,
                  P_OTP_CHANNEL_ID,
                  P_CREATED_BY,
                  NULL,
                  V_PHONE_NUMBER,
                  P_INDEMNITY_FLAG
                );
                COMMIT;
                V_RESPONSE := '00'  || '--' || 'SUCCESSFULLY SAVED';
            END IF;
        ELSIF(P_OTP_CHANNEL_ID = '2' OR P_OTP_CHANNEL_ID = 2) THEN
            BEGIN
                SELECT NVL(E_MAIL, E_MAIL)
                INTO V_EMAIL_ADDRESS
                FROM STTM_CUST_ACCOUNT A,
                STTM_CUST_PERSONAL B
                WHERE A.CUST_NO = B.CUSTOMER_NO
                AND CUST_AC_NO  = P_ACCOUNT_NUMBER;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                NULL;
            END;
            IF (V_EMAIL_ADDRESS IS NULL OR V_EMAIL_ADDRESS = '') THEN
                V_RESPONSE := '25'  || '--' || 'NO RECORD OF EMAIL ADDRESS, KINDLY UPDATE EMAIL ADDRESS';
            ELSE
              INSERT
              INTO NEWIBANK.CUSTOMER_DIASPORA_NEW
                (
                  ID,
                  CUSTOMER_NUMBER,
                  ACCOUNT_NUMBER,
                  OTP_CHANNEL_ID,
                  CREATED_BY,
                  EMAIL_ADDRESS,
                  PHONE_NUMBER,
                  INDEMNITY_FLAG
                )
                VALUES
                (
                  V_RECORD_ID,
                  P_CUSTOMER_NUMBER,
                  P_ACCOUNT_NUMBER,
                  P_OTP_CHANNEL_ID,
                  P_CREATED_BY,
                  V_EMAIL_ADDRESS,
                  NULL,
                  P_INDEMNITY_FLAG
                );
                COMMIT;
            V_RESPONSE := '00'  || '--' || 'SUCCESSFULLY SAVED';
        END IF;
        ELSE
            NULL;
        END IF;
    ELSE
      V_RESPONSE := '22' || '--' || 'RECORD ALREADY EXIST';
    END IF;
    RETURN V_RESPONSE;
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (
          error_date,
          error_msg,
          error_point
        )
        VALUES
        (
          SYSDATE,
          V_RESPONSE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.addOtpChannel'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (
          error_date,
          error_msg,
          error_point
        )
        VALUES
        (
          SYSDATE,
          V_RESPONSE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.addOtpChannel'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END addOtpChannel;
  FUNCTION updateOtpChannel(
    P_ACCOUNT_NUMBER  IN VARCHAR2,
    P_ACTIVE_STATUS   IN VARCHAR2,
    P_OTP_CHANNEL_ID  IN VARCHAR2,
    P_UPDATED_BY      IN VARCHAR2
  )
    RETURN VARCHAR2
  IS
    V_ID                      VARCHAR(20);
    V_INITIAL_ACTIVE_STATUS   VARCHAR2(20);
    V_INITIAL_OTP_CHANNEL_ID  VARCHAR2(20);
    V_RESPONSE                VARCHAR2(300);
    V_RECORD_ID               VARCHAR2(200);
    V_CUSTOMER_NUMBER         VARCHAR2(200);
    V_EMAIL_ADDRESS           VARCHAR2(200);
    V_PHONE_NUMBER            VARCHAR2(20);
  BEGIN
    BEGIN
      SELECT ID, CUSTOMER_NUMBER, ACTIVE_STATUS, OTP_CHANNEL_ID
      INTO V_ID, V_CUSTOMER_NUMBER, V_INITIAL_ACTIVE_STATUS, V_INITIAL_OTP_CHANNEL_ID
      FROM NEWIBANK.CUSTOMER_DIASPORA_NEW
      WHERE ACCOUNT_NUMBER = P_ACCOUNT_NUMBER;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
        V_RESPONSE := '99' || '--' || 'Record not found';
        RETURN V_RESPONSE;
    END;
    BEGIN
        V_RECORD_ID := CUSTOMERS_DIASPORA_ID_SEQ.NEXTVAL;
        INSERT 
        INTO NEWIBANK.CUSTOMER_DIASPORA_NEW_AUDIT
            (
                ID,
                CUSTOMER_NUMBER,
                ACCOUNT_NUMBER,
                UPDATED_BY,
                INITIAL_ACTIVE_STATUS,
                NEW_ACTIVE_STATUS,
                INITIAL_OTP_CHANNEL_ID,
                NEW_OTP_CHANNEL_ID
            )
        VALUES
            (
                V_RECORD_ID,
                V_CUSTOMER_NUMBER,
                P_ACCOUNT_NUMBER,
                P_UPDATED_BY,
                V_INITIAL_ACTIVE_STATUS,
                P_ACTIVE_STATUS,
                V_INITIAL_OTP_CHANNEL_ID,
                P_OTP_CHANNEL_ID
            );
        COMMIT;
        EXCEPTION 
        WHEN OTHERS THEN
            V_RESPONSE := '99' || '--' || SQLERRM;
        RETURN V_RESPONSE;
    END;
      IF(P_OTP_CHANNEL_ID = '1' OR P_OTP_CHANNEL_ID = 1) THEN
        BEGIN
            SELECT NVL(TELEPHONE, MOBILE_NUMBER)
            INTO V_PHONE_NUMBER
            FROM STTM_CUST_ACCOUNT A,
            STTM_CUST_PERSONAL B
            WHERE A.CUST_NO = B.CUSTOMER_NO
            AND CUST_AC_NO  = P_ACCOUNT_NUMBER;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
        END;
        IF (V_PHONE_NUMBER IS NULL OR V_PHONE_NUMBER = '') THEN
            RETURN '25'  || '--' || 'NO RECORD OF PHONE NUMBER, KINDLY UPDATE PHONE NUMBER';
        ELSE
          BEGIN
          UPDATE NEWIBANK.CUSTOMER_DIASPORA_NEW
          SET 
            ACTIVE_STATUS = P_ACTIVE_STATUS,
            OTP_CHANNEL_ID = P_OTP_CHANNEL_ID,
            PHONE_NUMBER = V_PHONE_NUMBER,
            INDEMNITY_FLAG = 'N',
            EMAIL_ADDRESS = NULL
          WHERE ID = V_ID;
          COMMIT;
          RETURN '00' || '--' || 'Successful';
          EXCEPTION
          WHEN OTHERS THEN
            V_RESPONSE := '99' || '--' || SQLERRM;
            INSERT
            INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
              (
                error_date,
                error_msg,
                error_point
              )
              VALUES
              (
                SYSDATE,
                DBMS_UTILITY.format_error_backtrace
                || V_RESPONSE
                || P_ACCOUNT_NUMBER,
                'NEWIBANK.UBN_EMAILOTP_PKG.updateOtpChannel'
              );
            COMMIT;
            RETURN '07' || '--' || 'Error occurred';
            END;
        END IF;
      ELSIF(P_OTP_CHANNEL_ID = '2' OR P_OTP_CHANNEL_ID = 2) THEN
        BEGIN
            SELECT NVL(E_MAIL, E_MAIL)
            INTO V_EMAIL_ADDRESS
            FROM STTM_CUST_ACCOUNT A,
            STTM_CUST_PERSONAL B
            WHERE A.CUST_NO = B.CUSTOMER_NO
            AND CUST_AC_NO  = P_ACCOUNT_NUMBER;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            NULL;
        END;
        IF (V_EMAIL_ADDRESS IS NULL OR V_EMAIL_ADDRESS = '') THEN
            V_RESPONSE := '25'  || '--' || 'NO RECORD OF EMAIL ADDRESS, KINDLY UPDATE EMAIL ADDRESS';
        ELSE
          BEGIN
            UPDATE NEWIBANK.CUSTOMER_DIASPORA_NEW
              SET 
                ACTIVE_STATUS = P_ACTIVE_STATUS,
                OTP_CHANNEL_ID = P_OTP_CHANNEL_ID,
                EMAIL_ADDRESS = V_EMAIL_ADDRESS,
                INDEMNITY_FLAG = 'Y',
                PHONE_NUMBER = NULL
              WHERE ID = V_ID;
              COMMIT;
              RETURN '00' || '--' || 'Successful';
              EXCEPTION
              WHEN OTHERS THEN
                V_RESPONSE := '99' || '--' || SQLERRM;
                INSERT
                INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
                  (
                    error_date,
                    error_msg,
                    error_point
                  )
                  VALUES
                  (
                    SYSDATE,
                    DBMS_UTILITY.format_error_backtrace
                    || V_RESPONSE
                    || P_ACCOUNT_NUMBER,
                    'NEWIBANK.UBN_EMAILOTP_PKG.updateOtpChannel'
                  );
                COMMIT;
                RETURN '07' || '--' || 'Error occurred';
            END;
        END IF;
    END IF;
  END updateOtpChannel;




FUNCTION VALIDATE_OTP(PCUSTOMERNUMBER IN VARCHAR2,
                        PACCOUNTNUMBER  IN VARCHAR2,
                        POTP            IN VARCHAR2) RETURN VARCHAR2 IS
    V_COUNT       INTEGER;
    V_ERR_MESSAGE VARCHAR2(3000);
    V_UID         VARCHAR2(100) := NULL;
    V_OTP  VARCHAR2(100) := UBN_RIBANK_UTIL_PKG.F_ENCRYPT (POTP);
  BEGIN
    SELECT COUNT(*)
      INTO V_COUNT
      FROM OTP_GENERATED_VALUES_NEW
     WHERE CUSTOMERNUMBER = LOWER(PCUSTOMERNUMBER)
       AND OTPVALUES = V_OTP
       AND DATEADDED BETWEEN
           (SELECT SYSDATE - INTERVAL '8' MINUTE FROM DUAL) AND (SYSDATE);

    IF (V_COUNT = 0) THEN
      RETURN 'FALSE';
    END IF;

    RETURN 'SUCCESS';
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      V_ERR_MESSAGE := SQLERRM;

      INSERT INTO RIB_SR_ERROR_LOG
        (ERROR_DATE, ERROR_MSG, ERROR_POINT)
      VALUES
        (SYSDATE,
         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || V_ERR_MESSAGE,
         'NEWIBANK.ubn_ribank_util_pkg2.VALIDATE_TOKEN');

      COMMIT;
      RETURN 'FALSE';
  END;
  
FUNCTION VALIDATE_OTP_REQUEST(
      p_ACCOUNT_NUMBER IN VARCHAR2,
      p_AMOUNT         IN VARCHAR2,
      p_CUSTOMER_NUMBER      IN VARCHAR2,
      p_CHANNEL        IN VARCHAR2,
      p_REQUEST_OBJECT IN VARCHAR2 ,
      p_REQUEST_TYPE IN VARCHAR2)
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
    V_REFERENCE VARCHAR2(300);
  BEGIN
  
      V_RECORD_ID   := EMAILOTP.NEXTVAL;
      INSERT
      INTO NEWIBANK.EMAIL_OTP_REQUEST
        (
          ID,
          ACCOUNT_NUMBER,
          AMOUNT,
          CUSTOMER_NUMBER,
          CHANNEL,
          REQUEST_OBJECT,
          REQUEST_TYPE
        )
        VALUES
        (
          V_RECORD_ID,
          p_ACCOUNT_NUMBER,
          p_AMOUNT,
          p_CUSTOMER_NUMBER,
          p_CHANNEL,
          p_REQUEST_OBJECT,
          p_REQUEST_TYPE
        );
      COMMIT;
      
      RETURN V_RECORD_ID  || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (
          error_date,
          error_msg,
          error_point
        )
        VALUES
        (
          SYSDATE,
          V_RESPONSE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.VALIDATE_OTP_REQUEST'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.EMAIL_OTP_ERROR_LOG
        (
          error_date,
          error_msg,
          error_point
        )
        VALUES
        (
          SYSDATE,
          V_RESPONSE
          || DBMS_UTILITY.format_error_backtrace,
          'NEWIBANK.UBN_EMAILOTP_PKG.VALIDATE_OTP_REQUEST'
        );
      COMMIT;
      RETURN V_RESPONSE;
   END;
  END VALIDATE_OTP_REQUEST;  
  
  FUNCTION checkCustomerSubscription(
    P_CUSTOMER_NUMBER IN VARCHAR2
    )
    RETURN VARCHAR2
  AS
    V_CUSTOMER_DETAILS VARCHAR2(100);
    BEGIN
      SELECT 
        account_number
      INTO V_CUSTOMER_DETAILS
      FROM
        NEWIBANK.CUSTOMER_DIASPORA_NEW
      WHERE 
        CUSTOMER_NUMBER = LOWER(P_CUSTOMER_NUMBER);
        RETURN '00' || '--' || 'User is already subscribed to the otp channel';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN '99' || '--' || 'User has not subscribed to the otp channel';
  END checkCustomerSubscription;
  
END UBN_EMAILOTP_PKG;