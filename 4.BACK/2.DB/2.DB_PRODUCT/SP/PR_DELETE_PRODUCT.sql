DROP PROCEDURE PR_DELETE_PRODUCT;
GO
CREATE PROCEDURE PR_DELETE_PRODUCT  
    @id VARCHAR(MAX),
	@status VARCHAR(MAX),
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR(MAX) OUTPUT
AS  
BEGIN TRY
   UPDATE [dbo].[product]
   SET [status]           = (CASE WHEN (@status = '' OR @status IS NULL) THEN status ELSE @status END)
      ,[update_date]      = GETDATE()
   WHERE id = @id
   
    --SELECT @id = @@ROWCOUNT
   
	IF @@ROWCOUNT = 0 
	BEGIN
		SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error el producto ',@id,' no existe');
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
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al borrar el producto ',@id);
  
END CATCH; 
GO 