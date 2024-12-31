create or replace PACKAGE        cib_ibank_sr_pkgcib_ibank_sr_pkg AS

 FUNCTION addcorporateaccountOtherBank(o_reference       out varchar2,
                               p_CORP_ACCT_ID    integer,
                               p_CREATED_BY      IN integer,
                               p_ACCOUNT_TYPE    IN VARCHAR2,
                               p_CORP_ID         IN integer,
                               p_RM_NAME         IN VARCHAR2,
                               p_RM_CODE         IN VARCHAR2,
                               p_ACCOUNT_NAME    IN VARCHAR2,
                               p_RM_EMAIL        IN VARCHAR2,
                               p_ACCOUNT_NUMBER  IN VARCHAR2,
                               p_REQUEST_TYPE_ID IN integer,
                               p_MENU_ID         integer,
                               p_context_url     varchar2,
                               p_ip_mac_address  varchar2,
                               p_session_id      varchar2,
							   p_Bank_Code      varchar2
							   ) RETURN VARCHAR2;
FUNCTION updatertgsfundtransferresponse(uids            IN VARCHAR2,
                                         responsecode    IN VARCHAR2,
                                         responsemessage IN VARCHAR2)
    RETURN VARCHAR2;
    FUNCTION GETACCOUNTLIST(I_CUSTOMERNUMBER IN VARCHAR2) RETURN SYS_REFCURSOR;
     FUNCTION getAccountDetailsByAcctNo(ACCTNO IN VARCHAR2) RETURN SYS_REFCURSOR;
    
     FUNCTION UPDATE_FEP_LOG(
   p_ID IN VARCHAR2,
   p_RESPONSE_CODE  IN VARCHAR2,
   p_RESPONSE_MSG IN VARCHAR2)
   RETURN VARCHAR2;
   
    FUNCTION ADD_FEP_LOG1(
   p_ID IN VARCHAR2,
   p_ABBRIDGE_PAN  IN VARCHAR2,
   p_CHANNEL IN VARCHAR2,
   p_USERNAME IN VARCHAR2,
   p_REQUEST_TYPE  IN VARCHAR2,
   p_ACCOUNT_NO    IN VARCHAR2,
   p_PAN           IN VARCHAR2,
   p_OLD_VALUE     IN VARCHAR2,
   p_NEW_VALUE     IN VARCHAR2,
   p_REQUEST_XML   IN VARCHAR2,
   p_INDEMNITY   IN VARCHAR2)
   RETURN VARCHAR2 ;
