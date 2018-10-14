CREATE OR REPLACE PACKAGE TOURESBALON.PK_ORDER Is
    /* =============================================================================
     Proposito:  Se Define Los Procedimientos CRUD para las ordenes
     ----------- --------- ------------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ------------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA  Creacion Del Package
     ----------- --------- ------------------------------------------------------------
    ============================================================================= */
    Lv_Job_Name                     Varchar2(100)          := Null;
    Ld_Fecha_Null                   Constant Date          := To_Date('01-01-1900','dd-mm-yyyy');
    Lv_Job_Nm                       Constant Varchar2(100) := 'PK_ORDER';
    Ld_Population_Date              Constant Date          := Trunc(Sysdate);
    Ld_Effective_Date               Constant Date          := Trunc(Sysdate-1);
    Lv_Usuario_Bd                   Constant Varchar2(30)  := 'TOURESBALON';
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
     Proposito:  Creacion de una nueva orden
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_CREATE(P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
                       );
	

	
    /* =============================================================================
     Procedure : PR_READ
     Proposito:  Consultar las ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_READ(  P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
						);
	
	
    /* =============================================================================
     Procedure : PR_UPDATE
     Proposito:  Modificar las ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_UPDATE(P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
						);
	
	
    
    /* =============================================================================
     Procedure : PR_DELETE
     Proposito:  Eliminado logico de las ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_DELETE(P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
					    );
	

	
   /* =============================================================================
     Procedure : PR_CREATE_ITEM
     Proposito:  Creacion de los items de ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_CREATE_ITEM(P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
                       );
	

	
    /* =============================================================================
     Procedure : PR_READ_ITEM
     Proposito:  Consultar los items de ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_READ_ITEM(  P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
						);
	
	
    /* =============================================================================
     Procedure : PR_UPDATE_ITEM
     Proposito:  Modificar los items de ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_UPDATE_ITEM(P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
						);
	
	
    
    /* =============================================================================
     Procedure : PR_DELETE_ITEM
     Proposito:  Eliminado logico de los items de ordenes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_DELETE_ITEM(P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
					    );
END PK_ORDER;
/







CREATE OR REPLACE PACKAGE BODY TOURESBALON.PK_ORDER IS

PROCEDURE PR_CREATE(    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
     ) IS
V_CONT NUMBER := 0;
V_DOCUMENT_TYPE_ID INTEGER :=0;
V_ORDER_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
   
        --OBTENIENDO EL ID DEL TIPO DE DOCUMENTO DEL CLIENTE
     BEGIN
		 SELECT ID INTO V_DOCUMENT_TYPE_ID
		 FROM TOURESBALON.DOCUMENT_TYPE
		 WHERE DOCUMENT_NAME = UPPER(P_CUSTOMER_DOCUMENT_TYPE_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		P_RESPONSE_ID:= -20002;
	    P_RESPONSE_DESC:= Lv_Comment_;
		raise_application_error(-20002, Lv_Comment_);
	 END;
	 
	--OBTENIENDO EL ID DEL ESTATUS DE LA ORDEN
     BEGIN
		 SELECT ID INTO V_ORDER_STATUS_ID
		 FROM TOURESBALON.ORDER_STATUS
		 WHERE STATUS_NAME = UPPER(P_ORDER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
		COMMIT;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20005, Lv_Comment_);
	 END;
  
  
   --INSERTANDO UNA NUEVA ORDEN
     INSERT INTO TOURESBALON.SALES_ORDER (id,
                                          order_date,
                                          price,
                                          status_id,
                                          comments,
                                          customer_document_type_id,
                                          customer_document_id,
                                          update_date) 
                  VALUES ( TOURESBALON.SEQ_SALES_ORDER.nextval,
				           SYSDATE,
						   P_PRICE,
						   CASE WHEN (V_ORDER_STATUS_ID = 0 OR V_ORDER_STATUS_ID IS NULL) THEN 1 ELSE V_ORDER_STATUS_ID END,
				           P_COMMENTS,
						   V_DOCUMENT_TYPE_ID,
						   UPPER(P_CUSTOMER_DOCUMENT_ID),
						   SYSDATE);
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_CREATE;
    
	
	
PROCEDURE PR_READ(      P_SALES_ORDER_ID              IN NUMBER,
                        P_PRICE                       OUT NUMBER,
	                    P_ORDER_STATUS_NAME           OUT VARCHAR2,
                        P_COMMENTS                    OUT VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME OUT VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        OUT VARCHAR2,
                        P_CREATE_DATE                 OUT VARCHAR2,
					    P_UPDATE_DATE                 OUT VARCHAR2,
	                    P_PRODUCT_ID                  OUT NUMBER,
                        P_PRODUCT_NAME                OUT VARCHAR2,
                        P_PARTNUM                     OUT VARCHAR2,
                        P_PRICE_ITEM                  OUT NUMBER,
                        P_QUANTITY                    OUT NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
   --OBTENIEDO INFORMACION DE LA ORDEN
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
		 FROM TOURESBALON.CUSTOMER A
		 INNER JOIN TOURESBALON.DOCUMENT_TYPE B     ON (B.ID = A.DOCUMENT_TYPE_ID AND B.DOCUMENT_NAME = UPPER(P_DOCUMENT_TYPE_NAME))
		 INNER JOIN TOURESBALON.CUSTOMER_CATEGORY C ON (C.ID = A.CUSTOMER_CATEGORY_ID)
		 INNER JOIN TOURESBALON.CREDITCARD_TYPE D   ON (D.ID = A.CREDITCARD_TYPE_ID)
		 INNER JOIN TOURESBALON.CUSTOMER_STATUS E   ON (E.ID = A.STATUS_ID)
		 WHERE A.DOCUMENT_ID = UPPER(P_DOCUMENT_ID);
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
End PR_READ;
	
	
	
PROCEDURE PR_UPDATE(    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
end PR_UPDATE;
	
	
PROCEDURE PR_DELETE(    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_DELETE;





PROCEDURE PR_CREATE_ITEM(    P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
     ) IS
V_CONT NUMBER := 0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_CREATE_ITEM;
    
	
	
PROCEDURE PR_READ_ITEM(      P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
End PR_READ_ITEM;
	
	
	
PROCEDURE PR_UPDATE_ITEM(    P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
end PR_UPDATE_ITEM;
	
	
PROCEDURE PR_DELETE_ITEM(    P_PRICE                       IN NUMBER,
	                         P_ORDER_STATUS_NAME           IN VARCHAR2,
                             P_COMMENTS                    IN VARCHAR2,
	                         P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                             P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= Lv_Comment_;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_DELETE_ITEM;
End;
/