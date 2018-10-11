CREATE OR REPLACE PACKAGE PK_CUSTOMER Is
    /* =============================================================================
     Proposito:  Se Define Los Procedimientos CRUD para los clientes
     ----------- --------- ------------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ------------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA  Creacion Del Package
     ----------- --------- ------------------------------------------------------------
    ============================================================================= */
    Lv_Job_Name                     Varchar2(100)          := Null;
    Ld_Fecha_Null                   Constant Date          := To_Date('01-01-1900','dd-mm-yyyy');
    Lv_Job_Nm                       Constant Varchar2(100) := 'PK_CUSTOMER';
    Ld_Population_Date              Constant Date          := Trunc(Sysdate);
    Ld_Effective_Date               Constant Date          := Trunc(Sysdate-1);
    Lv_Usuario_Bd                   Constant Varchar2(30)  := 'SYSTEM';
    Lv_Job_Owner                    Constant Varchar2(30)  := 'GERARDO HERRERA';
    Lv_Job_Type                     Constant Varchar2(30)  := 'PL-SQL';
    Ld_Start_Date                   Date                   := Sysdate;
    Ld_Data_Date                    Constant Date          := To_Date(To_Char(Sysdate,'YYYYMM')||'01','YYYYMMDD');
    Ln_Etl                          Constant Number        := 5;
    Ln_Lmt_Cmmt                     Constant Number        := 10000;
    Ln_Lmt_Cllct                    Constant Number        := 100;
    Ln_Periodo                      Constant Number        := To_Number(To_Char(Sysdate,'YYYYMM'));
    Ln_Job_Id                       Constant Number        := 0;
    Ln_Total_Readed_Rows            Number                 := 0;
    Ln_Total_Inserted_Rows          Number                 := 0;
    Ln_Total_Discarded_Rows         Number                 := 0;
    Ln_Total_Update_Rows            Number                 := 0;
    Ln_Total_Deleted_Rows           Number                 := 0;
    Ln_Cnt                          Number                 := 0;
    Ln_Step                         Number                 := 0;
    lv_successfull                  Varchar2(1);
    Lv_Comment_                     Varchar2(4000)         := Null;
    
    /* =============================================================================
     Procedure : PR_CREATE
     Proposito:  Creacion de un nuevo cliente
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_CREATE(P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
     ) ;
	
	
    /* =============================================================================
     Procedure : PR_READ
     Proposito:  Consultar los clientes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_READ(  P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             OUT VARCHAR2,
                        P_LAST_NAME              OUT VARCHAR2,
                        P_PHONE_NUMBER           OUT VARCHAR2,
                        P_EMAIL                  OUT VARCHAR2,
                        P_PASSWORD               OUT VARCHAR2,
					    P_CUSTOMER_CATEGORY_NAME OUT VARCHAR2,
					    P_CREDITCARD_NAME        OUT VARCHAR2,
                        P_CREDITCARD_NUMBER      OUT VARCHAR2,
					    P_CUSTOMER_STATUS_NAME   OUT VARCHAR2,
					    P_CREATE_DATE            OUT VARCHAR2,
					    P_UPDATE_DATE            OUT VARCHAR2,
					    P_STREET                 OUT VARCHAR2,
                        P_STATE                  OUT VARCHAR2,
                        P_ZIP                    OUT VARCHAR2,
                        P_COUNTRY                OUT VARCHAR2,
                        P_ADDRESS_TYPE           OUT VARCHAR2,
                        P_CITY                   OUT VARCHAR2);
	
	
    /* =============================================================================
     Procedure : PR_UPDATE
     Proposito:  Modificar los clientes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_UPDATE(P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
						);
	
	
    
    /* =============================================================================
     Procedure : PR_DELETE
     Proposito:  Eliminado logico de los clientes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_DELETE(P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
					    P_CUSTOMER_STATUS_NAME   IN VARCHAR2);
	
	
END PK_CUSTOMER;
/







CREATE OR REPLACE PACKAGE BODY PK_CUSTOMER IS

PROCEDURE PR_CREATE(    P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
     ) IS
V_DOCUMENT_TYPE_ID INTEGER :=0;
V_CUSTOMER_CATEGORY_ID INTEGER :=0;
V_CREDITCARD_TYPE_ID INTEGER :=0;
V_STATUS_ID INTEGER :=0;
BEGIN

     --OBTENIENDO EL ID DEL TIPO DE DOCUMENTO
     BEGIN
		 SELECT ID INTO V_DOCUMENT_TYPE_ID
		 FROM DOCUMENT_TYPE
		 WHERE DOCUMENT_NAME = UPPER(P_DOCUMENT_TYPE_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		raise_application_error(-20002, Lv_Comment_);
	 END;
	 
	 
	 --OBTENIENDO EL ID DEL TIPO DE CATEGORIA DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_CUSTOMER_CATEGORY_ID
		 FROM CUSTOMER_CATEGORY
		 WHERE CATEGORY_NAME = UPPER(P_CUSTOMER_CATEGORY_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		raise_application_error(-20003, Lv_Comment_);
	 END;

	 
	 --OBTENIENDO EL ID DEL TIPO DE TARJETA DE CREDITO DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_CREDITCARD_TYPE_ID
		 FROM CREDITCARD_TYPE
		 WHERE CREDITCARD_NAME = UPPER(P_CREDITCARD_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		raise_application_error(-20004, Lv_Comment_);
	 END;
	 
	 
	 --OBTENIENDO EL ID DEL ESTATUS DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_STATUS_ID
		 FROM CUSTOMER_STATUS
		 WHERE STATUS_NAME = UPPER(P_CUSTOMER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		--raise_application_error(-20002, Lv_Comment_);
	 END;

	 
	 --INSERTANDO EL NUEVO CLIENTE
     INSERT INTO CUSTOMER (document_type_id,
						   document_id,
						   first_name,
						   last_name,
						   phone_number,
						   email,
						   password,
						   customer_category_id,
						   creditcard_type_id,
						   creditcard_number,
						   status_id,
						   create_date,
						   update_date) 
                  VALUES ( V_DOCUMENT_TYPE_ID,
                           UPPER(P_DOCUMENT_ID),
						   P_FIRST_NAME,
						   P_LAST_NAME,
						   P_PHONE_NUMBER,
						   P_EMAIL,
						   P_PASSWORD,
						   V_CUSTOMER_CATEGORY_ID,
						   V_CREDITCARD_TYPE_ID,
						   P_CREDITCARD_NUMBER,
						   CASE WHEN (V_STATUS_ID = 0 OR V_STATUS_ID IS NULL) THEN 1 ELSE V_STATUS_ID END,
						   SYSDATE,
						   SYSDATE);
  COMMIT;
  Lv_Successfull           := 'Y';
   
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_CREATE;
    
	
	
PROCEDURE PR_READ(  P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                P_DOCUMENT_ID            IN VARCHAR2,
                    P_FIRST_NAME             OUT VARCHAR2,
                    P_LAST_NAME              OUT VARCHAR2,
                    P_PHONE_NUMBER           OUT VARCHAR2,
                    P_EMAIL                  OUT VARCHAR2,
                    P_PASSWORD               OUT VARCHAR2,
					P_CUSTOMER_CATEGORY_NAME OUT VARCHAR2,
					P_CREDITCARD_NAME        OUT VARCHAR2,
                    P_CREDITCARD_NUMBER      OUT VARCHAR2,
					P_CUSTOMER_STATUS_NAME   OUT VARCHAR2,
					P_CREATE_DATE            OUT VARCHAR2,
					P_UPDATE_DATE            OUT VARCHAR2,
					P_STREET                 OUT VARCHAR2,
                    P_STATE                  OUT VARCHAR2,
                    P_ZIP                    OUT VARCHAR2,
                    P_COUNTRY                OUT VARCHAR2,
                    P_ADDRESS_TYPE           OUT VARCHAR2,
                    P_CITY                   OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
  
      --OBTENIEDO INFORMACION DE UN CLIENTE
        SELECT A.FIRST_NAME,
               A.LAST_NAME,
               A.PHONE_NUMBER,
               A.EMAIL,
               A.PASSWORD,
               C.CATEGORY_NAME,
               D.CREDITCARD_NAME,
               A.CREDITCARD_NUMBER,
               E.STATUS_NAME,
               TO_CHAR(A.CREATE_DATE,'YYYYMMDD') CREATE_DATE,
               TO_CHAR(A.UPDATE_DATE,'YYYYMMDD') UPDATE_DATE 
         INTO P_FIRST_NAME,
              P_LAST_NAME,
              P_PHONE_NUMBER,
              P_EMAIL,
              P_PASSWORD,
              P_CUSTOMER_CATEGORY_NAME,
              P_CREDITCARD_NAME,
              P_CREDITCARD_NUMBER,
              P_CUSTOMER_STATUS_NAME,
			  P_CREATE_DATE,
			  P_UPDATE_DATE
		 FROM CUSTOMER A
		 INNER JOIN DOCUMENT_TYPE B     ON (B.ID = A.DOCUMENT_TYPE_ID AND B.DOCUMENT_NAME = UPPER(P_DOCUMENT_TYPE_NAME))
		 INNER JOIN CUSTOMER_CATEGORY C ON (C.ID = A.CUSTOMER_CATEGORY_ID)
		 INNER JOIN CREDITCARD_TYPE D   ON (D.ID = A.CREDITCARD_TYPE_ID)
		 INNER JOIN CUSTOMER_STATUS E   ON (E.ID = A.STATUS_ID)
		 WHERE A.DOCUMENT_ID = UPPER(P_DOCUMENT_ID);

   Lv_Successfull           := 'Y';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
End PR_READ;
	
	
	
PROCEDURE PR_UPDATE(    P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
				  ) IS
V_CONT NUMBER := 0;
V_CUSTOMER_CATEGORY_ID INTEGER :=0;
V_CREDITCARD_TYPE_ID INTEGER :=0;
V_STATUS_ID INTEGER :=0;
BEGIN

     --OBTENIENDO EL ID DEL TIPO DE CATEGORIA DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_CUSTOMER_CATEGORY_ID
		 FROM CUSTOMER_CATEGORY
		 WHERE CATEGORY_NAME = UPPER(P_CUSTOMER_CATEGORY_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
	 END;

	 
	 --OBTENIENDO EL ID DEL TIPO DE TARJETA DE CREDITO DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_CREDITCARD_TYPE_ID
		 FROM CREDITCARD_TYPE
		 WHERE CREDITCARD_NAME = UPPER(P_CREDITCARD_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
	 END;

     --OBTENIENDO EL ID DEL ESTATUS DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_STATUS_ID
		 FROM CUSTOMER_STATUS
		 WHERE STATUS_NAME = UPPER(P_CUSTOMER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
	 END;



  
  -- ACTUALIZANDO LA INFORMACION DEL CLIENTE
     UPDATE CUSTOMER A
     SET
     A.FIRST_NAME = (CASE WHEN (P_FIRST_NAME = '' OR P_FIRST_NAME IS NULL) THEN A.FIRST_NAME ELSE P_FIRST_NAME END),
     A.LAST_NAME = (CASE WHEN (P_LAST_NAME = '' OR P_LAST_NAME IS NULL) THEN A.LAST_NAME ELSE P_LAST_NAME END),
     A.PHONE_NUMBER = (CASE WHEN (P_PHONE_NUMBER = '' OR P_PHONE_NUMBER IS NULL) THEN A.PHONE_NUMBER ELSE P_PHONE_NUMBER END),
     A.EMAIL = (CASE WHEN (P_EMAIL = '' OR P_EMAIL IS NULL) THEN A.EMAIL ELSE P_EMAIL END),
     A.PASSWORD = (CASE WHEN (P_PASSWORD = '' OR P_PASSWORD IS NULL) THEN A.PASSWORD ELSE P_PASSWORD END),
     A.CUSTOMER_CATEGORY_ID = (CASE WHEN (V_CUSTOMER_CATEGORY_ID = 0 OR V_CUSTOMER_CATEGORY_ID IS NULL) THEN A.CUSTOMER_CATEGORY_ID ELSE V_CUSTOMER_CATEGORY_ID END),
     A.CREDITCARD_TYPE_ID = (CASE WHEN (V_CREDITCARD_TYPE_ID = 0 OR V_CREDITCARD_TYPE_ID IS NULL) THEN A.CREDITCARD_TYPE_ID ELSE V_CREDITCARD_TYPE_ID END),
     A.CREDITCARD_NUMBER = (CASE WHEN (P_CREDITCARD_NUMBER = '' OR P_CREDITCARD_NUMBER IS NULL) THEN A.CREDITCARD_NUMBER ELSE P_CREDITCARD_NUMBER END),
     A.STATUS_ID = (CASE WHEN (V_STATUS_ID = 0 OR V_STATUS_ID IS NULL) THEN A.STATUS_ID ELSE V_STATUS_ID END),
     A.UPDATE_DATE = SYSDATE
     WHERE A.DOCUMENT_ID = UPPER(P_DOCUMENT_ID)
     AND EXISTS (SELECT UNIQUE 1 
                   FROM DOCUMENT_TYPE B
			      WHERE B.ID = A.DOCUMENT_TYPE_ID 
				    AND B.DOCUMENT_NAME = UPPER(P_DOCUMENT_TYPE_NAME)
				 );
   COMMIT;
   Lv_Successfull           := 'Y';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
end PR_UPDATE;
	
	
PROCEDURE PR_DELETE( P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                 P_DOCUMENT_ID            IN VARCHAR2,
					 P_CUSTOMER_STATUS_NAME   IN VARCHAR2
				     ) IS
V_STATUS_ID INTEGER :=0;
BEGIN

     --OBTENIENDO EL ID DEL ESTATUS DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_STATUS_ID
		 FROM CUSTOMER_STATUS
		 WHERE STATUS_NAME = UPPER(P_CUSTOMER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		raise_application_error(-20002, Lv_Comment_);
	 END;

	 

   -- BORRADO LOGICO DE UN CLIENTE
   UPDATE CUSTOMER A
   SET A.UPDATE_DATE = SYSDATE , A.STATUS_ID = V_STATUS_ID
   WHERE A.DOCUMENT_ID = UPPER(P_DOCUMENT_ID)
   AND EXISTS ( SELECT UNIQUE 1 
                  FROM DOCUMENT_TYPE B
				 WHERE B.ID = A.DOCUMENT_TYPE_ID 
				   AND B.DOCUMENT_NAME = UPPER(P_DOCUMENT_TYPE_NAME)
				 );
   COMMIT;
   Lv_Successfull           := 'Y';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_DELETE;
End;
/