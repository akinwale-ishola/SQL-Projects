create or replace PACKAGE BODY DUBIA_VISA_PKG AS

  FUNCTION UPDATE_DUBIA_VISA_LOG(p_ID              IN VARCHAR2,
                                 p_RESPONSE_CODE   IN VARCHAR2,
                                 p_RESPONSE_MSG    IN VARCHAR2,
                                 P_RESPONSE_REF_ID IN VARCHAR2)
    RETURN VARCHAR2 AS
    V_STATUS VARCHAR2(1) := 'N';
  BEGIN
    if p_RESPONSE_CODE = '200' OR p_RESPONSE_CODE = '00' THEN
      V_STATUS := 'Y';
    END IF;
    UPDATE NEWIBANK.DUBAI_VISA_APPLICATION_REQUEST
       SET RESPONSE_CODE            = p_RESPONSE_CODE,
           RESPONSE_MSG             = p_RESPONSE_MSG,
           STATUS                   = V_STATUS,
           APPLICATION_REFERENCE_ID = P_RESPONSE_REF_ID,
           RESPONSE_DATE            = SYSDATE
     WHERE ID = p_ID;
  
    COMMIT;
    RETURN '00' || '--' || 'Successful';
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '99' || '--' || 'Successful';
  END UPDATE_DUBIA_VISA_LOG;

  FUNCTION UPDATE_DUBIA_VISA_REQUEST(p_ID                IN VARCHAR2,
                                     p_PAYMENT_REFERENCE IN VARCHAR2,
                                     p_CBA_RESP_CODE     IN VARCHAR2,
                                     p_CBA_RESP_MESSAGE  IN VARCHAR2)
    RETURN VARCHAR2 AS
  BEGIN
    UPDATE NEWIBANK.DUBAI_VISA_APPLICATION_REQUEST
       SET CBA_RESP_CODE     = p_CBA_RESP_CODE,
           CBA_RESP_MESSAGE  = p_CBA_RESP_MESSAGE,
           PAYMENT_REFERENCE = p_PAYMENT_REFERENCE
     WHERE ID = p_ID;
    COMMIT;
    RETURN '00' || '--' || 'Successful';
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '99' || '--' || 'Successful';
  END UPDATE_DUBIA_VISA_REQUEST;

  FUNCTION SAVE_DUBAI_VISA_APPL_REQUEST(
                                        
                                        P_APPLICATION_TYPE    IN VARCHAR2,
                                        P_TRANSACTION_AMOUNT  IN VARCHAR2,
                                        P_CURRENCY_TYPE       IN VARCHAR2,
                                        P_TRANSACTION_RECEIPT IN VARCHAR2,
                                        P_CHANNEL             IN VARCHAR2,
                                        P_IP_ADDR             IN VARCHAR2,
                                        P_APPLICANT_ID        IN VARCHAR2,
                                        P_DEBIT_ACCT_NUMBER   IN VARCHAR2,
                                        P_CREDIT_ACCT_NUMBER  IN VARCHAR2,
                                        P_PAYMENT_REFERENCE   IN VARCHAR2,
                                        P_USER_ID             IN VARCHAR2
                                        
                                        ) RETURN VARCHAR2 IS
    V_RESPONSE          VARCHAR2(300);
    V_RECORD_ID         VARCHAR2(300);
    V_PAYMENT_REFERENCE VARCHAR2(300);
  BEGIN
    BEGIN
      select payment_reference
        into V_PAYMENT_REFERENCE
        from NEWIBANK.DUBAI_VISA_APPLICATION_REQUEST
       where PAYMENT_REFERENCE = P_PAYMENT_REFERENCE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    END;
  
    if (V_PAYMENT_REFERENCE is null) then
      V_RECORD_ID := DUBIA_VISA.NEXTVAL;
      INSERT INTO NEWIBANK.DUBAI_VISA_APPLICATION_REQUEST
        (ID,
         APPLICATION_TYPE,
         TRANSACTION_AMOUNT,
         CURRENCY_TYPE,
         TRANSACTION_RECEIPT,
         CHANNEL,
         IP_ADDR,
         APPLICANT_ID,
         CREDIT_ACCT_NUMBER,
         DEBIT_ACCT_NUMBER,
         PAYMENT_REFERENCE,
         USER_ID)
      VALUES
        (V_RECORD_ID,
         
         P_APPLICATION_TYPE,
         P_TRANSACTION_AMOUNT,
         P_CURRENCY_TYPE,
         P_TRANSACTION_RECEIPT,
         P_CHANNEL,
         P_IP_ADDR,
         P_APPLICANT_ID,
         P_CREDIT_ACCT_NUMBER,
         P_DEBIT_ACCT_NUMBER,
         P_PAYMENT_REFERENCE,
         P_USER_ID);
    
      COMMIT;
    
      RETURN V_RECORD_ID || '--SUCCESSFULLY SAVED';
    else
    
      RETURN '22' || '--RECORD ALREADY EXIST';
    end if;
    RETURN V_RESPONSE;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      ROLLBACK;
      V_RESPONSE := '99' || '--ERROR OCCURRED';
      BEGIN
        INSERT INTO RIB_SR_ERROR_LOG
          (error_date, error_msg, error_point)
        VALUES
          (SYSDATE,
           V_RESPONSE || DBMS_UTILITY.format_error_backtrace,
           'NEWIBANK.DUBIA_VISA_PKG.SAVE_DUBAI_VISA_APPLICATION_REQUEST');
        COMMIT;
        RETURN V_RESPONSE;
      END;
    WHEN OTHERS THEN
      --ROLLBACK;
      V_RESPONSE := '22' || '--ERROR OCCURED';
      BEGIN
        INSERT INTO RIB_SR_ERROR_LOG
          (error_date, error_msg, error_point)
        VALUES
          (SYSDATE,
           V_RESPONSE || DBMS_UTILITY.format_error_backtrace,
           'NEWIBANK.DUBIA_VISA_PKG.SAVE_DUBAI_VISA_APPLICATION_REQUEST');
        COMMIT;
        RETURN V_RESPONSE;
      END;
  END SAVE_DUBAI_VISA_APPL_REQUEST;
  FUNCTION SAVE_DUBAI_VISA_APPL_DATA(P_DEPARTURE_DATE  IN VARCHAR2,
                                     P_EMAIL           IN VARCHAR2,
                                     P_FIRST_NAME      IN VARCHAR2,
                                     P_LAST_NAME       IN VARCHAR2,
                                     P_NATIONALITY     IN VARCHAR2,
                                     P_OCCUPATION      IN VARCHAR2,
                                     P_PASSPORT_NUMBER IN VARCHAR2,
                                     P_PASSPORT_PAGE   IN VARCHAR2,
                                     P_PASSPORT_PHOTO  IN VARCHAR2,
                                     P_PHONE           IN VARCHAR2,
                                     P_RETURNING_DATE  IN VARCHAR2,
                                     P_VISA_COUNTRY    IN VARCHAR2,
                                     P_VISA_TYPE       IN VARCHAR2,
                                     P_REQUEST_ID      IN VARCHAR2)
    RETURN VARCHAR2 IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  
  BEGIN
    V_RECORD_ID := DUBIA_VISA.NEXTVAL;
    INSERT INTO NEWIBANK.DUBAI_VISA_APPLICATION_DATA
      (ID,
       DEPARTURE_DATE,
       EMAIL,
       FIRST_NAME,
       LAST_NAME,
       NATIONALITY,
       OCCUPATION,
       PASSPORT_NUMBER,
       PASSPORT_PAGE,
       PASSPORT_PHOTO,
       PHONE,
       RETURNING_DATE,
       VISA_COUNTRY,
       VISA_TYPE,
       REQUEST_ID)
    VALUES
      (V_RECORD_ID,
       P_DEPARTURE_DATE,
       P_EMAIL,
       P_FIRST_NAME,
       P_LAST_NAME,
       P_NATIONALITY,
       P_OCCUPATION,
       P_PASSPORT_NUMBER,
       P_PASSPORT_PAGE,
       P_PASSPORT_PHOTO,
       P_PHONE,
       P_RETURNING_DATE,
       P_VISA_COUNTRY,
       P_VISA_TYPE,
       P_REQUEST_ID);
  
    COMMIT;
    V_RESPONSE := P_REQUEST_ID || '--SUCCESSFULLY SAVED';
    RETURN V_RESPONSE;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      ROLLBACK;
      V_RESPONSE := '99' || '--RECORD ALREADY EXIST';
      BEGIN
        INSERT INTO RIB_SR_ERROR_LOG
          (error_date, error_msg, error_point)
        VALUES
          (SYSDATE,
           V_RESPONSE || DBMS_UTILITY.format_error_backtrace,
           'NEWIBANK.DUBIA_VISA_PKG.SAVE_DUBAI_VISA_APPL_DATA');
        COMMIT;
        RETURN V_RESPONSE;
      END;
    WHEN OTHERS THEN
      --ROLLBACK;
      V_RESPONSE := '22' || '--ERROR OCCURED ' || SQLERRM;
      BEGIN
        INSERT INTO RIB_SR_ERROR_LOG
          (error_date, error_msg, error_point)
        VALUES
          (SYSDATE,
           V_RESPONSE || DBMS_UTILITY.format_error_backtrace,
           'NEWIBANK.DUBIA_VISA_PKG.SAVE_DUBAI_VISA_APPL_DATA');
        COMMIT;
        RETURN V_RESPONSE;
      END;
  END SAVE_DUBAI_VISA_APPL_DATA;

  PROCEDURE FETCH_PENDING_APPL_REQUESTS(P_DATA         OUT SYS_REFCURSOR,
                                        P_RESP_CODE    OUT VARCHAR2,
                                        P_RESP_MESSAGE OUT VARCHAR2) AS
  
    V_ID NUMBER;
  BEGIN
    SELECT COUNT(1)
      INTO V_ID
      FROM DUBAI_VISA_APPLICATION_REQUEST r
     WHERE r.STATUS = 'N'
       AND r.Payment_Reference IS NOT NULL
       AND r.cba_resp_code = '00'
       AND UPPER(r.Cba_Resp_Message) = UPPER('Transaction was Successful')
       AND r.CREATED_DATE >= (sysdate - (30 / 1440))
       AND ROWNUM = 1;
    IF (V_ID = 1) THEN
      OPEN P_DATA FOR
        SELECT r.ID,
               r.APPLICATION_TYPE,
               r.TRANSACTION_AMOUNT,
               r.CREDIT_ACCT_NUMBER,
               r.CURRENCY_TYPE,
               r.PAYMENT_REFERENCE,
               r.TRANSACTION_RECEIPT,
               'IBANK' AS CHANNEL
          FROM DUBAI_VISA_APPLICATION_REQUEST r
         WHERE r.status = 'N'
           AND r.payment_reference IS NOT NULL
           AND r.CREATED_DATE >= (sysdate - (30 / 1440))
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
      INSERT INTO RIB_SR_ERROR_LOG
        (error_date, error_msg, error_point)
      VALUES
        (SYSDATE,
         P_RESP_MESSAGE,
         'NEWIBANK.DUBIA_VISA_PKG.FETCH_PENDING_APPL_REQUESTS');
      COMMIT;
  END FETCH_PENDING_APPL_REQUESTS;

  FUNCTION GET_APPL_DATA_BYREQUESTID(P_REQUESTID IN VARCHAR2)
    RETURN SYS_REFCURSOR AS
    P_DATA SYS_REFCURSOR;
    P_ERR  VARCHAR2(600);
  BEGIN
    OPEN P_DATA FOR
      SELECT d.DEPARTURE_DATE,
             d.EMAIL,
             d.FIRST_NAME,
             d.LAST_NAME,
             d.NATIONALITY,
             d.OCCUPATION,
             d.PASSPORT_NUMBER,
             d.PASSPORT_NUMBER,
             d.PASSPORT_PAGE,
             d.PASSPORT_PHOTO,
             d.PHONE,
             d.RETURNING_DATE,
             d.VISA_COUNTRY,
             d.VISA_TYPE
        FROM DUBAI_VISA_APPLICATION_DATA d
       where d.REQUEST_ID = P_REQUESTID;
    return P_DATA;
  EXCEPTION
    WHEN OTHERS THEN
      P_ERR := 'Error occured: ' || SQLERRM;
      INSERT INTO RIB_SR_ERROR_LOG
        (error_date, error_msg, error_point)
      VALUES
        (SYSDATE,
         P_ERR,
         'NEWIBANK.DUBIA_VISA_PKG.FETCH_PENDING_APPL_REQUESTS');
      COMMIT;
  END;
  PROCEDURE LOG_REQUEST(P_REQUEST_OBJECT IN CLOB,
                        P_CHANNEL        IN VARCHAR2,
                        P_CODE           OUT VARCHAR2,
                        P_MSG            OUT VARCHAR2,
                        P_ID             OUT NUMBER) AS
    V_ID NUMBER := DUBAI_REQ_SEQ.NEXTVAL;
  BEGIN
    INSERT INTO DUBAI_VISA_REQUEST_LOGS
      (ID, REQUEST_OBJECT, CHANNEL)
    VALUES
      (V_ID, P_REQUEST_OBJECT, P_CHANNEL);
    COMMIT;
    P_ID   := V_ID;
    P_CODE := '00';
    P_MSG  := 'Successful';
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      P_ID   := NULL;
      P_CODE := '99';
      P_MSG  := SQLERRM;
      INSERT INTO RIB_SR_ERROR_LOG
        (error_date, error_msg, error_point)
      VALUES
        (SYSDATE, P_MSG, 'NEWIBANK.DUBIA_VISA_PKG.LOG_REQUEST');
      COMMIT;
  END LOG_REQUEST;

  PROCEDURE UPDATE_LOG(P_ID              IN VARCHAR2,
                       P_RESPONSE_OBJECT IN VARCHAR2,
                       P_CODE            OUT VARCHAR2,
                       P_MSG             OUT VARCHAR2) AS
  
  BEGIN
    UPDATE DUBAI_VISA_REQUEST_LOGS
       SET RESPONSE_OBJECT = P_RESPONSE_OBJECT,
           RESPONSE_DATE   = CURRENT_TIMESTAMP
     WHERE ID = P_ID;
    COMMIT;
    P_CODE := '00';
    P_MSG  := 'Successful';
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      P_CODE := '99';
      P_MSG  := SQLERRM;
      INSERT INTO RIB_SR_ERROR_LOG
        (error_date, error_msg, error_point)
      VALUES
        (SYSDATE, P_MSG, 'NEWIBANK.DUBIA_VISA_PKG.UPDATE_LOG');
      COMMIT;
  END UPDATE_LOG;
END DUBIA_VISA_PKG;
