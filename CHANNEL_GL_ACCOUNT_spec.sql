create or replace PACKAGE        CHANNEL_GL_ACCOUNT_pkg AS
function GETCHANNELGLACCOUNT(p_accountNumber varchar2, p_module_id varchar2)  return varchar2;
function REVERSENIPTRANSACTION( v_responseCode varchar2)  return varchar2;
function whatsAppLimitExceeded(p_accountNumber varchar2, p_tranAmt Number)  RETURN VARCHAR2;
 END;