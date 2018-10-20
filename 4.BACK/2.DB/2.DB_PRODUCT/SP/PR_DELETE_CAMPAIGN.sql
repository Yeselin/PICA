DROP PROCEDURE PR_DELETE_CAMPAIGN;
GO
CREATE PROCEDURE PR_DELETE_CAMPAIGN  
    @id VARCHAR(MAX),
	@is_active VARCHAR(MAX),
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR(MAX) OUTPUT
AS  
BEGIN TRY
   UPDATE [dbo].[campana]
   SET [is_active]           = (CASE WHEN (@is_active = '' OR @is_active IS NULL) THEN is_active ELSE @is_active END)
      ,[update_date]      = GETDATE()
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
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al borrar la campaña ',@id);
  
END CATCH; 
GO 