DROP PROCEDURE PR_UPDATE_CAMPAIGN;
GO
CREATE PROCEDURE PR_UPDATE_CAMPAIGN  
    @id VARCHAR(MAX),
    @name VARCHAR(MAX),
	@percentage VARCHAR(MAX),
	--@create_date VARCHAR(MAX),
	--@update_date VARCHAR(MAX),
	@start_date VARCHAR(MAX),
	@effective_date VARCHAR(MAX),
    @image_ref VARCHAR(MAX),
	@product_id VARCHAR(MAX),
	@is_active VARCHAR(MAX),
	@ErrorSeverity INT,
	@ErrorMessage VARCHAR(MAX) 
AS  
BEGIN TRY
   UPDATE [dbo].[campana]
   SET [name]           = (CASE WHEN (@name = '' OR @name IS NULL) THEN name ELSE @name END)
      ,[percentage]     = (CASE WHEN (@percentage = '' OR @percentage IS NULL) THEN percentage ELSE @percentage END)
	  ,[update_date]    = GETDATE()
      ,[start_date]     = (CASE WHEN (@start_date = '' OR @start_date IS NULL) THEN start_date ELSE @start_date END)
      ,[effective_date] = (CASE WHEN (@effective_date = '' OR @effective_date IS NULL) THEN effective_date ELSE @effective_date END)
	  ,[image_ref]      = (CASE WHEN (@image_ref = '' OR @image_ref IS NULL) THEN image_ref ELSE @image_ref END)
      ,[product_id]     = (CASE WHEN (@product_id = '' OR @product_id IS NULL) THEN product_id ELSE @product_id END)
      ,[is_active]      = (CASE WHEN (@is_active = '' OR @is_active IS NULL) THEN is_active ELSE @is_active END)
   WHERE id = @id
   
    --SELECT @id = @@ROWCOUNT
   
	IF @@ROWCOUNT = 0 
	BEGIN
		SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error la campaña ',@id,' no existe');
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
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al actualizar la campaña ',@id);
  
END CATCH; 
GO 