DROP PROCEDURE PR_READ_PRODUCT;
GO
CREATE PROCEDURE PR_READ_PRODUCT  
    @P_NAME VARCHAR,  
    @id VARCHAR OUTPUT,
    @name VARCHAR OUTPUT,
    @spectacle_date VARCHAR OUTPUT, 
    @arrival_date VARCHAR OUTPUT,
    @departure_date VARCHAR OUTPUT,
    @transport_type VARCHAR OUTPUT,
    @spectacle_type VARCHAR OUTPUT,
    @lodging_type VARCHAR OUTPUT,
    @description VARCHAR OUTPUT, 
    @code VARCHAR OUTPUT,
    @image_ref VARCHAR OUTPUT, 
    @source_city VARCHAR OUTPUT,
    @target_city VARCHAR OUTPUT,
    @create_date VARCHAR OUTPUT,
    @update_date VARCHAR OUTPUT,
	@cost_total VARCHAR OUTPUT,
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR OUTPUT
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
	@cost_total = cost_total
   FROM [dbo].[product]
   WHERE NAME = UPPER(@P_NAME)  
 END TRY
 BEGIN CATCH  
   -- Retorna el error.
  --SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();
  --RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al consultar el producto ',@P_NAME) ;
  
END CATCH; 
GO 