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
                        P_QUANTITY                    IN NUMBER
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
                        P_QUANTITY                    IN NUMBER
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
                        P_QUANTITY                    IN NUMBER
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
                        P_QUANTITY                    IN NUMBER
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
                             P_QUANTITY                    IN NUMBER
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
                             P_QUANTITY                    IN NUMBER
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
                             P_QUANTITY                    IN NUMBER
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
                             P_QUANTITY                    IN NUMBER
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
                        P_QUANTITY                    IN NUMBER
     ) IS
V_CONT NUMBER := 0;
BEGIN

  COMMIT;
   
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_CREATE;
    
	
	
PROCEDURE PR_READ(      P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
	                    P_PRODUCT_ID                  IN NUMBER,
                        P_PRODUCT_NAME                IN VARCHAR2,
                        P_PARTNUM                     IN VARCHAR2,
                        P_PRICE_ITEM                  IN NUMBER,
                        P_QUANTITY                    IN NUMBER
                  ) IS
V_CONT NUMBER := 0;
  begin
  

  COMMIT;
   
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
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
                        P_QUANTITY                    IN NUMBER
					) IS
V_CONT NUMBER := 0;
BEGIN
  
  
  
  Commit;
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
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
                        P_QUANTITY                    IN NUMBER
					) IS
V_CONT NUMBER := 0;
BEGIN

  COMMIT;
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
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
                             P_QUANTITY                    IN NUMBER
     ) IS
V_CONT NUMBER := 0;
BEGIN

  COMMIT;
   
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '.' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
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
                             P_QUANTITY                    IN NUMBER
                  ) IS
V_CONT NUMBER := 0;
  begin
  

  COMMIT;
   
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
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
                             P_QUANTITY                    IN NUMBER
					) IS
V_CONT NUMBER := 0;
BEGIN
  
  
  
  Commit;
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
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
                             P_QUANTITY                    IN NUMBER
					) IS
V_CONT NUMBER := 0;
BEGIN

  COMMIT;
   exception When Others Then
   Lv_Successfull           := 'N';
   Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
   raise_application_error(-20001, Lv_Comment_);
   --RAISE;
END PR_DELETE_ITEM;
End;
/