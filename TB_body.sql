create or replace PACKAGE BODY          treasury_pkg
AS
  PROCEDURE insertauditlog(
      pretnum OUT NUMBER,
      staffno   IN VARCHAR2,
      event     IN VARCHAR2,
      createdby IN VARCHAR2,
      eventref  IN VARCHAR2,
      serverip  IN VARCHAR2)
  AS
    pcount      NUMBER;
    v_staffno   VARCHAR2 (1250);
    v_event     VARCHAR2 (1250);
    v_createdby VARCHAR2 (1250);
    v_eventref  VARCHAR2 (1250);
    v_serverip  VARCHAR2 (1250);
  BEGIN
    v_staffno   := staffno;
    v_event     := event;
    v_createdby := createdby;
    v_eventref  := eventref;
    v_serverip  := serverip;
    BEGIN
      INSERT
      INTO tbills_audit_event
        (
          staff_no,
          event,
          created_by,
          date_created,
          trans_ref,
          serverip
        )
        VALUES
        (
          v_staffno,
          v_event,
          v_createdby,
          SYSDATE,
          v_eventref,
          v_serverip
        );
    EXCEPTION
    WHEN OTHERS THEN
      NULL;
    END;
    pretnum := 1;
    COMMIT;
    RETURN;
    pretnum := 5;
    ROLLBACK;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    pretnum := 2;
  END insertauditlog;
  FUNCTION fetchCancel
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    ACCT_NUM
  AS
    accountno,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    MATURITY_DATE
  AS
    maturityDate,
    REQUEST_DATE
  AS
    currDate,
    RELATNSHIP_MGR
  AS
    relationshipmgr,
    CURRENCY
  AS
    currency,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    RATE
  AS
    rate,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number;
    RETURN c_result;
  END;
  FUNCTION fetchCollateralizedDetails
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    ACCT_NUM
  AS
    accountno,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    MATURITY_DATE
  AS
    maturityDate,
    TO_DATE
    (
      value_date, 'dd/MM/rrrr'
    )
  AS
    valueDate,
    RELATNSHIP_MGR
  AS
    relationshipmgr,
    CURRENCY
  AS
    currency,
    RATE
  AS
    rate,
    CUSTOMER_ADDRESS
  AS
    customerAddress,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number AND REQUEST_STATUS IN
    (
      'RUNNING_INVESTMENT', 'HOLD_COLLATERAL_AUTHORIZED'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION fetchRefFactsDelsPremature
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    ACCT_NUM
  AS
    accountno,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    MATURITY_DATE
  AS
    maturityDate,
    TO_DATE
    (
      value_date, 'dd/MM/rrrr'
    )
  AS
    valueDate,
    RELATNSHIP_MGR
  AS
    relationshipmgr,
    CURRENCY
  AS
    currency,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    RATE
  AS
    rate,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number AND REQUEST_STATUS NOT IN
    (
      'PROCESSED_PREMATURE_ACCOUNT_CREDITED','PROCESSING_HOLD_COLLATERAL','HOLD_COLLATERAL_AUTHORIZED'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION fetchRefNoFactsDetails
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT ACCT_NUM
  AS
    accountno,
    REFERENCE_NUM
  AS
    referenceno,
    REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    MATURITY_DATE
  AS
    maturityDate,
    REQUEST_DATE
  AS
    currDate,
    RELATNSHIP_MGR
  AS
    relationshipmgr,
    CURRENCY
  AS
    currency,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    RATE
  AS
    rate,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number ;
    RETURN c_result;
  END;
  FUNCTION fetchDetailsInvestmentLetter
    (
      p_contractnum VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT customer_name
  AS
    customername,
    customer_address
  AS
    customerAddress,
    value_date
  AS
    valueDate,
    maturity_date
  AS
    maturityDate,
    amnt_face_value
  AS
    amountfacevalue,
    discounted_amount
  AS
    discountedAmount,
    charges
  AS
    charges,
    rate
  AS
    rate,
    tenor
  AS
    tenor,
    acct_num
  AS
    accountno FROM TREASURY_BILLS_REQ WHERE reference_num = p_contractnum AND request_status = 'RUNNING_INVESTMENT';
    RETURN c_result;
  END;
  FUNCTION fetchTreasurySalesReport
    (
      p_start_date DATE,
      p_end_date   DATE
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR
    SELECT DISTINCT REFERENCE_NUM AS referenceno,
      REQUEST_TYPE                AS requestType,
      CUSTOMER_NAME               AS customername,
      CUSTOMER_ID                 AS customerid,
      ACCT_NUM                    AS accountno,
      RELATNSHIP_MGR              AS relationshipmgr,
      BRN_NAME                    AS branchname,
      AMNT_FACE_VALUE             AS amountfacevalue,
      AMNT_ROLL_OVER              AS amountrollover,
      REQUEST_STATUS              AS requestStatus,
      TENOR                       AS tenor,
      RATE                        AS rate,
      UPLOAD_IMAGE                AS image,
      IMAGE_NAME                  AS imageName,
      REQUEST_DATE                AS currDate,
      CUSTOMER_EMAIL              AS customeremailadd
    FROM treasury_bills_req
    WHERE REQUEST_TYPE IN
      (
        'New',
        'Roll_Over',
        'Pre_Mature_Termination',
        'Secondary_Market'
      )
    AND REQUEST_STATUS = 'AUTHORIZED_BRANCH'
    AND TRUNC
      (
        REQUEST_DATE
      )
      BETWEEN TRUNC
      (
        p_start_date
      )
    AND TRUNC
      (
        p_end_date
      )
    AND REFERENCE_NUM NOT IN
      (SELECT REFERENCE_NUM FROM treasury_bills_req
      );
    RETURN c_result;
  END;
  FUNCTION fetchRefnoFactsRollTrops
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    ACCT_NUM
  AS
    accountno,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    MATURITY_DATE
  AS
    maturityDate,
    REQUEST_DATE
  AS
    currDate,
    RELATNSHIP_MGR
  AS
    relationshipmgr,
    CURRENCY
  AS
    currency,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    RATE
  AS
    rate,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number AND REQUEST_STATUS = 'RUNNING_INVESTMENT_CREDITED_COLLAT';
    RETURN c_result;
  END;
  FUNCTION fetchRefnoFactsDetailsRoll
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    ACCT_NUM
  AS
    accountno,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    MATURITY_DATE
  AS
    maturityDate,
    REQUEST_DATE
  AS
    currDate,
    RELATNSHIP_MGR
  AS
    relationshipmgr,
    CURRENCY
  AS
    currency,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    RATE
  AS
    rate,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number;
    RETURN c_result;
  END;
  FUNCTION fetchRefnoDetails
    (
      p_ref_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    ACCT_NUM
  AS
    accountno,
    BRN_NAME
  AS
    branchname,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    REFERENCE_NUM
  AS
    referenceno,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    TENOR
  AS
    tenor,
    RATE
  AS
    rate,
    REQUEST_DATE
  AS
    currDate,
    IMAGE_NAME
  AS
    imageName,
    RELATNSHIP_MGR
  AS
    relationshipmgr FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_number;
    RETURN c_result;
  END;
  FUNCTION fetchDetails
    (
      p_acct_number VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR
    SELECT DISTINCT REFERENCE_NUM AS referenceno,
      CUSTOMER_NAME               AS customername,
      CUSTOMER_ID                 AS customerid,
      AMNT_FACE_VALUE             AS amountfacevalue,
      TENOR                       AS tenor,
      RATE                        AS rate
    FROM TREASURY_BILLS_REQ
    WHERE ACCT_NUM     = p_acct_number
    AND REFERENCE_NUM IN
      (SELECT MAX (REFERENCE_NUM) FROM TREASURY_BILLS_REQ
      );
    RETURN c_result;
  END;
  FUNCTION searchAcctDetails
    (
      p_acct_num VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT REFERENCE_NUM
  AS
    referenceno,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    AMOUNT_HELD
  AS
    amountheld,
    TENOR
  AS
    tenor,
    RATE
  AS
    rate,
    REQUEST_DATE
  AS
    currDate,
    VALUE_DATE
  AS
    valueDate,
    MATURITY_DATE
  AS
    maturityDate,
    BRN_NAME
  AS
    branchName,
    REQUEST_STATUS
  AS
    requestStatus,
    BID_STATUS
  AS
    bidStatus,
    MAKER_BRANCH
  AS
    makerBranch,
    CHECKER_BRANCH
  AS
    checkerBranch,
    MAKER_TSALES
  AS
    makerTsales,
    CHECKER_TSALES
  AS
    checkerTsales,
    MAKER_TROPS
  AS
    makerTrops,
    CHECKER_TROPS
  AS
    checkerTrops,
    MAKER_BRANCH_TIMESTAMP
  AS
    makerbranchtime,
    CHECKER_BRANCH_TIMESTAMP
  AS
    checkerbranchtime,
    MAKER_TSALES_TIMESTAMP
  AS
    makersalestime,
    CHECKER_TSALES_TIMESTAMP
  AS
    checkersalestime FROM TREASURY_BILLS_REQ WHERE ACCT_NUM = p_acct_num;
    RETURN c_result;
  END;
  FUNCTION searchRefNumDetails
    (
      p_ref_num VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT ACCT_NUM
  AS
    accountno,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    AMOUNT_HELD
  AS
    amountheld,
    TENOR
  AS
    tenor,
    RATE
  AS
    rate,
    REQUEST_DATE
  AS
    currDate,
    VALUE_DATE
  AS
    valueDate,
    MATURITY_DATE
  AS
    maturityDate,
    BRN_NAME
  AS
    branchName,
    REQUEST_STATUS
  AS
    requestStatus,
    BID_STATUS
  AS
    bidStatus,
    MAKER_BRANCH
  AS
    makerBranch,
    CHECKER_BRANCH
  AS
    checkerBranch,
    MAKER_TSALES
  AS
    makerTsales,
    CHECKER_TSALES
  AS
    checkerTsales,
    MAKER_TROPS
  AS
    makerTrops,
    CHECKER_TROPS
  AS
    checkerTrops,
    MAKER_BRANCH_TIMESTAMP
  AS
    makerbranchtime,
    CHECKER_BRANCH_TIMESTAMP
  AS
    checkerbranchtime,
    MAKER_TSALES_TIMESTAMP
  AS
    makersalestime,
    CHECKER_TSALES_TIMESTAMP
  AS
    checkersalestime,
    AVAILABLE_BALANCE
  AS
    availableBalance,
    CUSTOMER_ADDRESS
  AS
    customerAddress FROM TREASURY_BILLS_REQ WHERE REFERENCE_NUM = p_ref_num;
    RETURN c_result;
  END;
  FUNCTION fetchContractMaturityDate
    (
      p_start_date DATE,
      p_end_date   DATE
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT ACCT_NUM
  AS
    accountno,
    REFERENCE_NUM
  AS
    referenceno,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    AMOUNT_HELD
  AS
    amountheld,
    TENOR
  AS
    tenor,
    RATE
  AS
    rate,
    REQUEST_DATE
  AS
    currDate,
    VALUE_DATE
  AS
    valueDate,
    BRN_NAME
  AS
    branchName,
    REQUEST_STATUS
  AS
    requestStatus,
    BID_STATUS
  AS
    bidStatus,
    MAKER_BRANCH
  AS
    makerBranch,
    CHECKER_BRANCH
  AS
    checkerBranch,
    MAKER_TSALES
  AS
    makerTsales,
    CHECKER_TSALES
  AS
    checkerTsales,
    MAKER_TROPS
  AS
    makerTrops,
    CHECKER_TROPS
  AS
    checkerTrops,
    MAKER_BRANCH_TIMESTAMP
  AS
    makerbranchtime,
    CHECKER_BRANCH_TIMESTAMP
  AS
    checkerbranchtime,
    MAKER_TSALES_TIMESTAMP
  AS
    makersalestime,
    CHECKER_TSALES_TIMESTAMP
  AS
    checkersalestime FROM TREASURY_BILLS_REQ WHERE REQUEST_DATE BETWEEN TRUNC
    (
      p_start_date
    )
    AND TRUNC
    (
      p_end_date
    )
    ;
    RETURN c_result;
  END;
  FUNCTION fetchContractRequestDate
    (
      p_start_date DATE,
      p_end_date   DATE
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT ACCT_NUM
  AS
    accountno,
    REFERENCE_NUM
  AS
    referenceno,
    CUSTOMER_NAME
  AS
    customername,
    CUSTOMER_ID
  AS
    customerid,
    REQUEST_TYPE
  AS
    requestType,
    CUSTOMER_EMAIL
  AS
    customeremailadd,
    AMNT_FACE_VALUE
  AS
    amountfacevalue,
    AMNT_ROLL_OVER
  AS
    amountrollover,
    AMOUNT_HELD
  AS
    amountheld,
    TENOR
  AS
    tenor,
    RATE
  AS
    rate,
    REQUEST_DATE
  AS
    currDate,
    VALUE_DATE
  AS
    valueDate,
    BRN_NAME
  AS
    branchName,
    REQUEST_STATUS
  AS
    requestStatus,
    BID_STATUS
  AS
    bidStatus,
    MAKER_BRANCH
  AS
    makerBranch,
    CHECKER_BRANCH
  AS
    checkerBranch,
    MAKER_TSALES
  AS
    makerTsales,
    CHECKER_TSALES
  AS
    checkerTsales,
    MAKER_TROPS
  AS
    makerTrops,
    CHECKER_TROPS
  AS
    checkerTrops,
    MAKER_BRANCH_TIMESTAMP
  AS
    makerbranchtime,
    CHECKER_BRANCH_TIMESTAMP
  AS
    checkerbranchtime,
    MAKER_TSALES_TIMESTAMP
  AS
    makersalestime,
    CHECKER_TSALES_TIMESTAMP
  AS
    checkersalestime FROM TREASURY_BILLS_REQ WHERE REQUEST_DATE BETWEEN TRUNC
    (
      p_start_date
    )
    AND TRUNC
    (
      p_end_date
    )
    ;
    RETURN c_result;
  END;
  FUNCTION getCurrentDate
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT sysdate
  AS
    currDate FROM dual;
    RETURN c_result;
  END;
  FUNCTION getcustomersDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status='NEW' ;
    RETURN c_result;
  END;
  FUNCTION gettotalInitiatorReportDaoList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'NEW' AND hold_flg = 'PENDING_HOLD' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION gettotalAutRptDaoList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'AUTHORIZED_BRANCH' AND hold_flg = 'HOLD' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION totalAuthRrtForTSViewDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status='AUTHORIZED_BRANCH' AND hold_flg = 'HOLD';
    RETURN c_result;
  END;
  FUNCTION getauthorizerequestsDAOList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE REQUEST_TYPE = 'New' AND request_status = 'NEW' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION getauthreqCancelDAOList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE REQUEST_TYPE = 'Cancel_A_Request' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION getauthreqPrematureBrnDAOList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type = 'Pre_Mature_Termination' AND request_status = 'NEW' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION getauthreqsecBrhDAOList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type = 'Secondary_Market' AND request_status = 'NEW' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION getauthreqRollBrhDAOList
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type = 'Roll_Over' AND request_status = 'NEW' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION getauthreqRollTropsDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type = 'Roll_Over' AND request_status = 'NEW' AND hold_flg_collat = 'PENDING_HOLD_COLLAT';
    RETURN c_result;
  END;
  FUNCTION getauthreqTreasuryDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type IN
    (
      'New', 'Roll_Over', 'Pre_Mature_Termination', 'Secondary_Market'
    )
    AND request_status='NEW_REQ_TREASURY';
    RETURN c_result;
  END;
  FUNCTION getCreditCustomerList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'RUNNING_INVESTMENT_CREDITING_PROCESSING' AND credit_status = 'ACCOUNT_CREDITING_PROCESSING';
    RETURN c_result;
  END;
  FUNCTION viewAllException
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
    (
      'REJECT_BRANCH', 'REJECTED_TROPS','REJECTED_TREASURY_SALES', 'REJECTED_NEW_TREASURY', 'REJECTED_TREASURY_SALES_PREMATURE', 'REJECTED_TREASURY_SALES_SECONDARY', 'REJECTED_PRE-MATURED', 'REJECTED_TROPS_SECONDARY', 'REJECTED_TROPS_STOP_RATE', 'RUNNING_INVESTMENT_CREDITING_REJECTED','COMMISSION_WAIVED_REJECTED'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION viewRejectedBrhandSaved
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
    (
      'REJECT_BRANCH', 'REJECTED_TREASURY_SALES', 'SAVED_BRANCH'
    )
    AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION viewAllRejTransByTROPStoTsales
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
    (
      'REJECTED_TROPS_SECONDARY', 'REJECTED_TROPS', 'REJECTED_TROPS_STOP_RATE', 'REJECTED_PRE-MATURE_INVESTMENT_PROCESSING'
    )
    ;
    RETURN c_result;
  END;
--  FUNCTION vARejByTsalesAutoTssProNewRoll
--    RETURN SYS_REFCURSOR
--  AS
--    c_result SYS_REFCURSOR;
--  BEGIN
--    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
--    (
--      'REJECTED_TREASURY_SALES_TO_PROCESSOR', 'REJECTED_TROPS_TO_PROCESSOR_FINALLY'
--    )
--    ;
--    RETURN c_result;
--  END;
  FUNCTION vARejByTsalesAutoTssAuProPrem
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
    (
      'REJECTED_TREASURY_SALES_TO_PROCESSOR', 'REJECTED_TROPS_TO_PROCESSOR_FINALLY'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION vARejByTsalesAutoTssProSec
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
    (
      'REJECTED_TREASURY_SALES_SECONDARY_TO_PROCESSOR', 'REJECTED_TROPS_SECONDARY_TO_PROCESSOR_FINALLY'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION vARejByTROPSsAutoTroProNR
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'REJECTED_TROPS_TO_PROCESSOR' ;
    RETURN c_result;
  END;
--  FUNCTION vARejByTROPSsAutoTroProSR
--    RETURN SYS_REFCURSOR
--  AS
--    c_result SYS_REFCURSOR;
--  BEGIN
--    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'REJECTED_TROPS_STOP_RATE_TO_PROCESSOR' ;
--    RETURN c_result;
--  END;
  FUNCTION vARejByTROPSsAutoTroProPM
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'REJECTED_PRE-MATURE_INVESTMENT_PROCESSING_TO_PROCESSOR' ;
    RETURN c_result;
  END;
  FUNCTION vARejByTROPSsAutoTroProSec
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'REJECTED_TROPS_SECONDARY_TO_PROCESSOR' ;
    RETURN c_result;
  END;
  FUNCTION vARejByTROPSsAutoTroProWC
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE commission_waived = 'COMMISSION_WAIVED_REJECTED' ;
    RETURN c_result;
  END;
  FUNCTION vARejByTROPSsAutoTroTsalePr
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status IN
    (
      'REJECTED_TREASURY_SALES_TO_PROCESSOR', 'REJECTED_TREASURY_SALES_TO_PROCESSOR', 'REJECTED_TREASURY_SALES_PREMATURE_TO_PROCESSOR', 'REJECTED_TREASURY_SALES_SECONDARY_TO_PROCESSOR'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION viewAllUnliened
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'REMOVING_HOLD' AND hold_flg = 'HOLD_REMOVED' ;
    RETURN c_result;
  END;
  FUNCTION viewAllInvestmentsBranch
    (
      p_brn_name VARCHAR2
    )
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_status = 'RUNNING_INVESTMENT' AND brn_name = p_brn_name;
    RETURN c_result;
  END;
  FUNCTION viewAllWaived
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE commission_waived = 'COMMISSION_WAIVED' ;
    RETURN c_result;
  END;
  FUNCTION viewAllUnsuccessfulBids
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE bid_status = 'UNSUCCESSFUL_BID_AUTHORIZED' ;
    RETURN c_result;
  END;
  FUNCTION totalreportDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type IN
    (
      'New', 'Roll_Over'
    )
    AND request_status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD' AND rate IS NOT NULL ;
    RETURN c_result;
  END;
  FUNCTION totalreportRateDAOList91
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type IN
    (
      'New','Roll_Over'
    )
    AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND rate IS NULL AND tenor = '91' ;
    RETURN c_result;
  END;
  FUNCTION totalreportRateDAOList182
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type IN
    (
      'New','Roll_Over'
    )
    AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND rate IS NULL AND tenor = '182' ;
    RETURN c_result;
  END;
  FUNCTION totalreportRateDAOList364
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type IN
    (
      'New','Roll_Over'
    )
    AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND rate IS NULL AND tenor = '364' ;
    RETURN c_result;
  END;
  FUNCTION totalreportPrematureDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type = 'Pre_Mature_Termination' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD' ;
    RETURN c_result;
  END;
  FUNCTION totalrepPreAuthorizeDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_type = 'Pre_Mature_Termination' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD' ;
    RETURN c_result;
  END;
  FUNCTION removeholdNewDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Pre_Mature_Termination' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD';
    RETURN c_result;
  END;
  FUNCTION removeHoldRollOverDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Pre_Mature_Termination' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD';
    RETURN c_result;
  END;
  FUNCTION removeHoldSecondaryDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Pre_Mature_Termination' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD';
    RETURN c_result;
  END;
  FUNCTION totalreportSecMarketDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Secondary_Market' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD';
    RETURN c_result;
  END;
  FUNCTION totalrptSecMarketAuthDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Secondary_Market' AND request_Status = 'RATE/MATURITY/VALUE_DATE_CHANGED_SECONDARY' AND treasury_Sales_Status = 'UPDATED_RATE/VALUE/MATURITY_DATE_SECONDARY';
    RETURN c_result;
  END;
  FUNCTION totalrptAuthRollDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Secondary_Market' AND request_Status IN
    (
      'AUTHORIZED_BRANCH','AUTHORIZED_NEW_TREASURY'
    )
    AND hold_flg = 'HOLD';
    RETURN c_result;
  END;
  FUNCTION totalrptAuthDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'New' AND treasury_Sales_Status IN
    (
      'RATE_APPLIED_INIT', 'BID_STATUS_CHANGED_CUSTOMER'
    )
    AND request_Status IN
    (
      'RATE_CHANGED', 'RATE_INTACT_CUSTOMER'
    )
    ;
    RETURN c_result;
  END;
  FUNCTION totalrptTrsryOpsBidDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE treasury_Sales_Status = 'RATE_APPLIED_INIT/ITEMS_CALCULATED' AND request_Status = 'AUTHORIZED_TREASURY_SALES_REPORT' AND bid_Status IS NULL;
    RETURN c_result;
  END;
  FUNCTION totalrptTrsryOpsDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE treasury_Sales_Status = 'RATE_APPLIED_INIT/ITEMS_CALCULATED' AND request_Status = 'AUTHORIZED_TREASURY_SALES_REPORT' AND bid_Status = 'Successful Bid' AND request_Type IN
    (
      'New', 'Roll_Over'
    )
    AND stop_rate_Status IS NULL;
    RETURN c_result;
  END;
  FUNCTION ttlrptTrsyOpsSRDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE stop_rate_Status = 'STOP_RATE_APPLIED';
    RETURN c_result;
  END;
  FUNCTION totalrptTrsyOps91DAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type IN
    (
      'New', 'Roll_Over', 'Pre_Mature_Termination', 'Secondary_Market'
    )
    AND treasury_Sales_Status = 'RATE_APPLIED_INIT/ITEMS_CALCULATED' AND request_Status = 'AUTHORIZED_TREASURY_SALES_REPORT' AND tenor = '91';
    RETURN c_result;
  END;
  FUNCTION totalrptTrsyOps182DAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type IN
    (
      'New', 'Roll_Over', 'Pre_Mature_Termination', 'Secondary_Market'
    )
    AND treasury_Sales_Status = 'RATE_APPLIED_INIT/ITEMS_CALCULATED' AND request_Status = 'AUTHORIZED_TREASURY_SALES_REPORT' AND tenor = '182';
    RETURN c_result;
  END;
  FUNCTION totalrptTrsyOps364DAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type IN
    (
      'New', 'Roll_Over', 'Pre_Mature_Termination', 'Secondary_Market'
    )
    AND treasury_Sales_Status = 'RATE_APPLIED_INIT/ITEMS_CALCULATED' AND request_Status = 'AUTHORIZED_TREASURY_SALES_REPORT' AND tenor = '364';
    RETURN c_result;
  END;
  FUNCTION totalrptauthTrsyOpsDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Status = 'PROCESSING_TROPS_INITIATOR' AND request_Type IN
    (
      'New', 'Roll_Over'
    )
    AND stop_rate_Status IS NULL;
    RETURN c_result;
  END;
  FUNCTION fetchSRDetailsDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE stop_rate_Status = 'STOP_RATE_APPLIED_VIEW';
    RETURN c_result;
  END;
  FUNCTION totalrptauthTrsyOpsSRAuthDAO
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE stop_rate_Status = 'STOP_RATE_APPLIED_VIEW';
    RETURN c_result;
  END;
  FUNCTION ttlrptauthTrsyOpsSRAuthsUnDAO
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE bid_Status = 'Unsuccessful Bid';
    RETURN c_result;
  END;
  FUNCTION ttlrptSecMrtTROPsDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Secondary_Market' AND request_Status = 'AUTHORIZED_TREASURY_SALES_SECONDARY' AND treasury_Sales_Status = 'RATE_APPLIED_INIT/ITEMS_CALCULATED';
    RETURN c_result;
  END;
  FUNCTION ttlrptSecMktTROPsAuthDAOList
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Type = 'Secondary_Market' AND request_Status = 'PROCESSING_TROPS_SECONDARY';
    RETURN c_result;
  END;
  FUNCTION ttlrptWvComTROPSAuthDAO
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE request_Status = 'PROCESSING_TROPS_INITIATOR' AND commission_Waived = 'PROCESSING_WAIVED_COMMISSION' AND account_Class = 'STAFF';
    RETURN c_result;
  END;
  FUNCTION printInvestmentLetter
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ WHERE print_Letter = 'TO_PRINT';
    RETURN c_result;
  END;
  FUNCTION treasurybillreq
    (
      i_REFERENCE_NUM     VARCHAR2,
      i_CUSTOMER_NAME     VARCHAR2,
      i_CUSTOMER_ID       VARCHAR2,
      i_REQUEST_TYPE      VARCHAR2,
      i_ACCT_NUM          VARCHAR2,
      i_BRN_NAME          VARCHAR2,
      i_CUSTOMER_EMAIL    VARCHAR2,
      i_AMNT_FACE_VALUE   VARCHAR2,
      i_AMNT_ROLL_OVER    VARCHAR2,
      i_TENOR             NUMBER,
      i_NEW_RATE          NUMBER,
      i_REQUEST_DATE      DATE,
      i_HOLD_FUNDS_OPTION VARCHAR2,
      i_UPLOAD_IMAGE BLOB,
      i_IMAGE_NAME                  VARCHAR2,
      i_MATURITY_DATE               DATE,
      i_VALUE_DATE                  DATE,
      i_INITIATOR_EMAIL             VARCHAR2,
      i_RELATNSHIP_MGR              VARCHAR2,
      i_RM_CODE                     VARCHAR2,
      i_REQUEST_STATUS              VARCHAR2,
      i_BID_STATUS                  VARCHAR2,
      i_COMMENTS                    VARCHAR2,
      i_HOLD_FLG                    VARCHAR2,
      i_HOLD_DATE                   TIMESTAMP,
      i_RELEASED_DATE               TIMESTAMP,
      i_HOLD_REF_NUM                VARCHAR2,
      i_AMNT_DIFFERENCE             NUMBER,
      i_RESPONSE_CODE               VARCHAR2,
      i_RESPONSE_MESSAGE            VARCHAR2,
      i_ASSIGNED_TO                 VARCHAR2,
      i_INTEREST                    NUMBER,
      i_DISCOUNTED_AMOUNT           NUMBER,
      i_COMMISSION                  NUMBER,
      i_CUSTODY_FEE                 NUMBER,
      i_VAT_COMMISSION              NUMBER,
      i_VAT_CUSTODY_FEE             NUMBER,
      i_COMMENT_BRANCH_SUP          VARCHAR2,
      i_COMMENT_TREASURYSALES_SUP   VARCHAR2,
      i_COMMENT_TREASURYOPS_SUP     VARCHAR2,
      i_REASON_FOR_REJECT_BRANCH    VARCHAR2,
      i_REASON_FOR_REJECT_TROPS     VARCHAR2,
      i_AMOUNT_HELD                 NUMBER,
      i_BRN_CODE                    VARCHAR2,
      i_DEBIT_STATUS                VARCHAR2,
      i_RESPONSE_CODE_DISCOUNTED    VARCHAR2,
      i_RESPONSE_MESSAGE_DISCOUNTED VARCHAR2,
      i_RESPONSE_CODE_INTEREST      VARCHAR2,
      i_RESPONSE_MESSAGE_INTEREST   VARCHAR2,
      i_RESPONSE_CODE_COMM          VARCHAR2,
      i_RESPONSE_MESSAGE_COMM       VARCHAR2,
      i_RESPONSE_CODE_CUSTODY       VARCHAR2,
      i_RESPONSE_MESSAGE_CUSTODY    VARCHAR2,
      i_RESPONSE_CODE_VATCUSTODY    VARCHAR2,
      i_RESPONSE_MESSAGE_VATCUSTODY VARCHAR2,
      i_RESPONSE_CODE_VATCOMM       VARCHAR2,
      i_RESPONSE_MESSAGE_VATCOMM    VARCHAR2,
      i_DEBIT_DATE                  TIMESTAMP ,
      i_TREASURY_SALES_STATUS       VARCHAR2,
      i_RATE_TYPE                   VARCHAR2,
      i_MAKER_BRANCH                VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP      TIMESTAMP,
      i_CHECKER_BRANCH              VARCHAR2,
      i_CHECKER_BRANCH_TIMESTAMP    TIMESTAMP,
      i_MAKER_TSALES                VARCHAR2,
      i_MAKER_TSALES_TIMESTAMP      TIMESTAMP,
      i_CHECKER_TSALES              VARCHAR2,
      i_CHECKER_TSALES_TIMESTAMP    TIMESTAMP,
      i_MAKER_TROPS                 VARCHAR2,
      i_MAKER_TROPS_TIMESTAMP       TIMESTAMP,
      i_CHECKER_TROPS               VARCHAR2,
      i_CHECKER_TROPS_TIMESTAMP     TIMESTAMP,
      i_HOLD_REF_NUM_REMOVEHOLD     VARCHAR2,
      i_RESPONSE_CODE_REMOVEHOLD    VARCHAR2,
      i_RESPONSE_MESSAGE_REMOVEHOLD VARCHAR2,
      i_COMMISSION_WAIVED           VARCHAR2,
      i_ACCOUNT_CLASS               VARCHAR2,
      i_CHARGES                     NUMBER,
      i_CREDIT_DATE                 TIMESTAMP ,
      i_CREDIT_STATUS               VARCHAR2,
      i_RESPONSE_CODE_CREDIT        VARCHAR2,
      i_RESPONSE_MESSAGE_CREDIT     VARCHAR2,
      i_AMOUNT_CREDITED             NUMBER,
      i_CURRENCY                    VARCHAR2,
      i_AVAILABLE_BALANCE           VARCHAR2,
      i_CUSTOMER_ADDRESS            VARCHAR2,
      i_REQUEST_DATE_MAIN           VARCHAR2,
      i_PRODUCT_CODE                VARCHAR2,
      i_STOP_RATE_STATUS            VARCHAR2,
      i_TOTAL_AMOUNT_CALCULATED     VARCHAR2,
      i_TOTAL_VOLUME_AMOUNT         VARCHAR2,
      i_ROW_ID                      NUMBER,
      i_RATE                        NUMBER,
      i_AMOUNT_ALLOTTED             NUMBER,
      i_PRINT_LETTER                VARCHAR2,
      i_CURRENT_YEAR_TENOR          NUMBER,
      i_NEW_YEAR_TENOR              NUMBER,
      i_CURRENT_YEAR_NO_DAYS        NUMBER,
      i_NEW_YEAR_NO_DAYS            NUMBER,
      i_REASON_FOR_REJECT_TSALES    VARCHAR2,
      i_RESPONSE_CODE_PROCESSFEE    VARCHAR2 ,
      i_RESPONSE_MESSAGE_PROCESSFEE VARCHAR2,
      i_HOLD_FLG_COLLAT             VARCHAR2,
      i_HOLD_REF_NUMCOLLAT          VARCHAR2,
      i_RESP_HOLDCOLLAT             VARCHAR2,
      i_RESP_MSG_HOLDCOLLAT         VARCHAR2,
      i_RESP_REMCOLLAT              VARCHAR2,
      i_RESP_MSG_REMCOLLAT          VARCHAR2,
      i_HOLD_REF_NUMREMCOLLAT       VARCHAR2,
      i_PROCESSING_FEE              NUMBER
    )
    RETURN VARCHAR2
  AS
  BEGIN
    INSERT
    INTO TREASURY_BILLS_REQ
      (
        REFERENCE_NUM ,
        CUSTOMER_NAME ,
        CUSTOMER_ID ,
        REQUEST_TYPE ,
        ACCT_NUM ,
        BRN_NAME ,
        CUSTOMER_EMAIL ,
        AMNT_FACE_VALUE ,
        AMNT_ROLL_OVER ,
        TENOR ,
        NEW_RATE ,
        REQUEST_DATE ,
        HOLD_FUNDS_OPTION ,
        UPLOAD_IMAGE ,
        IMAGE_NAME ,
        MATURITY_DATE ,
        VALUE_DATE ,
        INITIATOR_EMAIL ,
        RELATNSHIP_MGR ,
        RM_CODE ,
        REQUEST_STATUS ,
        BID_STATUS ,
        COMMENTS ,
        HOLD_FLG ,
        HOLD_DATE ,
        RELEASED_DATE ,
        HOLD_REF_NUM ,
        AMNT_DIFFERENCE ,
        RESPONSE_CODE ,
        RESPONSE_MESSAGE ,
        ASSIGNED_TO ,
        INTEREST ,
        DISCOUNTED_AMOUNT ,
        COMMISSION ,
        CUSTODY_FEE ,
        VAT_COMMISSION ,
        VAT_CUSTODY_FEE ,
        COMMENT_BRANCH_SUP ,
        COMMENT_TREASURYSALES_SUP ,
        COMMENT_TREASURYOPS_SUP ,
        REASON_FOR_REJECT_BRANCH ,
        REASON_FOR_REJECT_TROPS ,
        AMOUNT_HELD ,
        BRN_CODE ,
        DEBIT_STATUS ,
        RESPONSE_CODE_DISCOUNTED ,
        RESPONSE_MESSAGE_DISCOUNTED ,
        RESPONSE_CODE_INTEREST ,
        RESPONSE_MESSAGE_INTEREST ,
        RESPONSE_CODE_COMM ,
        RESPONSE_MESSAGE_COMM ,
        RESPONSE_CODE_CUSTODY ,
        RESPONSE_MESSAGE_CUSTODY ,
        RESPONSE_CODE_VATCUSTODY ,
        RESPONSE_MESSAGE_VATCUSTODY ,
        RESPONSE_CODE_VATCOMM ,
        RESPONSE_MESSAGE_VATCOMM ,
        DEBIT_DATE ,
        TREASURY_SALES_STATUS ,
        RATE_TYPE ,
        MAKER_BRANCH ,
        MAKER_BRANCH_TIMESTAMP ,
        CHECKER_BRANCH ,
        CHECKER_BRANCH_TIMESTAMP ,
        MAKER_TSALES ,
        MAKER_TSALES_TIMESTAMP ,
        CHECKER_TSALES ,
        CHECKER_TSALES_TIMESTAMP ,
        MAKER_TROPS ,
        MAKER_TROPS_TIMESTAMP ,
        CHECKER_TROPS ,
        CHECKER_TROPS_TIMESTAMP ,
        HOLD_REF_NUM_REMOVEHOLD ,
        RESPONSE_CODE_REMOVEHOLD ,
        RESPONSE_MESSAGE_REMOVEHOLD ,
        COMMISSION_WAIVED ,
        ACCOUNT_CLASS ,
        CHARGES ,
        CREDIT_DATE ,
        CREDIT_STATUS ,
        RESPONSE_CODE_CREDIT ,
        RESPONSE_MESSAGE_CREDIT ,
        AMOUNT_CREDITED ,
        CURRENCY ,
        AVAILABLE_BALANCE ,
        CUSTOMER_ADDRESS ,
        REQUEST_DATE_MAIN ,
        PRODUCT_CODE ,
        STOP_RATE_STATUS ,
        TOTAL_AMOUNT_CALCULATED ,
        TOTAL_VOLUME_AMOUNT ,
        ROW_ID ,
        RATE ,
        AMOUNT_ALLOTTED ,
        PRINT_LETTER ,
        CURRENT_YEAR_TENOR ,
        NEW_YEAR_TENOR ,
        CURRENT_YEAR_NO_DAYS ,
        NEW_YEAR_NO_DAYS ,
        REASON_FOR_REJECT_TSALES ,
        RESPONSE_CODE_PROCESSFEE ,
        RESPONSE_MESSAGE_PROCESSFEE ,
        HOLD_FLG_COLLAT ,
        HOLD_REF_NUMCOLLAT ,
        RESP_HOLDCOLLAT ,
        RESP_MSG_HOLDCOLLAT ,
        RESP_REMCOLLAT ,
        RESP_MSG_REMCOLLAT ,
        HOLD_REF_NUMREMCOLLAT ,
        PROCESSING_FEE
      )
      VALUES
      (
        i_REFERENCE_NUM ,
        i_CUSTOMER_NAME ,
        i_CUSTOMER_ID ,
        i_REQUEST_TYPE ,
        i_ACCT_NUM ,
        i_BRN_NAME ,
        i_CUSTOMER_EMAIL ,
        i_AMNT_FACE_VALUE ,
        i_AMNT_ROLL_OVER ,
        i_TENOR ,
        i_NEW_RATE ,
        i_REQUEST_DATE ,
        i_HOLD_FUNDS_OPTION ,
        i_UPLOAD_IMAGE ,
        i_IMAGE_NAME ,
        i_MATURITY_DATE ,
        i_VALUE_DATE ,
        i_INITIATOR_EMAIL ,
        i_RELATNSHIP_MGR ,
        i_RM_CODE ,
        i_REQUEST_STATUS ,
        i_BID_STATUS ,
        i_COMMENTS ,
        i_HOLD_FLG ,
        i_HOLD_DATE ,
        i_RELEASED_DATE ,
        i_HOLD_REF_NUM ,
        i_AMNT_DIFFERENCE ,
        i_RESPONSE_CODE ,
        i_RESPONSE_MESSAGE ,
        i_ASSIGNED_TO ,
        i_INTEREST ,
        i_DISCOUNTED_AMOUNT ,
        i_COMMISSION ,
        i_CUSTODY_FEE ,
        i_VAT_COMMISSION ,
        i_VAT_CUSTODY_FEE ,
        i_COMMENT_BRANCH_SUP ,
        i_COMMENT_TREASURYSALES_SUP ,
        i_COMMENT_TREASURYOPS_SUP ,
        i_REASON_FOR_REJECT_BRANCH ,
        i_REASON_FOR_REJECT_TROPS ,
        i_AMOUNT_HELD ,
        i_BRN_CODE ,
        i_DEBIT_STATUS ,
        i_RESPONSE_CODE_DISCOUNTED ,
        i_RESPONSE_MESSAGE_DISCOUNTED ,
        i_RESPONSE_CODE_INTEREST ,
        i_RESPONSE_MESSAGE_INTEREST ,
        i_RESPONSE_CODE_COMM ,
        i_RESPONSE_MESSAGE_COMM ,
        i_RESPONSE_CODE_CUSTODY ,
        i_RESPONSE_MESSAGE_CUSTODY ,
        i_RESPONSE_CODE_VATCUSTODY ,
        i_RESPONSE_MESSAGE_VATCUSTODY ,
        i_RESPONSE_CODE_VATCOMM ,
        i_RESPONSE_MESSAGE_VATCOMM ,
        i_DEBIT_DATE ,
        i_TREASURY_SALES_STATUS ,
        i_RATE_TYPE ,
        i_MAKER_BRANCH ,
        i_MAKER_BRANCH_TIMESTAMP ,
        i_CHECKER_BRANCH ,
        i_CHECKER_BRANCH_TIMESTAMP ,
        i_MAKER_TSALES ,
        i_MAKER_TSALES_TIMESTAMP ,
        i_CHECKER_TSALES ,
        i_CHECKER_TSALES_TIMESTAMP ,
        i_MAKER_TROPS ,
        i_MAKER_TROPS_TIMESTAMP ,
        i_CHECKER_TROPS ,
        i_CHECKER_TROPS_TIMESTAMP ,
        i_HOLD_REF_NUM_REMOVEHOLD ,
        i_RESPONSE_CODE_REMOVEHOLD ,
        i_RESPONSE_MESSAGE_REMOVEHOLD ,
        i_COMMISSION_WAIVED ,
        i_ACCOUNT_CLASS ,
        i_CHARGES ,
        i_CREDIT_DATE ,
        i_CREDIT_STATUS ,
        i_RESPONSE_CODE_CREDIT ,
        i_RESPONSE_MESSAGE_CREDIT ,
        i_AMOUNT_CREDITED ,
        i_CURRENCY ,
        i_AVAILABLE_BALANCE ,
        i_CUSTOMER_ADDRESS ,
        i_REQUEST_DATE_MAIN ,
        i_PRODUCT_CODE ,
        i_STOP_RATE_STATUS ,
        i_TOTAL_AMOUNT_CALCULATED ,
        i_TOTAL_VOLUME_AMOUNT ,
        i_ROW_ID ,
        i_RATE ,
        i_AMOUNT_ALLOTTED ,
        i_PRINT_LETTER ,
        i_CURRENT_YEAR_TENOR ,
        i_NEW_YEAR_TENOR ,
        i_CURRENT_YEAR_NO_DAYS ,
        i_NEW_YEAR_NO_DAYS ,
        i_REASON_FOR_REJECT_TSALES ,
        i_RESPONSE_CODE_PROCESSFEE,
        i_RESPONSE_MESSAGE_PROCESSFEE ,
        i_HOLD_FLG_COLLAT ,
        i_HOLD_REF_NUMCOLLAT ,
        i_RESP_HOLDCOLLAT ,
        i_RESP_MSG_HOLDCOLLAT ,
        i_RESP_REMCOLLAT ,
        i_RESP_MSG_REMCOLLAT ,
        i_HOLD_REF_NUMREMCOLLAT ,
        i_PROCESSING_FEE
      );
    COMMIT;
    RETURN '00';
  END;
  FUNCTION updatecustomerprematture
    (
      i_REFERENCE_NUM          VARCHAR2,
      i_TENOR                  NUMBER,
      i_MAKER_BRANCH           VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP TIMESTAMP,
      i_REQUEST_STATUS         VARCHAR2,
      i_HOLD_FLG               VARCHAR2,
      i_ASSIGNED_TO            VARCHAR2,
      i_INITIATOR_EMAIL        VARCHAR2,
      i_RELATNSHIP_MGR         VARCHAR2,
      i_BRN_NAME               VARCHAR2,
      i_RM_CODE                VARCHAR2,
      i_REQUEST_TYPE           VARCHAR2
    )
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET a.TENOR                = i_TENOR,
      a.MAKER_BRANCH           = i_MAKER_BRANCH,
      a.MAKER_BRANCH_TIMESTAMP = sysdate,
      a.REQUEST_STATUS         = i_REQUEST_STATUS,
      a.HOLD_FLG               = i_HOLD_FLG,
      a.ASSIGNED_TO            = i_ASSIGNED_TO,
      a.INITIATOR_EMAIL        = i_INITIATOR_EMAIL,
      a.RELATNSHIP_MGR         = i_RELATNSHIP_MGR,
      a.BRN_NAME               = i_BRN_NAME,
      a.RM_CODE                = i_RM_CODE,
      a.REQUEST_TYPE           = i_REQUEST_TYPE
    WHERE a.REFERENCE_NUM      = i_REFERENCE_NUM;
    COMMIT;
    RETURN '';
  END;
  FUNCTION updatecustomerrollover(
      i_REFERENCE_NUM          VARCHAR2,
      i_MAKER_BRANCH           VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP TIMESTAMP,
      i_REQUEST_STATUS         VARCHAR2,
      i_HOLD_FLG               VARCHAR2,
      i_ASSIGNED_TO            VARCHAR2,
      i_INITIATOR_EMAIL        VARCHAR2,
      i_RELATNSHIP_MGR         VARCHAR2,
      i_BRN_NAME               VARCHAR2,
      i_RM_CODE                VARCHAR2,
      i_REQUEST_TYPE           VARCHAR2)
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET a.MAKER_BRANCH         = i_MAKER_BRANCH,
      a.MAKER_BRANCH_TIMESTAMP = sysdate,
      a.REQUEST_STATUS         = i_REQUEST_STATUS,
      a.HOLD_FLG               = i_HOLD_FLG,
      a.ASSIGNED_TO            = i_ASSIGNED_TO,
      a.INITIATOR_EMAIL        = i_INITIATOR_EMAIL,
      a.RELATNSHIP_MGR         = i_RELATNSHIP_MGR,
      a.BRN_NAME               = i_BRN_NAME,
      a.RM_CODE                = i_RM_CODE,
      a.REQUEST_TYPE           = i_REQUEST_TYPE
    WHERE a.REFERENCE_NUM      = i_REFERENCE_NUM;
    COMMIT;
    RETURN '';
  END;
  FUNCTION updatecustomerrollovertrops(
      i_REFERENCE_NUM         VARCHAR2,
      i_DISCOUNTED_AMOUNT     NUMBER,
      i_CUSTODY_FEE           NUMBER,
      i_VAT_CUSTODY_FEE       NUMBER,
      i_TENOR                 NUMBER,
      i_MAKER_TROPS           VARCHAR2,
      i_MAKER_TROPS_TIMESTAMP TIMESTAMP,
      i_REQUEST_STATUS        VARCHAR2,
      i_HOLD_FLG_COLLAT       VARCHAR2,
      i_REQUEST_TYPE          VARCHAR2)
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET a.DISCOUNTED_AMOUNT   = i_DISCOUNTED_AMOUNT,
      a.CUSTODY_FEE           = i_CUSTODY_FEE,
      a.VAT_CUSTODY_FEE       = i_VAT_CUSTODY_FEE,
      a.TENOR                 = i_TENOR,
      a.MAKER_TROPS           = i_MAKER_TROPS,
      a.MAKER_TROPS_TIMESTAMP = i_MAKER_TROPS_TIMESTAMP,
      a.REQUEST_STATUS        = i_REQUEST_STATUS,
      a.HOLD_FLG_COLLAT       = i_HOLD_FLG_COLLAT,
      a.REQUEST_TYPE          = i_REQUEST_TYPE
    WHERE a.REFERENCE_NUM     = i_REFERENCE_NUM;
    COMMIT;
    RETURN '00';
  END;
  FUNCTION updatecustomerinvestment(
      i_REFERENCE_NUM VARCHAR2,
      i_PRINT_LETTER  VARCHAR2 )
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET a.PRINT_LETTER    = i_PRINT_LETTER
    WHERE a.REFERENCE_NUM = i_REFERENCE_NUM;
    COMMIT;
    RETURN '00';
  END;
  FUNCTION inserttodb(
      i_REQUEST_DATE           DATE,
      i_MAKER_BRANCH           VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP TIMESTAMP,
      i_REQUEST_STATUS         VARCHAR2,
      i_HOLD_FLG               VARCHAR2,
      i_REQUEST_TYPE           VARCHAR2,
      i_ASSIGNED_TO            VARCHAR2,
      i_INITIATOR_EMAIL        VARCHAR2,
      i_RELATNSHIP_MGR         VARCHAR2,
      i_BRN_NAME               VARCHAR2,
      i_RM_CODE                VARCHAR2,
      i_AMOUNT_HELD            NUMBER,
      i_INTEREST               NUMBER,
      i_DISCOUNTED_AMOUNT      NUMBER,
      i_CUSTODY_FEE            NUMBER,
      i_VAT_CUSTODY_FEE        NUMBER,
      i_PROCESSING_FEE         NUMBER,
      i_CHARGES                NUMBER,
      i_TENOR                  NUMBER,
      i_PRODUCT_CODE           VARCHAR2,
      i_RATE                   NUMBER,
      i_REQUEST_DATE_MAIN      VARCHAR2,
      i_ACCOUNT_CLASS          VARCHAR2,
      i_CUSTOMER_NAME          VARCHAR2,
      i_CUSTOMER_ID            VARCHAR2,
      i_ACCT_NUM               VARCHAR2,
      i_CURRENCY               VARCHAR2,
      i_AVAILABLE_BALANCE      VARCHAR2,
      i_CUSTOMER_ADDRESS       VARCHAR2,
      i_CUSTOMER_EMAIL         VARCHAR2,
      i_MATURITY_DATE          DATE,
      i_VALUE_DATE             DATE,
      i_AMNT_FACE_VALUE        VARCHAR2,
      i_IMAGE_NAME             VARCHAR2 ,
      i_HOLD_DATE              TIMESTAMP,
      i_RELEASED_DATE          TIMESTAMP )
    RETURN VARCHAR2
  AS
  BEGIN
    INSERT
    INTO TREASURY_BILLS_REQ
      (
        REQUEST_DATE ,
        MAKER_BRANCH ,
        MAKER_BRANCH_TIMESTAMP ,
        REQUEST_STATUS ,
        HOLD_FLG ,
        REQUEST_TYPE ,
        ASSIGNED_TO ,
        INITIATOR_EMAIL ,
        RELATNSHIP_MGR ,
        BRN_NAME ,
        RM_CODE ,
        AMOUNT_HELD ,
        INTEREST ,
        DISCOUNTED_AMOUNT ,
        CUSTODY_FEE ,
        VAT_CUSTODY_FEE ,
        PROCESSING_FEE ,
        CHARGES ,
        TENOR,
        PRODUCT_CODE,
        RATE,
        REQUEST_DATE_MAIN,
        ACCOUNT_CLASS,
        CUSTOMER_NAME,
        CUSTOMER_ID,
        ACCT_NUM,
        CURRENCY,
        AVAILABLE_BALANCE,
        CUSTOMER_ADDRESS,
        CUSTOMER_EMAIL,
        MATURITY_DATE,
        VALUE_DATE,
        AMNT_FACE_VALUE ,
        IMAGE_NAME ,
        HOLD_DATE,
        RELEASED_DATE
      )
      VALUES
      (
        i_REQUEST_DATE ,
        i_MAKER_BRANCH ,
        i_MAKER_BRANCH_TIMESTAMP ,
        i_REQUEST_STATUS ,
        i_HOLD_FLG ,
        i_REQUEST_TYPE ,
        i_ASSIGNED_TO ,
        i_INITIATOR_EMAIL ,
        i_RELATNSHIP_MGR ,
        i_BRN_NAME ,
        i_RM_CODE ,
        i_AMOUNT_HELD ,
        i_INTEREST ,
        i_DISCOUNTED_AMOUNT ,
        i_CUSTODY_FEE ,
        i_VAT_CUSTODY_FEE ,
        i_PROCESSING_FEE ,
        i_CHARGES ,
        i_TENOR ,
        i_PRODUCT_CODE,
        i_RATE,
        i_REQUEST_DATE_MAIN,
        i_ACCOUNT_CLASS,
        i_CUSTOMER_NAME,
        i_CUSTOMER_ID,
        i_ACCT_NUM,
        i_CURRENCY,
        i_AVAILABLE_BALANCE,
        i_CUSTOMER_ADDRESS,
        i_CUSTOMER_EMAIL,
        i_MATURITY_DATE,
        i_VALUE_DATE,
        i_AMNT_FACE_VALUE,
        i_IMAGE_NAME,
        i_HOLD_DATE ,
        i_RELEASED_DATE
      );
    COMMIT;
    RETURN '00';
  END;
  FUNCTION savecustomerforlater
    (
      i_REQUEST_DATE           DATE,
      i_MAKER_BRANCH           VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP TIMESTAMP,
      i_REQUEST_STATUS         VARCHAR2,
      i_HOLD_FLG               VARCHAR2,
      i_ASSIGNED_TO            VARCHAR2,
      i_INITIATOR_EMAIL        VARCHAR2,
      i_RELATNSHIP_MGR         VARCHAR2,
      i_BRN_NAME               VARCHAR2,
      i_RM_CODE                VARCHAR2,
      i_PRODUCT_CODE           VARCHAR2,
      i_RATE                   NUMBER,
      i_REQUEST_DATE_MAIN      VARCHAR2,
      i_ACCOUNT_CLASS          VARCHAR2,
      i_CUSTOMER_NAME          VARCHAR2,
      i_CUSTOMER_ID            VARCHAR2,
      i_ACCT_NUM               VARCHAR2,
      i_CURRENCY               VARCHAR2,
      i_AVAILABLE_BALANCE      VARCHAR2,
      i_CUSTOMER_ADDRESS       VARCHAR2,
      i_CUSTOMER_EMAIL         VARCHAR2,
      i_MATURITY_DATE          DATE,
      i_VALUE_DATE             DATE,
      i_AMNT_FACE_VALUE        VARCHAR2,
      i_IMAGE_NAME             VARCHAR2 ,
      i_HOLD_DATE              TIMESTAMP,
      i_RELEASED_DATE          TIMESTAMP,
      i_TENOR                  NUMBER
    )
    RETURN VARCHAR2
  AS
  BEGIN
    INSERT
    INTO TREASURY_BILLS_REQ
      (
        REQUEST_DATE ,
        MAKER_BRANCH ,
        MAKER_BRANCH_TIMESTAMP ,
        REQUEST_STATUS ,
        HOLD_FLG ,
        ASSIGNED_TO ,
        INITIATOR_EMAIL ,
        RELATNSHIP_MGR ,
        BRN_NAME ,
        RM_CODE ,
        PRODUCT_CODE,
        RATE,
        REQUEST_DATE_MAIN,
        ACCOUNT_CLASS,
        CUSTOMER_NAME,
        CUSTOMER_ID,
        ACCT_NUM,
        CURRENCY,
        AVAILABLE_BALANCE,
        CUSTOMER_ADDRESS,
        CUSTOMER_EMAIL,
        MATURITY_DATE,
        VALUE_DATE,
        AMNT_FACE_VALUE ,
        IMAGE_NAME ,
        HOLD_DATE,
        RELEASED_DATE ,
        TENOR
      )
      VALUES
      (
        i_REQUEST_DATE ,
        i_MAKER_BRANCH ,
        i_MAKER_BRANCH_TIMESTAMP ,
        i_REQUEST_STATUS ,
        i_HOLD_FLG ,
        i_ASSIGNED_TO ,
        i_INITIATOR_EMAIL ,
        i_RELATNSHIP_MGR ,
        i_BRN_NAME ,
        i_RM_CODE ,
        i_PRODUCT_CODE,
        i_RATE,
        i_REQUEST_DATE_MAIN,
        i_ACCOUNT_CLASS,
        i_CUSTOMER_NAME,
        i_CUSTOMER_ID,
        i_ACCT_NUM,
        i_CURRENCY,
        i_AVAILABLE_BALANCE,
        i_CUSTOMER_ADDRESS,
        i_CUSTOMER_EMAIL,
        i_MATURITY_DATE,
        i_VALUE_DATE,
        i_AMNT_FACE_VALUE,
        i_IMAGE_NAME,
        i_HOLD_DATE ,
        i_RELEASED_DATE ,
        i_TENOR
      );
    COMMIT;
    RETURN '00';
  END;
  FUNCTION updatecustomerpremature
    (
      i_REQUEST_DATE                DATE,
      i_REFERENCE_NUM               VARCHAR2,
      i_CUSTOMER_NAME               VARCHAR2,
      i_CUSTOMER_ID                 VARCHAR2,
      i_REQUEST_TYPE                VARCHAR2,
      i_ACCT_NUM                    VARCHAR2,
      i_BRN_NAME                    VARCHAR2,
      i_REQUEST_STATUS              VARCHAR2,
      i_HOLD_FLG                    VARCHAR2,
      i_ASSIGNED_TO                 VARCHAR2,
      i_INITIATOR_EMAIL             VARCHAR2,
      i_RELATNSHIP_MGR              VARCHAR2,
      i_RM_CODE                     VARCHAR2,
      i_TENOR                       NUMBER,
      i_MAKER_BRANCH                VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP      TIMESTAMP,
      i_MATURITY_DATE               DATE,
      i_VALUE_DATE                  DATE,
      i_HOLD_REF_NUM                VARCHAR2,
      i_RESPONSE_CODE               VARCHAR2,
      i_RESPONSE_MESSAGE            VARCHAR2,
      i_INTEREST                    NUMBER,
      i_DISCOUNTED_AMOUNT           NUMBER,
      i_COMMISSION                  NUMBER,
      i_CUSTODY_FEE                 NUMBER,
      i_VAT_COMMISSION              NUMBER,
      i_VAT_CUSTODY_FEE             NUMBER,
      i_AMOUNT_HELD                 NUMBER,
      i_DEBIT_STATUS                VARCHAR2,
      i_RESPONSE_CODE_DISCOUNTED    VARCHAR2,
      i_RESPONSE_MESSAGE_DISCOUNTED VARCHAR2,
      i_DEBIT_DATE                  TIMESTAMP ,
      i_TREASURY_SALES_STATUS       VARCHAR2,
      i_CHECKER_BRANCH              VARCHAR2,
      i_CHECKER_BRANCH_TIMESTAMP    TIMESTAMP,
      i_MAKER_TSALES                VARCHAR2,
      i_MAKER_TSALES_TIMESTAMP      TIMESTAMP,
      i_CHECKER_TSALES              VARCHAR2,
      i_CHECKER_TSALES_TIMESTAMP    TIMESTAMP,
      i_MAKER_TROPS                 VARCHAR2,
      i_MAKER_TROPS_TIMESTAMP       TIMESTAMP,
      i_CHECKER_TROPS               VARCHAR2,
      i_CHECKER_TROPS_TIMESTAMP     TIMESTAMP,
      i_HOLD_REF_NUM_REMOVEHOLD     VARCHAR2,
      i_RESPONSE_CODE_REMOVEHOLD    VARCHAR2,
      i_RESPONSE_MESSAGE_REMOVEHOLD VARCHAR2,
      i_ACCOUNT_CLASS               VARCHAR2,
      i_CHARGES                     NUMBER,
      i_PROCESSING_FEE              NUMBER,
      i_REQUEST_DATE_MAIN           VARCHAR2,
      i_PRODUCT_CODE                VARCHAR2,
      i_RATE                        VARCHAR2
    )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_DATE             =i_REQUEST_DATE,
      CUSTOMER_NAME              = i_CUSTOMER_NAME,
      CUSTOMER_ID                = i_CUSTOMER_ID,
      REQUEST_TYPE               = i_REQUEST_TYPE,
      ACCT_NUM                   = i_ACCT_NUM,
      BRN_NAME                   = i_BRN_NAME,
      REQUEST_STATUS             =i_REQUEST_STATUS ,
      HOLD_FLG                   =i_HOLD_FLG ,
      ASSIGNED_TO                =i_ASSIGNED_TO ,
      INITIATOR_EMAIL            =i_INITIATOR_EMAIL ,
      RELATNSHIP_MGR             =i_RELATNSHIP_MGR ,
      RM_CODE                    =i_RM_CODE ,
      TENOR                      =i_TENOR,
      MAKER_BRANCH               =i_MAKER_BRANCH ,
      MAKER_BRANCH_TIMESTAMP     =i_MAKER_BRANCH_TIMESTAMP,
      MATURITY_DATE              = i_MATURITY_DATE ,
      VALUE_DATE                 =i_VALUE_DATE ,
      HOLD_REF_NUM               =i_HOLD_REF_NUM ,
      RESPONSE_CODE              =i_RESPONSE_CODE ,
      RESPONSE_MESSAGE           =i_RESPONSE_MESSAGE ,
      INTEREST                   =i_INTEREST ,
      DISCOUNTED_AMOUNT          =i_DISCOUNTED_AMOUNT ,
      COMMISSION                 =i_COMMISSION ,
      CUSTODY_FEE                =i_CUSTODY_FEE ,
      VAT_COMMISSION             =i_VAT_COMMISSION ,
      VAT_CUSTODY_FEE            =i_VAT_CUSTODY_FEE ,
      AMOUNT_HELD                =i_AMOUNT_HELD ,
      DEBIT_STATUS               =i_DEBIT_STATUS ,
      RESPONSE_CODE_DISCOUNTED   =i_RESPONSE_CODE_DISCOUNTED ,
      RESPONSE_MESSAGE_DISCOUNTED=i_RESPONSE_MESSAGE_DISCOUNTED ,
      DEBIT_DATE                 =i_DEBIT_DATE ,
      TREASURY_SALES_STATUS      =i_TREASURY_SALES_STATUS ,
      CHECKER_BRANCH             =i_CHECKER_BRANCH ,
      CHECKER_BRANCH_TIMESTAMP   =i_CHECKER_BRANCH_TIMESTAMP ,
      MAKER_TSALES               =i_MAKER_TSALES ,
      MAKER_TSALES_TIMESTAMP     =i_MAKER_TSALES_TIMESTAMP ,
      CHECKER_TSALES             =i_CHECKER_TSALES ,
      CHECKER_TSALES_TIMESTAMP   =i_CHECKER_TSALES_TIMESTAMP ,
      MAKER_TROPS                =i_MAKER_TROPS ,
      MAKER_TROPS_TIMESTAMP      =i_MAKER_TROPS_TIMESTAMP ,
      CHECKER_TROPS              =i_CHECKER_TROPS ,
      CHECKER_TROPS_TIMESTAMP    =i_CHECKER_TROPS_TIMESTAMP ,
      HOLD_REF_NUM_REMOVEHOLD    =i_HOLD_REF_NUM_REMOVEHOLD ,
      RESPONSE_CODE_REMOVEHOLD   =i_RESPONSE_CODE_REMOVEHOLD ,
      RESPONSE_MESSAGE_REMOVEHOLD=i_RESPONSE_MESSAGE_REMOVEHOLD ,
      ACCOUNT_CLASS              =i_ACCOUNT_CLASS ,
      CHARGES                    =i_CHARGES ,
      PROCESSING_FEE             =i_PROCESSING_FEE ,
      REQUEST_DATE_MAIN          =i_REQUEST_DATE_MAIN ,
      PRODUCT_CODE               =i_PRODUCT_CODE,
      RATE                       =i_RATE
    WHERE REFERENCE_NUM          = i_REFERENCE_NUM;
    v_response                  := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION updateTransaction(
      p_ref_num VARCHAR2)
    RETURN VARCHAR2
  IS
    i_REQUEST_STATUS   VARCHAR2(255 BYTE);
    i_REQUEST_TYPE     VARCHAR2(255 BYTE);
    v_response         VARCHAR2(255 BYTE);
    i_CUSTOMER_NAME    VARCHAR2(255 BYTE);
    i_CUSTOMER_ID      VARCHAR2(255 BYTE);
    i_ACCT_NUM         VARCHAR2(10 BYTE);
    i_BRN_NAME         VARCHAR2(255 BYTE);
    i_CUSTOMER_ADDRESS VARCHAR2(255 BYTE);
    i_REFERENCE_NUM    VARCHAR2(255 BYTE);
    i_AMNT_FACE_VALUE  VARCHAR2(100 BYTE);
    i_AMNT_ROLL_OVER   VARCHAR2(100 BYTE);
    i_TENOR            NUMBER(19,0);
    i_RATE             NUMBER(13,10);
    i_REQUEST_DATE     DATE;
    i_IMAGE_NAME       VARCHAR2(255 BYTE);
    i_RELATNSHIP_MGR   VARCHAR2(255 BYTE);
    i_RM_CODE          VARCHAR2(10 BYTE);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  = i_REQUEST_STATUS,
      REQUEST_TYPE      = i_REQUEST_TYPE,
      CUSTOMER_NAME     = i_CUSTOMER_NAME,
      CUSTOMER_ID       = i_CUSTOMER_ID,
      ACCT_NUM          = i_ACCT_NUM,
      BRN_NAME          =i_BRN_NAME,
      CUSTOMER_ADDRESS  = i_CUSTOMER_ADDRESS,
      REFERENCE_NUM     = i_REFERENCE_NUM,
      AMNT_FACE_VALUE   = i_AMNT_FACE_VALUE,
      AMNT_ROLL_OVER    = i_AMNT_ROLL_OVER,
      TENOR             =i_TENOR,
      RATE              = i_RATE,
      REQUEST_DATE      = i_REQUEST_DATE,
      IMAGE_NAME        = i_IMAGE_NAME,
      RELATNSHIP_MGR    = i_RELATNSHIP_MGR,
      RM_CODE           =i_RM_CODE
    WHERE REFERENCE_NUM = p_ref_num;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION updatevaluematuritydate(
      i_MATURITY_DATE         DATE,
      i_VALUE_DATE            DATE,
      i_TREASURY_SALES_STATUS VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_MAKER_TROPS           VARCHAR2,
      --i_MAKER_TROPS_TIMESTAMP       TIMESTAMP,
      i_REQUEST_DATE  DATE,
      i_REFERENCE_NUM VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET MATURITY_DATE      =i_MATURITY_DATE ,
      VALUE_DATE           =i_VALUE_DATE ,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS ,
      REQUEST_STATUS       =i_REQUEST_STATUS ,
      MAKER_TROPS          =i_MAKER_TROPS,
      --MAKER_TROPS_TIMESTAMP=i_MAKER_TROPS_TIMESTAMP,
      REQUEST_DATE      =i_REQUEST_DATE
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesNewRoll(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesPrem(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesSec(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesNewRollRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesPremRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesSecRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsales(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTROPsAuthToProcSec(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2,
      i_HOLD_FLG              VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      HOLD_FLG             =i_HOLD_FLG ,
      TREASURY_SALES_STATUS='RATE_APPLIED_INIT/ITEMS_CALCULATED'
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTROPsAuthToProcSecRej(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2,
      i_HOLD_FLG              VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      HOLD_FLG             =i_HOLD_FLG ,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTROPsAuthToProcPre(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTROPsAuthToProcPreRej(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTROPsAuthToProcWC(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTROPsAuthToProcWCR(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTROPsAuthToProcSR(
      i_REFERENCE_NUM    VARCHAR2,
      i_REQUEST_STATUS   VARCHAR2,
      i_STOP_RATE_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      STOP_RATE_STATUS  =i_STOP_RATE_STATUS
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTROPsAuthToProcNewRoll(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_HOLD_FLG              VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      HOLD_FLG             =i_HOLD_FLG ,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTROPsAuthToProcNRR(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_HOLD_FLG              VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS     =i_REQUEST_STATUS,
      HOLD_FLG             =i_HOLD_FLG ,
      TREASURY_SALES_STATUS=i_TREASURY_SALES_STATUS
    WHERE REFERENCE_NUM    = i_REFERENCE_NUM;
    v_response            := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesPre(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS,
      HOLD_FLG          =i_HOLD_FLG
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpTranTsalesNewRollRejTSA(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpdateTranTsalesPreRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET REQUEST_STATUS  =i_REQUEST_STATUS
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    v_response         := '00';
    COMMIT;
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION savebidstatus(
      i_REQUEST_DATE           DATE,
      i_MAKER_TSALES           VARCHAR2,
      i_MAKER_TSALES_TIMESTAMP TIMESTAMP ,
      i_REQUEST_STATUS         VARCHAR2,
      i_TREASURY_SALES_STATUS  VARCHAR2,
      i_BID_STATUS             VARCHAR2 )
    RETURN VARCHAR2
  AS
  BEGIN
    INSERT
    INTO TREASURY_BILLS_REQ
      (
        REQUEST_DATE ,
        MAKER_TSALES ,
        MAKER_TSALES_TIMESTAMP ,
        REQUEST_STATUS ,
        TREASURY_SALES_STATUS ,
        BID_STATUS
      )
      VALUES
      (
        i_REQUEST_DATE ,
        i_MAKER_TSALES ,
        i_MAKER_TSALES_TIMESTAMP ,
        i_REQUEST_STATUS ,
        i_TREASURY_SALES_STATUS ,
        i_BID_STATUS
      );
    COMMIT;
    RETURN '00';
  END;
  FUNCTION saveCustomerRollover
    (
      i_REFERENCE_NUM               VARCHAR2,
      i_REQUEST_DATE                DATE,
      i_MAKER_BRANCH                VARCHAR2,
      i_MAKER_BRANCH_TIMESTAMP      TIMESTAMP,
      i_REQUEST_STATUS              VARCHAR2,
      i_HOLD_FLG                    VARCHAR2,
      i_ASSIGNED_TO                 VARCHAR2,
      i_INITIATOR_EMAIL             VARCHAR2,
      i_RELATNSHIP_MGR              VARCHAR2,
      i_BRN_NAME                    VARCHAR2,
      i_RM_CODE                     VARCHAR2,
      i_REQUEST_TYPE                VARCHAR2,
      i_HOLD_REF_NUM                VARCHAR2,
      i_RESPONSE_CODE               VARCHAR2,
      i_RESPONSE_MESSAGE            VARCHAR2,
      i_INTEREST                    NUMBER,
      i_DISCOUNTED_AMOUNT           NUMBER,
      i_COMMISSION                  NUMBER,
      i_CUSTODY_FEE                 NUMBER,
      i_VAT_COMMISSION              NUMBER,
      i_VAT_CUSTODY_FEE             NUMBER,
      i_AMOUNT_HELD                 NUMBER,
      i_DEBIT_STATUS                VARCHAR2,
      i_RESPONSE_CODE_DISCOUNTED    VARCHAR2,
      i_RESPONSE_MESSAGE_DISCOUNTED VARCHAR2,
      i_DEBIT_DATE                  TIMESTAMP ,
      i_TREASURY_SALES_STATUS       VARCHAR2,
      i_CHECKER_BRANCH              VARCHAR2,
      i_CHECKER_BRANCH_TIMESTAMP    TIMESTAMP,
      i_MAKER_TSALES                VARCHAR2,
      i_MAKER_TSALES_TIMESTAMP      TIMESTAMP,
      i_CHECKER_TSALES              VARCHAR2,
      i_CHECKER_TSALES_TIMESTAMP    TIMESTAMP,
      i_MAKER_TROPS                 VARCHAR2,
      i_MAKER_TROPS_TIMESTAMP       TIMESTAMP,
      i_CHECKER_TROPS               VARCHAR2,
      i_CHECKER_TROPS_TIMESTAMP     TIMESTAMP,
      i_HOLD_REF_NUM_REMOVEHOLD     VARCHAR2,
      i_RESPONSE_CODE_REMOVEHOLD    VARCHAR2,
      i_RESPONSE_MESSAGE_REMOVEHOLD VARCHAR2,
      i_ACCOUNT_CLASS               VARCHAR2,
      i_CHARGES                     NUMBER,
      i_PROCESSING_FEE              NUMBER,
      i_REQUEST_DATE_MAIN           VARCHAR2,
      i_PRODUCT_CODE                VARCHAR2,
      i_AMNT_ROLL_OVER              VARCHAR2,
      i_TENOR                       NUMBER,
      i_HOLD_DATE                   TIMESTAMP,
      i_RELEASED_DATE               TIMESTAMP,
      i_RATE                        NUMBER
    )
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET REQUEST_DATE             =i_REQUEST_DATE ,
      MAKER_BRANCH               =i_MAKER_BRANCH ,
      MAKER_BRANCH_TIMESTAMP     =i_MAKER_BRANCH_TIMESTAMP ,
      REQUEST_STATUS             =i_REQUEST_STATUS ,
      HOLD_FLG                   =i_HOLD_FLG ,
      ASSIGNED_TO                =i_ASSIGNED_TO ,
      INITIATOR_EMAIL            =i_INITIATOR_EMAIL ,
      RELATNSHIP_MGR             =i_RELATNSHIP_MGR ,
      BRN_NAME                   =i_BRN_NAME,
      RM_CODE                    =i_RM_CODE ,
      REQUEST_TYPE               =i_REQUEST_TYPE ,
      HOLD_REF_NUM               =i_HOLD_REF_NUM ,
      RESPONSE_CODE              =i_RESPONSE_CODE ,
      RESPONSE_MESSAGE           =i_RESPONSE_MESSAGE ,
      INTEREST                   =i_INTEREST ,
      DISCOUNTED_AMOUNT          =i_DISCOUNTED_AMOUNT ,
      COMMISSION                 =i_COMMISSION ,
      CUSTODY_FEE                =i_CUSTODY_FEE ,
      VAT_COMMISSION             =i_VAT_COMMISSION ,
      VAT_CUSTODY_FEE            =i_VAT_CUSTODY_FEE ,
      AMOUNT_HELD                =i_AMOUNT_HELD ,
      DEBIT_STATUS               =i_DEBIT_STATUS ,
      RESPONSE_CODE_DISCOUNTED   =i_RESPONSE_CODE_DISCOUNTED ,
      RESPONSE_MESSAGE_DISCOUNTED=i_RESPONSE_MESSAGE_DISCOUNTED ,
      DEBIT_DATE                 =i_DEBIT_DATE ,
      TREASURY_SALES_STATUS      =i_TREASURY_SALES_STATUS ,
      CHECKER_BRANCH             =i_CHECKER_BRANCH ,
      CHECKER_BRANCH_TIMESTAMP   =i_CHECKER_BRANCH_TIMESTAMP ,
      MAKER_TSALES               =i_MAKER_TSALES ,
      MAKER_TSALES_TIMESTAMP     =i_MAKER_TSALES_TIMESTAMP ,
      CHECKER_TSALES             =i_CHECKER_TSALES ,
      CHECKER_TSALES_TIMESTAMP   =i_CHECKER_TSALES_TIMESTAMP ,
      MAKER_TROPS                =i_MAKER_TROPS ,
      MAKER_TROPS_TIMESTAMP      =i_MAKER_TROPS_TIMESTAMP ,
      CHECKER_TROPS              =i_CHECKER_TROPS ,
      CHECKER_TROPS_TIMESTAMP    =i_CHECKER_TROPS_TIMESTAMP ,
      HOLD_REF_NUM_REMOVEHOLD    =i_HOLD_REF_NUM_REMOVEHOLD ,
      RESPONSE_CODE_REMOVEHOLD   =i_RESPONSE_CODE_REMOVEHOLD ,
      RESPONSE_MESSAGE_REMOVEHOLD=i_RESPONSE_MESSAGE_REMOVEHOLD ,
      ACCOUNT_CLASS              =i_ACCOUNT_CLASS ,
      CHARGES                    =i_CHARGES ,
      PROCESSING_FEE             =i_PROCESSING_FEE ,
      REQUEST_DATE_MAIN          =i_REQUEST_DATE_MAIN ,
      PRODUCT_CODE               =i_PRODUCT_CODE ,
      AMNT_ROLL_OVER             =i_AMNT_ROLL_OVER,
      TENOR                      =i_TENOR,
      HOLD_DATE                  =i_HOLD_DATE,
      RELEASED_DATE              =i_RELEASED_DATE ,
      RATE                       =i_RATE
    WHERE a.REFERENCE_NUM        = i_REFERENCE_NUM;
    COMMIT;
    RETURN '00';
  END;
  FUNCTION saveCustomerRolloverTrops(
      i_REFERENCE_NUM         VARCHAR2,
      i_DISCOUNTED_AMOUNT     NUMBER,
      i_CUSTODY_FEE           NUMBER,
      i_VAT_CUSTODY_FEE       NUMBER,
      i_TENOR                 NUMBER,
      i_REQUEST_DATE          DATE,
      i_MAKER_TROPS           VARCHAR2,
      i_MAKER_TROPS_TIMESTAMP TIMESTAMP,
      i_REQUEST_STATUS        VARCHAR2,
      i_HOLD_FLG_COLLAT       VARCHAR2,
      i_REQUEST_TYPE          VARCHAR2 )
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET DISCOUNTED_AMOUNT  =i_DISCOUNTED_AMOUNT ,
      CUSTODY_FEE          =i_CUSTODY_FEE ,
      VAT_CUSTODY_FEE      =i_VAT_CUSTODY_FEE ,
      TENOR                =i_TENOR ,
      REQUEST_DATE         =i_REQUEST_DATE ,
      MAKER_TROPS          =i_MAKER_TROPS ,
      MAKER_TROPS_TIMESTAMP=i_MAKER_TROPS_TIMESTAMP ,
      REQUEST_STATUS       =i_REQUEST_STATUS ,
      HOLD_FLG_COLLAT      =i_HOLD_FLG_COLLAT ,
      REQUEST_TYPE         =i_REQUEST_TYPE
    WHERE a.REFERENCE_NUM  = i_REFERENCE_NUM;
    COMMIT;
    RETURN '00';
  END;
  FUNCTION saveCustomerInvestment(
      i_REFERENCE_NUM VARCHAR2,
      i_PRINT_LETTER  VARCHAR2 )
    RETURN VARCHAR2
  AS
  BEGIN
    UPDATE TREASURY_BILLS_REQ a
    SET PRINT_LETTER      =i_PRINT_LETTER
    WHERE a.REFERENCE_NUM = i_REFERENCE_NUM;
    COMMIT;
    RETURN '00';
  END;
  FUNCTION UpLienRemovalFailTROPA(
      i_REFERENCE_NUM VARCHAR2,
      i_RESP_CODE     VARCHAR2,
      i_RESP_MESSAGE  VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_REMOVEHOLD  =i_RESP_CODE,
      RESPONSE_MESSAGE_REMOVEHOLD =i_RESP_MESSAGE
    WHERE REFERENCE_NUM           = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpLienRemSuccTROPA(
      i_REFERENCE_NUM       VARCHAR2,
      i_RESP_CODE           VARCHAR2,
      i_RESP_MESSAGE        VARCHAR2,
      i_CHECKER_TROPS       VARCHAR2,
      i_MAKER_TROPS         VARCHAR2,
      i_HOLD_REFNUM_REMHOLD VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_REMOVEHOLD  =i_RESP_CODE,
      RESPONSE_MESSAGE_REMOVEHOLD =i_RESP_MESSAGE,
      HOLD_REF_NUM_REMOVEHOLD     =i_HOLD_REFNUM_REMHOLD,
      REQUEST_STATUS              ='REMOVED_HOLD',
      HOLD_FLG                    ='HOLD_REMOVED',
      MAKER_TROPS                 =i_MAKER_TROPS,
      CHECKER_TROPS               =i_CHECKER_TROPS,
      CHECKER_TROPS_TIMESTAMP     = sysdate
    WHERE REFERENCE_NUM           = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION UpPostingFailTROPA(
      i_REFERENCE_NUM VARCHAR2,
      i_RESP_CODE     VARCHAR2,
      i_RESP_MESSAGE  VARCHAR2,
      i_CHECKER_TROPS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_DISCOUNTED  =i_RESP_CODE,
      RESPONSE_MESSAGE_DISCOUNTED =i_RESP_MESSAGE,
      CHECKER_TROPS               =i_CHECKER_TROPS,
      CHECKER_TROPS_TIMESTAMP     =SYSDATE
    WHERE REFERENCE_NUM           = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION HoldRemovalSuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE      VARCHAR2,
      i_RESP_MESSAGE   VARCHAR2,
      i_HOLD_REF_NUM   VARCHAR2,
      i_AMOUNT_HELD    NUMBER,
      i_CHECKER_BRANCH VARCHAR2,
      i_BRN_NAME       VARCHAR2)
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE         =i_RESP_CODE,
      RESPONSE_MESSAGE        =i_RESP_MESSAGE,
      HOLD_REF_NUM            =i_HOLD_REF_NUM,
      REQUEST_STATUS          ='PROCESSING_TROPS_SECONDARY',
      HOLD_FLG                ='HOLD',
      AMOUNT_HELD             =i_AMOUNT_HELD,
      CHECKER_BRANCH          =i_CHECKER_BRANCH,
      CHECKER_BRANCH_TIMESTAMP=SYSDATE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM
    AND REQUEST_TYPE          ='Secondary_Market'
    AND REQUEST_STATUS        ='REMOVED_HOLD'
    AND BRN_NAME              =i_BRN_NAME;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION PostingSuccTROPA(
      i_REFERENCE_NUM   VARCHAR2,
      i_RESP_CODE       VARCHAR2,
      i_RESP_MESSAGE    VARCHAR2,
      i_INITIATOR_EMAIL VARCHAR2,
      i_MAKER_TROPS     VARCHAR2,
      i_CUSTOMER_EMAIL  VARCHAR2,
      i_CHECKER_TROPS   VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_DISCOUNTED  =i_RESP_CODE,
      RESPONSE_MESSAGE_DISCOUNTED =i_RESP_MESSAGE,
      REQUEST_STATUS              ='RUNNING_INVESTMENT',
      DEBIT_STATUS                ='ACCOUNT_DEBITED',
      INITIATOR_EMAIL             =i_INITIATOR_EMAIL,
      MAKER_TROPS                 =i_MAKER_TROPS,
      CUSTOMER_EMAIL              =i_CUSTOMER_EMAIL,
      CHECKER_TROPS               =i_CHECKER_TROPS,
      CHECKER_TROPS_TIMESTAMP     =SYSDATE,
      DEBIT_DATE                  =SYSDATE
    WHERE REFERENCE_NUM           = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION CreditCustMATINVSuccTROPA(
      i_REFERENCE_NUM          VARCHAR2,
      i_RESP_CODE              VARCHAR2,
      i_RESP_MESSAGE           VARCHAR2,
      i_convertedAmntFaceValue NUMBER,
      i_INITIATOR_EMAIL        VARCHAR2,
      i_CUSTOMER_EMAIL         VARCHAR2,
      i_CHECKER_TROPS          VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_CREDIT  =i_RESP_CODE,
      RESPONSE_MESSAGE_CREDIT =i_RESP_MESSAGE,
      REQUEST_STATUS          ='RUNNING_INVESTMENT_CREDITED',
      CREDIT_STATUS           ='ACCOUNT_CREDITED',
      AMOUNT_CREDITED         =i_convertedAmntFaceValue,
      INITIATOR_EMAIL         =i_INITIATOR_EMAIL,
      CUSTOMER_EMAIL          =i_CUSTOMER_EMAIL,
      CHECKER_TROPS           =i_CHECKER_TROPS,
      CHECKER_TROPS_TIMESTAMP =SYSDATE,
      CREDIT_DATE             =SYSDATE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION CreditCustMATINVFailTROPA(
      i_REFERENCE_NUM VARCHAR2,
      i_RESP_CODE     VARCHAR2,
      i_RESP_MESSAGE  VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_CREDIT  =i_RESP_CODE,
      RESPONSE_MESSAGE_CREDIT =i_RESP_MESSAGE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION CreditMATINVCOLLSuccTROPA(
      i_REFERENCE_NUM VARCHAR2,
      i_RESP_CODE     VARCHAR2,
      i_RESP_MESSAGE  VARCHAR2,
      i_AMOUNT_HELD   NUMBER,
      i_CHECKER_TROPS VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_CREDIT  =i_RESP_CODE,
      RESPONSE_MESSAGE_CREDIT =i_RESP_MESSAGE,
      REQUEST_STATUS          ='RUNNING_INVESTMENT_CREDITED_COLLAT',
      CREDIT_STATUS           ='ACCOUNT_CREDITED_COLLATERAL',
      AMOUNT_CREDITED         =i_AMOUNT_HELD,
      CHECKER_TROPS           =i_CHECKER_TROPS,
      CHECKER_TROPS_TIMESTAMP =SYSDATE,
      CREDIT_DATE             =SYSDATE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  FUNCTION CreditMATINVPRESuccTROPA(
      i_REFERENCE_NUM     VARCHAR2,
      i_RESP_CODE         VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
      i_AMOUNT_DISCOUNTED NUMBER,
      i_INITIATOR_EMAIL   VARCHAR2,
      i_CUSTOMER_EMAIL    VARCHAR2,
      i_CHECKER_TROPS     VARCHAR2 )
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE_CREDIT  =i_RESP_CODE,
      RESPONSE_MESSAGE_CREDIT =i_RESP_MESSAGE,
      REQUEST_STATUS          ='PROCESSED_PREMATURE_ACCOUNT_CREDITED',
      CREDIT_STATUS           ='ACCOUNT_CREDITED',
      AMOUNT_CREDITED         =i_AMOUNT_DISCOUNTED,
      INITIATOR_EMAIL         =i_INITIATOR_EMAIL,
      CUSTOMER_EMAIL          =i_CUSTOMER_EMAIL,
      CHECKER_TROPS           =i_CHECKER_TROPS,
      HOLD_FLG                ='HOLD_REMOVED',
      CHECKER_TROPS_TIMESTAMP =SYSDATE,
      CREDIT_DATE             =SYSDATE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  
  FUNCTION uploadSecondaryMarketRate(
        P_MATURITY_DATE VARCHAR2,
        P_TENOR NUMBER,
        P_AMOUNT_VALUE NUMBER,
        P_RATE FLOAT
    )
  RETURN VARCHAR2
    IS
    V_RESPONSE VARCHAR2(100);
    V_REFERENCE_ID VARCHAR2(100);
    BEGIN
        V_REFERENCE_ID := 'SM' || P_MATURITY_DATE;
        INSERT INTO
        NEWIBANK.TREASURY_BILLS_RATES (
            REFERENCE_ID,
            MATURITY_DATE,
            TENOR,
            AMOUNT_VALUE,
            RATE,
            REQUEST_TYPE,
            REQUEST_STATUS
        )
        VALUES (
            V_REFERENCE_ID,
            P_MATURITY_DATE,
            P_TENOR,
            P_AMOUNT_VALUE,
            P_RATE,
            'SECONDARY_MARKET',
            'PENDING_AUTHORISATION'
        );
        COMMIT;
        V_RESPONSE := V_REFERENCE_ID || '--SUCCESSFULLY SAVED';
        RETURN V_RESPONSE;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            V_RESPONSE := '99' || '--UNSUCCESSFUL';
            RETURN V_RESPONSE;
          END;
--printInvestmentLetter





-----------Newly added to the package for the Approval page-----
FUNCTION approvalListSecMarketRequest(P_BRN_NAME varchar2)
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ where REQUEST_TYPE = 'Secondary_Market' and request_Status='NEW' and BRN_NAME = P_BRN_NAME;
    RETURN c_result;
  END;
  
  FUNCTION initiateCollateralLien(
      i_REFERENCE_NUM  VARCHAR2,
      i_MAKER_TROPS VARCHAR2)
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET MAKER_TROPS = i_MAKER_TROPS ,
    
      HOLD_FLG_COLLAT = 'PLACING_HOLD_COLLATERAL',
      REQUEST_STATUS = 'PROCESSING_HOLD_COLLATERAL',
      REQUEST_DATE = SYSDATE,
      MAKER_TROPS_TIMESTAMP = SYSDATE
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  
    FUNCTION removeCollateralLien(
      i_REFERENCE_NUM  VARCHAR2,
      i_MAKER_TROPS VARCHAR2)
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET MAKER_TROPS = i_MAKER_TROPS ,
    
      HOLD_FLG_COLLAT = 'REMOVING_HOLD_COLLATERAL',
      REQUEST_STATUS = 'PROCESSING_HOLD_COLLATERAL',
      REQUEST_DATE = SYSDATE,
      MAKER_TROPS_TIMESTAMP = SYSDATE
    WHERE REFERENCE_NUM = i_REFERENCE_NUM;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  
  
  
  
  
  
   FUNCTION UpdateSecMarketAfterApproval(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE      VARCHAR2,
      i_RESP_MESSAGE   VARCHAR2,
      i_HOLD_REF_NUM   VARCHAR2,
      i_CHECKER_BRANCH VARCHAR2,
      i_BRN_NAME       VARCHAR2,
	  i_COMMENT_BRANCH_SUP VARCHAR2)
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET RESPONSE_CODE         =i_RESP_CODE,
      RESPONSE_MESSAGE        =i_RESP_MESSAGE,
      HOLD_REF_NUM            =i_HOLD_REF_NUM,
      REQUEST_STATUS          ='AUTHORIZED_BRANCH',
      HOLD_FLG                ='HOLD',
	  COMMENT_BRANCH_SUP      =i_COMMENT_BRANCH_SUP,
      CHECKER_BRANCH          =i_CHECKER_BRANCH,
      CHECKER_BRANCH_TIMESTAMP=SYSDATE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM
    AND REQUEST_TYPE          ='Secondary_Market'
    AND REQUEST_STATUS        ='NEW'
    AND BRN_NAME              =i_BRN_NAME;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  
  
 
   FUNCTION UpdateSecMarketAferRejection(
      i_REFERENCE_NUM  VARCHAR2,
      i_COMMENT_BRANCH_SUP   VARCHAR2,
      i_CHECKER_BRANCH VARCHAR2,
      i_BRN_NAME       VARCHAR2)
    RETURN VARCHAR2
  IS
    v_response VARCHAR2(100);
  BEGIN
    UPDATE TREASURY_BILLS_REQ
    SET 
      COMMENT_BRANCH_SUP      =i_COMMENT_BRANCH_SUP,
      REQUEST_STATUS          ='REJECT_BRANCH',
      HOLD_FLG                ='NOT_HELD',
      CHECKER_BRANCH          =i_CHECKER_BRANCH,
      CHECKER_BRANCH_TIMESTAMP=SYSDATE
    WHERE REFERENCE_NUM       = i_REFERENCE_NUM
    AND REQUEST_TYPE          ='Secondary_Market'
    AND REQUEST_STATUS        ='NEW'
    AND BRN_NAME              =i_BRN_NAME;
    COMMIT;
    v_response := '00';
    RETURN v_response;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    v_response := '99';
    RETURN v_response;
  END;
  
  
  
  FUNCTION MaturedInvPendingCredit(P_MATURITY_DATE varchar2,P_REQUEST_TYPE varchar2)
    RETURN SYS_REFCURSOR
  AS
    c_result SYS_REFCURSOR;
  BEGIN
    OPEN c_result FOR SELECT * FROM TREASURY_BILLS_REQ where trunc(MATURITY_DATE) = P_MATURITY_DATE and request_Status = 'RUNNING_INVESTMENT' and hold_flg = 'HOLD_REMOVED' and request_type=P_REQUEST_TYPE;
    RETURN c_result;
  END;
  
END treasury_pkg;