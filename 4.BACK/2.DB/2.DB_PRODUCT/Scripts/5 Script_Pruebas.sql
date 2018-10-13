-- alter SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';
-- SELECT * FROM CUSTOMER WHERE DOCUMENT_TYPE_ID = 2 AND DOCUMENT_ID = '500123'
--INSERTS CUSTOMER
BEGIN
SYSTEM.PK_CUSTOMER.PR_CREATE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                         P_DOCUMENT_ID            =>'500123',
                             P_FIRST_NAME             =>'Gerardo',
                             P_LAST_NAME              =>'Herrera',
                             P_PHONE_NUMBER           =>'3211234567',
                             P_EMAIL                  =>'timolo@hotmail.com',
                             P_PASSWORD               =>'123456',
						     P_CUSTOMER_CATEGORY_NAME =>'DORADO',
						     P_CREDITCARD_NAME        =>'VISA',
                             P_CREDITCARD_NUMBER      =>'1234567891234567',
						     P_CUSTOMER_STATUS_NAME   =>'ACTIVO',
						     P_STREET                 =>'BOGOTA',
                             P_STATE                  =>'BOGOTÁ, D. C.',
                             P_ZIP                    =>'11001',
                             P_COUNTRY                =>'COLOMBIA',
                             P_ADDRESS_TYPE           =>'1',
                             P_CITY                   =>'BOGOTÁ, D.C.');
COMMIT;
END;
/

-- UPDATE CUSTOMER
BEGIN
SYSTEM.PK_CUSTOMER.PR_UPDATE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                         P_DOCUMENT_ID            =>'500123',
                             P_FIRST_NAME             =>'Gerardo',
                             P_LAST_NAME              =>'Herrera',
                             P_PHONE_NUMBER           =>'3211234567',
                             P_EMAIL                  =>'timolo@hotmail.com',
                             P_PASSWORD               =>'123456',
						     P_CUSTOMER_CATEGORY_NAME =>'DORADO',
						     P_CREDITCARD_NAME        =>'VISA',
                             P_CREDITCARD_NUMBER      =>'7654321987654321',
						     P_CUSTOMER_STATUS_NAME   =>'ACTIVO',
						     P_STREET                 =>'BOGOTA',
                             P_STATE                  =>'BOGOTÁ, D. C.',
                             P_ZIP                    =>'11001',
                             P_COUNTRY                =>'COLOMBIA',
                             P_ADDRESS_TYPE           =>'1',
                             P_CITY                   =>'BOGOTÁ, D.C.');
COMMIT;
END;
/


-- UPDATE CUSTOMER
BEGIN
SYSTEM.PK_CUSTOMER.PR_UPDATE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                         P_DOCUMENT_ID            =>'500123',
                             P_FIRST_NAME             =>'Gerardo',
                             P_LAST_NAME              =>'Herrera',
                             P_PHONE_NUMBER           =>'3211234567',
                             P_EMAIL                  =>'timolo@hotmail.com',
                             P_PASSWORD               =>'123456',
						     P_CUSTOMER_CATEGORY_NAME =>'DORADO',
						     P_CREDITCARD_NAME        =>'VISA',
                             P_CREDITCARD_NUMBER      =>'7654321987654321',
						     P_CUSTOMER_STATUS_NAME   =>'ACTIVO',
						     P_STREET                 =>'BOGOTA',
                             P_STATE                  =>'BOGOTÁ, D. C.',
                             P_ZIP                    =>'11001',
                             P_COUNTRY                =>'COLOMBIA',
                             P_ADDRESS_TYPE           =>'1',
                             P_CITY                   =>'BOGOTÁ, D.C.');
COMMIT;
END;
/

-- DELETE CUSTOMER
BEGIN
SYSTEM.PK_CUSTOMER.PR_DELETE(P_DOCUMENT_TYPE_NAME     =>'CE',
	                         P_DOCUMENT_ID            =>'500123',
						     P_CUSTOMER_STATUS_NAME   =>'INACTIVO');
COMMIT;
END;
/


--CONSULTA CUSTOMER
BEGIN
SYSTEM.PK_CUSTOMER.PR_READ  (P_DOCUMENT_TYPE_NAME     =>'CE',
	                         P_DOCUMENT_ID            =>'500123');
COMMIT;
END;
/