FUNCTION add_rtgsfundtransfer( 
 p_GENERATE_RESPONSECODE                 IN VARCHAR2 ,
      p_GENERATED_MESSAGE                 IN VARCHAR2,
      p_VALUE_SETTLED_AMOUNT         IN VARCHAR2 ,
      p_BENEFICIARY_CUSTOMER_ACCOUNT IN VARCHAR2,
      p_TRANSACTION_TYPE_CODE        IN VARCHAR2 ,
      p_UIDS                         IN VARCHAR2 ,
      p_BENEFICIARY_CUSTOMER_ADDRESS IN VARCHAR2,
      p_BENEFICIARY_CUSTOMER_NAME    IN VARCHAR2 ,
      p_REMITTANCE_VALUE_DATE        IN VARCHAR2,
      p_BATCH_DETAIL_ID              IN VARCHAR2 ,
      p_ORDERING_CUSTOMER_ACCOUNT    IN VARCHAR2,
      p_ORDERING_CUSTOMER_NAME       IN VARCHAR2 ,
      p_VALUE_DATE                   IN VARCHAR2 ,
      p_ACCT_WITH_INSTITUTE_CODE     IN VARCHAR2,
      p_REMITTANCE_CODE              IN VARCHAR2,
      
      p_ACCT_WITH_INSTITUTE          IN VARCHAR2 ,
     
      p_REMITTANCE_NARRATION         IN VARCHAR2,
      p_ORDERING_CUSTOMER_ADDRESS    IN VARCHAR2 ,
      p_GENERATE_RESPONSE_MESSAGE              IN VARCHAR2 
)
    RETURN VARCHAR2;
  FUNCTION updateNipTSQResponse(p_uids            IN VARCHAR2,
                                p_responsecode    IN VARCHAR2,
                                p_responsemessage IN VARCHAR2
                                --p_invoiceids        IN   VARCHAR2,
                                -- p_SESSIONID           IN VARCHAR2 
                                
                                ) RETURN VARCHAR2;
  FUNCTION add_tsqRequests(
                           
                           p_CHANNELCODE         IN VARCHAR2,
                           p_INVOICEID           IN VARCHAR2,
                           p_SESSIONID           IN VARCHAR2,
                           p_UIDS                IN VARCHAR2,
                           p_DESTINATIONBANKCODE IN VARCHAR2,
                           p_COLLECTIONTYPEID    IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION updateTinValidationSummary(p_THREAD_id IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION UpdateFIRSTinValidationResp(recordid        IN VARCHAR2,
                                       responsecode    IN VARCHAR2,
                                       responsemessage IN VARCHAR2,
                                       acctname        IN VARCHAR2,
                                       v_taxtype       IN VARCHAR2)
    RETURN VARCHAR2;

  function addCollectionDetails(p_CUSTOM_VALUE_4  IN varchar2,
                                p_CUSTOM_VALUE_5  IN varchar2,
                                p_CUSTOM_VALUE_6  IN varchar2,
                                p_CUSTOM_VALUE_7  IN varchar2,
                                p_CUSTOM_VALUE_8  IN varchar2,
                                p_CUSTOM_VALUE_9  IN varchar2,
                                p_CUSTOM_VALUE_10 IN varchar2,
                                p_BATCH_ID        IN varchar2,
                                p_REQUEST_ID      IN varchar2,
                                p_CUSTOM_VALUE_1  IN varchar2,
                                p_CUSTOM_VALUE_2  IN varchar2,
                                p_CUSTOM_VALUE_3  IN varchar2,
                                p_COLLECTION_ID   IN varchar2,
                                p_CORP_ID         IN varchar2,
                                p_CREATED_BY      IN varchar2)
    return varchar2;
  function addFIRSRemitDetailsTemp(p_PAYMENTMETHOD   IN varchar2,
                                   p_PAYERNAME       IN varchar2,
                                   p_PAYERTIN        IN varchar2,
                                   p_BANK            IN varchar2,
                                   p_TAXTYPE         IN varchar2,
                                   p_ADDRESS         IN varchar2,
                                   p_TAXOFFICE       IN varchar2,
                                   p_BATCH_DETAIL_ID IN varchar2,
                                   p_PAYPERIODFROM   IN varchar2,
                                   p_PAYREF          IN varchar2,
                                   p_PAYPERIODTO     IN varchar2,
                                   p_CREATEDBY       IN varchar2,
                                   p_CORP_ID         IN varchar2,
                                   p_noofrecord      IN varchar2,
                                   p_totalamt        IN varchar2)
    return varchar2;
  function addFIRSRemitDetailsWHTTemp(p_BENEFICIARYADDRESS IN varchar2,
                                      p_RATE               IN varchar2,
                                      
                                      p_BATCH_DETAIL_ID IN varchar2,
                                      p_CONTRACTDATE    IN varchar2,
                                      p_INVOICENUMBER   IN varchar2,
                                      p_TAXAMOUNT       IN varchar2,
                                      p_DESCRIPTION     IN varchar2,
                                      p_CONTRACTAMOUNT  IN varchar2,
                                      p_CONTRACTTYPE    IN varchar2,
                                      p_BENEFICIARYNAME IN varchar2,
                                      p_BENEFICIARYTIN  IN varchar2,
                                      p_TAXAUTHORITY    IN varchar2,
                                      p_CREATEDBY       IN varchar2,
                                      p_CORP_ID         IN varchar2,
                                      p_BEN_EMAIL       IN varchar2
                                      
                                      ) return varchar2;
  function addFIRSRemitDetailsPayeTemp(p_NHIS               IN varchar2,
                                       p_BASICSALARY        IN varchar2,
                                       p_RATE               IN varchar2,
                                       p_LIFEASSURANCE      IN varchar2,
                                       p_BATCH_DETAIL_ID    IN varchar2,
                                       p_PENSION            IN varchar2,
                                       p_NHF                IN varchar2,
                                       p_PAYABLEPERANNUM    IN varchar2,
                                       p_TAXAMOUNT          IN varchar2,
                                       p_ALLOWANCE          IN varchar2,
                                       p_GRATUITY           IN varchar2,
                                       p_CRA                IN varchar2,
                                       p_MINPAYABLEPERANNUM IN varchar2,
                                       p_STAFFNUMBER        IN varchar2,
                                       
                                       p_SN                       IN varchar2,
                                       p_BENEFICIARYNAME          IN varchar2,
                                       p_STATUTORYPAYABLEPERANNUM IN varchar2,
                                       p_BENEFICIARYTIN           IN varchar2,
                                       p_GROSSPAY                 IN varchar2,
                                       p_TAXAUTHORITY             IN varchar2,
                                       
                                       p_BENEFICIARYDESIGNATION IN varchar2,
                                       p_CREATEDBY              IN varchar2,
                                       p_CORP_ID                IN varchar2,
                                       p_BEN_EMAIL              IN varchar2)
    return varchar2;

  function addFIRSRemittanceDetails(p_PAYMENTMETHOD       IN varchar2,
                                    p_PAYERNAME           IN varchar2,
                                    p_PAYERTIN            IN varchar2,
                                    p_BANK                IN varchar2,
                                    p_TAXTYPE             IN varchar2,
                                    p_ADDRESS             IN varchar2,
                                    p_TAXOFFICE           IN varchar2,
                                    p_BATCH_DETAIL_ID     IN varchar2,
                                    p_PAYPERIODFROM       IN varchar2,
                                    p_PAYREF              IN varchar2,
                                    p_PAYPERIODTO         IN varchar2,
                                    p_CREATEDBY           IN varchar2,
                                    p_CORP_ID             IN varchar2,
                                    p_TAXTYPE_DESCRIPTION IN varchar2)
    return varchar2;
  function addFIRSRemittanceDetailsWHT(p_BENEFICIARYADDRESS IN varchar2,
                                       p_RATE               IN varchar2,
                                       
                                       p_BATCH_DETAIL_ID      IN varchar2,
                                       p_CONTRACTDATE         IN varchar2,
                                       p_INVOICENUMBER        IN varchar2,
                                       p_TAXAMOUNT            IN varchar2,
                                       p_DESCRIPTION          IN varchar2,
                                       p_CONTRACTAMOUNT       IN varchar2,
                                       p_CONTRACTTYPE         IN varchar2,
                                       p_BENEFICIARYNAME      IN varchar2,
                                       p_BENEFICIARYTIN       IN varchar2,
                                       p_TAXAUTHORITY         IN varchar2,
                                       p_CREATEDBY            IN varchar2,
                                       p_CORP_ID              IN varchar2,
                                       p_NameValidationStatus IN varchar2,
                                       p_NE_CUST_NAME         IN varchar2,
                                       p_BEN_EMAIL            IN varchar2)
    return varchar2;
  function addFIRSRemittanceDetailsPaye(p_NHIS               IN varchar2,
                                        p_BASICSALARY        IN varchar2,
                                        p_RATE               IN varchar2,
                                        p_LIFEASSURANCE      IN varchar2,
                                        p_BATCH_DETAIL_ID    IN varchar2,
                                        p_PENSION            IN varchar2,
                                        p_NHF                IN varchar2,
                                        p_PAYABLEPERANNUM    IN varchar2,
                                        p_TAXAMOUNT          IN varchar2,
                                        p_ALLOWANCE          IN varchar2,
                                        p_GRATUITY           IN varchar2,
                                        p_CRA                IN varchar2,
                                        p_MINPAYABLEPERANNUM IN varchar2,
                                        p_STAFFNUMBER        IN varchar2,
                                        
                                        p_SN                       IN varchar2,
                                        p_BENEFICIARYNAME          IN varchar2,
                                        p_STATUTORYPAYABLEPERANNUM IN varchar2,
                                        p_BENEFICIARYTIN           IN varchar2,
                                        p_GROSSPAY                 IN varchar2,
                                        p_TAXAUTHORITY             IN varchar2,
                                        
                                        p_BENEFICIARYDESIGNATION IN varchar2,
                                        p_CREATEDBY              IN varchar2,
                                        p_CORP_ID                IN varchar2,
                                        p_NameValidationStatus   IN varchar2,
                                        p_NE_CUST_NAME           IN varchar2,
                                        p_BEN_EMAIL              IN varchar2)
    return varchar2;

  FUNCTION getCustomerTINByAccountNo(p_acctNo IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION addTransactionScheduleSummary(p_DR_ACCOUNT         IN VARCHAR2,
                                         p_CREATED_BY         IN VARCHAR2,
                                         p_CORP_ID            IN VARCHAR2,
                                         p_BATCH_ID           IN VARCHAR2,
                                         p_SCHEDULE_DATE      IN VARCHAR2,
                                         p_NO_OF_RECORD       IN VARCHAR2,
                                         p_TOTAL_AMOUNT       IN VARCHAR2,
                                         p_PAYMENT_TYPE_ID    IN VARCHAR2,
                                         p_MENU_ID            IN VARCHAR2,
                                         p_CHARGE_OPTION_ID   IN VARCHAR2,
                                         p_BATCH_DESCRIPTION  IN VARCHAR2,
                                         p_POSTING_OPTIONID   IN VARCHAR2,
                                         p_payment_channel_id varchar2,
                                         
                                         p_upload_filename     varchar2, --#sprint2
                                         p_auth_token_flag     char,
                                         p_auth_token_sno      varchar2,
                                         p_context_url         varchar2,
                                         p_ip_mac_address      varchar2,
                                         p_session_id          varchar2,
                                         p_schedule_type_id    varchar2,
                                         p_schedule_option_id  varchar2,
                                         p_schedule_start_date varchar2,
                                         p_schedule_end_date   varchar2,
                                         p_sweep_variable      varchar2,
                                         p_sweep_option_id     varchar2)
    RETURN VARCHAR2;

  function addTransactionScheduleDetails(p_BATCH_ID             IN VARCHAR2,
                                         p_AMOUNT               IN VARCHAR2,
                                         p_CR_ACCOUNT_NO        IN VARCHAR2,
                                         p_BENEFICIARY_ID       IN VARCHAR2,
                                         p_BANK_CODE            IN VARCHAR2,
                                         p_DR_ACCOUNT_NO        IN VARCHAR2,
                                         p_CREATED_BY           IN VARCHAR2,
                                         p_SCHEDULE_DATE        IN VARCHAR2,
                                         p_NARRATION            IN VARCHAR2,
                                         p_PAYMENT_TYPE_ID      IN VARCHAR2,
                                         p_BANK_NAME            IN VARCHAR2,
                                         p_CORP_ID              IN VARCHAR2,
                                         p_PAYMENT_CHANNEL_ID   IN VARCHAR2,
                                         p_MOBILE_NETWORK_ID    IN VARCHAR2,
                                         p_MOBILE_NUMBER        IN VARCHAR2,
                                         p_BILLER_CATEGORY      IN VARCHAR2,
                                         p_BENEFICIARY_EMAIL    IN VARCHAR2,
                                         p_BILLER_NAME          IN VARCHAR2,
                                         p_CHARGE_AMOUNT        IN VARCHAR2,
                                         p_beneficiary_name     varchar2, --#sprint2
                                         p_uploadbatchid        varchar2, --correct
                                         p_nameenquiry_name     varchar2, --correct
                                         p_bvn                  varchar2,
                                         p_sessioid             varchar2,
                                         p_kyclevel             varchar2,
                                         p_namevalidationstatus varchar2)
    return varchar2;

  function addTransactionScheduleCalendar(
                                          
                                          p_SCHEDULE_SECOND    IN VARCHAR2,
                                          p_SCHEDULE_YEAR      IN VARCHAR2,
                                          p_SCHEDULE_HOUR      IN VARCHAR2,
                                          p_SCHEDULE_MINUTE    IN VARCHAR2,
                                          p_SCHEDULE_DAY       IN VARCHAR2,
                                          p_SCHEDULE_MONTH     IN VARCHAR2,
                                          p_SCHEDULE_TIME      IN VARCHAR2,
                                          p_CORP_ID            IN VARCHAR2,
                                          p_BATCH_ID           IN VARCHAR2,
                                          p_SCHEDULE_OPTION_ID IN VARCHAR2)
    return varchar2;
  procedure executeStandingInstructions;
  FUNCTION isThreadRunning(p_THREAD_id IN VARCHAR2) RETURN varchar2;
  FUNCTION updatethreadlaststatus(v_threadid  IN VARCHAR2,
                                  v_runstatus IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION isThreadAlive(p_THREAD_id IN VARCHAR2, p_duration IN Integer)
    RETURN varchar2;
  FUNCTION addTransactionUploadSummary(p_DR_ACCOUNT         IN VARCHAR2,
                                       p_CREATED_BY         IN VARCHAR2,
                                       p_CORP_ID            IN VARCHAR2,
                                       p_BATCH_ID           IN VARCHAR2,
                                       p_SCHEDULE_DATE      IN VARCHAR2,
                                       p_NO_OF_RECORD       IN VARCHAR2,
                                       p_TOTAL_AMOUNT       IN VARCHAR2,
                                       p_PAYMENT_TYPE_ID    IN VARCHAR2,
                                       p_MENU_ID            IN VARCHAR2,
                                       p_CHARGE_OPTION_ID   IN VARCHAR2,
                                       p_BATCH_DESCRIPTION  IN VARCHAR2,
                                       p_POSTING_OPTIONID   IN VARCHAR2,
                                       p_payment_channel_id varchar2,
                                       p_upload_filename    varchar2, --#sprint2
                                       p_auth_token_flag    char,
                                       p_auth_token_sno     varchar2,
                                       p_context_url        varchar2,
                                       p_ip_mac_address     varchar2,
                                       p_session_id         varchar2)
    RETURN VARCHAR2;
  function addTransactionUploadDetails(
                                       
                                       p_BATCH_ID           IN VARCHAR2,
                                       p_AMOUNT             IN VARCHAR2,
                                       p_CR_ACCOUNT_NO      IN VARCHAR2,
                                       p_BENEFICIARY_ID     IN VARCHAR2,
                                       p_BANK_CODE          IN VARCHAR2,
                                       p_DR_ACCOUNT_NO      IN VARCHAR2,
                                       p_CREATED_BY         IN VARCHAR2,
                                       p_SCHEDULE_DATE      IN VARCHAR2,
                                       p_NARRATION          IN VARCHAR2,
                                       p_PAYMENT_TYPE_ID    IN VARCHAR2,
                                       p_BANK_NAME          IN VARCHAR2,
                                       p_CORP_ID            IN VARCHAR2,
                                       p_PAYMENT_CHANNEL_ID IN VARCHAR2,
                                       p_MOBILE_NETWORK_ID  IN VARCHAR2,
                                       p_MOBILE_NUMBER      IN VARCHAR2,
                                       p_BILLER_CATEGORY    IN VARCHAR2,
                                       p_BENEFICIARY_EMAIL  IN VARCHAR2,
                                       p_BILLER_NAME        IN VARCHAR2,
                                       
                                       p_CHARGE_AMOUNT    IN VARCHAR2,
                                       p_beneficiary_name varchar2
                                       
                                       ) return varchar2;

  FUNCTION updateProcessedUploadsSummary(p_THREAD_id IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION updatenipnameenquiryrespupload(uids            IN VARCHAR2,
                                          responsecode    IN VARCHAR2,
                                          responsemessage IN VARCHAR2,
                                          acctname        IN VARCHAR2,
                                          bvn             IN VARCHAR2,
                                          kyclevel        IN VARCHAR2,
                                          recordid        IN VARCHAR2,
                                          sessionids      IN VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION updateaccountvalidnUpload(recordid    IN VARCHAR2,
                                     customerid  IN VARCHAR2,
                                     bvn         IN VARCHAR2,
                                     isvalidacct IN VARCHAR2,
                                     branchcode  IN VARCHAR2,
                                     currcode    IN VARCHAR2,
                                     acctname    IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION selectPendingUploadTxn(p_userid IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION selectpendingaccntvalidnUpload(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;

  FUNCTION selectpendingnameenquiryUpld(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;

  FUNCTION add_tokenvalidation_log(p_VALIDATION_REF IN VARCHAR2,
                                   p_RESPONSE_CODE  IN VARCHAR2,
                                   p_TOKEN          IN VARCHAR2,
                                   p_MODULE         IN VARCHAR2,
                                   p_RESPONSE_MSG   IN VARCHAR2,
                                   p_USERNAME       IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION getPendApprovReqDistTranTypAll(i_batch_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getApprovalUserGroupIdForLevel(signatoryid IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getPendApprovReqDistCorp(i_batch_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getPendApprovReqDistTranType(i_batch_id IN VARCHAR2)
    RETURN sys_refcursor;
  function validateAccount(p_account_number varchar) return varchar2;

  FUNCTION updateProcessedRecordsSummary(p_THREAD_id IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION add_gefupostingparameters_rev(batchid              IN VARCHAR2,
                                         initiatingbranch     IN VARCHAR2,
                                         requestmodule        IN VARCHAR2,
                                         modulecredentials    IN VARCHAR2,
                                         transactioncurrency  IN VARCHAR2,
                                         acccountnumber       IN VARCHAR2,
                                         branchcode           IN VARCHAR2,
                                         amount               IN VARCHAR2,
                                         debitcreditindicator IN VARCHAR2,
                                         glcasaindicator      IN VARCHAR2,
                                         mnemonic             IN VARCHAR2,
                                         narration            IN VARCHAR2,
                                         paymentreference     IN VARCHAR2,
                                         transactionid        IN VARCHAR2,
                                         isinterbanktransfer  IN VARCHAR2,
                                         uids                 IN VARCHAR2,
                                         invoiceid            IN VARCHAR2,
                                         collectiontypeid     IN VARCHAR2,
                                         parentrecordid       IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fetchpostingparameters_rev(postingsessionid IN VARCHAR2)
    RETURN sys_refcursor;
  function removeDuplicateEmails(p_delimited_emails varchar2) return varchar2;
  function isCorporateSoleProprietorship(p_corp_id varchar2) return char;
  FUNCTION add_nipfundtransfer(accountname             IN VARCHAR2,
                               accountnumber           IN VARCHAR2,
                               amount                  IN VARCHAR2,
                               bankverificationnumber  IN VARCHAR2,
                               channelcode             IN VARCHAR2,
                               destinationbankcode     IN VARCHAR2,
                               kyclevel                IN VARCHAR2,
                               modulecredentials       IN VARCHAR2,
                               nameenquirysessionid    IN VARCHAR2,
                               narration               IN VARCHAR2,
                               originatoraccountnumber IN VARCHAR2,
                               originatorbvn           IN VARCHAR2,
                               originatorkyclevel      IN VARCHAR2,
                               originatorname          IN VARCHAR2,
                               paymentreference        IN VARCHAR2,
                               requestmodule           IN VARCHAR2,
                               sessionid               IN VARCHAR2,
                               transactionlocation     IN VARCHAR2,
                               uids                    IN VARCHAR2,
                               invoiceid               IN VARCHAR2,
                               collectiontypeid        IN VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION add_quickteller_log(v_recordid     IN VARCHAR2,
                               v_batchid      IN VARCHAR2,
                               v_reqxml       IN VARCHAR2,
                               v_resp_code    IN VARCHAR2,
                               v_resp_msg     IN VARCHAR2,
                               v_payment_type IN VARCHAR2,
                               v_resp_xml     IN VARCHAR2,
                               v_req_type     IN VARCHAR2,
                               v_recharge_pin IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION updatethreadlastrun(v_threadid IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION getdestinationbanksortcode(bankcodeorname IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getnibbssessionidseq RETURN sys_refcursor;
  function logemail(p_menuid IN VARCHAR2, p_scheduleid IN VARCHAR2)
    return varchar2;
  PROCEDURE logerror(p_errormsg IN VARCHAR2, p_table_name IN VARCHAR2);
  FUNCTION add_gefupostingparameters(batchid              IN VARCHAR2,
                                     initiatingbranch     IN VARCHAR2,
                                     requestmodule        IN VARCHAR2,
                                     modulecredentials    IN VARCHAR2,
                                     transactioncurrency  IN VARCHAR2,
                                     acccountnumber       IN VARCHAR2,
                                     branchcode           IN VARCHAR2,
                                     amount               IN VARCHAR2,
                                     debitcreditindicator IN VARCHAR2,
                                     glcasaindicator      IN VARCHAR2,
                                     mnemonic             IN VARCHAR2,
                                     narration            IN VARCHAR2,
                                     paymentreference     IN VARCHAR2,
                                     transactionid        IN VARCHAR2,
                                     isinterbanktransfer  IN VARCHAR2,
                                     uids                 IN VARCHAR2,
                                     recordid             IN VARCHAR2,
                                     paymenttypeid        IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION getacctdetails(acctno IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION getappconfig RETURN sys_refcursor;
  FUNCTION updategefupostingparam_rev(uidsin                IN VARCHAR2,
                                      responsecodein        IN VARCHAR2,
                                      responsemessagein     IN VARCHAR2,
                                      isinterbanktransferin IN VARCHAR2,
                                      recordid              IN VARCHAR2,
                                      paymenttypeid         IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION updategefupostingparameters(uidsin                IN VARCHAR2,
                                       responsecodein        IN VARCHAR2,
                                       responsemessagein     IN VARCHAR2,
                                       isinterbanktransferin IN VARCHAR2,
                                       recordid              IN VARCHAR2,
                                       paymenttypeid         IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION updatenipfundtransferresponse(uids            IN VARCHAR2,
                                         responsecode    IN VARCHAR2,
                                         responsemessage IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION updateFirsNoticeresponse(v_post_ref_no   IN VARCHAR2,
                                    responsecode    IN VARCHAR2,
                                    responsemessage IN VARCHAR2,
                                    v_error_msg     IN VARCHAR2)
    RETURN VARCHAR2;

  FUNCTION updateAkwaIbomNoticeresponse(v_batch_detail  IN VARCHAR2,
                                        responsecode    IN VARCHAR2,
                                        responsemessage IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION updateRevPayNoticeresponse(v_batch_detail  IN VARCHAR2,
                                      responsecode    IN VARCHAR2,
                                      responsemessage IN VARCHAR2,
                                      v_receiptid     IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION updatenipnameenquiryresponse(uids            IN VARCHAR2,
                                        responsecode    IN VARCHAR2,
                                        responsemessage IN VARCHAR2,
                                        acctname        IN VARCHAR2,
                                        bvn             IN VARCHAR2,
                                        kyclevel        IN VARCHAR2,
                                        recordid        IN VARCHAR2,
                                        sessionids      IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION selectPendingFIRSValidation(p_userid  IN VARCHAR2,
                                       p_taxtype IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION fetchPendingFIRSUploadValReq(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION updateaccountvalidation(recordid    IN VARCHAR2,
                                   customerid  IN VARCHAR2,
                                   bvn         IN VARCHAR2,
                                   isvalidacct IN VARCHAR2,
                                   branchcode  IN VARCHAR2,
                                   currcode    IN VARCHAR2,
                                   acctname    IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION getPaymentTypes RETURN sys_refcursor;
  FUNCTION getPendingFIRSNotice(p_THREAD_id IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION getFIRSWhtDetailsByTranRef(p_TranRef IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getFIRSPayeDetailsByTranRef(p_TranRef IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getPendingRevpayNotice(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION getPendingAkwaIbomNotice(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  --FUNCTION getPendingFIRSNoticeWHT(p_THREAD_id IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION selectpendingtransitreversal(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION selectpendingpostingreversal(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION selectpendinginterbankft(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION selectpendingquicktellertxn(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION selectpendingaccountvalidation(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION selectpendinginterbanknenquiry(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION selectpendingposting(p_THREAD_id IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION selectpendingtransitentries(p_THREAD_id IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION addTransactionBatchSummary(p_DR_ACCOUNT         IN VARCHAR2,
                                      p_CREATED_BY         IN VARCHAR2,
                                      p_CORP_ID            IN VARCHAR2,
                                      p_BATCH_ID           IN VARCHAR2,
                                      p_SCHEDULE_DATE      IN VARCHAR2,
                                      p_NO_OF_RECORD       IN VARCHAR2,
                                      p_TOTAL_AMOUNT       IN VARCHAR2,
                                      p_PAYMENT_TYPE_ID    IN VARCHAR2,
                                      p_MENU_ID            IN VARCHAR2,
                                      p_CHARGE_OPTION_ID   IN VARCHAR2,
                                      p_BATCH_DESCRIPTION  IN VARCHAR2,
                                      p_POSTING_OPTIONID   IN VARCHAR2,
                                      p_payment_channel_id varchar2,
                                      p_upload_filename    varchar2, --#sprint2
                                      p_auth_token_flag    char,
                                      p_auth_token_sno     varchar2,
                                      p_context_url        varchar2,
                                      p_ip_mac_address     varchar2,
                                      p_session_id         varchar2)
    RETURN VARCHAR2;

  function addTransactionBatchDetails(
                                      
                                      p_BATCH_ID           IN VARCHAR2,
                                      p_AMOUNT             IN VARCHAR2,
                                      p_CR_ACCOUNT_NO      IN VARCHAR2,
                                      p_BENEFICIARY_ID     IN VARCHAR2,
                                      p_BANK_CODE          IN VARCHAR2,
                                      p_DR_ACCOUNT_NO      IN VARCHAR2,
                                      p_CREATED_BY         IN VARCHAR2,
                                      p_SCHEDULE_DATE      IN VARCHAR2,
                                      p_NARRATION          IN VARCHAR2,
                                      p_PAYMENT_TYPE_ID    IN VARCHAR2,
                                      p_BANK_NAME          IN VARCHAR2,
                                      p_CORP_ID            IN VARCHAR2,
                                      p_PAYMENT_CHANNEL_ID IN VARCHAR2,
                                      p_MOBILE_NETWORK_ID  IN VARCHAR2,
                                      p_MOBILE_NUMBER      IN VARCHAR2,
                                      p_BILLER_CATEGORY    IN VARCHAR2,
                                      p_BENEFICIARY_EMAIL  IN VARCHAR2,
                                      p_BILLER_NAME        IN VARCHAR2,
                                      
                                      p_CHARGE_AMOUNT        IN VARCHAR2,
                                      p_beneficiary_name     varchar2,
                                      p_uploadbatchid        varchar2, --correct
                                      p_nameenquiry_name     varchar2, --correct
                                      p_bvn                  varchar2,
                                      p_sessioid             varchar2,
                                      p_kyclevel             varchar2,
                                      p_namevalidationstatus varchar2)
    return varchar2;

  FUNCTION addsignatory(o_reference                    out varchar2,
                        p_CREATED_BY                   IN VARCHAR2,
                        p_NO_OF_SIGNATORIES_FOR_LEVEL  IN VARCHAR2,
                        p_ROUTEID                      IN VARCHAR2,
                        p_APPROVAL_LEVEL               IN VARCHAR2,
                        p_GROUP_USERS_APPROVAL_ORDERED IN VARCHAR2,
                        p_APPROVER_ROUTE_TYPEID        IN VARCHAR2,
                        p_CAN_ANY_GROUP_USER_APPROVE   IN VARCHAR2,
                        p_REQUEST_TYPE_ID              IN VARCHAR2,
                        p_EXPECTED_GROUP_APPROVER_ID   IN VARCHAR2,
                        p_ROUTE_SIGNATORY_ID           IN VARCHAR2,
                        p_EXPECTED_USER_APPROVER_ID    IN VARCHAR2,
                        p_MENU_ID                      IN VARCHAR2,
                        p_APPLY_APPROVAL_LIMIT         IN VARCHAR2,
                        p_signatory_type_id            varchar2,
                        p_system_generated             char,
                        p_context_url                  varchar2,
                        p_ip_mac_address               varchar2,
                        p_session_id                   varchar2)
    RETURN VARCHAR2;

  FUNCTION updateEmailNotification(i_SCHEDULE_ID    IN VARCHAR2,
                                   i_STATUS         IN VARCHAR2,
                                   i_status_message varchar2) RETURN VARCHAR2;
  FUNCTION getPendingEmailNotification RETURN SYS_REFCURSOR;

  PROCEDURE send_mail(p_to        IN VARCHAR2,
                      p_from      IN VARCHAR2,
                      p_message   IN VARCHAR2,
                      p_smtp_host IN VARCHAR2,
                      p_smtp_port IN NUMBER DEFAULT 25);
  FUNCTION createapprovalroute(o_reference              out varchar2,
                               p_APPROVAL_ROUTE_ID_REQ  IN VARCHAR2,
                               p_IS_APPROVAL_SEQUENTIAL IN VARCHAR2,
                               p_ISFINANCIAL            IN VARCHAR2,
                               p_CORP_ACCT_ID           IN NUMBER,
                               p_MODULE_ID              IN NUMBER,
                               p_REQUEST_TYPE_ID        IN VARCHAR2,
                               p_ISGLOBALRULE           IN VARCHAR2,
                               p_CREATED_BY             IN VARCHAR2,
                               p_TRAN_TYPE_ID           IN NUMBER,
                               p_DEPARTMENT_ID          IN NUMBER,
                               p_CORP_ID                IN VARCHAR2,
                               p_NO_OF_SIGNATORIES      varchar2,
                               p_NO_OF_APPROVAL_LEVELS  varchar2,
                               p_ROUTE_TYPE_ID          IN VARCHAR2,
                               p_APPROVAL_OPTIONS_ID    IN VARCHAR2,
                               -- p_PARENT_TABLE_ID        IN VARCHAR2,
                               p_ISGLOBAL_ACCTRULE IN VARCHAR2,
                               p_ISMODULERULE      IN VARCHAR2,
                               p_MENU_ID           IN VARCHAR2,
                               p_ROUTE_NAME        IN VARCHAR2,
                               p_ROUTE_DESC        IN VARCHAR2,
                               p_IS_AMOUNT_RULE    varchar2,
                               p_START_AMOUNT      number,
                               p_END_AMOUNT        number,
                               p_system_generated  char,
                               p_context_url       varchar2,
                               p_ip_mac_address    varchar2,
                               p_session_id        varchar2) RETURN VARCHAR2;
  FUNCTION getTranDetailsByScheduleID(ptrantype      IN VARCHAR2,
                                      pparenttableid IN VARCHAR2,
                                      p_view_only    char)
    RETURN sys_refcursor;

  PROCEDURE updateParentTable(p_requesttype   IN VARCHAR2,
                              p_parenttableid IN VARCHAR2,
                              p_scheduleid    IN NUMBER,
                              p_menuid        IN VARCHAR2,
                              p_approved_by   varchar2,
                              p_response_code OUT VARCHAR2
                              
                              );

  PROCEDURE getApprovalScheduleNarration(p_requesttype   IN VARCHAR2,
                                         p_parenttableid IN VARCHAR2,
                                         p_scheduleid    IN NUMBER,
                                         p_menuurl       IN VARCHAR2,
                                         p_narration     OUT VARCHAR2,
                                         p_dr_acct       OUT VARCHAR2,
                                         p_amount        OUT NUMBER,
                                         p_response_code OUT VARCHAR2
                                         
                                         );

  FUNCTION approverecord(p_scheduleid      IN VARCHAR2,
                         p_userid          IN VARCHAR2,
                         p_approvaloption  IN VARCHAR2,
                         p_comments        IN VARCHAR2,
                         p_menuid          IN VARCHAR2,
                         p_REQUEST_TYPE_ID IN VARCHAR2,
                         p_auth_token_flag char,
                         p_auth_token_sno  varchar2,
                         p_context_url     varchar2,
                         p_ip_mac_address  varchar2,
                         p_session_id      varchar2,
                         p_id_values       ID_VALUE_OBJECTS_TYP)
    RETURN VARCHAR2;

  -- this has been made private function
  /*FUNCTION approverecord(p_scheduleid      IN VARCHAR2,
  p_userid          IN VARCHAR2,
  p_approvaloption  IN VARCHAR2,
  p_comments        IN VARCHAR2,
  p_menuid          IN VARCHAR2,
  p_REQUEST_TYPE_ID IN VARCHAR2,
  p_context_url     varchar2,
  p_ip_mac_address  varchar2,
  p_session_id      varchar2) RETURN VARCHAR2;*/
  FUNCTION getacctdetailsbyacctnumber(paccountno IN VARCHAR2)
    RETURN sys_refcursor;

  FUNCTION getPendingApprovalsbyUserid(puserid IN VARCHAR2)
    RETURN sys_refcursor;
  FUNCTION logApproveralRequest(acctno            IN VARCHAR2,
                                userid            IN VARCHAR2,
                                v_menuurl         IN VARCHAR2,
                                requesttype       IN VARCHAR2,
                                v_parenttableid   IN VARCHAR2,
                                v_tran_amount     in number,
                                v_merchant_corpid IN VARCHAR2,
                                p_context_url     varchar2,
                                p_ip_mac_address  varchar2,
                                p_session_id      varchar2) RETURN VARCHAR2;
  FUNCTION logApproveralRequest(acctno            IN VARCHAR2,
                                userid            IN VARCHAR2,
                                v_menuurl         IN VARCHAR2,
                                requesttype       IN VARCHAR2,
                                v_parenttableid   IN VARCHAR2,
                                v_tran_amount     IN NUMBER,
                                v_merchant_corpid IN VARCHAR2,
                                p_auth_token_flag char,
                                p_auth_token_sno  varchar2,
                                p_context_url     varchar2,
                                p_ip_mac_address  varchar2,
                                p_session_id      varchar2) return varchar2;
  FUNCTION getacctdetailsbycustid(pcustid IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION createcorporate(o_reference       out varchar2,
                           p_MOBILE_PHONE_NO IN VARCHAR2,
                           p_CREATED_BY      IN VARCHAR2,
                           p_CUSTOMER_ID     IN VARCHAR2,
                           p_CORP_ID         IN VARCHAR2,
                           
                           p_EMAIL                 IN VARCHAR2,
                           p_OFFICE_PHONE_NO       IN VARCHAR2,
                           p_NAME                  IN VARCHAR2,
                           p_RM_EMAIL              IN VARCHAR2,
                           p_CORPORATE_ID          IN VARCHAR2,
                           p_ADDRESS               IN VARCHAR2,
                           p_APPROVAL_COMMENT      IN VARCHAR2,
                           p_REQUEST_TYPE_ID       IN VARCHAR2,
                           p_MENU_ID               IN VARCHAR2,
                           p_POSTING_OPTION_ID     in varchar2,
                           p_HOLDING_ACCOUNT_ID    varchar2,
                           p_AUTO_APPROVAL_ENABLED varchar2,
                           p_HAS_TOKEN             char,
                           p_IS_SOLEPROPRIETOR     char,
                           p_corporate_type_id     integer,
                           p_enable_Verifier_Token char,
                           p_enable_Inputter_Token char,
                           p_authorizer_Token_Flag char,
                           p_narration_option_id   integer,
                           p_context_url           varchar2,
                           p_ip_mac_address        varchar2,
                           p_session_id            varchar2) RETURN VARCHAR2;

  FUNCTION addcorporateaccount(o_reference       out varchar2,
                               p_CORP_ACCT_ID    integer,
                               p_CREATED_BY      IN integer,
                               p_ACCOUNT_TYPE    IN VARCHAR2,
                               p_CORP_ID         IN integer,
                               p_RM_NAME         IN VARCHAR2,
                               p_RM_CODE         IN VARCHAR2,
                               p_ACCOUNT_NAME    IN VARCHAR2,
                               p_RM_EMAIL        IN VARCHAR2,
                               p_ACCOUNT_NUMBER  IN VARCHAR2,
                               p_REQUEST_TYPE_ID IN integer,
                               p_MENU_ID         integer,
                               p_context_url     varchar2,
                               p_ip_mac_address  varchar2,
                               p_session_id      varchar2) RETURN VARCHAR2;

  /* Formatted on 2/21/2018 8:39:05 PM (QP5 v5.215.12089.38647) */

  FUNCTION createUser(o_reference       out varchar2,
                      i_USER_ID         IN INTEGER,
                      i_USERNAME        IN VARCHAR2,
                      i_FIRST_NAME      IN VARCHAR2,
                      i_LAST_NAME       IN VARCHAR2,
                      i_MIDDLE_NAME     IN VARCHAR2,
                      i_ADDRESS         IN VARCHAR2,
                      i_OFFICE_PHONE_NO IN VARCHAR2,
                      i_MOBILE_PHONE_NO IN VARCHAR2,
                      i_JOB_TITLE       IN VARCHAR2,
                      i_USER_TYPE_ID    IN VARCHAR2,
                      i_EMAIL           IN VARCHAR2,
                      i_CHANGE_PASSWORD IN VARCHAR2,
                      
                      i_CREATED_BY IN INTEGER,
                      
                      i_LAST_MODIFIED_BY IN NUMBER,
                      
                      i_APPROVAL_BY            IN INTEGER,
                      i_CORP_ID                IN NUMBER,
                      i_DEPT_ID                IN NUMBER,
                      i_APPROVAL_LIMIT         IN NUMBER,
                      i_HAS_GLOBAL_ACCT_ACCESS IN VARCHAR2,
                      i_IS_SIGNATORY           IN VARCHAR2,
                      i_REQUEST_TYPE_ID        IN VARCHAR2,
                      i_MENU_ID                IN integer,
                      i_AUTO_APPROVAL_ENABLED  varchar2,
                      i_HAS_TOKEN              char,
                      i_TOKEN_DELIVERED        CHAR,
                      p_context_url            varchar2,
                      p_ip_mac_address         varchar2,
                      p_session_id             varchar2,
                      p_view_balance           varchar2) RETURN VARCHAR2;

  function cancelupload(i_batchid VARCHAR2, i_userid VARCHAR2)
    RETURN VARCHAR2; --correct
  function cancelFIRSTinValidnupload(i_batchid VARCHAR2, i_userid VARCHAR2)
    RETURN VARCHAR2;
  function getPaymentDetailsByBatchId(p_batch_detail_id varchar2)
    return sys_refcursor;
  function getMonthlyInOutFlowGraph(p_corp_id varchar2) return Sys_Refcursor;
  function getWeeklyInOutFlowGraph(p_corp_id varchar2) return Sys_Refcursor;
  function getCorporateRmDetail(p_corp_id varchar) return sys_refcursor;
  FUNCTION createCorporateRole(i_ROLE_ID    INTEGER,
                               i_NAME       VARCHAR2,
                               i_CORP_ID    INTEGER,
                               i_ROLE_TYPE  INTEGER,
                               i_CREATED_BY NUMBER,
                               
                               i_APPROVED_BY NUMBER,
                               
                               i_LAST_MODIFIED_BY NUMBER,
                               
                               i_REQUEST_TYPE_ID INTEGER,
                               i_MENU_ID         integer,
                               p_context_url     varchar2,
                               p_ip_mac_address  varchar2,
                               p_session_id      varchar2) RETURN VARCHAR2;

  FUNCTION getActiveCorporateProfiles RETURN SYS_REFCURSOR;

  function addUserToRole(o_reference    out varchar2,
                         i_USER_ROLE_ID INTEGER,
                         i_ROLE_ID      INTEGER,
                         i_USER_ID      INTEGER,
                         
                         i_CREATED_BY       INTEGER,
                         i_LAST_MODOFIED_BY INTEGER,
                         
                         i_APPROVAL_BY     NUMBER,
                         i_REQUEST_TYPE_ID INTEGER,
                         i_MENU_ID         INTEGER,
                         p_context_url     varchar2,
                         p_ip_mac_address  varchar2,
                         p_session_id      varchar2) RETURN VARCHAR2;

  function addAppMenuRole(i_APPMENUROLEID INTEGER,
                          i_APPMENUID     INTEGER,
                          i_ROLEID        INTEGER,
                          i_CREATED_BY    NUMBER,
                          
                          i_APPROVED_BY NUMBER,
                          
                          i_LASTMODIFIED_BY NUMBER,
                          
                          i_REQUEST_TYPE_ID integer,
                          i_MENU_ID         integer,
                          p_context_url     varchar2,
                          p_ip_mac_address  varchar2,
                          p_session_id      varchar2) RETURN VARCHAR2;

  function saveDepartment(i_DEPT_ID     NUMBER,
                          i_CORP_ID     NUMBER,
                          i_NAME        VARCHAR2,
                          i_DESCRIPTION VARCHAR2,
                          i_CREATED_BY  NUMBER,
                          
                          i_LAST_MODIFIED_BY NUMBER,
                          
                          i_APPROVAL_COMMENTS VARCHAR2,
                          i_APPROVED_BY       NUMBER,
                          
                          i_REQUEST_TYPE_ID integer,
                          i_MENU_ID         INTEGER,
                          p_context_url     varchar2,
                          p_ip_mac_address  varchar2,
                          p_session_id      varchar2) RETURN VARCHAR2;

  FUNCTION getDepartmentsByCorpId(i_CorpId Number) RETURN SYS_REFCURSOR;

  FUNCTION getUserTypes RETURN SYS_REFCURSOR;

  FUNCTION getAccountsByCorpId(i_CorpId IN VARCHAR2) RETURN SYS_REFCURSOR;

  FUNCTION getRoleTypes RETURN SYS_REFCURSOR;

  function getRoleTypesBySignFlag(p_signatory_flag char) RETURN SYS_REFCURSOR;

  FUNCTION getMenuHeadersByUserId(p_user_id varchar2) RETURN SYS_REFCURSOR;

  FUNCTION getMenuHeaderItemsByUserId(p_user_id      varchar2,
                                      i_MenuHeaderId Integer)
    RETURN SYS_REFCURSOR;

  FUNCTION getRolesForUser(p_user_id varchar2) RETURN SYS_REFCURSOR;

  FUNCTION getUserRoleById(p_user_role_id varchar2) RETURN SYS_REFCURSOR;

  FUNCTION getRolesForCorporate(i_CorpId varchar2) RETURN SYS_REFCURSOR;
  FUNCTION getRolesForCorporateByTypeId(i_CorpId       varchar2,
                                        p_role_type_id varchar2)
    RETURN SYS_REFCURSOR;

  FUNCTION getAllMenus(p_corp_id varchar2) RETURN SYS_REFCURSOR;

  FUNCTION getMenusByModuleCorpId(p_module_id varchar2, p_corp_id varchar2)
    RETURN SYS_REFCURSOR;

  function getUserProfileByUsername(p_corporate_id varchar2,
                                    p_username     varchar2)
    return sys_refcursor;

  function getCorporateProfile(i_CorpId varchar2) return sys_refcursor;

  -- FUNCTION getRmByCustomerId(i_CustomerId IN VARCHAR2) RETURN SYS_REFCURSOR;

  function saveUserAccountAccess(o_reference         out varchar2,
                                 i_ACCOUNT_ACCESS_ID NUMBER,
                                 i_USER_ID           NUMBER,
                                 i_CORP_ACCT_ID      NUMBER,
                                 i_CORP_ID           NUMBER,
                                 
                                 i_CREATED_BY NUMBER,
                                 
                                 i_APPROVED_BY NUMBER,
                                 
                                 i_LAST_MODIFIED_BY NUMBER,
                                 
                                 i_REQUEST_TYPE_ID INTEGER,
                                 i_MENU_ID         integer,
                                 i_ACCOUNT_RIGHTS  VARCHAR2,
                                 i_TRANSFER_LIMIT  number,
                                 i_view_balance    char,
                                 p_context_url     varchar2,
                                 p_ip_mac_address  varchar2,
                                 p_session_id      varchar2
                                 
                                 ) RETURN VARCHAR2;

  function saveApprovalGroup(o_reference      out varchar2,
                             i_GROUP_ID       NUMBER,
                             i_NAME           VARCHAR2,
                             i_DESCRIPTION    VARCHAR2,
                             i_CORP_ID        NUMBER,
                             i_APPROVAL_LEVEL NUMBER,
                             i_CREATED_BY     NUMBER,
                             
                             i_LAST_MODIFIED_BY NUMBER,
                             
                             i_APPROVAL_COMMENTS VARCHAR2,
                             i_APPROVED_BY       NUMBER,
                             
                             i_APPLY_APPROVAL_LIMIT VARCHAR2,
                             i_REQUEST_TYPE_ID      INTEGER,
                             i_GROUP_EMAILS         varchar2,
                             i_MENU_ID              integer,
                             i_group_type_id        integer,
                             i_target_route_sign_id integer,
                             p_system_generated     char,
                             p_context_url          varchar2,
                             p_ip_mac_address       varchar2,
                             p_session_id           varchar2) RETURN VARCHAR2;

  function saveApprovalUserGroup(o_reference                out varchar2,
                                 i_APPROVAL_GROUPS_USERS_ID NUMBER,
                                 i_GROUPS_USERS_TYPE        NUMBER,
                                 p_USER_ID                  NUMBER,
                                 p_DEPT_ID                  NUMBER,
                                 i_CREATED_BY               NUMBER,
                                 
                                 i_LAST_MODIFIED_BY NUMBER,
                                 
                                 i_APPROVAL_GROUP_ID NUMBER,
                                 i_CORP_ID           NUMBER,
                                 i_REQUEST_TYPE_ID   INTEGER,
                                 i_MENU_ID           integer,
                                 p_context_url       varchar2,
                                 p_ip_mac_address    varchar2,
                                 p_session_id        varchar2)
    RETURN VARCHAR2;

  FUNCTION searchCorporateProfiles(i_searchParam varchar2)
    RETURN SYS_REFCURSOR;

  procedure newPosFeed(
                       
                       i_MESSAGE      CLOB,
                       i_MESSAGE_TYPE VARCHAR2,
                       i_MESSAGE_CODE VARCHAR2
                       
                       );

  FUNCTION getPendingPosFeeds RETURN SYS_REFCURSOR;

  procedure newPosFinancialRequest(i_FEED_TYPE                    VARCHAR2,
                                   i_FEED_MESSAGE_CODE            VARCHAR2,
                                   i_FEED_MESSAGE_VERSION         VARCHAR2,
                                   i_FEED_TIMESTAMP               date,
                                   i_CLEARING_PERIOD              VARCHAR2,
                                   i_TRANSACTION_ID               VARCHAR2,
                                   i_TERMINAL_TYPE                VARCHAR2,
                                   i_PRT_APPLICATION_PDD          VARCHAR2,
                                   i_CHANNEL_MESSAGE_CODE         VARCHAR2,
                                   i_A041_CARD_ACCEPTOR_TERM_ID   VARCHAR2,
                                   i_AUTH_TRANSACTION_CODE        VARCHAR2,
                                   i_A012_LOCAL_TRANSACTION_TIME  VARCHAR2,
                                   i_A013_LOCAL_TRANSACTION_DATE  date,
                                   i_A004_TRANSACTION_AMOUNT      number,
                                   i_A007_TRANSMISION_DATE_TIME   date,
                                   i_A011_SYSTEM_TRACE_AUDIT_NUM  VARCHAR2,
                                   i_MERCHANT_CATEGORY_CODE       VARCHAR2,
                                   i_A022_PAN_AND_DATE_ENTRY_MODE VARCHAR2,
                                   i_A022_PIN_ENTRY_CAPABILITY    VARCHAR2,
                                   i_PAN_SEQUENCE_NUMBER          VARCHAR2,
                                   i_A025_POS_CONDITION_CODE      VARCHAR2,
                                   i_A026_POS_PIN_CAPTURE_CODE    VARCHAR2,
                                   i_ACCEPTING_INSTITUTION        VARCHAR2,
                                   i_RETRIEVAL_REFERENCE_NUMBER   VARCHAR2,
                                   i_CARD_ACCEPTOR_IDENT_CODE     VARCHAR2,
                                   i_A043_CARD_ACC_NME_LOC_8583   VARCHAR2,
                                   i_TRANSACTION_CURRENCY_CODE    VARCHAR2,
                                   i_A059_ECHO_DATA_8583          VARCHAR2,
                                   i_A095_REPLAC_AMOUNTS_8583     VARCHAR2,
                                   i_DATE_FETCHED                 DATE,
                                   i_POS_FEEDS_REF                VARCHAR);

  procedure newPosFinancialResponse(i_FEED_TYPE                  VARCHAR2,
                                    i_FEED_MESSAGE_CODE          VARCHAR2,
                                    i_FEED_MESSAGE_VERSION       VARCHAR2,
                                    i_FEED_TIMESTAMP             DATE,
                                    i_CLEARING_PERIOD            VARCHAR2,
                                    i_TRANSACTION_ID             VARCHAR2,
                                    i_EBMS_TRANSACTION_TAG       VARCHAR2,
                                    i_CHANNEL_MESSAGE_CODE       VARCHAR2,
                                    i_EPMS_RESPONSE_CODE         VARCHAR2,
                                    i_A041_CARD_ACCEPTOR_TERM_ID VARCHAR2,
                                    i_AUTH_RESPONSE_CODE         VARCHAR2,
                                    i_AUTH_RESPONSE_IDENTIFIER   VARCHAR2,
                                    i_FWD_INSTITUTION_ID_CODE    VARCHAR2,
                                    i_TRANSACTION_TIMESTAMP      DATE,
                                    i_TRANSACTION_AMOUNT         NUMBER,
                                    i_AMOUNT_SIGNAL              VARCHAR2,
                                    i_EPMS_TERMINAL_ID           VARCHAR2,
                                    i_BANK_CODE                  VARCHAR2,
                                    i_PRIMARY_ACCOUNT_NUMBER     VARCHAR2,
                                    i_CIPHER_DATA_KEY_INDEX      VARCHAR2,
                                    i_CARD_EXPIRATION_DATE       varchar2,
                                    i_PAYMENT_SYSTEM             VARCHAR2,
                                    i_EPMS_DECISION_SCENARIO     VARCHAR2,
                                    i_A059_ECHO_DATA_8583        VARCHAR2,
                                    i_DATE_FETCHED               DATE,
                                    i_POS_FEEDS_REF              VARCHAR);

  FUNCTION searchUsers(i_corpId varchar2, i_searchParam varchar2)
    RETURN SYS_REFCURSOR;

  FUNCTION searchRoles(i_corpId integer, i_searchParam varchar2)
    RETURN SYS_REFCURSOR;

  FUNCTION searchDepartments(i_corpId integer, i_searchParam varchar2)
    RETURN SYS_REFCURSOR;

  FUNCTION getApprovalGroupsByCorpId(i_corpId integer) RETURN SYS_REFCURSOR;

  FUNCTION getTransactionTypes RETURN SYS_REFCURSOR;

  FUNCTION getRouteTypes RETURN SYS_REFCURSOR;

  FUNCTION getModuleTypes RETURN SYS_REFCURSOR;

  FUNCTION getSignatoryTypes RETURN SYS_REFCURSOR;

  FUNCTION getApprovalGroupUserTypes RETURN SYS_REFCURSOR;

  function getUserProfilesByCorpId(i_corpId integer) return sys_refcursor;

  function getUserProfilesByGroupId(i_groupId integer) return sys_refcursor;
  FUNCTION getApprovalRoutesByCorpId(i_corpId integer) RETURN SYS_REFCURSOR;

  FUNCTION getCorporateAccountsByCorpId(i_corpId integer)
    RETURN SYS_REFCURSOR;

  function getCorporateAccountsByUserId(i_corp_id integer,
                                        p_user_id varchar)
    RETURN SYS_REFCURSOR;

  function saveCorporateDiscount(i_CHARGE_DISCOUNT_ID  INTEGER,
                                 i_CORP_ID             INTEGER,
                                 i_PAYMENT_TYPE_ID     INTEGER,
                                 i_PERCENTAGE_DISCOUNT number,
                                 
                                 i_CREATED_BY       INTEGER,
                                 i_LAST_MODOFIED_BY INTEGER,
                                 
                                 i_APPROVAL_BY     NUMBER,
                                 i_REQUEST_TYPE_ID INTEGER,
                                 i_MENU_ID         INTEGER,
                                 p_context_url     varchar2,
                                 p_ip_mac_address  varchar2,
                                 p_session_id      varchar2) RETURN VARCHAR2;

  function saveHoldingAccount(i_HOLDING_ACCOUNT_ID NUMBER,
                              i_ACCOUNT_NO         VARCHAR2,
                              i_ACCOUNT_TYPE       VARCHAR2,
                              i_NAME               VARCHAR2,
                              i_BRANCH_CODE        VARCHAR2,
                              i_CURRENCY_CODE      VARCHAR2,
                              
                              i_CREATED_BY       INTEGER,
                              i_LAST_MODOFIED_BY INTEGER,
                              
                              i_APPROVAL_BY     NUMBER,
                              i_REQUEST_TYPE_ID INTEGER,
                              i_MENU_ID         INTEGER,
                              p_context_url     varchar2,
                              p_ip_mac_address  varchar2,
                              p_session_id      varchar2) RETURN VARCHAR2;

  FUNCTION getHoldingAccounts RETURN SYS_REFCURSOR;

  function saveCorporateTerminal(i_CORP_TERMINAL_ID NUMBER,
                                 i_corp_id          varchar2,
                                 i_merchant_id      VARCHAR2,
                                 i_terminal_id      VARCHAR2,
                                 i_outlet_name      VARCHAR2,
                                 i_CREATED_BY       INTEGER,
                                 i_LAST_MODOFIED_BY INTEGER,
                                 i_APPROVAL_BY      NUMBER,
                                 i_REQUEST_TYPE_ID  INTEGER,
                                 i_MENU_ID          INTEGER,
                                 p_context_url      varchar2,
                                 p_ip_mac_address   varchar2,
                                 p_session_id       varchar2) RETURN VARCHAR2;

  FUNCTION getCorporateTerminals(i_corpId varchar2) RETURN SYS_REFCURSOR;

  function getPosTerminalTransactions(p_corp_id     varchar2,
                                      p_terminal_id varchar2,
                                      p_start_date  date,
                                      p_end_date    date)
    return SYS_REFCURSOR;

  function getPosTransactionSummary(p_corp_id     varchar2,
                                    p_terminal_id varchar2,
                                    p_start_date  date,
                                    p_end_date    date) RETURN sys_refcursor;

  FUNCTION getPaymentChannels RETURN SYS_REFCURSOR;
  FUNCTION getChargeOptions RETURN SYS_REFCURSOR;

  function generateSha512(p_plain_text in varchar2,
                          
                          p_salt in varchar2) return varchar2;
  function generatePassword return varchar2;

  FUNCTION loginuser(O_auth_response_message OUT varchar2,
                     o_send_sms              out varchar2,
                     o_segment               out varchar2,
                     
                     p_corporate_id    varchar2,
                     p_username        IN VARCHAR2,
                     p_hashed_password IN VARCHAR2,
                     p_ip_address      IN VARCHAR2
                     
                     ) RETURN VARCHAR2;

  function resetPassword(p_corporate_id   varchar2,
                         p_username       varchar2,
                         p_context_url    varchar2,
                         p_ip_mac_address varchar2,
                         p_session_id     varchar2) return varchar2;

  function changePassword(p_corporate_id      varchar2,
                          p_username          varchar2,
                          p_old_hash_password varchar2,
                          p_new_hash_password varchar2,
                          p_context_url       varchar2,
                          p_ip_mac_address    varchar2,
                          p_session_id        varchar2) return varchar2;
  function getCorporateProfileByAcctNo(p_account_number varchar2)
    return sys_refcursor;

  function getNextApprovalLevel(p_approval_route_id varchar2) return number;

  FUNCTION getAccountRights RETURN SYS_REFCURSOR;

  function getUserProfileById(p_id varchar2) return sys_refcursor;

  function getCorporateProfileById(p_id varchar2) return sys_refcursor;
  function getApprovalRouteById(p_id varchar2) return sys_refcursor;
  function getApprovalRouteSignatoryById(p_id varchar2) return sys_refcursor;
  function getApprovalSignByRouteId(p_corp_id  varchar2,
                                    p_route_id varchar2) return sys_refcursor;
  function getUserAccountAccessById(p_id varchar2) return sys_refcursor;
  function getRoleById(p_id varchar2) return sys_refcursor;
  function getApprovalGroupById(p_id varchar2) return sys_refcursor;
  function getApprovalGroupUsersByGroupId(pGroupId varchar2)
    return sys_refcursor;
  function getApprovalGroupUserById(p_id varchar2) return sys_refcursor;
  function getCorporateTerminalById(p_id varchar2) return sys_refcursor;
  function getHoldingAccountById(p_id varchar2) return sys_refcursor;
  function getDepartmentById(p_id varchar2) return sys_refcursor;
  function getLoanSchedules(p_loan_account_number varchar2)
    return sys_refcursor;
  function getLoanDetails(p_loan_account_number varchar2)
    return sys_refcursor;
  function getLoanSummary(p_corp_id IN VARCHAR2) return sys_refcursor;
  function getInvestmentSummary(p_corp_id varchar2) return sys_refcursor;
  function getInvestmentDetails(p_contract_number varchar2)
    return sys_refcursor;

  function getCorporateBeneByCorpId(p_corp_id              varchar2,
                                    p_beneficiary_category varchar2,
                                    p_product_category     varchar2)
    return sys_refcursor;
  function getCorporateBeneById(p_id varchar2) return sys_refcursor;
  FUNCTION getAccountListByUserId(p_user_id IN VARCHAR2) RETURN sys_refcursor;
  function getApprovedTransByUserId(p_user_id    varchar2,
                                    p_start_date date,
                                    p_end_date   date) return sys_refcursor;
  function getApprovedTransByStatus(p_batch_id    varchar2,
                                    p_status_flag varchar2)
    return sys_refcursor;
  function saveApprovalPriorities(p_APPROVAL_PRIORITIES_TYP APPROVAL_PRIORITIES_TYP,
                                  p_context_url             varchar2,
                                  p_ip_mac_address          varchar2,
                                  p_session_id              varchar2)
    RETURN VARCHAR2;
  function getApprovalPrioritiesByCorpId(p_corp_id varchar2)
    RETURN sys_refcursor;
  FUNCTION getModuleTypesByRoleId(p_role_id varchar2) RETURN SYS_REFCURSOR;
  function getBranches return sys_refcursor;
  FUNCTION getMenusByModuleRoleCorpId(p_module_id varchar2,
                                      p_role_id   varchar2,
                                      p_corp_id   varchar2)
    RETURN SYS_REFCURSOR;

  function saveBeneficiaries(p_corporate_beneficiaries corporate_beneficiaries_typ,
                             p_context_url             varchar2,
                             p_ip_mac_address          varchar2,
                             p_session_id              varchar2)
    RETURN VARCHAR2;
  function getCorporateBeneByCorpIdHtml(p_corp_id              varchar2,
                                        p_beneficiary_category varchar2)
    return sys_refcursor;
  function getApprovalRoutesByCorpId2(p_corp_id varchar2)
    return sys_refcursor;
  FUNCTION getAccountDetail(p_account_number varchar2) RETURN SYS_REFCURSOR;
  function getTransactionsByBatchId(p_batch_id varchar2) return sys_refcursor;
  function getTransactionsByUserId(p_user_id    varchar2,
                                   p_start_date date,
                                   p_end_date   date) return sys_refcursor;

  function createEventLog(p_USER_ID          number,
                          p_SESSION_ID       VARCHAR2,
                          p_EVENT_CATEGORY   varchar2,
                          p_EVENT_DETAIL     VARCHAR2,
                          p_CONTEXT_URL      varchar2,
                          p_IP_MAC_ADDRESS   varchar2,
                          p_SOURCE_APP_NAME  varchar2,
                          p_target_reference varchar2) return varchar2;

  function getGroupMembers(p_group_id varchar2) return sys_refcursor;
  function getRolesByTypeId(p_role_type_id varchar2) return Sys_Refcursor;

  function getAuditLogs(p_corp_id    number,
                        p_user_id    number,
                        p_start_date date,
                        p_end_date   date) return sys_refcursor;
  FUNCTION getCorporateTypes RETURN SYS_REFCURSOR;
  procedure clearBlockedUser;
  function saveCorporateLimit(i_CORP_LIMIT_ID            NUMBER,
                              i_corp_id                  varchar2,
                              p_TRANSACTION_LIMIT_AMOUNT NUMBER,
                              p_DAILY_LIMIT_AMOUNT       NUMBER,
                              p_TRANSACTION_LIMIT_COUNT  INTEGER,
                              p_DAILY_LIMIT_COUNT        INTEGER,
                              i_CREATED_BY               INTEGER,
                              i_LAST_MODOFIED_BY         INTEGER,
                              i_APPROVAL_BY              NUMBER,
                              i_REQUEST_TYPE_ID          INTEGER,
                              i_MENU_ID                  INTEGER,
                              p_context_url              varchar2,
                              p_ip_mac_address           varchar2,
                              p_session_id               varchar2)
    RETURN VARCHAR2;
  FUNCTION getCorporateLimit(i_corpId varchar2) RETURN SYS_REFCURSOR;
  --FUNCTION getCorporateLimitSetup(i_corpId varchar2) RETURN SYS_REFCURSOR;
  --FUNCTION getCorporateLimitSetup(i_corpId varchar2)
  --RETURN CORPORATE_LIMITS%rowtype;
  function getCorporateLimitById(p_id varchar2) return sys_refcursor;
  function getCorporateDiscountById(p_id varchar2) return sys_refcursor;
  function getCorporateDiscountsByCorpId(p_corp_id varchar2)
    return sys_refcursor;
  function getBanks return Sys_Refcursor;
  FUNCTION getquicktellercategories RETURN sys_refcursor;
  FUNCTION log_quickteller_res(p_account_number IN VARCHAR2,
                               p_bills_ref      IN VARCHAR2,
                               p_resp_xml       IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION getquicktellerbillers(pcategory IN VARCHAR2) RETURN sys_refcursor;
  FUNCTION getquicktellerbillerdetails(billerid IN VARCHAR2)
    RETURN sys_refcursor;
  function getDashBoardGraphValues(p_corp_id varchar2) return Sys_Refcursor;
  FUNCTION getaccountname(account_number IN VARCHAR2) RETURN sys_refcursor;

  ----=============== SPRINT 2 BEGINS ===================================
  function getPendingBatches(p_batch_state varchar2) return sys_refcursor;
  function getPendingBatchItems(p_batch_id    varchar2,
                                p_batch_state varchar2) return sys_refcursor;
  function updateBatchItems(p_batch_id          varchar2,
                            p_processing_status varchar2) return varchar2;
  function updateBatchItemEnquiryStatus(p_batch_id             varchar2,
                                        p_batch_detail_id      varchar2,
                                        p_napsneft_ref         varchar2,
                                        p_napsneft_status_code varchar2,
                                        p_napsneft_status_msg  varchar2)
    return varchar2;
  function getCorporateRm(p_corp_id varchar) return sys_refcursor;
  function getUserProfileByUsername2fa(p_corporate_id varchar2,
                                       p_username     varchar2)
    return sys_refcursor;
  FUNCTION getTokenOptions RETURN SYS_REFCURSOR;
  function getCorpUsersByApprovalLevel(p_corp_id        varchar2,
                                       p_approval_level integer)
    return sys_refcursor;
  function formatDateTime(p_date date) return varchar2;
  function getUserFullnameById(p_user_id varchar2) return varchar2;
  FUNCTION getApprovedRequestsByUserId(p_user_id    IN VARCHAR2,
                                       p_start_date date,
                                       p_end_date   date)
    RETURN SYS_REFCURSOR;

  FUNCTION getNarrationOptions RETURN SYS_REFCURSOR;

  FUNCTION createChequeBookRequest(i_REQUEST_ID         number,
                                   i_CORP_ID            number,
                                   i_ACCOUNT_NO         varchar2,
                                   i_NO_OF_LEAFLETS     number,
                                   i_NO_OF_BOOKLETS     number,
                                   i_DELIVERY_OPTION_ID number,
                                   i_COLLECTION_BRANCH  varchar2,
                                   i_RM_EMAIL           varchar2,
                                   
                                   i_CREATED_BY       NUMBER,
                                   i_APPROVED_BY      NUMBER,
                                   i_LAST_MODIFIED_BY NUMBER,
                                   i_REQUEST_TYPE_ID  INTEGER,
                                   i_MENU_ID          integer,
                                   p_context_url      varchar2,
                                   p_ip_mac_address   varchar2,
                                   p_session_id       varchar2,
                                   p_auth_token_flag  char,
                                   p_auth_token_sno   varchar2)
    RETURN VARCHAR2;
  FUNCTION createManagerChequeRequest(i_REQUEST_ID          number,
                                      i_CORP_ID             number,
                                      i_ACCOUNT_NO          varchar2,
                                      i_AMOUNT              number,
                                      i_BENEFICIARY_NAME    varchar2,
                                      i_DELIVERY_OPTION_ID  number,
                                      i_COLLECTION_BRANCH   varchar2,
                                      i_RM_EMAIL            varchar2,
                                      i_PURPOSE_OF_ISSUANCE varchar2,
                                      
                                      i_CREATED_BY       NUMBER,
                                      i_APPROVED_BY      NUMBER,
                                      i_LAST_MODIFIED_BY NUMBER,
                                      i_REQUEST_TYPE_ID  INTEGER,
                                      i_MENU_ID          integer,
                                      p_context_url      varchar2,
                                      p_ip_mac_address   varchar2,
                                      p_session_id       varchar2,
                                      p_auth_token_flag  char,
                                      p_auth_token_sno   varchar2)
    RETURN VARCHAR2;
  FUNCTION createChequeConfirmRequest(i_REQUEST_ID          NUMBER,
                                      i_CORP_ID             number,
                                      i_ACCOUNT_NO          varchar2,
                                      i_CHEQUE_NO           varchar2,
                                      i_AMOUNT              number,
                                      i_BENEFICIARY_NAME    varchar2,
                                      i_ISSUANCE_DATE       date,
                                      i_RM_EMAIL            varchar2,
                                      i_PURPOSE_OF_ISSUANCE varchar2,
                                      
                                      i_CREATED_BY       NUMBER,
                                      i_APPROVED_BY      NUMBER,
                                      i_LAST_MODIFIED_BY NUMBER,
                                      i_REQUEST_TYPE_ID  INTEGER,
                                      i_MENU_ID          integer,
                                      p_context_url      varchar2,
                                      p_ip_mac_address   varchar2,
                                      p_session_id       varchar2,
                                      p_auth_token_flag  char,
                                      p_auth_token_sno   varchar2)
    RETURN VARCHAR2;
  function getDeliveryOptions return sys_refcursor;
  FUNCTION getDomAccountListByUserId(p_user_id IN VARCHAR2)
    RETURN sys_refcursor;
  -- function getPendingServiceRequests return sys_refcursor;
  function getServiceRequestsByCorpId(p_corp_id           number,
                                      p_service_status_id number,
                                      p_start_date        date,
                                      p_end_date          date)
    return sys_refcursor;

  function getServiceRequests(p_corp_id           number,
                              p_service_status_id number,
                              p_start_date        date,
                              p_end_date          date) return sys_refcursor;
  function getServiceRequestStatus return sys_refcursor;
  function getServiceRequestDetailsById(p_service_request_type_id number,
                                        p_request_id              number)
    return sys_refcursor;
  function updateServiceRequestStatus(p_request_id              number,
                                      p_service_request_type_id number,
                                      p_request_status_id       number,
                                      p_actioned_by             varchar2,
                                      p_remarks                 varchar2)
    return varchar2;
  function getTransactionSchedules(p_batch_id varchar2) return varchar2;
  function getScheduledTxnSummaryByUserId(p_user_id    varchar2,
                                          p_start_date date,
                                          p_end_date   date)
    return sys_refcursor;
  function getScheduledTxnDetailByBatchId(p_batch_id    varchar2,
                                          p_status_flag varchar2)
    return sys_refcursor;

  FUNCTION deleteDisableEnableSI(p_REQUEST_TYPE_ID IN VARCHAR2,
                                 p_CREATED_BY      IN VARCHAR2,
                                 p_BATCH_ID        IN VARCHAR2,
                                 p_auth_token_flag char,
                                 p_auth_token_sno  varchar2,
                                 p_context_url     varchar2,
                                 p_ip_mac_address  varchar2,
                                 p_session_id      varchar2) RETURN VARCHAR2;

  function getCorporateCreditAccByUserId(i_corp_id integer,
                                         p_user_id varchar)
    RETURN SYS_REFCURSOR;

  FUNCTION changeCardStatusRequest(i_REQUEST_ID           NUMBER,
                                   i_CORP_ID              NUMBER,
                                   i_ACCOUNT_NO           VARCHAR2,
                                   i_card_pan             VARCHAR2,
                                   i_card_type            VARCHAR2,
                                   i_status_flag          CHAR,
                                   i_PHONE_NO             VARCHAR2,
                                   i_EMAIL_ADDRESS        VARCHAR2,
                                   i_RELATIONSHIP_MANAGER VARCHAR2,
                                   i_CREATED_BY           NUMBER,
                                   i_APPROVED_BY          NUMBER,
                                   i_LAST_MODIFIED_BY     NUMBER,
                                   i_REQUEST_TYPE_ID      INTEGER,
                                   i_MENU_ID              integer,
                                   p_context_url          varchar2,
                                   p_ip_mac_address       varchar2,
                                   p_session_id           varchar2,
                                   p_auth_token_flag      char,
                                   p_auth_token_sno       varchar2)
    RETURN VARCHAR2;

  FUNCTION createCardRequest(i_REQUEST_ID           NUMBER,
                             i_CORP_ID              NUMBER,
                             i_ACCOUNT_NO           VARCHAR2,
                             i_CARD_PAN             VARCHAR2,
                             i_CARD_TYPE            VARCHAR2,
                             i_CARD_SUB_TYPE        VARCHAR2,
                             i_DELIVERY_OPTION_ID   NUMBER,
                             i_PHONE_NO             VARCHAR2,
                             i_EMAIL_ADDRESS        VARCHAR2,
                             i_RELATIONSHIP_MANAGER VARCHAR2,
                             i_PICKUP_BRANCH        VARCHAR2,
                             i_COUNTRY              VARCHAR2,
                             i_START_DATE           VARCHAR2,
                             i_END_DATE             VARCHAR2,
                             i_CREATED_BY           NUMBER,
                             i_APPROVED_BY          NUMBER,
                             i_LAST_MODIFIED_BY     NUMBER,
                             i_REQUEST_TYPE_ID      INTEGER,
                             i_MENU_ID              integer,
                             p_context_url          varchar2,
                             p_ip_mac_address       varchar2,
                             p_session_id           varchar2,
                             p_auth_token_flag      char,
                             p_auth_token_sno       varchar2,
                              i_CARD_QUANTITY             VARCHAR2,
                               i_CARD_SPEND_LIMIT             VARCHAR2,
                                i_CLEAN_UP_CYCLE             VARCHAR2,
                                 i_NAME_ON_CARD             VARCHAR2,
                                  i_AUTO_RENEW             VARCHAR2,
                                   i_DELIVERY_ADDRESS             VARCHAR2) RETURN VARCHAR2;
                                   
  FUNCTION changeCardLimitsRequest(i_REQUEST_ID           NUMBER,
                                   i_CORP_ID              NUMBER,
                                   i_ACCOUNT_NO           VARCHAR2,
                                   i_card_pan             VARCHAR2,
                                   i_card_type            VARCHAR2,
                                   i_limit_type           varchar2,
                                   i_limit_value          number,
                                   i_PHONE_NO             VARCHAR2,
                                   i_EMAIL_ADDRESS        VARCHAR2,
                                   i_RELATIONSHIP_MANAGER VARCHAR2,
                                   i_CREATED_BY           NUMBER,
                                   i_APPROVED_BY          NUMBER,
                                   i_LAST_MODIFIED_BY     NUMBER,
                                   i_REQUEST_TYPE_ID      INTEGER,
                                   i_MENU_ID              integer,
                                   p_context_url          varchar2,
                                   p_ip_mac_address       varchar2,
                                   p_session_id           varchar2,
                                   p_auth_token_flag      char,
                                   p_auth_token_sno       varchar2)
    RETURN VARCHAR2;

  -----Added For Sprint 3 Managers Cheque Upload------

  function addManagersChequeUploadTemp(
                                       
                                       p_CORP_ID             IN VARCHAR2,
                                       p_ACCOUNT_NO          IN VARCHAR2,
                                       p_AMOUNT              IN VARCHAR2,
                                       p_BENEFICIARY_NAME    IN VARCHAR2,
                                       p_DELIVERY_OPTION_ID  IN VARCHAR2,
                                       p_COLLECTION_BRANCH   IN VARCHAR2,
                                       p_PURPOSE_OF_ISSUANCE IN VARCHAR2,
                                       p_CREATED_BY          IN VARCHAR2,
                                       --p_APPROVAL_STATUS_ID IN VARCHAR2,
                                       p_REQUEST_TYPE_ID IN VARCHAR2,
                                       
                                       --p_RECORD_STATUS_ID IN VARCHAR2,
                                       p_NO_OF_RECORD    IN VARCHAR2,
                                       p_UPLOAD_FILENAME IN VARCHAR2,
                                       i_MENU_ID         IN VARCHAR2,
                                       p_auth_token_flag IN VARCHAR2,
                                       p_auth_token_sno  IN VARCHAR2,
                                       p_session_id      IN VARCHAR2,
                                       p_context_url     IN VARCHAR2,
                                       p_ip_mac_address  IN VARCHAR2,
                                       p_BATCH_ID        IN VARCHAR2)
    return varchar2;

  function addManagersChequeUploadDetail(
                                         
                                         p_CORP_ID             IN VARCHAR2,
                                         p_ACCOUNT_NO          IN VARCHAR2,
                                         p_AMOUNT              IN VARCHAR2,
                                         p_BENEFICIARY_NAME    IN VARCHAR2,
                                         p_DELIVERY_OPTION_ID  IN VARCHAR2,
                                         p_COLLECTION_BRANCH   IN VARCHAR2,
                                         p_PURPOSE_OF_ISSUANCE IN VARCHAR2,
                                         p_CREATED_BY          IN VARCHAR2,
                                         --p_APPROVAL_STATUS_ID IN VARCHAR2,
                                         p_REQUEST_TYPE_ID IN VARCHAR2,
                                         
                                         --p_RECORD_STATUS_ID IN VARCHAR2,
                                         p_NO_OF_RECORD    IN VARCHAR2,
                                         p_UPLOAD_FILENAME IN VARCHAR2,
                                         i_MENU_ID         IN VARCHAR2,
                                         p_auth_token_flag IN VARCHAR2,
                                         p_auth_token_sno  IN VARCHAR2,
                                         p_session_id      IN VARCHAR2,
                                         p_context_url     IN VARCHAR2,
                                         p_ip_mac_address  IN VARCHAR2,
                                         p_BATCH_ID        IN VARCHAR2)
    return varchar2;

  FUNCTION create_fx_transfer_request(i_REQUEST_ID               NUMBER,
                                      i_CORP_ID                  NUMBER,
                                      i_account_number           VARCHAR2,
                                      i_account_currency         VARCHAR2,
                                      i_transfer_amount          NUMBER,
                                      i_charge_option            VARCHAR2,
                                      i_beneficiary_name         VARCHAR2,
                                      i_beneficiary_address      VARCHAR2,
                                      i_beneficiary_bank_name    VARCHAR2,
                                      i_beneficiary_bank_address VARCHAR2,
                                      i_iban_code                VARCHAR2,
                                      i_swift_code               VARCHAR2,
                                      i_purpose_of_payment       VARCHAR2,
                                      i_sort_code                VARCHAR2,
                                      i_int_bank_account_number  VARCHAR2,
                                      i_int_bank_iban_code       VARCHAR2,
                                      i_int_bank_swift_code      VARCHAR2,
                                      i_int_bank_sort_code       VARCHAR2,
                                      i_CREATED_BY               NUMBER,
                                      i_APPROVED_BY              NUMBER,
                                      i_LAST_MODIFIED_BY         NUMBER,
                                      i_REQUEST_TYPE_ID          INTEGER,
                                      i_MENU_ID                  integer,
                                      p_context_url              varchar2,
                                      p_ip_mac_address           varchar2,
                                      p_session_id               varchar2,
                                      p_auth_token_flag          char,
                                      p_auth_token_sno           varchar2)
    RETURN VARCHAR2;

  FUNCTION getFxTransferPurposes RETURN SYS_REFCURSOR;
  function formatDate(p_date date) return varchar2;

  function save_Beneficiary_acct_group(i_group_id         number,
                                       i_corp_id          number,
                                       i_name             varchar2,
                                       i_description      varchar2,
                                       i_CREATED_BY       NUMBER,
                                       i_APPROVED_BY      NUMBER,
                                       i_LAST_MODIFIED_BY NUMBER,
                                       i_REQUEST_TYPE_ID  INTEGER,
                                       i_MENU_ID          integer,
                                       p_context_url      varchar2,
                                       p_ip_mac_address   varchar2,
                                       p_session_id       varchar2,
                                       p_auth_token_flag  char,
                                       p_auth_token_sno   varchar2)
    RETURN VARCHAR2;

  function save_Beneficiary_detail(i_beneficiary_id   number,
                                   i_beneficiary_code VARCHAR2,
                                   i_corp_id          number,
                                   i_name             varchar2,
                                   i_address          varchar2,
                                   i_mobile_number    varchar2,
                                   i_email_address    varchar2,
                                   
                                   i_CREATED_BY       NUMBER,
                                   i_APPROVED_BY      NUMBER,
                                   i_LAST_MODIFIED_BY NUMBER,
                                   i_REQUEST_TYPE_ID  INTEGER,
                                   i_MENU_ID          integer,
                                   p_context_url      varchar2,
                                   p_ip_mac_address   varchar2,
                                   p_session_id       varchar2,
                                   p_auth_token_flag  char,
                                   p_auth_token_sno   varchar2)
    RETURN VARCHAR2;

  function save_Beneficiary_account(i_account_id                 number,
                                    i_beneficiary_id             number,
                                    i_beneficiary_acct_group_id  number,
                                    i_corp_id                    NUMBER,
                                    i_preferred_name             VARCHAR2,
                                    i_destination_bank_code      VARCHAR2,
                                    i_account_name               VARCHAR2,
                                    i_acctno_phoneno_rsa_tax_tin VARCHAR2,
                                    i_product_category           VARCHAR2,
                                    i_beneficiary_acct_code      varchar2,
                                    i_CREATED_BY                 NUMBER,
                                    i_APPROVED_BY                NUMBER,
                                    i_LAST_MODIFIED_BY           NUMBER,
                                    i_REQUEST_TYPE_ID            INTEGER,
                                    i_MENU_ID                    integer,
                                    p_context_url                varchar2,
                                    p_ip_mac_address             varchar2,
                                    p_session_id                 varchar2,
                                    p_auth_token_flag            char,
                                    p_auth_token_sno             varchar2)
    RETURN VARCHAR2;

  function get_corp_beneacctgrp_by_corpid(p_corp_id number)
    return Sys_Refcursor;
  function get_corp_beneficiary_by_corpid(p_corp_id number)
    return Sys_Refcursor;
  function get_corp_bene_acct_by_beneid(p_beneficiary_id number)
    return Sys_Refcursor;
  function get_corp_bene_acct_by_catid(p_corp        number,
                                       p_category_id varchar2)
    return sys_refcursor;

  FUNCTION create_upload_batch_master(i_batch_id         VARCHAR2,
                                      i_corp_id          NUMBER,
                                      i_description      varchar2,
                                      i_total_count      number,
                                      i_total_amount     number,
                                      i_file_name        varchar2,
                                      i_file_content     clob,
                                      i_file_ext         varchar2,
                                      i_file_size        number,
                                      i_CREATED_BY       NUMBER,
                                      i_APPROVED_BY      NUMBER,
                                      i_LAST_MODIFIED_BY NUMBER,
                                      i_REQUEST_TYPE_ID  INTEGER,
                                      i_MENU_ID          integer,
                                      p_context_url      varchar2,
                                      p_ip_mac_address   varchar2,
                                      p_session_id       varchar2,
                                      p_auth_token_flag  char,
                                      p_auth_token_sno   varchar2)
    RETURN VARCHAR2;

  function get_corp_bene_acct_by_catgrpid(p_corp        number,
                                          p_group_id    varchar2,
                                          p_category_id varchar2)
    return sys_refcursor;
  function get_corp_bene_acct_by_acctcode(p_corp_id               number,
                                          p_beneficiary_acct_code varchar2)
    return Sys_Refcursor;

  FUNCTION selectpendingRTGS(p_THREAD_id IN VARCHAR2) RETURN sys_refcursor;
  function getRecordStatusId(i_requestTypeId integer) return integer;
  function getApprovalStatusId(i_requestTypeId integer) return integer;
  FUNCTION stopChequeRequest(i_REQUEST_ID         number,
                                   i_CORP_ID            number,
                                   i_ACCOUNT_NO         varchar2,
                                  i_START_CHEQUE_NUMBER varchar2,
                                   i_END_CHEQUE_NUMBER varchar2,
                                   i_CREATED_BY       NUMBER,
                                   i_APPROVED_BY      NUMBER,
                                   i_LAST_MODIFIED_BY NUMBER,
                                   i_REQUEST_TYPE_ID  INTEGER,
                                   i_MENU_ID          integer,
                                   p_context_url      varchar2,
                                   p_ip_mac_address   varchar2,
                                   p_session_id       varchar2,
                                   p_auth_token_flag  char,
                                   p_auth_token_sno   varchar2,
                                    p_no_of_booklet   varchar2,
  p_no_of_leaflet   varchar2)
    RETURN VARCHAR2;
  FUNCTION createExpenseCardRequest(i_REQUEST_ID           NUMBER,
                             i_CORP_ID              NUMBER,
                             i_ACCOUNT_NO           VARCHAR2,
                             i_CARD_PAN             VARCHAR2,
                             i_CARD_TYPE            VARCHAR2,
                             i_CARD_SUB_TYPE        VARCHAR2,
                             i_ACTION    VARCHAR2,
                             
                             i_CREATED_BY           NUMBER,
                             i_APPROVED_BY          NUMBER,
                             i_LAST_MODIFIED_BY     NUMBER,
                             i_REQUEST_TYPE_ID      INTEGER,
                             i_MENU_ID              integer,
                             p_context_url          varchar2,
                             p_ip_mac_address       varchar2,
                             p_session_id           varchar2,
                             p_auth_token_flag      char,
                             p_auth_token_sno       varchar2
                              ) RETURN VARCHAR2;
  
  
  procedure createAuditLog(p_USER_ID        VARCHAR2,
                           p_SESSION_ID     VARCHAR2,
                           p_EVENT_CATEGORY varchar2,
                           p_EVENT_DETAIL   VARCHAR2,
                           p_CONTEXT_URL    varchar2,
                           p_IP_MAC_ADDRESS varchar2,
                           -- p_SOURCE_APP_NAME varchar2,
                           p_MENU_ID          varchar2,
                           p_request_type_id  VARCHAR2,
                           p_response         varchar2,
                           p_target_reference varchar2);

  function getFriendlyExceptionMessage(p_raw_error_message varchar2,
                                       
                                       p_menu_id integer) return varchar2;
                                       
function getStopChequeStatusByCorpId(p_corp_id number)
    return sys_refcursor;
    function getFixedDepositStatusByCorpId(p_corp_id   number)
    return sys_refcursor;
  function save_beneficiaries_v2(p_corporate_beneficiaries_v2 corporate_beneficiaries_v2_typ,
                                 p_context_url                varchar2,
                                 p_ip_mac_address             varchar2,
                                 p_session_id                 varchar2)
    return varchar2;
    
    FUNCTION ADD_FEP_LOG(
   p_ID IN VARCHAR2,
   p_ABBRIDGE_PAN  IN VARCHAR2,
   p_CHANNEL IN VARCHAR2,
   p_USERNAME IN VARCHAR2,
   p_REQUEST_TYPE  IN VARCHAR2,
   p_ACCOUNT_NO    IN VARCHAR2,
   p_PAN           IN VARCHAR2)
   RETURN VARCHAR2;
   
   FUNCTION saveEmailIndemnityRequest(i_REQUEST_ID         number,
                                   i_CORP_ID            number,
                                   i_ACCOUNT_NO         varchar2,
                                   i_EMAIL     varchar2,
                                   i_MOBILE     number,
                                   i_ACCOUNT_NAME varchar2,
                                   i_CREATED_BY       NUMBER,
                                   i_APPROVED_BY      NUMBER,
                                   i_LAST_MODIFIED_BY NUMBER,
                                   i_REQUEST_TYPE_ID  INTEGER,
                                   i_MENU_ID          integer,
                                   p_context_url      varchar2,
                                   p_ip_mac_address   varchar2,
                                   p_session_id       varchar2,
                                   p_auth_token_flag  char,
                                   p_auth_token_sno   varchar2)
    RETURN VARCHAR2;
    
   FUNCTION createHRquickResponse(i_REQUEST_ID           NUMBER,
                             i_CORP_ID              NUMBER,
                             --i_STATUS             VARCHAR2,
                             i_CHANNEL            VARCHAR2,
                             i_STAFF_MOBILE_NUMBER        VARCHAR2,
                             i_STAFF_NUMBER   NUMBER,
                             i_SMS_CONTENT             VARCHAR2,
                             i_STAFF_EMAIL        VARCHAR2,
                             i_MESSAGE_SUBJECT VARCHAR2,
                             i_MESSAGE_CATEGORY        VARCHAR2,
                             i_STAFF_BRANCH_CODE              VARCHAR2,
                             i_STAFF_NAME           VARCHAR2,
                             i_MESSAGE_CONTENT            VARCHAR2,
                             i_CREATED_BY           NUMBER,
                             i_APPROVED_BY          NUMBER,
                             i_LAST_MODIFIED_BY     NUMBER,
                             i_REQUEST_TYPE_ID      INTEGER,
                             i_MENU_ID              integer,
                             p_context_url          varchar2,
                             p_ip_mac_address       varchar2,
                             p_session_id           varchar2,
                             p_auth_token_flag      char,
                             p_auth_token_sno       varchar2,
							 p_state varchar2,
							 p_lga varchar2,
							 
							 p_incidenttype varchar2,
							 
							 p_searchoption varchar2,
							 
							 p_emailgroup varchar2,
							 p_group varchar2,
							 p_otheraction varchar2
                             
                             ) RETURN VARCHAR2;
   
END;