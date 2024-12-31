create or replace PACKAGE          treasury_pkg
AS
  PROCEDURE insertAuditLog(
      pretnum OUT NUMBER,
      staffno   IN VARCHAR2,
      event     IN VARCHAR2,
      createdBy IN VARCHAR2,
      eventRef  IN VARCHAR2,
      serverip  IN VARCHAR2 );
  FUNCTION fetchCancel(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchCollateralizedDetails(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchRefFactsDelsPremature(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchRefNoFactsDetails(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchDetailsInvestmentLetter(
      p_contractnum VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchTreasurySalesReport(
      p_start_date DATE,
      p_end_date   DATE)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchRefnoFactsRollTrops(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchRefnoFactsDetailsRoll(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchRefnoDetails(
      p_ref_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchDetails(
      p_acct_number VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION searchAcctDetails(
      p_acct_num VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION searchRefNumDetails(
      p_ref_num VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchContractMaturityDate(
      p_start_date DATE,
      p_end_date   DATE)
    RETURN SYS_REFCURSOR;
  FUNCTION fetchContractRequestDate(
      p_start_date DATE,
      p_end_date   DATE)
    RETURN SYS_REFCURSOR;
  FUNCTION getCurrentDate
    RETURN SYS_REFCURSOR;
  FUNCTION getcustomersDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION gettotalInitiatorReportDaoList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION gettotalAutRptDaoList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION totalAuthRrtForTSViewDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION getauthorizerequestsDAOList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION getauthreqCancelDAOList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION getauthreqPrematureBrnDAOList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION getauthreqsecBrhDAOList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION getauthreqRollBrhDAOList(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION getauthreqRollTropsDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION getauthreqTreasuryDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION getCreditCustomerList
    RETURN SYS_REFCURSOR;
  FUNCTION viewAllException
    RETURN SYS_REFCURSOR;
  FUNCTION viewRejectedBrhandSaved(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION viewAllRejTransByTROPStoTsales
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTsalesAutoTssAuProPrem
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTsalesAutoTssProSec
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTROPSsAutoTroProNR
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTROPSsAutoTroProPM
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTROPSsAutoTroProSec
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTROPSsAutoTroProWC
    RETURN SYS_REFCURSOR;
  FUNCTION vARejByTROPSsAutoTroTsalePr
    RETURN SYS_REFCURSOR;
  FUNCTION viewAllUnliened
    RETURN SYS_REFCURSOR;
  FUNCTION viewAllInvestmentsBranch(
      p_brn_name VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION viewAllWaived
    RETURN SYS_REFCURSOR;
  FUNCTION viewAllUnsuccessfulBids
    RETURN SYS_REFCURSOR;
  FUNCTION totalreportDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalreportRateDAOList91
    RETURN SYS_REFCURSOR;
  FUNCTION totalreportRateDAOList182
    RETURN SYS_REFCURSOR;
  FUNCTION totalreportRateDAOList364
    RETURN SYS_REFCURSOR;
  FUNCTION totalreportPrematureDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrepPreAuthorizeDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION removeholdNewDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION removeHoldSecondaryDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalreportSecMarketDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptAuthDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptTrsryOpsBidDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptTrsryOpsDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION ttlrptTrsyOpsSRDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptTrsyOps91DAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptTrsyOps182DAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptTrsyOps364DAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptauthTrsyOpsDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION fetchSRDetailsDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION totalrptauthTrsyOpsSRAuthDAO
    RETURN SYS_REFCURSOR;
  FUNCTION ttlrptauthTrsyOpsSRAuthsUnDAO
    RETURN SYS_REFCURSOR;
  FUNCTION ttlrptSecMrtTROPsDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION ttlrptSecMktTROPsAuthDAOList
    RETURN SYS_REFCURSOR;
  FUNCTION ttlrptWvComTROPSAuthDAO
    RETURN SYS_REFCURSOR;
  FUNCTION printInvestmentLetter
    RETURN SYS_REFCURSOR;
  FUNCTION treasurybillreq(
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
      i_PROCESSING_FEE              NUMBER )
    RETURN VARCHAR2;
  FUNCTION updatecustomerprematture(
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
      i_REQUEST_TYPE           VARCHAR2)
    RETURN VARCHAR2;
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
    RETURN VARCHAR2;
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
    RETURN VARCHAR2;
  FUNCTION updatecustomerinvestment(
      i_REFERENCE_NUM VARCHAR2,
      i_PRINT_LETTER  VARCHAR2 )
    RETURN VARCHAR2;
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
      i_IMAGE_NAME             VARCHAR2,
      i_HOLD_DATE              TIMESTAMP,
      i_RELEASED_DATE          TIMESTAMP)
    RETURN VARCHAR2;
  FUNCTION savecustomerforlater(
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
      i_IMAGE_NAME             VARCHAR2,
      i_HOLD_DATE              TIMESTAMP,
      i_RELEASED_DATE          TIMESTAMP,
      i_TENOR                  NUMBER)
    RETURN VARCHAR2;
  FUNCTION updatecustomerpremature(
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
      i_RATE               VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION updatevaluematuritydate(
      i_MATURITY_DATE         DATE,
      i_VALUE_DATE            DATE,
      i_TREASURY_SALES_STATUS VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2 ,
      i_MAKER_TROPS           VARCHAR2,
      --i_MAKER_TROPS_TIMESTAMP       TIMESTAMP,
      i_REQUEST_DATE  DATE,
      i_REFERENCE_NUM VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTsalesNewRoll(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION UpdateTranTsalesPrem(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2 ;
  
  FUNCTION UpdateTranTsalesNewRollRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTsalesPremRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTsalesSecRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTsales(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTsalesRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTROPsAuthToProcSec(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2,
      i_HOLD_FLG              VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpTranTROPsAuthToProcSecRej(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2,
      i_HOLD_FLG              VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTROPsAuthToProcPre(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpTranTROPsAuthToProcPreRej(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpTranTROPsAuthToProcWC(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpTranTROPsAuthToProcWCR(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpdateTranTROPsAuthToProcSR(
      i_REFERENCE_NUM    VARCHAR2,
      i_REQUEST_STATUS   VARCHAR2,
      i_STOP_RATE_STATUS VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION UpTranTROPsAuthToProcNewRoll(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_HOLD_FLG              VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION UpTranTROPsAuthToProcNRR(
      i_REFERENCE_NUM         VARCHAR2,
      i_REQUEST_STATUS        VARCHAR2,
      i_HOLD_FLG              VARCHAR2,
      i_TREASURY_SALES_STATUS VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION UpdateTranTsalesPre(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION UpTranTsalesNewRollRejTSA(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION UpdateTranTsalesPreRej(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2 )
    RETURN VARCHAR2 ;
  FUNCTION savebidstatus(
      i_REQUEST_DATE           DATE,
      i_MAKER_TSALES           VARCHAR2,
      i_MAKER_TSALES_TIMESTAMP TIMESTAMP ,
      i_REQUEST_STATUS         VARCHAR2,
      i_TREASURY_SALES_STATUS  VARCHAR2,
      i_BID_STATUS             VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION saveCustomerRollover(
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
      i_RATE                        NUMBER )
    RETURN VARCHAR2;
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
    RETURN VARCHAR2;
  FUNCTION saveCustomerInvestment(
      i_REFERENCE_NUM VARCHAR2,
      i_PRINT_LETTER  VARCHAR2 )
    RETURN VARCHAR2;
  FUNCTION updateTransaction(
      p_ref_num VARCHAR2)
    RETURN VARCHAR2;
    FUNCTION UpdateTranTsalesSec(
      i_REFERENCE_NUM  VARCHAR2,
      i_REQUEST_STATUS VARCHAR2,
      i_HOLD_FLG       VARCHAR2 )
    RETURN VARCHAR2;
    
     FUNCTION UpLienRemovalFailTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2 )
    RETURN VARCHAR2;
  
  
   FUNCTION UpLienRemSuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
i_CHECKER_TROPS VARCHAR2,
i_MAKER_TROPS VARCHAR2,
i_HOLD_REFNUM_REMHOLD VARCHAR2
  )
    RETURN VARCHAR2;
	
	
	FUNCTION UpPostingFailTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
i_CHECKER_TROPS VARCHAR2	  )
    RETURN VARCHAR2;
	
	

	
	FUNCTION HoldRemovalSuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
	  i_HOLD_REF_NUM VARCHAR2,
	  i_AMOUNT_HELD NUMBER,
	  i_CHECKER_BRANCH VARCHAR2,
	  i_BRN_NAME VARCHAR2 )
    RETURN VARCHAR2;
	
FUNCTION PostingSuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
	  i_INITIATOR_EMAIL VARCHAR2,
	  i_MAKER_TROPS VARCHAR2,
	  i_CUSTOMER_EMAIL VARCHAR2,
	  i_CHECKER_TROPS VARCHAR2
	  )
    RETURN VARCHAR2;
FUNCTION CreditCustMATINVSuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
	  i_convertedAmntFaceValue NUMBER,
	  i_INITIATOR_EMAIL VARCHAR2,
	  i_CUSTOMER_EMAIL VARCHAR2,
	  i_CHECKER_TROPS VARCHAR2
	  )
    RETURN VARCHAR2;
	
	FUNCTION CreditCustMATINVFailTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2
	  )
    RETURN VARCHAR2;

	
	FUNCTION CreditMATINVCOLLSuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
	  i_AMOUNT_HELD NUMBER,
	  i_CHECKER_TROPS VARCHAR2
	  )
    RETURN VARCHAR2;
	
	FUNCTION CreditMATINVPRESuccTROPA(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE VARCHAR2,
      i_RESP_MESSAGE      VARCHAR2,
	  i_AMOUNT_DISCOUNTED NUMBER,
	  i_INITIATOR_EMAIL      VARCHAR2,
	  i_CUSTOMER_EMAIL      VARCHAR2,
	  i_CHECKER_TROPS VARCHAR2
	  
	  )
    RETURN VARCHAR2;
    
    FUNCTION uploadSecondaryMarketRate(
        P_MATURITY_DATE VARCHAR2,
        P_TENOR NUMBER,
        P_AMOUNT_VALUE NUMBER,
        P_RATE FLOAT
    )
    RETURN VARCHAR2;
    
   FUNCTION UpdateSecMarketAfterApproval(
      i_REFERENCE_NUM  VARCHAR2,
      i_RESP_CODE      VARCHAR2,
      i_RESP_MESSAGE   VARCHAR2,
      i_HOLD_REF_NUM   VARCHAR2,
      i_CHECKER_BRANCH VARCHAR2,
      i_BRN_NAME       VARCHAR2,
	  i_COMMENT_BRANCH_SUP VARCHAR2)
    RETURN VARCHAR2;
	
	FUNCTION UpdateSecMarketAferRejection(
      i_REFERENCE_NUM  VARCHAR2,
      i_COMMENT_BRANCH_SUP   VARCHAR2,
      i_CHECKER_BRANCH VARCHAR2,
      i_BRN_NAME       VARCHAR2)
    RETURN VARCHAR2;
    
    FUNCTION initiateCollateralLien(
      i_REFERENCE_NUM  VARCHAR2,
      i_MAKER_TROPS VARCHAR2)
    RETURN VARCHAR2;
    
    FUNCTION removeCollateralLien(
      i_REFERENCE_NUM  VARCHAR2,
      i_MAKER_TROPS VARCHAR2)
    RETURN VARCHAR2;
   
    
   ------Added for secondary market approval---
   FUNCTION approvalListSecMarketRequest(P_BRN_NAME varchar2)
    RETURN SYS_REFCURSOR;

     FUNCTION MaturedInvPendingCredit(P_MATURITY_DATE varchar2,P_REQUEST_TYPE varchar2)
    RETURN SYS_REFCURSOR;
END treasury_pkg;