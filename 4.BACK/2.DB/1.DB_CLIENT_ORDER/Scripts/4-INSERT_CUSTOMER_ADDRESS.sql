BEGIN
DELETE FROM TOURESBALON.customer_address;
COMMIT;

Insert /*+ Append */ INTO TOURESBALON.customer_address
SELECT
CASE WHEN CA.address_id < 1 THEN 164 ELSE CA.address_id END address_id,
CA.cust_document_type,
CA.cust_document_id,
CA.create_date,
CA.update_date
FROM (
SELECT round(dbms_random.value() * 1199) address_id,
	   C.DOCUMENT_TYPE_ID cust_document_type,
	   C.DOCUMENT_ID cust_document_id,
	   SYSDATE create_date,
	   SYSDATE update_date
  FROM TOURESBALON.customer c
  ORDER BY TO_NUMBER(c.document_id)
) CA;
COMMIT;
END;
/
