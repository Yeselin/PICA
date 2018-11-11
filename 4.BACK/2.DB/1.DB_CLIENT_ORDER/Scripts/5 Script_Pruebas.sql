-- SET SERVEROUTPUT ON
-- alter SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
-- SELECT * FROM TOURESBALON.CUSTOMER WHERE DOCUMENT_TYPE_ID = 2 AND DOCUMENT_ID = '500123' ORDER BY UPDATE_DATE DESC
-- SELECT * FROM TOURESBALON.CUSTOMER WHERE DOCUMENT_TYPE_ID = 1 AND DOCUMENT_ID = '23094857' ORDER BY UPDATE_DATE DESC
--INSERTS CUSTOMER
SET SERVEROUTPUT ON
DECLARE
V_RESPONSE_ID INTEGER :=0;
V_RESPONSE_DESC VARCHAR2(4000 BYTE) := '';
BEGIN
TOURESBALON.PK_CUSTOMER.PR_CREATE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                              P_DOCUMENT_ID            =>'500123',
                                  P_FIRST_NAME             =>'Gerardo',
                                  P_LAST_NAME              =>'Herrera',
                                  P_PHONE_NUMBER           =>'3211234567',
                                  P_EMAIL                  =>'timolo@hotmail.com',
                                  --P_PASSWORD               =>'123456',
						          P_CUSTOMER_CATEGORY_NAME =>'DORADO',
						          --P_CREDITCARD_NAME        =>'VISA',
                                  --P_CREDITCARD_NUMBER      =>'1234567891234567',
						          P_CUSTOMER_STATUS_NAME   =>'ACTIVO',
						          P_STREET                 =>'BOGOTA',
                                  P_STATE                  =>'BOGOTÁ, D. C.',
                                  P_ZIP                    =>'11001',
                                  P_COUNTRY                =>'COLOMBIA',
                                  P_CITY                   =>'BOGOTÁ, D.C.',
								  P_RESPONSE_ID            => V_RESPONSE_ID,
                                  P_RESPONSE_DESC          => V_RESPONSE_DESC
								  );
