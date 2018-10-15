--CREATE DATABASE DB_CLIENT_ORDER
--DROP TABLE TOURESBALON.order_item_status;
--DROP TABLE TOURESBALON.order_item;
--DROP TABLE TOURESBALON.sales_order;
--DROP TABLE TOURESBALON.order_status;
--DROP TABLE TOURESBALON.customer_address;
--DROP TABLE TOURESBALON.customer;
--DROP TABLE TOURESBALON.customer_status;
--DROP TABLE TOURESBALON.customer_category;
--DROP TABLE TOURESBALON.address;
--DROP TABLE TOURESBALON.document_type;
--DROP TABLE TOURESBALON.creditcard_type;


CREATE TABLE TOURESBALON.creditcard_type
(
  id                     INTEGER DEFAULT -1 NOT NULL,
  creditcard_name        VARCHAR2(50 BYTE) NOT NULL,
  creditcard_description VARCHAR2(200 BYTE) NOT NULL,
  create_date            DATE,
  update_date            DATE DEFAULT SYSDATE,
  CONSTRAINT creditcard_type_pk PRIMARY KEY (id)
);

CREATE TABLE TOURESBALON.document_type
(
  id                     INTEGER DEFAULT -1 NOT NULL,
  document_name          VARCHAR2(20 BYTE) NOT NULL,
  document_description   VARCHAR2(200 BYTE) NOT NULL,
  create_date            DATE,
  update_date            DATE DEFAULT SYSDATE,
  CONSTRAINT document_type_pk PRIMARY KEY (id)
);

CREATE TABLE TOURESBALON.address (
    id             NUMBER NOT NULL,
    street         VARCHAR2(50 BYTE),
    state          VARCHAR2(50 BYTE),
    zip            VARCHAR2(20 BYTE),
    country        VARCHAR2(50 BYTE),
    city           VARCHAR2(50 BYTE),
    create_date    DATE,
    update_date    DATE DEFAULT SYSDATE,
	CONSTRAINT address_pk PRIMARY KEY (id)
);

CREATE TABLE TOURESBALON.customer_category (
    id                          INTEGER DEFAULT -1 NOT NULL,
    category_name               VARCHAR2(50 BYTE) NOT NULL,
    category_description        VARCHAR2(200 BYTE) NOT NULL,
    create_date                 DATE,
    update_date                 DATE DEFAULT SYSDATE,
    CONSTRAINT customer_category_pk PRIMARY KEY (id)
);

CREATE TABLE TOURESBALON.customer_status (
    id                          INTEGER DEFAULT -1 NOT NULL,
    status_name                 VARCHAR2(50 BYTE) NOT NULL,
    status_description          VARCHAR2(200 BYTE) NOT NULL,
    create_date                 DATE,
    update_date                 DATE DEFAULT SYSDATE,
    CONSTRAINT customer_status_pk PRIMARY KEY (id)
);


CREATE TABLE TOURESBALON.customer (
	document_type_id     INTEGER DEFAULT 1 NOT NULL,
	document_id          VARCHAR2(20 BYTE) NOT NULL,
    first_name           VARCHAR2(50 BYTE),
    last_name            VARCHAR2(50 BYTE),
    phone_number         VARCHAR2(20 BYTE),
    email                VARCHAR2(50 BYTE),
    password             VARCHAR2(50 BYTE),
	customer_category_id INTEGER,
    creditcard_type_id   INTEGER,
    creditcard_number    VARCHAR2(20 BYTE),
    status_id            INTEGER,
    create_date          DATE,
    update_date          DATE DEFAULT SYSDATE,
	CONSTRAINT customer_pk PRIMARY KEY (document_type_id, document_id),
	CONSTRAINT customer_document_type_fk  FOREIGN KEY (document_type_id)  REFERENCES TOURESBALON.document_type(id),
	CONSTRAINT customer_category_fk  FOREIGN KEY (customer_category_id)  REFERENCES TOURESBALON.customer_category(id),
	CONSTRAINT creditcard_type_fk  FOREIGN KEY (creditcard_type_id)  REFERENCES TOURESBALON.creditcard_type(id),
	CONSTRAINT customer_status_fk  FOREIGN KEY (status_id)  REFERENCES TOURESBALON.customer_status(id)
);

