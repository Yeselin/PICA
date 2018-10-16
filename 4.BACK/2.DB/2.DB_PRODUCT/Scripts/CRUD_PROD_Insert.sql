DROP PROCEDURE PRODUCT_INSERT;
GO
CREATE PROCEDURE PRODUCT_INSERT
    @name			varchar , 
    @spectacle_date varchar , 
    @arrival_date	varchar , 
    @departure_date varchar , 
    @transport_type varchar , 
    @spectacle_type varchar , 
    @lodging_type	varchar , 
    @description	varchar , 
    @code			varchar , 
    @image_ref		varchar , 
    @source_city	varchar , 
    @target_city	varchar ,
    @create_date	varchar ,
    @update_date	varchar ,
    @cost_total		varchar 
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
	GETDATE(), --@create_date, 
	@update_date,
	@cost_total	
)
END TRY
BEGIN CATCH  
   -- Retorna el error.
  DECLARE @ErrorMessage nvarchar(4000),  @ErrorSeverity int;  
  SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();  
  RAISERROR(@ErrorMessage, @ErrorSeverity, 1);  
END CATCH;  
GO
