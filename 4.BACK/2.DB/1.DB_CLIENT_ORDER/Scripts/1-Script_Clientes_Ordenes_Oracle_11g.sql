--CREATE DATABASE DB_CLIENT_ORDER

--DROP TABLE order_item;
--DROP TABLE sales_order;
--DROP TABLE order_status;
--DROP TABLE customer_address;
--DROP TABLE customer;
--DROP TABLE customer_status;
--DROP TABLE customer_category;
--DROP TABLE address;
--DROP TABLE document_type;
--DROP TABLE creditcard_type;


CREATE TABLE creditcard_type
(
  id                     INTEGER DEFAULT -1 NOT NULL,
  creditcard_name        VARCHAR2(50 BYTE) NOT NULL,
  creditcard_description VARCHAR2(200 BYTE) NOT NULL,
  create_date            DATE,
  update_date            DATE DEFAULT SYSDATE,
  CONSTRAINT creditcard_type_pk PRIMARY KEY (id)
);

CREATE TABLE document_type
(
  id                     INTEGER DEFAULT -1 NOT NULL,
  document_name          VARCHAR2(20 BYTE) NOT NULL,
  document_description   VARCHAR2(200 BYTE) NOT NULL,
  create_date            DATE,
  update_date            DATE DEFAULT SYSDATE,
  CONSTRAINT document_type_pk PRIMARY KEY (id)
);

CREATE TABLE address (
    id             NUMBER NOT NULL,
    street         VARCHAR2(50 BYTE),
    state          VARCHAR2(50 BYTE),
    zip            VARCHAR2(20 BYTE),
    country        VARCHAR2(50 BYTE),
    address_type   VARCHAR2(4 BYTE),
    city           VARCHAR2(50 BYTE),
    create_date         DATE,
    update_date         DATE DEFAULT SYSDATE,
	CONSTRAINT address_pk PRIMARY KEY (id)
);

CREATE TABLE customer_category (
    id                          INTEGER DEFAULT -1 NOT NULL,
    category_name               VARCHAR2(50 BYTE) NOT NULL,
    category_description        VARCHAR2(200 BYTE) NOT NULL,
    create_date                 DATE,
    update_date                 DATE DEFAULT SYSDATE,
    CONSTRAINT customer_category_pk PRIMARY KEY (id)
);

CREATE TABLE customer_status (
    id                          INTEGER DEFAULT -1 NOT NULL,
    status_name                 VARCHAR2(50 BYTE) NOT NULL,
    status_description          VARCHAR2(200 BYTE) NOT NULL,
    create_date                 DATE,
    update_date                 DATE DEFAULT SYSDATE,
    CONSTRAINT customer_status_pk PRIMARY KEY (id)
);


CREATE TABLE customer (
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
	CONSTRAINT customer_category_fk  FOREIGN KEY (customer_category_id)  REFERENCES customer_category(id),
	CONSTRAINT creditcard_type_fk  FOREIGN KEY (creditcard_type_id)  REFERENCES creditcard_type(id),
	CONSTRAINT customer_status_fk  FOREIGN KEY (status_id)  REFERENCES customer_status(id)
);

CREATE TABLE customer_address (
    address_id    NUMBER NOT NULL,
    cust_document_type  INTEGER NOT NULL,
	cust_document_id    VARCHAR2(20 BYTE) NOT NULL,
	create_date         DATE,
    update_date         DATE DEFAULT SYSDATE,
	CONSTRAINT address_fk  FOREIGN KEY (address_id)  REFERENCES address(id),
	CONSTRAINT customer_fk FOREIGN KEY (cust_document_type,cust_document_id) REFERENCES customer(document_type_id,document_id)
);


CREATE TABLE order_status (
    id                          INTEGER DEFAULT -1 NOT NULL,
    status_name                 VARCHAR2(50 BYTE) NOT NULL,
    status_description          VARCHAR2(200 BYTE) NOT NULL,
    create_date                 DATE,
    update_date                 DATE DEFAULT SYSDATE,
    CONSTRAINT order_status_pk PRIMARY KEY (id)
);


CREATE TABLE sales_order (
    id                          NUMBER NOT NULL,
    order_date                  DATE,
    price                       NUMBER,
    status_id                   INTEGER,
    comments                    VARCHAR2(4000 BYTE),
    customer_document_type_id   INTEGER NOT NULL,
    customer_document_id        VARCHAR2(20 BYTE) NOT NULL,
    update_date                 DATE,
	CONSTRAINT sales_order_pk PRIMARY KEY ( id ),
	CONSTRAINT customer_sales_fk FOREIGN KEY (customer_document_type_id,customer_document_id) REFERENCES customer(document_type_id,document_id),
	CONSTRAINT order_status_fk  FOREIGN KEY (status_id)  REFERENCES order_status(id)
);

CREATE TABLE order_item (
    id                                      NUMBER NOT NULL,
    product_id                              NUMBER,
    product_name                            VARCHAR2(50 BYTE),
    partnum                                 VARCHAR2(20 BYTE),
    price                                   NUMBER,
    quantity                                NUMBER,
    sales_order_id                          NUMBER NOT NULL,
    create_date                             DATE,
    update_date                             DATE,
	CONSTRAINT order_item_pk  PRIMARY KEY ( id ),
	CONSTRAINT order_item_fk  FOREIGN KEY (sales_order_id)  REFERENCES sales_order(id)
);