CREATE TABLE TOURESBALON.customer_address (
    address_id          NUMBER NOT NULL,
    cust_document_type  INTEGER NOT NULL,
	cust_document_id    VARCHAR2(20 BYTE) NOT NULL,
	create_date         DATE,
    update_date         DATE DEFAULT SYSDATE,
	CONSTRAINT address_fk  FOREIGN KEY (address_id)  REFERENCES TOURESBALON.address(id),
	CONSTRAINT customer_fk FOREIGN KEY (cust_document_type,cust_document_id) REFERENCES TOURESBALON.customer(document_type_id,document_id)
);


CREATE TABLE TOURESBALON.order_status (
    id                          INTEGER DEFAULT -1 NOT NULL,
    status_name                 VARCHAR2(50 BYTE) NOT NULL,
    status_description          VARCHAR2(200 BYTE) NOT NULL,
    create_date                 DATE,
    update_date                 DATE DEFAULT SYSDATE,
    CONSTRAINT order_status_pk PRIMARY KEY (id)
);


CREATE TABLE TOURESBALON.sales_order (
    id                          NUMBER NOT NULL,
    order_date                  DATE,
    price                       NUMBER,
    status_id                   INTEGER,
    comments                    VARCHAR2(4000 BYTE),
    customer_document_type_id   INTEGER NOT NULL,
    customer_document_id        VARCHAR2(20 BYTE) NOT NULL,
    update_date                 DATE,
	CONSTRAINT sales_order_pk PRIMARY KEY ( id ),
	CONSTRAINT customer_sales_fk FOREIGN KEY (customer_document_type_id,customer_document_id) REFERENCES TOURESBALON.customer(document_type_id,document_id),
	CONSTRAINT order_status_fk  FOREIGN KEY (status_id)  REFERENCES TOURESBALON.order_status(id)
);

CREATE TABLE TOURESBALON.order_item_status (
    id                   INTEGER DEFAULT -1 NOT NULL,
    status_name          VARCHAR2(50 BYTE) NOT NULL,
    status_description   VARCHAR2(200 BYTE) NOT NULL,
    create_date          DATE,
    update_date          DATE DEFAULT SYSDATE,
	CONSTRAINT order_item_status_pk PRIMARY KEY (id)
);


CREATE TABLE TOURESBALON.order_item (
    id                        NUMBER NOT NULL,
    product_id                NUMBER,
    product_name              VARCHAR2(50 BYTE),
    partnum                   VARCHAR2(20 BYTE),
    price                     NUMBER,
    quantity                  NUMBER,
    sales_order_id            NUMBER NOT NULL,
	status_item_id            INTEGER,
    create_date               DATE,
    update_date               DATE,
	CONSTRAINT order_item_pk  PRIMARY KEY ( id ),
	CONSTRAINT order_item_fk  FOREIGN KEY (sales_order_id)  REFERENCES TOURESBALON.sales_order(id),
	CONSTRAINT order_item_status_fk  FOREIGN KEY (status_item_id)  REFERENCES TOURESBALON.order_item_status(id)
);

--DROP SEQUENCE TOURESBALON.SEQ_ADDRESS;
CREATE SEQUENCE TOURESBALON.SEQ_ADDRESS
  START WITH 1200
  INCREMENT BY   1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

--DROP SEQUENCE TOURESBALON.SEQ_SALES_ORDER;
CREATE SEQUENCE TOURESBALON.SEQ_SALES_ORDER
  START WITH 1
  INCREMENT BY   1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;
  
--DROP SEQUENCE TOURESBALON.SEQ_ORDER_ITEM;
CREATE SEQUENCE TOURESBALON.SEQ_ORDER_ITEM
  START WITH 1
  INCREMENT BY   1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;



