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
    PROCEDURE PR_CREATE(P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
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
    PROCEDURE PR_READ(  P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2);
	
	
    /* =============================================================================
     Procedure : PR_UPDATE
     Proposito:  Modificar los clientes
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     08-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_UPDATE(P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
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
    PROCEDURE PR_DELETE(P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2);
	
	
END PK_CUSTOMER;
/







CREATE OR REPLACE PACKAGE BODY PK_CUSTOMER IS

PROCEDURE PR_CREATE(    P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
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
    
	
	
PROCEDURE PR_READ(      P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
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
	
	
	
PROCEDURE PR_UPDATE(    P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
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
	
	
PROCEDURE PR_DELETE(    P_USER                   IN VARCHAR2 DEFAULT USER,
	                    P_DOCUMENT_TYPE_ID       IN INTEGER,
						P_DOCUMENT_TYPE_NAME     IN VARCHAR2,
	                    P_DOCUMENT_ID            IN VARCHAR2,
                        P_FIRST_NAME             IN VARCHAR2,
                        P_LAST_NAME              IN VARCHAR2,
                        P_PHONE_NUMBER           IN VARCHAR2,
                        P_EMAIL                  IN VARCHAR2,
                        P_PASSWORD               IN VARCHAR2,
	                    P_CUSTOMER_CATEGORY_ID   IN INTEGER,
						P_CUSTOMER_CATEGORY_NAME IN VARCHAR2,
                        P_CREDITCARD_TYPE_ID     IN INTEGER,
						P_CREDITCARD_NAME        IN VARCHAR2,
                        P_CREDITCARD_NUMBER      IN VARCHAR2,
                        P_STATUS_ID              IN INTEGER,
						P_CUSTOMER_STATUS_NAME   IN VARCHAR2,
						P_STREET                 IN VARCHAR2,
                        P_STATE                  IN VARCHAR2,
                        P_ZIP                    IN VARCHAR2,
                        P_COUNTRY                IN VARCHAR2,
                        P_ADDRESS_TYPE           IN VARCHAR2,
                        P_CITY                   IN VARCHAR2
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
End;
/