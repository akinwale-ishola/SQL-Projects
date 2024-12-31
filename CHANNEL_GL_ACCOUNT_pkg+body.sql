create or replace package body   CHANNEL_GL_ACCOUNT_pkg is

function whatsAppLimitExceeded(p_accountNumber varchar2,p_tranAmt Number)  RETURN VARCHAR2 IS
	   
	   v_count             INTEGER;
     v_amountspent            Number(18,2);
      v_totalAmtToSSpend            Number(18,2);
     v_limit            Number(18,2);
	 v_response              VARCHAR2(100);
	   
	   
	    begin
    v_amountspent:=0.0;
    v_limit:=0.0;
    v_response :='N';
    Select TRANSFER_LIMIT into v_limit from  WHATSAPPBNK.WHATSAPP_REG_TABLE where CUST_AC_NO=p_accountNumber;
    select sum(amount) into v_amountspent from UBNPOSTING_BATCH_ITEMS_HIST a
join UBNPOSTING_BATCH_MASTER b on b.PAYMENT_REFERENCE=a.PAYMENT_REFERENCE and REQUEST_MODULE_ID='' and b.CBA_RESPONSE_CODE='00' and trunc(TRANSACTION_DATE)=trunc(sysdate)
where a.ACCOUNT_TYPE='CASA' AND a.CR_DR_FLAG='D' and a.ACCOUNT_NUMBER=p_accountNumber;
	  
	   v_totalAmtToSSpend:=v_amountspent+p_tranAmt;
	      IF (v_totalAmtToSSpend > v_limit) THEN
		  
		  v_response :='Y' ;
		
		  END IF;
		  
		
	      return v_response;
		
		END whatsAppLimitExceeded;
    
	   function GETCHANNELGLACCOUNT(p_accountNumber varchar2, p_module_id varchar2)  RETURN VARCHAR2 IS
	   
	   v_count             INTEGER;
	 v_response              VARCHAR2(100);
	   
	   
	    begin
    
	  select count(1)
        into v_count
        from MISERV.CHANNEL_GL_ACCOUNTS
       where MODULE_ID = p_module_id and GL_ACCOUNT=p_accountNumber and Del_flg='N';
	   
	      IF (v_count > 0) THEN
		  
		  v_response :='Y' ;
		  else
		  v_response :='N';
		  
		  
		  END IF;
		  
		
	      return v_response;
		
		END GETCHANNELGLACCOUNT;
    
   function REVERSENIPTRANSACTION( v_responseCode varchar2)  RETURN VARCHAR2 IS
	   
	   v_count             INTEGER;
	 v_response              VARCHAR2(100);
	   
	   
	    begin
    
	  select count(1)
        into v_count
        from PAYMENTS.REF_RESPONSE_CODES
       where RESPONSE_CODE=v_responseCode and REVERSE='Y';
	   
	      IF (v_count > 0) THEN
		  
		  v_response :='Y' ;
		  else
		  v_response :='N';
		  
		  
		  END IF;
		  
		
	      return v_response;
		
		END REVERSENIPTRANSACTION;
	   
	   end CHANNEL_GL_ACCOUNT_pkg;