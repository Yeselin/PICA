DROP PROCEDURE PRODUCT_UPDATE;
GO
CREATE PROCEDURE PRODUCT_UPDATE
	@id             varchar ,
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
UPDATE product 	
	SET name				= ISNULL (@name,				name),
		spectacle_date		= ISNULL (@spectacle_date,	spectacle_date), 
	    arrival_date		= ISNULL (@arrival_date,		arrival_date), 
	    departure_date		= ISNULL (@departure_date,	departure_date),  
	    transport_type		= ISNULL (@transport_type,	transport_type),
	    spectacle_type		= ISNULL (@spectacle_type,	spectacle_type),
	    lodging_type		= ISNULL (@lodging_type,		lodging_type),
	    description			= ISNULL (@description,		description), 
	    code				= ISNULL (@code,				code), 
	    image_ref			= ISNULL (@image_ref,			image_ref), 
	    source_city			= ISNULL (@source_city,		source_city),
	    target_city			= ISNULL (@target_city,		target_city), 
	    create_date			= ISNULL (@create_date,		create_date), 
	    update_date			= GETDATE(),
	    cost_total			= ISNULL (@cost_total,		cost_total)	

	WHERE ID = @ID 
END TRY
BEGIN CATCH  
   -- Retorna el error.
  DECLARE @ErrorMessage nvarchar(4000),  @ErrorSeverity int;  
  SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();  
  RAISERROR(@ErrorMessage, @ErrorSeverity, 1);  
END CATCH;  
GO
