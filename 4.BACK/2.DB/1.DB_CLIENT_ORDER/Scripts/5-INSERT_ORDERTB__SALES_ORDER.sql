--INSERTS ORDER
SET SERVEROUTPUT ON
DECLARE
V_SALES_ORDER_ID NUMBER:= 0;
V_ORDER_ITEM_ID NUMBER:= 0;
V_CONT NUMBER:=0;
V_RESPONSE_ID INTEGER :=0;
V_RESPONSE_DESC VARCHAR2(4000 BYTE) := '';
BEGIN

	--INSERT 17.621
    FOR C IN (
			SELECT B.DOCUMENT_NAME, A.DOCUMENT_ID
			FROM TOURESBALON.CUSTOMER A
			INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.ID = A.DOCUMENT_TYPE_ID)
			ORDER BY TO_NUMBER(A.DOCUMENT_ID)
        ) LOOP

		V_CONT:= V_CONT+1;
		
		ORDERTB.PK_ORDER.PR_CREATE(P_PRICE               => 75,
	                       P_ORDER_STATUS_NAME           => 'VALIDACION',
                           P_COMMENTS                    => 'CREACION DE ORDEN',
	                       P_CUSTOMER_DOCUMENT_TYPE_NAME => C.DOCUMENT_NAME,
                           P_CUSTOMER_DOCUMENT_ID        => C.DOCUMENT_ID,
						   P_PAYMENT_ID                  => V_CONT,
	                       P_PAYMENT_STATUS              => 1,
						   P_OUT_SALES_ORDER_ID          => V_SALES_ORDER_ID,
				           P_RESPONSE_ID                 => V_RESPONSE_ID,
                           P_RESPONSE_DESC               => V_RESPONSE_DESC);
		COMMIT;
		--dbms_output.put_line( '1 - P_OUT_SALES_ORDER_ID: '||V_SALES_ORDER_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

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
		--dbms_output.put_line( '2 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 


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
		--dbms_output.put_line( '3 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

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
		--dbms_output.put_line( '4 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
				
    END LOOP;

	--INSERT 35.242
    FOR C IN (
			SELECT B.DOCUMENT_NAME, A.DOCUMENT_ID
			FROM TOURESBALON.CUSTOMER A
			INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.ID = A.DOCUMENT_TYPE_ID)
			ORDER BY TO_NUMBER(A.DOCUMENT_ID)
        ) LOOP

		V_CONT:= V_CONT+1;
		
		ORDERTB.PK_ORDER.PR_CREATE(P_PRICE               => 75,
	                       P_ORDER_STATUS_NAME           => 'VALIDACION',
                           P_COMMENTS                    => 'CREACION DE ORDEN',
	                       P_CUSTOMER_DOCUMENT_TYPE_NAME => C.DOCUMENT_NAME,
                           P_CUSTOMER_DOCUMENT_ID        => C.DOCUMENT_ID,
						   P_PAYMENT_ID                  => V_CONT,
	                       P_PAYMENT_STATUS              => 1,
						   P_OUT_SALES_ORDER_ID          => V_SALES_ORDER_ID,
				           P_RESPONSE_ID                 => V_RESPONSE_ID,
                           P_RESPONSE_DESC               => V_RESPONSE_DESC);
		COMMIT;
		--dbms_output.put_line( '1 - P_OUT_SALES_ORDER_ID: '||V_SALES_ORDER_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

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
		--dbms_output.put_line( '2 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 


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
		--dbms_output.put_line( '3 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

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
		--dbms_output.put_line( '4 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
				
    END LOOP;
	
	--INSERT 50.002
	FOR C IN (
	       SELECT A.* FROM (
			  SELECT B.DOCUMENT_NAME, A.DOCUMENT_ID
			  FROM TOURESBALON.CUSTOMER A
			  INNER JOIN TOURESBALON.DOCUMENT_TYPE B ON (B.ID = A.DOCUMENT_TYPE_ID)
			  ORDER BY TO_NUMBER(A.DOCUMENT_ID)
			)A WHERE ROWNUM <= 14760
        ) LOOP

		V_CONT:= V_CONT+1;
		
		ORDERTB.PK_ORDER.PR_CREATE(P_PRICE               => 75,
	                       P_ORDER_STATUS_NAME           => 'VALIDACION',
                           P_COMMENTS                    => 'CREACION DE ORDEN',
	                       P_CUSTOMER_DOCUMENT_TYPE_NAME => C.DOCUMENT_NAME,
                           P_CUSTOMER_DOCUMENT_ID        => C.DOCUMENT_ID,
						   P_PAYMENT_ID                  => V_CONT,
	                       P_PAYMENT_STATUS              => 1,
						   P_OUT_SALES_ORDER_ID          => V_SALES_ORDER_ID,
				           P_RESPONSE_ID                 => V_RESPONSE_ID,
                           P_RESPONSE_DESC               => V_RESPONSE_DESC);
		COMMIT;
		--dbms_output.put_line( '1 - P_OUT_SALES_ORDER_ID: '||V_SALES_ORDER_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

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
		--dbms_output.put_line( '2 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 


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
		--dbms_output.put_line( '3 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 

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
		--dbms_output.put_line( '4 - P_OUT_ORDER_ITEM_ID: '||V_ORDER_ITEM_ID || ' P_RESPONSE_ID: '||V_RESPONSE_ID ||' P_RESPONSE_DESC: '||V_RESPONSE_DESC); 
				
    END LOOP;
	
END;
/