COMMIT;
dbms_output.put_line( '1 - P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

END;
/

SET SERVEROUTPUT ON
DECLARE
V_RESPONSE_ID INTEGER :=0;
V_RESPONSE_DESC VARCHAR2(4000 BYTE) := '';
BEGIN
TOURESBALON.PK_CUSTOMER.PR_CREATE(P_DOCUMENT_TYPE_NAME     =>'CC',
	                              P_DOCUMENT_ID            =>'23094857',
                                  P_FIRST_NAME             =>'Yeselin',
                                  P_LAST_NAME              =>'Eublime',
                                  P_PHONE_NUMBER           =>'+573111111111',
                                  P_EMAIL                  =>'yeselin.eublime@gmail.com',
                                  --P_PASSWORD               =>'123456',
						          P_CUSTOMER_CATEGORY_NAME =>'DORADO',
						          --P_CREDITCARD_NAME        =>'VISA',
                                  --P_CREDITCARD_NUMBER      =>'1234567891234567',
						          P_CUSTOMER_STATUS_NAME   =>'ACTIVO',
						          P_STREET                 =>'BOGOTA',
                                  P_STATE                  =>'BOGOTÁ, D. C.',
                                  P_ZIP                    =>'11001',
                                  P_COUNTRY                =>'COLOMBIA',
                                  P_CITY                   =>'BOGOTÁ, D.C.',
								  P_RESPONSE_ID            => V_RESPONSE_ID,
                                  P_RESPONSE_DESC          => V_RESPONSE_DESC
								  );
COMMIT;
dbms_output.put_line( '1 - P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

END;
/

-- UPDATE CUSTOMER
SET SERVEROUTPUT ON
DECLARE
V_RESPONSE_ID INTEGER :=0;
V_RESPONSE_DESC VARCHAR2(4000 BYTE) := '';
BEGIN
TOURESBALON.PK_CUSTOMER.PR_UPDATE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                              P_DOCUMENT_ID            =>'500123',
                                  P_FIRST_NAME             =>'Gerardo',
                                  P_LAST_NAME              =>'Herrera',
                                  P_PHONE_NUMBER           =>'3123456789',
                                  P_EMAIL                  =>'timolo@hotmail.com',
                                  --P_PASSWORD               =>'123456',
						          P_CUSTOMER_CATEGORY_NAME =>'DORADO',
						          --P_CREDITCARD_NAME        =>'VISA',
                                  --P_CREDITCARD_NUMBER      =>'7654321987654321',
						          P_CUSTOMER_STATUS_NAME   =>'ACTIVO',
						          P_STREET                 =>'BOGOTA',
                                  P_STATE                  =>'BOGOTÁ, D. C.',
                                  P_ZIP                    =>'11001',
                                  P_COUNTRY                =>'COLOMBIA',
                                  P_CITY                   =>'BOGOTÁ, D.C.',
                                  P_RESPONSE_ID            => V_RESPONSE_ID,
                                  P_RESPONSE_DESC          => V_RESPONSE_DESC
								  );
COMMIT;
dbms_output.put_line( '1 - P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
END;
/

-- DELETE CUSTOMER
SET SERVEROUTPUT ON
DECLARE
V_RESPONSE_ID INTEGER :=0;
V_RESPONSE_DESC VARCHAR2(4000 BYTE) := '';
BEGIN
TOURESBALON.PK_CUSTOMER.PR_DELETE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                              P_DOCUMENT_ID            =>'500123',
						          P_CUSTOMER_STATUS_NAME   =>'INACTIVO',
                                  P_RESPONSE_ID            => V_RESPONSE_ID,
                                  P_RESPONSE_DESC          => V_RESPONSE_DESC
								  );
COMMIT;
dbms_output.put_line( '1 - P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC);
END;
/


--CONSULTA CUSTOMER
SET SERVEROUTPUT ON
DECLARE
V_FIRST_NAME             VARCHAR2(50 BYTE) := '';
V_LAST_NAME              VARCHAR2(50 BYTE) := '';
V_PHONE_NUMBER           VARCHAR2(20 BYTE) := '';
V_EMAIL                  VARCHAR2(50 BYTE) := '';
V_CUSTOMER_CATEGORY_NAME VARCHAR2(50 BYTE) := '';
V_CUSTOMER_STATUS_NAME   VARCHAR2(50 BYTE) := '';
V_CREATE_DATE            VARCHAR2(50 BYTE) := '';
V_UPDATE_DATE            VARCHAR2(50 BYTE) := '';
V_STREET                 VARCHAR2(50 BYTE) := '';
V_STATE                  VARCHAR2(50 BYTE) := '';
V_ZIP                    VARCHAR2(50 BYTE) := '';
V_COUNTRY                VARCHAR2(50 BYTE) := '';
V_CITY                   VARCHAR2(50 BYTE) := '';
V_OUT_DOCUMENT_TYPE_ID   INTEGER := 0;
V_OUT_DOCUMENT_ID        VARCHAR2(20 BYTE) := '';
V_RESPONSE_ID            INTEGER :=0;
V_RESPONSE_DESC          VARCHAR2(4000 BYTE) := '';
BEGIN
TOURESBALON.PK_CUSTOMER.PR_READ  (P_DOCUMENT_TYPE_NAME     =>'CE',
	                              P_DOCUMENT_ID            =>'500123',
								  P_FIRST_NAME             => V_FIRST_NAME,
                                  P_LAST_NAME              => V_LAST_NAME,
                                  P_PHONE_NUMBER           => V_PHONE_NUMBER,
                                  P_EMAIL                  => V_EMAIL,
					              P_CUSTOMER_CATEGORY_NAME => V_CUSTOMER_CATEGORY_NAME,
					              P_CUSTOMER_STATUS_NAME   => V_CUSTOMER_STATUS_NAME,
					              P_CREATE_DATE            => V_CREATE_DATE,
					              P_UPDATE_DATE            => V_UPDATE_DATE,
					              P_STREET                 => V_STREET,
                                  P_STATE                  => V_STATE,
                                  P_ZIP                    => V_ZIP,
                                  P_COUNTRY                => V_COUNTRY,
                                  P_CITY                   => V_CITY,
					              P_OUT_DOCUMENT_TYPE_ID   => V_OUT_DOCUMENT_TYPE_ID,
					              P_OUT_DOCUMENT_ID        => V_OUT_DOCUMENT_ID,
					              P_RESPONSE_ID            => V_RESPONSE_ID,
                                  P_RESPONSE_DESC          => V_RESPONSE_DESC
								  );
dbms_output.put_line( '1 - P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC);
COMMIT;
END;
/
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- SET SERVEROUTPUT ON
-- alter SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
-- SELECT A.* , B.* FROM ORDERTB.SALES_ORDER A 
-- INNER JOIN ORDERTB.ORDER_ITEM B ON (B.SALES_ORDER_ID = A.ID)
-- WHERE A.CUSTOMER_DOCUMENT_TYPE_ID = 2 AND A.CUSTOMER_DOCUMENT_ID = '500123'

/*
BEGIN
DELETE FROM ORDERTB.ORDER_ITEM;
COMMIT;

DELETE FROM ORDERTB.SALES_ORDER;
COMMIT;
END;
/
*/

--INSERTS ORDER
SET SERVEROUTPUT ON
DECLARE
V_SALES_ORDER_ID NUMBER:= 0;
V_ORDER_ITEM_ID NUMBER:= 0;
V_RESPONSE_ID INTEGER :=0;
V_RESPONSE_DESC VARCHAR2(4000 BYTE) := '';
BEGIN
ORDERTB.PK_ORDER.PR_CREATE(P_PRICE                       => 75,
	                       P_ORDER_STATUS_NAME           => 'VALIDACION',
                           P_COMMENTS                    => 'CREACION DE ORDEN',
	                       P_CUSTOMER_DOCUMENT_TYPE_NAME => 'CE',
                           P_CUSTOMER_DOCUMENT_ID        => '500123',
						   P_PAYMENT_ID                  => '12345',
	                       P_PAYMENT_STATUS              => 1,
						   P_OUT_SALES_ORDER_ID          => V_SALES_ORDER_ID,
				           P_RESPONSE_ID                 => V_RESPONSE_ID,
                           P_RESPONSE_DESC               => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line( '1 - P_OUT_SALES_ORDER_ID: '||V_SALES_ORDER_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

ORDERTB.PK_ORDER.PR_CREATE_ITEM (P_PRODUCT_ID                  => 1,
                                 P_PRODUCT_NAME                => 'R.C.D. Espanyol / Real Madrid C.F.',
                                 P_PARTNUM                     => '1',
                                 P_PRICE_ITEM                  => 20,
                                 P_QUANTITY                    => 1,
							     P_SALES_ORDER_ID              => V_SALES_ORDER_ID,
							     P_ITEM_STATUS_NAME            => 'VALIDACION',
							     P_OUT_ORDER_ITEM_ID           => V_ORDER_ITEM_ID,
				                 P_RESPONSE_ID                 => V_RESPONSE_ID,
                                 P_RESPONSE_DESC               => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line( '2 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 


ORDERTB.PK_ORDER.PR_CREATE_ITEM (P_PRODUCT_ID                  => 7,
                                 P_PRODUCT_NAME                => 'C.D. Europa / Real Racing Club',
                                 P_PARTNUM                     => '2',
                                 P_PRICE_ITEM                  => 15,
                                 P_QUANTITY                    => 1,
							     P_SALES_ORDER_ID              => V_SALES_ORDER_ID,
							     P_ITEM_STATUS_NAME            => 'VALIDACION',
							     P_OUT_ORDER_ITEM_ID           => V_ORDER_ITEM_ID,
				                 P_RESPONSE_ID                 => V_RESPONSE_ID,
                                 P_RESPONSE_DESC               => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line( '3 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

ORDERTB.PK_ORDER.PR_CREATE_ITEM (P_PRODUCT_ID                  => 25,
                                 P_PRODUCT_NAME                => 'F.C. Barcelona / C.D. Europa',
                                 P_PARTNUM                     => '3',
                                 P_PRICE_ITEM                  => 20,
                                 P_QUANTITY                    => 2,
							     P_SALES_ORDER_ID              => V_SALES_ORDER_ID,
							     P_ITEM_STATUS_NAME            => 'VALIDACION',
							     P_OUT_ORDER_ITEM_ID           => V_ORDER_ITEM_ID,
				                 P_RESPONSE_ID                 => V_RESPONSE_ID,
                                 P_RESPONSE_DESC               => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line( '4 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

END;
/


--MODIFICAR ORDEN
SET SERVEROUTPUT ON;
alter SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
DECLARE
V_RESPONSE_ID    INTEGER :=0;
V_RESPONSE_DESC  VARCHAR2(4000 BYTE) := '';
BEGIN
ORDERTB.PK_ORDER.PR_UPDATE(P_SALES_ORDER_ID              => 2,
						   P_PRICE                       => 100,
	                       P_ORDER_STATUS_NAME           => 'VALIDACION',
                           P_COMMENTS                    => 'MODICACION ORDEN',
	                       P_CUSTOMER_DOCUMENT_TYPE_NAME => 'CC',
                           P_CUSTOMER_DOCUMENT_ID        => '23094857',
						   P_PAYMENT_ID                  => 'SDFAS3244',
	                       P_PAYMENT_STATUS              => 1,
						   P_RESPONSE_ID               => V_RESPONSE_ID,
						   P_RESPONSE_DESC             => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line(' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
END;
/


--CONSULTAR ITEMS
SET SERVEROUTPUT ON;
alter SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
DECLARE
V_SALES_ORDER_ID NUMBER:= 1;
V_XML            CLOB;
V_RESPONSE_ID    INTEGER :=0;
V_RESPONSE_DESC  VARCHAR2(4000 BYTE) := '';
BEGIN
ORDERTB.PK_ORDER.PR_READ_ITEM(P_SALES_ORDER_ID              => V_SALES_ORDER_ID,
					          P_XML_DET                     => V_XML,
				              P_RESPONSE_ID                 => V_RESPONSE_ID,
                              P_RESPONSE_DESC               => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line(' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
dbms_output.put_line(V_XML); 

END;
/


--CONSULTAR ORDENES POR CLIENTE
SET SERVEROUTPUT ON;
alter SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
DECLARE
V_CUSTOMER_DOCUMENT_TYPE_NAME VARCHAR2(10 BYTE):= 'CE';
V_CUSTOMER_DOCUMENT_ID VARCHAR2(50 BYTE):= '500123';
V_XML            CLOB;
V_RESPONSE_ID    INTEGER :=0;
V_RESPONSE_DESC  VARCHAR2(4000 BYTE) := '';
BEGIN
ORDERTB.PK_ORDER.PR_READ_CUSTOMER(P_CUSTOMER_DOCUMENT_TYPE_NAME => V_CUSTOMER_DOCUMENT_TYPE_NAME,
                                  P_CUSTOMER_DOCUMENT_ID        => V_CUSTOMER_DOCUMENT_ID,
					              P_XML_DET                     => V_XML,
				                  P_RESPONSE_ID                 => V_RESPONSE_ID,
                                  P_RESPONSE_DESC               => V_RESPONSE_DESC);
COMMIT;
dbms_output.put_line(' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
dbms_output.put_line(V_XML); 

END;
/

