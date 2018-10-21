DROP PROCEDURE PR_READ_PRODUCT;
GO
CREATE PROCEDURE PR_READ_PRODUCT  
    @P_ID VARCHAR(MAX),
    @id VARCHAR(MAX) OUTPUT,
    @name VARCHAR(MAX) OUTPUT,
    @spectacle_date VARCHAR(MAX) OUTPUT, 
    @arrival_date VARCHAR(MAX) OUTPUT,
    @departure_date VARCHAR(MAX) OUTPUT,
    @transport_type VARCHAR(MAX) OUTPUT,
    @spectacle_type VARCHAR(MAX) OUTPUT,
    @lodging_type VARCHAR(MAX) OUTPUT,
    @description VARCHAR(MAX) OUTPUT, 
    @code VARCHAR(MAX) OUTPUT,
    @image_ref VARCHAR(MAX) OUTPUT, 
    @source_city VARCHAR(MAX) OUTPUT,
    @target_city VARCHAR(MAX) OUTPUT,
    @create_date VARCHAR(MAX) OUTPUT,
    @update_date VARCHAR(MAX) OUTPUT,
	@cost_total VARCHAR(MAX) OUTPUT,
	@status VARCHAR(MAX) OUTPUT,
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR(MAX) OUTPUT
AS  
BEGIN TRY
   SELECT
    @id = id,
    @name = name,
    @spectacle_date = spectacle_date,
    @arrival_date = arrival_date,
    @departure_date = departure_date,
    @transport_type = transport_type,
    @spectacle_type = spectacle_type,
    @lodging_type = lodging_type,
    @description = description,
    @code = code,
    @image_ref = image_ref,
    @source_city = source_city,
    @target_city = target_city,
    @create_date = create_date,
    @update_date = update_date,
	@cost_total = cost_total,
	@status = status
   FROM [dbo].[product]
   WHERE id = @P_ID
   
    SELECT @id = @@ROWCOUNT
   
	IF @id = 0 
	BEGIN
		SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error el producto ',@P_ID,' no existe');
	END
	ELSE
	BEGIN
		SELECT @ErrorSeverity = 20100, @ErrorMessage = 'OK';
	END
	
END TRY
 BEGIN CATCH  
   -- Retorna el error.
  --SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();
  --RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al consultar el producto ',@P_ID);
  
END CATCH; 
GO 