DROP PROCEDURE PRODUCT_INSERT;
GO
CREATE PROCEDURE PRODUCT_INSERT
    @id     varchar ,
    @name   varchar (50) , 
    @spectacle_date varchar (20) , 
    @arrival_date varchar (20), 
    @departure_date varchar (20), 
    @transport_type varchar , 
    @spectacle_type varchar , 
    @lodging_type varchar , 
    @description varchar (100) , 
    @code varchar (20) , 
    @image_ref varchar (500) , 
    @source_city varchar (20), 
    @target_city varchar (20),
    @create_date varchar (20),
    @update_date varchar (20),
    @cost_total varchar (20)
AS
BEGIN
	SET    @name = 'prueba1' 
	SET    @spectacle_date = GETDATE()
	SET    @arrival_date = GETDATE()
	SET    @departure_date = GETDATE()
	SET    @transport_type = '1'  
	SET    @spectacle_type = '1'  
	SET    @lodging_type = '1'  
	SET    @description = 'des prod'  
	SET    @code = '1'  
	SET    @image_ref = '1'  
	SET    @source_city = '22'  
	SET    @target_city = '11' 
	SET    @create_date = GETDATE()
	SET    @update_date = GETDATE()
	SET    @id = '50000'
	SET    @cost_total = '300'

INSERT INTO product 
	values ( 
	@id,
	@name, 
	@spectacle_date, 
	@arrival_date, 
	@departure_date, 
	@transport_type, 
	@spectacle_type,
	@lodging_type,
	@description, 
	@code, 
	@image_ref, 
	@source_city,
	@target_city, 
	@create_date, 
	@update_date,
	300 
)
END
GO
/*
--    @id     bigint NOT NULL,
DECLARE    @name   nvarchar (50)  
DECLARE    @spectacle_date DATE  
DECLARE    @arrival_date DATE  
DECLARE    @departure_date DATE  
DECLARE    @transport_type BIGINT 
DECLARE    @spectacle_type BIGINT 
DECLARE    @lodging_type BIGINT  
DECLARE    @description NVARCHAR (100)  
DECLARE    @code NVARCHAR (20)  
DECLARE    @image_ref NVARCHAR (500)  
DECLARE    @source_city BIGINT  
DECLARE    @target_city BIGINT 
DECLARE    @create_date datetime
DECLARE    @update_date datetime
--    cost_total numeric(18,2)
--     @id     bigint NOT NULL,
SET    @name   'prueba1',
SET    @spectacle_date '27-10-18 10:15:00 PM' , 
SET    @arrival_date '27-10-18 10:15:00 PM' , 
SET    @departure_date '27-10-18 10:15:00 PM' , 
SET    @transport_type 1 , 
SET    @spectacle_type 1 , 
SET    @lodging_type 1 , 
SET    @description 'des prod' , 
SET    @code 1 , 
SET    @image_ref 1 , 
SET    @source_city 22 , 
SET    @target_city 11 ,
SET    @create_date GETDATE(),
SET    @update_date GETDATE(),
AS
BEGIN
INSERT INTO product
	Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id) id,
	@name name  ,
	@spectacle_date spectacle_date,
	@arrival_date arrival_date,
	@departure_date departure_date,
	@id transport_type,
	@id spectacle_type ,
	@id lodging_type,
	@name description,
	@code code,
	@image_ref image_ref,
	@id source_city ,
	@id target_city ,
	@create_date create_date,
	@update_date update_date,
	300 cost_total
END
GO
*/