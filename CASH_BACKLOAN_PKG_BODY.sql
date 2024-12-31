create or replace PACKAGE body CASH_BACKLOAN_PKG
IS
  FUNCTION saveLoanRequest(
      P_APPLICATION_NUMBER    IN VARCHAR2,
      P_PRODUCT_CODE          IN VARCHAR2,
      P_TENOR                 IN VARCHAR2,
      P_AMOUNT                IN VARCHAR2,
      P_ACCOUNT_NUMBER        IN VARCHAR2,
      P_HANDLING_CHARGE       IN VARCHAR2,
      P_INSURANCE_FEE         IN VARCHAR2,
      P_INSURANCE_RENEWAL_FEE IN VARCHAR2,
      P_INTEREST_RATE         IN VARCHAR2,
      P_CHANNEL               IN VARCHAR2,
      P_REQUEST_OBJECT        IN VARCHAR2 )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    V_RECORD_ID := CASH_BACKLOAN.NEXTVAL;
    INSERT
    INTO NEWIBANK.CASH_LOAN_DISBURSEMENT_REQUEST
      (
        ID,
        APPLICATION_NUMBER,
        PRODUCT_CODE,
        TENOR,
        AMOUNT,
        ACCOUNT_NUMBER,
        HANDLING_CHARGE,
        INSURANCE_FEE,
        INSURANCE_RENEWAL_FEE,
        INTEREST_RATE,
        CHANNEL,
        REQUEST_OBJECT
      )
      VALUES
      (
        V_RECORD_ID,
        P_APPLICATION_NUMBER,
        P_PRODUCT_CODE,
        P_TENOR,
        P_AMOUNT,
        P_ACCOUNT_NUMBER,
        P_HANDLING_CHARGE,
        P_INSURANCE_FEE,
        P_INSURANCE_RENEWAL_FEE,
        P_INTEREST_RATE,
        P_CHANNEL,
        P_REQUEST_OBJECT
      );
    COMMIT;
    RETURN V_RECORD_ID || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.saveLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.saveLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END saveLoanRequest;
  FUNCTION updateLoanRequest
    (
      P_ID              IN VARCHAR2,
      P_RESPONSE_OBJECT IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    UPDATE NEWIBANK.CASH_LOAN_DISBURSEMENT_REQUEST
    SET RESPONSE_OBJECT=P_RESPONSE_OBJECT
    WHERE ID           =P_ID;
    COMMIT;
    RETURN '00' || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END updateLoanRequest;
  FUNCTION creditBureauCheckRequest
    (
      P_USERID           IN VARCHAR2,
      P_BUREAUIDS        IN VARCHAR2,
      P_BVN              IN VARCHAR2,
      P_IPADDRESS        IN VARCHAR2,
      P_DEBITACCOUNTNO   IN VARCHAR2,
      P_PAYMENTREFERENCE IN VARCHAR2,
      P_REQUEST_OBJECT   IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    V_RECORD_ID := CASHBACK_CREDITBUREAU_SEQ.NEXTVAL;
    INSERT
    INTO NEWIBANK.CASHBACK_CREDITBUREAU
      (
        ID,
        USERID,
        BUREAUIDS,
        BVN,
        IPADDRESS,
        DEBITACCOUNTNO,
        PAYMENTREFERENCE,
        REQUEST_OBJECT
      )
      VALUES
      (
        V_RECORD_ID,
        P_USERID,
        P_BUREAUIDS,
        P_BVN,
        P_IPADDRESS,
        P_DEBITACCOUNTNO,
        P_PAYMENTREFERENCE,
        P_REQUEST_OBJECT
      );
    COMMIT;
    RETURN V_RECORD_ID || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.creditBureauCheckRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.creditBureauCheckRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END creditBureauCheckRequest;
  FUNCTION updateCreditBureauCheckRequest
    (
      P_ID              IN VARCHAR2,
      P_RESPONSE_OBJECT IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    UPDATE NEWIBANK.CASHBACK_CREDITBUREAU
    SET RESPONSE_OBJECT=P_RESPONSE_OBJECT
    WHERE ID           =P_ID;
    COMMIT;
    RETURN '00' || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCreditBureauCheckRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END updateCreditBureauCheckRequest;
  FUNCTION getTenors
    RETURN SYS_REFCURSOR
  IS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM NEWIBANK.CASH_BACKLOAN_TENOR WHERE del_flg = 'N';
    RETURN c_result;
  END getTenors;
  FUNCTION getRepaymentTypes
    RETURN SYS_REFCURSOR
  IS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM NEWIBANK.CASH_BACKLOAN_REPAYMENT_TYPES WHERE del_flg = 'N';
    RETURN c_result;
  END getRepaymentTypes;
  FUNCTION saveCashLoanRequest
    (
      P_USERID         IN VARCHAR2,
      P_IPADDRESS      IN VARCHAR2,
      P_ACCOUNT_NUMBER IN VARCHAR2,
      P_AMOUNT         IN VARCHAR2,
      P_TENOR          IN VARCHAR2,
      P_RATE           IN VARCHAR2,
      P_CHANNEL        IN VARCHAR2,
       
       P_PRIMARY_ACCOUNT IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    V_RECORD_ID := CASH_BACKLOAN.NEXTVAL;
    INSERT
    INTO NEWIBANK.CASHBACK_LOAN_REQUEST
      (
        ID,
        USERID,
        IPADDRESS,
        ACCOUNT_NUMBER,
        AMOUNT,
        TENOR,
        RATE,
        CHANNEL,
        PRIMARY_ACCOUNT
      )
      VALUES
      (
        V_RECORD_ID,
        P_USERID,
        P_IPADDRESS,
        P_ACCOUNT_NUMBER,
        P_AMOUNT,
        P_TENOR,
        P_RATE,
        P_CHANNEL,
         P_PRIMARY_ACCOUNT 
      );
    COMMIT;
    RETURN V_RECORD_ID || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.saveCashLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.saveCashLoanRequest'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END saveCashLoanRequest;
  FUNCTION updateCtBurueaRespCRSERVICES
    (
      P_ID                          IN VARCHAR2,
      P_PAYMENT_REF_CRSERVICES      IN VARCHAR2,
      P_GOOD_CT_STATUS_CRSERVICES   IN VARCHAR2,
      P_DATE_GOOD_CRT_ST_CRSERVICES IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    UPDATE NEWIBANK.CASHBACK_LOAN_REQUEST
    SET PAYMENT_REF_CRSERVICES     =P_PAYMENT_REF_CRSERVICES,
      GOOD_CREDIT_STATUS_CRSERVICES=P_GOOD_CT_STATUS_CRSERVICES,
      DATE_GOOD_CRT_ST_CRSERVICES  =P_DATE_GOOD_CRT_ST_CRSERVICES
    WHERE ID                       =P_ID;
    COMMIT;
    RETURN '00' || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCtBurueaRespCRSERVICES'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCtBurueaRespCRSERVICES'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END updateCtBurueaRespCRSERVICES;
  FUNCTION updateCrmsNumber
    (
      P_ID                    IN VARCHAR2,
      P_CRMS_NUMBER           IN VARCHAR2,
      P_CRMS_RESPONSE_CODE    IN VARCHAR2,
      P_CRMS_RESPONSE_MESSAGE IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE VARCHAR2(300);
  BEGIN
    UPDATE NEWIBANK.CASHBACK_LOAN_REQUEST
    SET CRMS_NUMBER        =P_CRMS_NUMBER ,
      CRMS_RESPONSE_CODE   =P_CRMS_RESPONSE_CODE ,
      CRMS_RESPONSE_MESSAGE=P_CRMS_RESPONSE_MESSAGE
    WHERE ID               =P_ID;
    COMMIT;
    RETURN '00' || '--' || 'SUCCESSFULLY UPDATED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCrmsNumber'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCrmsNumber'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END updateCrmsNumber;
  FUNCTION updateLoanAccountNumber
    (
      P_ID                    IN VARCHAR2,
      P_LOAN_ACCOUNT_NUMBER   IN VARCHAR2,
      P_LOAN_RESPONSE_CODE    IN VARCHAR2,
      P_LOAN_RESPONSE_MESSAGE IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE VARCHAR2(300);
  BEGIN
    UPDATE NEWIBANK.CASHBACK_LOAN_REQUEST
    SET LOAN_ACCOUNT_NUMBER=P_LOAN_ACCOUNT_NUMBER,
      LOAN_RESPONSE_CODE   =P_LOAN_RESPONSE_CODE ,
      LOAN_RESPONSE_MESSAGE=P_LOAN_RESPONSE_MESSAGE
    WHERE ID               =P_ID;
    COMMIT;
    RETURN '00' || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateLoanAccountNumber'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateLoanAccountNumber'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END updateLoanAccountNumber;
  FUNCTION updateCtBurueaRespXDS
    (
      P_ID                       IN VARCHAR2,
      P_PAYMENT_REF_XDS          IN VARCHAR2,
      P_GOOD_CREDIT_STATUS_XDS   IN VARCHAR2,
      P_DATE_GOOD_CRT_STATUS_XDS IN VARCHAR2
    )
    RETURN VARCHAR2
  IS
    V_RESPONSE  VARCHAR2(300);
    V_RECORD_ID VARCHAR2(300);
  BEGIN
    UPDATE NEWIBANK.CASHBACK_LOAN_REQUEST
    SET PAYMENT_REF_XDS       =P_PAYMENT_REF_XDS,
      GOOD_CREDIT_STATUS_XDS  =P_GOOD_CREDIT_STATUS_XDS,
      DATE_GOOD_CRT_STATUS_XDS=P_DATE_GOOD_CRT_STATUS_XDS
    WHERE ID                  =P_ID;
    COMMIT;
    RETURN '00' || '--' || 'SUCCESSFULLY SAVED';
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
    V_RESPONSE := '99' || '--' || 'ERROR OCCURRED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCtBurueaRespXDS'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  WHEN OTHERS THEN
    --ROLLBACK;
    V_RESPONSE := '22' || '--' || 'ERROR OCCURED';
    BEGIN
      INSERT
      INTO NEWIBANK.CASH_BACKLOAN_ERROR_LOG
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
          'NEWIBANK.CASH_BACKLOAN_PKG.updateCtBurueaRespXDS'
        );
      COMMIT;
      RETURN V_RESPONSE;
    END;
  END updateCtBurueaRespXDS;
  PROCEDURE getCustomerBVN
    (
      paccountNumber IN VARCHAR2,
      pBVNNumber OUT VARCHAR2
    )
  IS
  BEGIN
    SELECT FIELD_VAL_1
    INTO pBVNNumber
    FROM Fcubslive.cstm_function_userdef_fields
    WHERE FUNCTION_ID = 'STDCIF'
    AND FIELD_VAL_1  != ' '
    AND REC_KEY       =
      (SELECT CUST_NO
        || '~'
      FROM STTM_CUST_ACCOUNT
      WHERE CUST_AC_NO = paccountNumber
      )
      --  SELECT FIELD_VAL_1
      --    INTO pBVNNumber
      --  FROM Fcubslive.cstm_function_userdef_fields a
      --   WHERE FUNCTION_ID = 'STDCIF'
      --    AND REC_KEY = pCustomerID || '~'
      ;
  EXCEPTION
  WHEN no_data_found THEN
    pBVNNumber := 'N/A';
  END getCustomerBVN;
  PROCEDURE getPrimaryAccount(
      pTspAccount IN VARCHAR2,
      pPrimartAccount OUT VARCHAR2)
  IS
  BEGIN
    SELECT DISTINCT dr_account
    INTO pPrimartAccount
    FROM fcubslive.sitb_contract_master
    WHERE cr_account =pTspAccount;
  EXCEPTION
  WHEN no_data_found THEN
    pPrimartAccount := 'N/A';
  END getPrimaryAccount;
  FUNCTION GETTSPACCOUNTLIST(
      I_CUSTOMERNUMBER IN VARCHAR2,
      I_ACCOUNTNUMBER  IN VARCHAR2 )
    RETURN SYS_REFCURSOR
  IS
    O_REFCURSOR SYS_REFCURSOR;
  BEGIN
    OPEN O_REFCURSOR FOR
    SELECT DISTINCT CUSTOMEREMAIL,
      MOBILENUMBER,
      FIRSTNAME,
      LASTNAME,
      CUSTOMERNUMBER USERNAME,
      D.CR_ACCOUNT accountnumber,
      ACCOUNTSTATUS,
      A.TRANSFERLIMIT TRANSFERLIMIT,
      ACCOUNTCURRENCY,
      ACCOUNTNAME,
      ACCRIGHT,
      CHEQUE_BOOK_FACILITY
    FROM newibank.CUSTOMERS C,
      newibank.CUSTOMER_ACCOUNTS A,
      STTM_CUST_ACCOUNT B,
      fcubslive.sitb_contract_master D
    WHERE C.customernumber = I_CUSTOMERNUMBER
    AND D.DR_ACCOUNT       = A.ACCOUNTNUMBER
    AND D.CR_ACCOUNT      IN
      ( SELECT DISTINCT cr_account
      FROM fcubslive.sitb_contract_master E
      WHERE dr_account =I_ACCOUNTNUMBER
      )
    AND A.UIDS          = C.UIDS
    AND A.ACCOUNTNUMBER = B.CUST_AC_NO
    AND A.ACCOUNTSTATUS = 'Authorised'
    AND B.AUTH_STAT     = 'A'
    AND B.RECORD_STAT   = 'O'
    AND C.USERSTATUS    = 'Authorised'
      --AND NOT EXISTS (
      --           SELECT 1
      --    FROM fcubslive.catm_amount_blocks d
      --    WHERE a.accountnumber = d.account
      --     AND d.record_stat = 'O'
      --  AND d.remarks = 'TSPCASHBACKEDLOAN'
      --   AND TRUNC(SYSDATE) BETWEEN d.effective_date AND d.expiry_date
      --   )
      --AND NOT EXISTS ( SELECT 1
      --        FROM cltb_account_apps_master e
      --       WHERE customer_id IN (
      --          SELECT DISTINCT cust_no
      --             FROM sttm_cust_account f
      --     WHERE cust_ac_no IN (I_ACCOUNTNUMBER))
      -- )
      ;
    RETURN O_REFCURSOR;
  END GETTSPACCOUNTLIST;
  PROCEDURE getEmailAddress(
      pCustomerNumber IN VARCHAR2,
      pEmailAddress OUT VARCHAR2)
  IS
  BEGIN
    SELECT E_MAIL
    INTO pEmailAddress
    FROM sttm_cust_personal
    WHERE CUSTOMER_NO IN
      (SELECT cust_no
      FROM fcubslive.sttm_cust_account
      WHERE cust_ac_no IN
        (SELECT accountnumber
        FROM
          (SELECT ACCOUNTNUMBER
          FROM newibank.customer_accounts
          WHERE uids IN
            (SELECT uids
            FROM newibank.customers
            WHERE LOWER(CUSTOMERNUMBER) = LOWER(pCustomerNumber)
            )
          AND ACCOUNTSTATUS = 'Authorised'
          ORDER BY DATECREATED ASC
          )
        WHERE ROWNUM <2
        )
      );
    
  EXCEPTION
  WHEN no_data_found THEN
    pEmailAddress := 'N/A';
  END getEmailAddress;
  
  
  PROCEDURE getCustomerName(
      pCustomerNumber IN VARCHAR2,
      pCustomerName OUT VARCHAR2)
  IS
  BEGIN
   
      SELECT FIRST_NAME||' ' ||LAST_NAME customername
    INTO pCustomerName
    FROM sttm_cust_personal
    WHERE CUSTOMER_NO IN
      (SELECT cust_no
      FROM fcubslive.sttm_cust_account
      WHERE cust_ac_no IN
        (SELECT accountnumber
        FROM
          (SELECT ACCOUNTNUMBER
          FROM newibank.customer_accounts
          WHERE uids IN
            (SELECT uids
            FROM newibank.customers
            WHERE LOWER(CUSTOMERNUMBER) = LOWER(pCustomerNumber)
            )
          AND ACCOUNTSTATUS = 'Authorised'
          ORDER BY DATECREATED ASC
          )
        WHERE ROWNUM <2
        )
      );
  EXCEPTION
  WHEN no_data_found THEN
    pCustomerName := 'N/A';
  END getCustomerName;
  
  
END CASH_BACKLOAN_PKG;