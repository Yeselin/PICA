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
    @cost varchar,
	@status varchar
AS
BEGIN TRY
INSERT INTO product 
	values (	
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
	300,
	@status 
)
END TRY
BEGIN CATCH  
   -- Retorna el error.
  DECLARE @ErrorMessage nvarchar(4000),  @ErrorSeverity int;  
  SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();  
  RAISERROR(@ErrorMessage, @ErrorSeverity, 1);  
END CATCH;  
GO

