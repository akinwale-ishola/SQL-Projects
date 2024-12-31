create or replace PACKAGE DUBIA_VISA_PKG AS

  FUNCTION UPDATE_DUBIA_VISA_LOG(p_ID              IN VARCHAR2,
                                 p_RESPONSE_CODE   IN VARCHAR2,
                                 p_RESPONSE_MSG    IN VARCHAR2,
                                 P_RESPONSE_REF_ID IN VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION UPDATE_DUBIA_VISA_REQUEST(p_ID                IN VARCHAR2,
                                     p_PAYMENT_REFERENCE IN VARCHAR2,
                                     p_CBA_RESP_CODE     IN VARCHAR2,
                                     p_CBA_RESP_MESSAGE  IN VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION SAVE_DUBAI_VISA_APPL_REQUEST(P_APPLICATION_TYPE    IN VARCHAR2,
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
                                        
                                        ) RETURN VARCHAR2;

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
    RETURN VARCHAR2;

  PROCEDURE FETCH_PENDING_APPL_REQUESTS(P_DATA         OUT SYS_REFCURSOR,
                                        P_RESP_CODE    OUT VARCHAR2,
                                        P_RESP_MESSAGE OUT VARCHAR2);
  FUNCTION GET_APPL_DATA_BYREQUESTID(P_REQUESTID IN VARCHAR2)
    RETURN SYS_REFCURSOR;

  PROCEDURE LOG_REQUEST(P_REQUEST_OBJECT IN CLOB,
                        P_CHANNEL        IN VARCHAR2,
                        P_CODE           OUT VARCHAR2,
                        P_MSG            OUT VARCHAR2,
                        P_ID             OUT NUMBER);
  PROCEDURE UPDATE_LOG(P_ID              IN VARCHAR2,
                       P_RESPONSE_OBJECT IN VARCHAR2,
                       P_CODE            OUT VARCHAR2,
                       P_MSG             OUT VARCHAR2);

END DUBIA_VISA_PKG;
