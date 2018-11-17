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
						P_PAYMENT_ID                  IN VARCHAR2,
	                    P_PAYMENT_STATUS              IN INTEGER,
						P_OUT_SALES_ORDER_ID          OUT NUMBER,
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
						P_PAYMENT_ID                  OUT VARCHAR2,
	                    P_PAYMENT_STATUS              OUT INTEGER,
						P_OUT_SALES_ORDER_ID          OUT NUMBER,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
						);

    /* =============================================================================
     Procedure : PR_READ_CUSTOMER
     Proposito:  Consultar las ordenes por cliente
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     21-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_READ_CUSTOMER(
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_XML_DET                     OUT CLOB,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
						);						
	
	 /* =============================================================================
     Procedure : PR_READ_ITEM_ORDER_CUSTOMER
     Proposito:  Consultar los items de las ordenes por cliente
     ----------- --------- ---------------------------------------------------------
     Fecha       Iniciales Descripcion
     ----------- --------- ---------------------------------------------------------
     21-OCT-2018 GERARDO HERRERA     Creacion del procedimiento
     ----------- --------- ---------------------------------------------------------
    ============================================================================= */
    PROCEDURE PR_READ_ITEM_ORDER_CUSTOMER(
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_XML_DET                     OUT CLOB,
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
						P_PAYMENT_ID                  IN VARCHAR2,
	                    P_PAYMENT_STATUS              IN INTEGER,
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
							 P_ITEM_STATUS_NAME            IN VARCHAR2,
							 P_OUT_ORDER_ITEM_ID           OUT NUMBER,
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
    PROCEDURE PR_READ_ITEM(  P_SALES_ORDER_ID              IN NUMBER,
					         P_XML_DET                     OUT CLOB,
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
							 P_ITEM_STATUS_NAME            IN VARCHAR2,
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
                             P_ITEM_STATUS_NAME            IN VARCHAR2,
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
						P_PAYMENT_ID                  IN VARCHAR2,
	                    P_PAYMENT_STATUS              IN INTEGER,
						P_OUT_SALES_ORDER_ID          OUT NUMBER,
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
     P_OUT_SALES_ORDER_ID := ORDERTB.SEQ_SALES_ORDER.nextval;
	 
     INSERT INTO ORDERTB.sales_order (id,
                                          order_date,
                                          price,
                                          status_id,
                                          comments,
                                          customer_document_type_id,
                                          customer_document_id,
                                          update_date,
										  payment_id,
										  payment_status) 
                  VALUES ( P_OUT_SALES_ORDER_ID,
				           SYSDATE,
						   P_PRICE,
						   CASE WHEN (V_ORDER_STATUS_ID = 0 OR V_ORDER_STATUS_ID IS NULL) THEN 1 ELSE V_ORDER_STATUS_ID END,
				           P_COMMENTS,
						   V_DOCUMENT_TYPE_ID,
						   UPPER(P_CUSTOMER_DOCUMENT_ID),
						   SYSDATE,
						   P_PAYMENT_ID,
						   P_PAYMENT_STATUS
						   );
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
						P_PAYMENT_ID                  OUT VARCHAR2,
	                    P_PAYMENT_STATUS              OUT INTEGER,
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
		a.payment_id,
		a.payment_status,
		A.ID
		INTO 
		P_ORDER_DATE,
		P_PRICE,
		P_ORDER_STATUS_NAME,
		P_COMMENTS,
		P_CUSTOMER_DOCUMENT_TYPE_NAME,
		P_CUSTOMER_DOCUMENT_ID,
		P_UPDATE_DATE,
		P_PAYMENT_ID,
        P_PAYMENT_STATUS,
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


PROCEDURE PR_READ_CUSTOMER(
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_XML_DET                     OUT CLOB,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
   -------------------------------------------------------------
   --OBTENIEDO INFORMACION DE LA ORDEN POR CLIENTE
   -------------------------------------------------------------
   BEGIN
   
   FOR CUR IN (
		  SELECT
		  A.ID,
		  TO_CHAR(A.order_date,'YYYYMMDD') order_date,
		  A.price,
		  C.STATUS_NAME,
		  A.COMMENTS,
		  B.DOCUMENT_NAME CUSTOMER_DOCUMENT_TYPE_NAME,
		  A.CUSTOMER_DOCUMENT_ID,
		  TO_CHAR(A.UPDATE_DATE,'YYYYMMDD') update_date,
		  a.payment_id,
		  a.payment_status
		  FROM ORDERTB.SALES_ORDER A
		  INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.DOCUMENT_NAME = P_CUSTOMER_DOCUMENT_TYPE_NAME AND B.ID = A.CUSTOMER_DOCUMENT_TYPE_ID)
		  INNER JOIN ORDERTB.ORDER_STATUS C ON (C.ID = A.STATUS_ID)
		  WHERE A.CUSTOMER_DOCUMENT_ID = P_CUSTOMER_DOCUMENT_ID
        ) LOOP
		
		
		    p_xml_det := p_xml_det ||'<ORDER>' ||CHR(13);
            p_xml_det := p_xml_det || '<ID>'                          || CUR.ID                          || '</ID>'||CHR(13);
	        p_xml_det := p_xml_det || '<ORDER_DATE>'                  || CUR.ORDER_DATE                  || '</ORDER_DATE>'||CHR(13);
	        p_xml_det := p_xml_det || '<PRICE>'                       || ROUND(CUR.PRICE, 2)             || '</PRICE>'||CHR(13);
	        p_xml_det := p_xml_det || '<STATUS_NAME>'                 || CUR.STATUS_NAME                 || '</STATUS_NAME>'||CHR(13);
	        p_xml_det := p_xml_det || '<COMMENTS>'                    || CUR.COMMENTS                    || '</COMMENTS>'||CHR(13);
	        p_xml_det := p_xml_det || '<CUSTOMER_DOCUMENT_TYPE_NAME>' || CUR.CUSTOMER_DOCUMENT_TYPE_NAME || '</CUSTOMER_DOCUMENT_TYPE_NAME>'||CHR(13);
	        p_xml_det := p_xml_det || '<CUSTOMER_DOCUMENT_ID>'        || CUR.CUSTOMER_DOCUMENT_ID        || '</CUSTOMER_DOCUMENT_ID>'||CHR(13);
	        p_xml_det := p_xml_det || '<UPDATE_DATE>'                 || CUR.UPDATE_DATE                 || '</UPDATE_DATE>'||CHR(13);
			p_xml_det := p_xml_det || '<PAYMENT_ID>'                  || CUR.PAYMENT_ID                  || '</PAYMENT_ID>'||CHR(13);
			p_xml_det := p_xml_det || '<PAYMENT_STATUS>'              || CUR.PAYMENT_STATUS              || '</PAYMENT_STATUS>'||CHR(13);
			p_xml_det := p_xml_det ||'</ORDER>' ||CHR(13);
		
		END LOOP;
	  
	  
  exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al consultar las ordenes del cliente '||P_CUSTOMER_DOCUMENT_TYPE_NAME||'-'||P_CUSTOMER_DOCUMENT_ID;
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
End PR_READ_CUSTOMER;


PROCEDURE PR_READ_ITEM_ORDER_CUSTOMER(
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_XML_DET                     OUT CLOB,
						P_RESPONSE_ID                 OUT INTEGER,
                        P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
   -------------------------------------------------------------
   --OBTENIEDO INFORMACION DE LA ORDEN POR CLIENTE
   -------------------------------------------------------------
   BEGIN
   
   FOR CUR IN (
		  SELECT
		  A.ID,
		  TO_CHAR(A.order_date,'YYYYMMDD') order_date,
		  NVL(A.price,0) price,
		  C.STATUS_NAME,
		  A.COMMENTS,
		  B.DOCUMENT_NAME CUSTOMER_DOCUMENT_TYPE_NAME,
		  A.CUSTOMER_DOCUMENT_ID,
		  TO_CHAR(A.UPDATE_DATE,'YYYYMMDD') update_date,
		  a.payment_id,
		  a.payment_status
		  FROM ORDERTB.SALES_ORDER A
		  INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.DOCUMENT_NAME = P_CUSTOMER_DOCUMENT_TYPE_NAME AND B.ID = A.CUSTOMER_DOCUMENT_TYPE_ID)
		  INNER JOIN ORDERTB.ORDER_STATUS C ON (C.ID = A.STATUS_ID)
		  WHERE A.CUSTOMER_DOCUMENT_ID = P_CUSTOMER_DOCUMENT_ID
        ) LOOP
		
		
		    p_xml_det := p_xml_det ||'<ORDER>' ||CHR(13);
            p_xml_det := p_xml_det || '<ID>'                          || CUR.ID                          || '</ID>'||CHR(13);
	        p_xml_det := p_xml_det || '<ORDER_DATE>'                  || CUR.ORDER_DATE                  || '</ORDER_DATE>'||CHR(13);
	        p_xml_det := p_xml_det || '<TOTAL_PRICE>'                 || ROUND(CUR.PRICE, 2)             || '</TOTAL_PRICE>'||CHR(13);
	        p_xml_det := p_xml_det || '<STATUS_NAME>'                 || CUR.STATUS_NAME                 || '</STATUS_NAME>'||CHR(13);
	        p_xml_det := p_xml_det || '<COMMENTS>'                    || CUR.COMMENTS                    || '</COMMENTS>'||CHR(13);
	        p_xml_det := p_xml_det || '<CUSTOMER_DOCUMENT_TYPE_NAME>' || CUR.CUSTOMER_DOCUMENT_TYPE_NAME || '</CUSTOMER_DOCUMENT_TYPE_NAME>'||CHR(13);
	        p_xml_det := p_xml_det || '<CUSTOMER_DOCUMENT_ID>'        || CUR.CUSTOMER_DOCUMENT_ID        || '</CUSTOMER_DOCUMENT_ID>'||CHR(13);
	        p_xml_det := p_xml_det || '<UPDATE_DATE>'                 || CUR.UPDATE_DATE                 || '</UPDATE_DATE>'||CHR(13);
			p_xml_det := p_xml_det || '<PAYMENT_ID>'                  || CUR.PAYMENT_ID                  || '</PAYMENT_ID>'||CHR(13);
			p_xml_det := p_xml_det || '<PAYMENT_STATUS>'              || CUR.PAYMENT_STATUS              || '</PAYMENT_STATUS>'||CHR(13);
			
			 FOR CUR2 IN (
			  SELECT
				ID,
				PRODUCT_ID,
				PRODUCT_NAME,
				PARTNUM,
				NVL(PRICE,0) PRICE,
				QUANTITY,
				SALES_ORDER_ID,
				STATUS_ITEM_ID,
				TO_CHAR(CREATE_DATE,'YYYYMMDD') CREATE_DATE,
				TO_CHAR(UPDATE_DATE,'YYYYMMDD') UPDATE_DATE
				FROM ORDERTB.ORDER_ITEM
				WHERE SALES_ORDER_ID = CUR.ID
			) LOOP
				p_xml_det := p_xml_det ||'<PRODUCTO>' ||CHR(13);
				p_xml_det := p_xml_det || '<ITEM_ID>'           || CUR2.ID              || '</ITEM_ID>'||CHR(13);
				p_xml_det := p_xml_det || '<PRODUCT_ID>'        || CUR2.PRODUCT_ID      || '</PRODUCT_ID>'||CHR(13);
				p_xml_det := p_xml_det || '<PRODUCT_NAME>'      || CUR2.PRODUCT_NAME    || '</PRODUCT_NAME>'||CHR(13);
				p_xml_det := p_xml_det || '<PARTNUM>'           || CUR2.PARTNUM         || '</PARTNUM>'||CHR(13);
				p_xml_det := p_xml_det || '<PRICE>'             || ROUND(CUR2.PRICE, 2) || '</PRICE>'||CHR(13);
				p_xml_det := p_xml_det || '<QUANTITY>'          || CUR2.QUANTITY        || '</QUANTITY>'||CHR(13);
				p_xml_det := p_xml_det || '<SALES_ORDER_ID>'    || CUR2.SALES_ORDER_ID  || '</SALES_ORDER_ID>'||CHR(13);
				p_xml_det := p_xml_det || '<STATUS_ITEM_ID>'    || CUR2.STATUS_ITEM_ID  || '</STATUS_ITEM_ID>'||CHR(13);
				p_xml_det := p_xml_det ||'</PRODUCTO>' ||CHR(13);
				
			END LOOP;	
			
			p_xml_det := p_xml_det ||'</ORDER>' ||CHR(13);
		
		END LOOP;
	  
	  
  exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al consultar las ordenes del cliente '||P_CUSTOMER_DOCUMENT_TYPE_NAME||'-'||P_CUSTOMER_DOCUMENT_ID;
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
End PR_READ_ITEM_ORDER_CUSTOMER;

	
PROCEDURE PR_UPDATE(    P_SALES_ORDER_ID              IN NUMBER ,
	                    P_PRICE                       IN NUMBER,
	                    P_ORDER_STATUS_NAME           IN VARCHAR2,
                        P_COMMENTS                    IN VARCHAR2,
	                    P_CUSTOMER_DOCUMENT_TYPE_NAME IN VARCHAR2,
                        P_CUSTOMER_DOCUMENT_ID        IN VARCHAR2,
						P_PAYMENT_ID                  IN VARCHAR2,
	                    P_PAYMENT_STATUS              IN INTEGER,
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
		 A.UPDATE_DATE = SYSDATE,
		 A.PAYMENT_ID = (CASE WHEN (P_PAYMENT_ID = '' OR P_PAYMENT_ID IS NULL) THEN A.PAYMENT_ID ELSE P_PAYMENT_ID END),
		 A.PAYMENT_STATUS = (CASE WHEN (P_PAYMENT_STATUS = 0 OR P_PAYMENT_STATUS IS NULL) THEN A.PAYMENT_STATUS ELSE P_PAYMENT_STATUS END)
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
							 P_ITEM_STATUS_NAME            IN VARCHAR2,
							 P_OUT_ORDER_ITEM_ID           OUT NUMBER,
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
     P_OUT_ORDER_ITEM_ID := ORDERTB.SEQ_ORDER_ITEM.nextval;
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
                  VALUES ( P_OUT_ORDER_ITEM_ID,
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
    
	
	
PROCEDURE PR_READ_ITEM(  P_SALES_ORDER_ID              IN NUMBER,
					     P_XML_DET                     OUT CLOB,
						 P_RESPONSE_ID                 OUT INTEGER,
                         P_RESPONSE_DESC               OUT VARCHAR2
                  ) IS
V_CONT NUMBER := 0;
V_ID                          NUMBER:=0;
V_ORDER_DATE                  VARCHAR2(10 BYTE):= '';
V_PRICE                       NUMBER:=0;
V_STATUS_NAME                 VARCHAR2(50 BYTE):= '';
V_COMMENTS                    VARCHAR2(4000 BYTE):= '';
V_CUSTOMER_DOCUMENT_TYPE_NAME VARCHAR2(20 BYTE):= '';
V_CUSTOMER_DOCUMENT_ID        VARCHAR2(20 BYTE):= '';
V_UPDATE_DATE                 VARCHAR2(10 BYTE):= '';
V_PAYMENT_ID                  VARCHAR2(50 BYTE):= '';
V_PAYMENT_STATUS              INTEGER:=0;
  begin
   P_RESPONSE_ID:= -20001;
   P_RESPONSE_DESC:= 'KO';
   -------------------------------------------------------------
   --OBTENIEDO INFORMACION DE LA ORDEN
   -------------------------------------------------------------
   BEGIN
		SELECT A.ID,
		TO_CHAR(A.ORDER_DATE,'YYYYMMDD') ORDER_DATE,
		A.PRICE,
		C.STATUS_NAME,
		A.COMMENTS,
		B.DOCUMENT_NAME,
		A.CUSTOMER_DOCUMENT_ID,
		TO_CHAR(A.UPDATE_DATE,'YYYYMMDD') UPDATE_DATE,
		PAYMENT_ID,
		PAYMENT_STATUS
		INTO
		V_ID,
		V_ORDER_DATE,
		V_PRICE,
		V_STATUS_NAME,
		V_COMMENTS,
		V_CUSTOMER_DOCUMENT_TYPE_NAME,
		V_CUSTOMER_DOCUMENT_ID,
		V_UPDATE_DATE,
		V_PAYMENT_ID,
		V_PAYMENT_STATUS
		FROM ORDERTB.SALES_ORDER A
		INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.ID = A.CUSTOMER_DOCUMENT_TYPE_ID)
		INNER JOIN ORDERTB.ORDER_STATUS  C ON (C.ID = A.STATUS_ID)
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
    p_xml_det := '<ORDER>' ||CHR(13);
    p_xml_det := p_xml_det || '<ID>'                          || V_ID                          || '</ID>'||CHR(13);
	p_xml_det := p_xml_det || '<ORDER_DATE>'                  || V_ORDER_DATE                  || '</ORDER_DATE>'||CHR(13);
	p_xml_det := p_xml_det || '<PRICE>'                       || ROUND(V_PRICE, 2)             || '</PRICE>'||CHR(13);
	p_xml_det := p_xml_det || '<STATUS_NAME>'                 || V_STATUS_NAME                 || '</STATUS_NAME>'||CHR(13);
	p_xml_det := p_xml_det || '<COMMENTS>'                    || V_COMMENTS                    || '</COMMENTS>'||CHR(13);
	p_xml_det := p_xml_det || '<CUSTOMER_DOCUMENT_TYPE_NAME>' || V_CUSTOMER_DOCUMENT_TYPE_NAME || '</CUSTOMER_DOCUMENT_TYPE_NAME>'||CHR(13);
	p_xml_det := p_xml_det || '<CUSTOMER_DOCUMENT_ID>'        || V_CUSTOMER_DOCUMENT_ID        || '</CUSTOMER_DOCUMENT_ID>'||CHR(13);
	p_xml_det := p_xml_det || '<UPDATE_DATE>'                 || V_UPDATE_DATE                 || '</UPDATE_DATE>'||CHR(13);
	p_xml_det := p_xml_det || '<PAYMENT_ID>'                  || V_PAYMENT_ID                  || '</PAYMENT_ID>'||CHR(13);
	p_xml_det := p_xml_det || '<PAYMENT_STATUS>'              || V_PAYMENT_STATUS              || '</PAYMENT_STATUS>'||CHR(13);
   
  -------------------------------------------------------------
   --OBTENIEDO INFORMACION DEL ITEM
   -------------------------------------------------------------
   BEGIN
   FOR C IN (
		  SELECT
          B.ID ID_ITEM,
          B.PRODUCT_ID,
          B.PRODUCT_NAME,
          B.PARTNUM,
          B.PRICE PRICE_ITEM,
          B.QUANTITY,
          B.SALES_ORDER_ID,
          A.STATUS_NAME ITEM_STATUS_NAME,
          TO_CHAR(B.CREATE_DATE,'YYYYMMDD') CREATE_DATE_ITEM,
          TO_CHAR(B.UPDATE_DATE,'YYYYMMDD') UPDATE_DATE_ITEM
          FROM ORDERTB.ORDER_ITEM B
		  INNER JOIN ORDERTB.ORDER_ITEM_STATUS  A ON (A.ID = B.STATUS_ITEM_ID)
          WHERE B.SALES_ORDER_ID = P_SALES_ORDER_ID
		  ORDER BY B.ID
        ) LOOP
		
		 p_xml_det := p_xml_det ||'<ITEM>' ||CHR(13);
		 p_xml_det := p_xml_det || '<ID_ITEM>'         || C.ID_ITEM              || '</ID_ITEM>'||CHR(13);
		 p_xml_det := p_xml_det || '<PRODUCT_ID>'      || C.PRODUCT_ID           || '</PRODUCT_ID>'||CHR(13);
		 p_xml_det := p_xml_det || '<PRODUCT_NAME>'    || C.PRODUCT_NAME         || '</PRODUCT_NAME>'||CHR(13);
		 p_xml_det := p_xml_det || '<PARTNUM>'         || C.PARTNUM              || '</PARTNUM>'||CHR(13);
		 p_xml_det := p_xml_det || '<PRICE_ITEM>'      || ROUND(C.PRICE_ITEM, 2) || '</PRICE_ITEM>'||CHR(13);
		 p_xml_det := p_xml_det || '<QUANTITY>'        || C.QUANTITY             || '</QUANTITY>'||CHR(13);
		 p_xml_det := p_xml_det || '<ITEM_STATUS_NAME>'|| C.ITEM_STATUS_NAME     || '</ITEM_STATUS_NAME>'||CHR(13);
		 p_xml_det := p_xml_det || '<CREATE_DATE_ITEM>'|| C.CREATE_DATE_ITEM     || '</CREATE_DATE_ITEM>'||CHR(13);
		 p_xml_det := p_xml_det || '<UPDATE_DATE_ITEM>'|| C.UPDATE_DATE_ITEM     || '</UPDATE_DATE_ITEM>'||CHR(13);
		 p_xml_det := p_xml_det ||'</ITEM>' ||CHR(13);
		
		END LOOP;

  exception When Others Then
		Lv_Successfull           := 'N';
		Lv_Comment_              := 'Error al consultar los items de la orden '||P_SALES_ORDER_ID;
		COMMIT;
		P_RESPONSE_ID:= -20001;
	    P_RESPONSE_DESC:= Lv_Comment_;
		--raise_application_error(-20001, Lv_Comment_);
		RAISE;
  END;
  
  p_xml_det := p_xml_det ||'</ORDER>' ||CHR(13);
  
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
							 P_ITEM_STATUS_NAME            IN VARCHAR2,
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
                             P_ITEM_STATUS_NAME            IN VARCHAR2,
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