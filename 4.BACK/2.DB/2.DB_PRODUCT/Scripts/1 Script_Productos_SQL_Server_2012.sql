--USE DB_PRODUCT
--GO
/****** Object:  Table [dbo].[city]    Script Date: 09/10/2018 18:10:23 ******/
--DROP TABLE PRODUCT;
--DROP TABLE CITY;
--DROP TABLE TRANSPORT;
--DROP TABLE SPECTACLE;
--DROP TABLE LODGING;
--DROP TABLE CAMPANA;
--GO

CREATE TABLE city (
    id          bigint NOT NULL,
    name_city   nvarchar (50) , 
    cost NUMERIC (18,2) , 
    country_name NVARCHAR (100) ,
	country_short_name nvarchar(2),
	create_date datetime,
	update_date datetime,
    CONSTRAINT city_pk PRIMARY KEY (id)
)
GO
--268.832

CREATE TABLE lodging (
    id     bigint NOT NULL,
    name   nvarchar (50),
	cost numeric(18,2),
	create_date datetime,
	update_date datetime,
    CONSTRAINT lodging_pk PRIMARY KEY (id)
)
GO

CREATE TABLE spectacle (
    id     bigint NOT NULL,
    name   nvarchar(50),
	cost numeric(18,2),
	create_date datetime,
	update_date datetime,
	CONSTRAINT spectacle_pk PRIMARY KEY (id)
)
GO

CREATE TABLE transport(
    id     bigint NOT NULL,
    name   nvarchar(50),
	cost numeric(18,2),
	create_date datetime,
	update_date datetime,
	CONSTRAINT transport_pk PRIMARY KEY (id)
)
GO

CREATE TABLE campana(
    id     bigint NOT NULL,
    name   nvarchar(50),
	percentage numeric(18,2),
	create_date datetime,
	update_date datetime,
	start_date datetime,
	effective_date datetime,
    image_ref NVARCHAR (500),
	product_id BIGINT,
	is_active int,
	CONSTRAINT campana_pk PRIMARY KEY (id)
--	CONSTRAINT campana_product_fk FOREIGN KEY (product_id) REFERENCES product(id)
)
GO

CREATE TABLE product (
    id     bigint NOT NULL,
    name   nvarchar (50) , 
    spectacle_date DATE , 
    arrival_date DATE , 
    departure_date DATE , 
    transport_type BIGINT , 
    spectacle_type BIGINT , 
    lodging_type BIGINT , 
    description NVARCHAR (100) , 
    code NVARCHAR (20) , 
    image_ref NVARCHAR (500) , 
    source_city BIGINT , 
    target_city BIGINT ,
    create_date datetime,
    update_date datetime,
	cost_total numeric(18,2)
	CONSTRAINT product_pk PRIMARY KEY (id),
	CONSTRAINT product_source_city_fk FOREIGN KEY (source_city) REFERENCES city(id),
	CONSTRAINT product_target_city_fk FOREIGN KEY (target_city) REFERENCES city(id),
	CONSTRAINT product_transport_fk FOREIGN KEY (transport_type) REFERENCES transport(id),
	CONSTRAINT product_lodging_fk FOREIGN KEY (lodging_type) REFERENCES lodging(id),
	CONSTRAINT product_spectacle_fk FOREIGN KEY (spectacle_type) REFERENCES spectacle(id)
)
GO

ALTER TABLE campana 
	ADD CONSTRAINT campana_product_fk FOREIGN KEY (product_id) REFERENCES product(id)
GO