CREATE OR REPLACE PACKAGE ORDERTB.PK_ORDER Is
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
    Lv_Usuario_Bd                   Constant Varchar2(30)  := 'ORDERTB';
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
    PROCEDURE PR_READ(  P_SALES_ORDER_ID              IN NUMBER,
                        P_PRICE                       OUT NUMBER,
	                    P_ORDER_STATUS_NAME           OUT VARCHAR2,
                        P_COMMENTS                    OUT VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME OUT VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        OUT VARCHAR2,
                        P_ORDER_DATE                  OUT VARCHAR2,
					    P_UPDATE_DATE                 OUT VARCHAR2,
						P_OUT_SALES_ORDER_ID          OUT NUMBER,
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
    PROCEDURE PR_UPDATE(P_SALES_ORDER_ID              IN NUMBER,
	                    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
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
    PROCEDURE PR_DELETE(P_SALES_ORDER_ID              IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
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
    PROCEDURE PR_CREATE_ITEM(P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
							 P_SALES_ORDER_ID              IN NUMBER,
							 P_ITEM_STATUS_NAME            OUT VARCHAR2,
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
    PROCEDURE PR_READ_ITEM(  P_SALES_ORDER_ITEM_ID          IN NUMBER,
	                         P_PRODUCT_ID                  OUT NUMBER,
                             P_PRODUCT_NAME                OUT VARCHAR2,
                             P_PARTNUM                     OUT VARCHAR2,
                             P_PRICE_ITEM                  OUT NUMBER,
                             P_QUANTITY                    OUT NUMBER,
							 P_SALES_ORDER_ID              OUT NUMBER,
							 P_ITEM_STATUS_NAME            OUT VARCHAR2,
							 P_CREATE_ITEM_DATE            OUT VARCHAR2,
					         P_UPDATE_ITEM_DATE            OUT VARCHAR2,
							 P_OUT_SALES_ORDER_ITEM_ID     OUT NUMBER,
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
    PROCEDURE PR_UPDATE_ITEM(P_SALES_ORDER_ITEM_ID         IN NUMBER,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
							 P_ITEM_STATUS_NAME            OUT VARCHAR2,
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
    PROCEDURE PR_DELETE_ITEM(P_SALES_ORDER_ITEM_ID         IN NUMBER,
                             P_ITEM_STATUS_NAME            OUT VARCHAR2,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
					    );
END PK_ORDER;
/







CREATE OR REPLACE PACKAGE BODY ORDERTB.PK_ORDER IS

PROCEDURE PR_CREATE(    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
     ) IS
V_CONT NUMBER := 0;
V_DOCUMENT_TYPE_ID INTEGER :=0;
V_ORDER_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
   
     -------------------------------------------------------------
     --OBTENIENDO EL ID DEL TIPO DE DOCUMENTO
	 -------------------------------------------------------------
     BEGIN
		 SELECT ID INTO V_DOCUMENT_TYPE_ID
		 FROM TOURESBALON.DOCUMENT_TYPE
		 WHERE DOCUMENT_NAME = UPPER(P_CUSTOMER_DOCUMENT_TYPE_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el tipo de documento '||P_CUSTOMER_DOCUMENT_TYPE_NAME;
		P_RESPONSE_ID:= -20002;
	    P_RESPONSE_DESC:= Lv_Comment_;
		RAISE;
	 END;
	
	-------------------------------------------------------------
	--OBTENIENDO EL ID DEL ESTATUS DE LA ORDEN
	-------------------------------------------------------------
    BEGIN
		 SELECT ID INTO V_ORDER_STATUS_ID
		 FROM ORDERTB.order_status
		 WHERE STATUS_NAME = UPPER(P_ORDER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el status de la orden '||P_ORDER_STATUS_NAME;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--RAISE;
	 END;
  
   -------------------------------------------------------------
   --INSERTANDO UNA NUEVA ORDEN
   -------------------------------------------------------------
   BEGIN
     INSERT INTO ORDERTB.sales_order (id,
                                          order_date,
                                          price,
                                          status_id,
                                          comments,
                                          customer_document_type_id,
                                          customer_document_id,
                                          update_date) 
                  VALUES ( ORDERTB.SEQ_SALES_ORDER.nextval,
				           SYSDATE,
						   P_PRICE,
						   CASE WHEN (V_ORDER_STATUS_ID = 0 OR V_ORDER_STATUS_ID IS NULL) THEN 1 ELSE V_ORDER_STATUS_ID END,
				           P_COMMENTS,
						   V_DOCUMENT_TYPE_ID,
						   UPPER(P_CUSTOMER_DOCUMENT_ID),
						   SYSDATE);
   COMMIT;
  exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al insertar la nueva orden ';
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
  END;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
END PR_CREATE;
    
	
	
PROCEDURE PR_READ(      P_SALES_ORDER_ID              IN NUMBER,
                        P_PRICE                       OUT NUMBER,
	                    P_ORDER_STATUS_NAME           OUT VARCHAR2,
                        P_COMMENTS                    OUT VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME OUT VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        OUT VARCHAR2,
                        P_ORDER_DATE                  OUT VARCHAR2,
					    P_UPDATE_DATE                 OUT VARCHAR2,
						P_OUT_SALES_ORDER_ID          OUT NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
   -------------------------------------------------------------
   --OBTENIEDO INFORMACION DE LA ORDEN
   -------------------------------------------------------------
   BEGIN
		SELECT
		TO_CHAR(A.order_date,'YYYYMMDD') order_date,
		A.price,
		C.STATUS_NAME,
		A.comments,
		B.DOCUMENT_NAME,
		A.customer_document_id,
		TO_CHAR(A.UPDATE_DATE,'YYYYMMDD') update_date,
		A.ID
		INTO 
		P_ORDER_DATE,
		P_PRICE,
		P_ORDER_STATUS_NAME,
		P_COMMENTS,
		P_CUSTOMER_DOCUMENT_TYPE_NAME,
		P_CUSTOMER_DOCUMENT_ID,
		P_UPDATE_DATE,
		P_OUT_SALES_ORDER_ID
		FROM ORDERTB.sales_order A
		INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.ID = A.CUSTOMER_DOCUMENT_TYPE_ID)
		INNER JOIN ORDERTB.order_status  C ON (C.ID = A.STATUS_ID)
		WHERE A.ID = P_SALES_ORDER_ID;
  
      COMMIT;
  exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al consultar la orden '||P_SALES_ORDER_ID;
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
  END;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
End PR_READ;
	
	
	
PROCEDURE PR_UPDATE(    P_SALES_ORDER_ID              IN NUMBER,
	                    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
V_DOCUMENT_TYPE_ID INTEGER :=0;
V_ORDER_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
     -------------------------------------------------------------
     --OBTENIENDO EL ID DEL TIPO DE DOCUMENTO
	 -------------------------------------------------------------
     BEGIN
		 SELECT ID INTO V_DOCUMENT_TYPE_ID
		 FROM TOURESBALON.DOCUMENT_TYPE
		 WHERE DOCUMENT_NAME = UPPER(P_CUSTOMER_DOCUMENT_TYPE_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el tipo de documento '||P_CUSTOMER_DOCUMENT_TYPE_NAME;
		P_RESPONSE_ID:= -20002;
	    P_RESPONSE_DESC:= Lv_Comment_;
		RAISE;
	 END;
	
	-------------------------------------------------------------
	--OBTENIENDO EL ID DEL ESTATUS DE LA ORDEN
	-------------------------------------------------------------
    BEGIN
		 SELECT ID INTO V_ORDER_STATUS_ID
		 FROM ORDERTB.order_status
		 WHERE STATUS_NAME = UPPER(P_ORDER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el status de la orden '||P_ORDER_STATUS_NAME;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		RAISE;
	 END;
  
     -------------------------------------------------------------
     -- ACTUALIZANDO LOS DATOS DE LA ORDEN
	 -------------------------------------------------------------
	 BEGIN
		 UPDATE ORDERTB.sales_order A
		 SET
		 A.PRICE = (CASE WHEN (P_PRICE = 0 OR P_PRICE IS NULL) THEN A.PRICE ELSE P_PRICE END),
		 A.STATUS_ID = (CASE WHEN (V_ORDER_STATUS_ID = 0 OR V_ORDER_STATUS_ID IS NULL) THEN A.STATUS_ID ELSE V_ORDER_STATUS_ID END),
		 A.COMMENTS = (CASE WHEN (P_COMMENTS = '' OR P_COMMENTS IS NULL) THEN A.COMMENTS ELSE SUBSTR(P_COMMENTS||' ¤ '|| A.COMMENTS,1,3999) END),
		 A.CUSTOMER_DOCUMENT_TYPE_ID = (CASE WHEN (V_DOCUMENT_TYPE_ID = 0 OR V_DOCUMENT_TYPE_ID IS NULL) THEN A.CUSTOMER_DOCUMENT_TYPE_ID ELSE V_DOCUMENT_TYPE_ID END),
		 A.CUSTOMER_DOCUMENT_ID = (CASE WHEN (P_CUSTOMER_DOCUMENT_ID = '' OR P_CUSTOMER_DOCUMENT_ID IS NULL) THEN A.CUSTOMER_DOCUMENT_ID ELSE P_CUSTOMER_DOCUMENT_ID END),
		 A.UPDATE_DATE = SYSDATE
		 WHERE A.ID = UPPER(P_SALES_ORDER_ID);
	     COMMIT;
    exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al actualizar la orden '||P_SALES_ORDER_ID;
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
   END;
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
end PR_UPDATE;
	
	
PROCEDURE PR_DELETE(    P_SALES_ORDER_ID              IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
V_ORDER_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
	-------------------------------------------------------------
	--OBTENIENDO EL ID DEL ESTATUS DE LA ORDEN
	-------------------------------------------------------------
    BEGIN
		 SELECT ID INTO V_ORDER_STATUS_ID
		 FROM ORDERTB.order_status
		 WHERE STATUS_NAME = UPPER(P_ORDER_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el status de la orden '||P_ORDER_STATUS_NAME;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		RAISE;
	 END;

	 
   -------------------------------------------------------------
   -- BORRADO LOGICO DE UNA ORDEN
   -------------------------------------------------------------
   BEGIN 
	     UPDATE ORDERTB.sales_order A
		 SET
		 A.STATUS_ID = (CASE WHEN (V_ORDER_STATUS_ID = 0 OR V_ORDER_STATUS_ID IS NULL) THEN A.STATUS_ID ELSE V_ORDER_STATUS_ID END),
		 A.COMMENTS = (CASE WHEN (P_COMMENTS = '' OR P_COMMENTS IS NULL) THEN A.COMMENTS ELSE SUBSTR(P_COMMENTS||' ¤ '|| A.COMMENTS,1,3999) END),
		 A.UPDATE_DATE = SYSDATE
		 WHERE A.ID = UPPER(P_SALES_ORDER_ID); 
		 COMMIT;
    exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al borrar la orden '||P_SALES_ORDER_ID;
			COMMIT;
			P_RESPONSE_ID:= -20001;
			P_RESPONSE_DESC:= Lv_Comment_;
			--raise_application_error(-20001, Lv_Comment_);
			RAISE;
   END;
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
END PR_DELETE;





PROCEDURE PR_CREATE_ITEM(    P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
							 P_SALES_ORDER_ID              IN NUMBER,
							 P_ITEM_STATUS_NAME            OUT VARCHAR2,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
     ) IS
V_CONT NUMBER := 0;
V_ITEM_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  	
	-------------------------------------------------------------
	--OBTENIENDO EL ID DEL ESTATUS DEL ITEM
	-------------------------------------------------------------
    BEGIN
		 SELECT ID INTO V_ITEM_STATUS_ID
		 FROM ORDERTB.order_item_status
		 WHERE STATUS_NAME = UPPER(P_ITEM_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el status del item '||P_ITEM_STATUS_NAME;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--RAISE;
	 END;
  
   -------------------------------------------------------------
   --INSERTANDO UNA NUEVO ITEM
   -------------------------------------------------------------
   BEGIN
     INSERT INTO ORDERTB.order_item (id,
                                         product_id,
                                         product_name,
                                         partnum,
                                         price,
                                         quantity,
                                         sales_order_id,
                                         status_item_id,
                                         create_date,
                                         update_date) 
                  VALUES ( ORDERTB.SEQ_ORDER_ITEM.nextval,
				           P_PRODUCT_ID,
                           P_PRODUCT_NAME,
                           P_PARTNUM,
                           P_PRICE_ITEM,
                           P_QUANTITY,
					 	   P_SALES_ORDER_ID,
						   CASE WHEN (V_ITEM_STATUS_ID = 0 OR V_ITEM_STATUS_ID IS NULL) THEN 1 ELSE V_ITEM_STATUS_ID END,
						   SYSDATE,
						   SYSDATE);
   COMMIT;
   exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al insertar el nuevo item de la orden ';
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
  END;
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
END PR_CREATE_ITEM;
    
	
	
PROCEDURE PR_READ_ITEM(      P_SALES_ORDER_ITEM_ID          IN NUMBER,
	                         P_PRODUCT_ID                  OUT NUMBER,
                             P_PRODUCT_NAME                OUT VARCHAR2,
                             P_PARTNUM                     OUT VARCHAR2,
                             P_PRICE_ITEM                  OUT NUMBER,
                             P_QUANTITY                    OUT NUMBER,
							 P_SALES_ORDER_ID              OUT NUMBER,
							 P_ITEM_STATUS_NAME            OUT VARCHAR2,
							 P_CREATE_ITEM_DATE            OUT VARCHAR2,
					         P_UPDATE_ITEM_DATE            OUT VARCHAR2,
							 P_OUT_SALES_ORDER_ITEM_ID     OUT NUMBER,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  -------------------------------------------------------------
   --OBTENIEDO INFORMACION DEL ITEM
   -------------------------------------------------------------
   BEGIN
		SELECT
		A.PRODUCT_ID,
		A.PRODUCT_NAME,
		A.PARTNUM,
		A.PRICE,
		A.QUANTITY,
		A.SALES_ORDER_ID,
		B.STATUS_NAME,
		TO_CHAR(A.CREATE_DATE,'YYYYMMDD') CREATE_DATE,
		TO_CHAR(A.UPDATE_DATE,'YYYYMMDD') UPDATE_DATE,
        A.ID
		INTO 
		 P_PRODUCT_ID,
		 P_PRODUCT_NAME,
		 P_PARTNUM,
		 P_PRICE_ITEM,
		 P_QUANTITY,
		 P_SALES_ORDER_ID,
		 P_ITEM_STATUS_NAME,
		 P_CREATE_ITEM_DATE,
		 P_UPDATE_ITEM_DATE,
		 P_OUT_SALES_ORDER_ITEM_ID
		FROM ORDERTB.order_item A
		INNER JOIN ORDERTB.order_item_STATUS  B ON (B.ID = A.STATUS_ITEM_ID)
		WHERE A.ID = P_SALES_ORDER_ITEM_ID;
  
      COMMIT;
  exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al consultar item '||P_SALES_ORDER_ITEM_ID;
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
  END;
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
End PR_READ_ITEM;
	
	
	
PROCEDURE PR_UPDATE_ITEM(    P_SALES_ORDER_ITEM_ID         IN NUMBER,
	                         P_PRODUCT_ID                  IN NUMBER,
                             P_PRODUCT_NAME                IN VARCHAR2,
                             P_PARTNUM                     IN VARCHAR2,
                             P_PRICE_ITEM                  IN NUMBER,
                             P_QUANTITY                    IN NUMBER,
							 P_ITEM_STATUS_NAME            OUT VARCHAR2,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
V_ITEM_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
	-------------------------------------------------------------
	--OBTENIENDO EL ID DEL ESTATUS DEL ITEM
	-------------------------------------------------------------
    BEGIN
		 SELECT ID INTO V_ITEM_STATUS_ID
		 FROM ORDERTB.order_item_status
		 WHERE STATUS_NAME = UPPER(P_ITEM_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el status del item '||P_ITEM_STATUS_NAME;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--RAISE;
	 END;
  
     -------------------------------------------------------------
     -- ACTUALIZANDO LOS DATOS DEL ITEM
	 -------------------------------------------------------------
	 BEGIN
		 UPDATE ORDERTB.order_item A
		 SET
		 A.PRODUCT_ID = (CASE WHEN (P_PRODUCT_ID = 0 OR P_PRODUCT_ID IS NULL) THEN A.PRODUCT_ID ELSE P_PRODUCT_ID END),
		 A.PRODUCT_NAME = (CASE WHEN (P_PRODUCT_NAME = '' OR P_PRODUCT_NAME IS NULL) THEN A.PRODUCT_NAME ELSE P_PRODUCT_NAME END),
		 A.PARTNUM = (CASE WHEN (P_PARTNUM = '' OR P_PARTNUM IS NULL) THEN A.PARTNUM ELSE P_PARTNUM END),
		 A.PRICE = (CASE WHEN (P_PRICE_ITEM = 0 OR P_PRICE_ITEM IS NULL) THEN A.PRICE ELSE P_PRICE_ITEM END),
		 A.QUANTITY = (CASE WHEN (P_QUANTITY = 0 OR P_QUANTITY IS NULL) THEN A.QUANTITY ELSE P_QUANTITY END),
		 A.STATUS_ITEM_ID = (CASE WHEN (V_ITEM_STATUS_ID = 0 OR V_ITEM_STATUS_ID IS NULL) THEN A.STATUS_ITEM_ID ELSE V_ITEM_STATUS_ID END),
		 A.UPDATE_DATE = SYSDATE
		 WHERE A.ID = UPPER(P_SALES_ORDER_ITEM_ID);
	     COMMIT;
    exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al actualizar el item '||P_SALES_ORDER_ITEM_ID;
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
   END;
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
end PR_UPDATE_ITEM;
	
	
PROCEDURE PR_DELETE_ITEM(    P_SALES_ORDER_ITEM_ID         IN NUMBER,
                             P_ITEM_STATUS_NAME            OUT VARCHAR2,
						     P_RESPONSE_ID                 OUT INTEGER,
                             P_RESPONSE_DESC               OUT VARCHAR2
					) IS
V_CONT NUMBER := 0;
V_ITEM_STATUS_ID INTEGER :=0;
BEGIN
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
  
	-------------------------------------------------------------
	--OBTENIENDO EL ID DEL ESTATUS DEL ITEM
	-------------------------------------------------------------
    BEGIN
		 SELECT ID INTO V_ITEM_STATUS_ID
		 FROM ORDERTB.order_item_status
		 WHERE STATUS_NAME = UPPER(P_ITEM_STATUS_NAME);
	 
	 exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al obtener el status del item '||P_ITEM_STATUS_NAME;
		P_RESPONSE_ID:= -20003;
	    P_RESPONSE_DESC:= Lv_Comment_;
		RAISE;
	 END;

	 
   -------------------------------------------------------------
   -- BORRADO LOGICO DE UN ITEM
   -------------------------------------------------------------
   BEGIN 
	     UPDATE ORDERTB.order_item A
		 SET
		 A.STATUS_ITEM_ID = (CASE WHEN (V_ITEM_STATUS_ID = 0 OR V_ITEM_STATUS_ID IS NULL) THEN A.STATUS_ITEM_ID ELSE V_ITEM_STATUS_ID END),
		 A.UPDATE_DATE = SYSDATE
		 WHERE A.ID = UPPER(P_SALES_ORDER_ITEM_ID); 
		 COMMIT;
    exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al borrar el item '||P_SALES_ORDER_ITEM_ID;
			COMMIT;
			P_RESPONSE_ID:= -20001;
			P_RESPONSE_DESC:= Lv_Comment_;
			--raise_application_error(-20001, Lv_Comment_);
			RAISE;
   END;
  
  
   COMMIT;
   Lv_Successfull := 'Y';
   P_RESPONSE_ID:= 20100;
   P_RESPONSE_DESC:= 'OK';
   exception When Others Then
   Lv_Successfull           := 'N';
   --Lv_Comment_              := substr(dbms_utility.format_error_backtrace || '. ' || Lv_Comment_||' '||to_char(sqlcode)||': '||sqlerrm,1,500);
   COMMIT;
END PR_DELETE_ITEM;
End;
/