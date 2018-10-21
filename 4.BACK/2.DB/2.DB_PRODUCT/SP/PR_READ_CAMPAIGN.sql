DROP PROCEDURE PR_READ_CAMPAIGN;
GO
CREATE PROCEDURE PR_READ_CAMPAIGN
	@P_ID VARCHAR(MAX),
	@id VARCHAR(MAX) OUTPUT,
    @name VARCHAR(MAX) OUTPUT,
	@percentage VARCHAR(MAX) OUTPUT,
	@create_date VARCHAR(MAX) OUTPUT,
	@update_date VARCHAR(MAX) OUTPUT,
	@start_date VARCHAR(MAX) OUTPUT,
	@effective_date VARCHAR(MAX) OUTPUT,
    @image_ref VARCHAR(MAX) OUTPUT,
	@product_id VARCHAR(MAX) OUTPUT,
	@is_active VARCHAR(MAX) OUTPUT,
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR(MAX) OUTPUT
AS  
BEGIN TRY
   SELECT 
      @id =id,
      @name =name,
      @percentage =percentage,
      @create_date =create_date,
      @update_date =update_date,
      @start_date =start_date,
      @effective_date =effective_date,
      @image_ref =image_ref,
      @product_id =product_id,
      @is_active =is_active
  FROM [dbo].[campana]
   WHERE id = @P_ID
   
    SELECT @id = @@ROWCOUNT
   
	IF @id = 0 
	BEGIN
		SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error la campaña ',@P_ID,' no existe');
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
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al consultar la campaña ',@P_ID);
  
END CATCH; 
GO 