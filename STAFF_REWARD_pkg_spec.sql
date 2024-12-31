create or replace PACKAGE STAFF_REWARD_pkg AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  FUNCTION FetchReward( p_acct IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION UPDATEReward( p_ID IN VARCHAR2, p_status IN VARCHAR2 ) RETURN VARCHAR2;
   FUNCTION UpdateCreditCardInfo( 
   p_HOMETYPE IN VARCHAR2,
   p_IDDOCUMENTNUMBER IN VARCHAR2,
   p_IDDOCUMENTPLACEOFISSUE IN VARCHAR2,
   p_IDDOCUMENTDATEOFISSUE IN VARCHAR2,
   p_IDDOCUMENTEXPIRYDATE IN VARCHAR2,
   p_FAVSPORT IN VARCHAR2,
   p_FAVSPORTTEAM IN VARCHAR2,
   p_FAVNEWSMEDIA IN VARCHAR2,
   p_FAVSOCIALMEDIA IN VARCHAR2,
   p_REFEREENAME IN VARCHAR2,
   p_REFEREEPHONE IN VARCHAR2,
   p_PREFERREDCARDNAME IN VARCHAR2,
   p_SECURITYQUESTION IN VARCHAR2,
   p_SECURITYANSWER IN VARCHAR2,
   p_WORKFLOW_ID_NAME IN VARCHAR2
   ) RETURN VARCHAR2;
   FUNCTION UPDATEAccountOpening( p_ACCT_BALANCE IN VARCHAR2, p_DEPENDANT_NAME IN VARCHAR2, p_DEPENDANT_ACCTNO IN VARCHAR2, p_UIDS IN VARCHAR2, p_STAFFID IN VARCHAR2,p_DEPENDANT_CUSTID IN VARCHAR2,p_ACCOUNTNO IN VARCHAR2,p_ISACCT_CREDITED IN VARCHAR2,p_ISLIEN_PLACED IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION SAVE_STAFF_EMERGENCY_REQ(
p_CREATED_BY IN VARCHAR2,
        p_STATUS IN VARCHAR2,
        p_CHANNEL IN VARCHAR2,
        
        p_SMS_CONTENT IN VARCHAR2,
       p_STAFF_NAME IN VARCHAR2,

        p_STAFF_EMAIL IN VARCHAR2,
        p_MESSAGE_CONTENT IN VARCHAR2,p_MESSAGE_SUBJECT IN VARCHAR2,p_MESSAGE_CATEGORY IN VARCHAR2,p_STAFF_NUMBER IN VARCHAR2,p_STAFF_MOBILE IN VARCHAR2,p_STAFF_BRANCH_CODE IN VARCHAR2
) RETURN VARCHAR2;   
  END STAFF_REWARD_pkg;