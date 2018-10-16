DROP PROCEDURE PRODUCT_DELETE;
GO
CREATE PROCEDURE PRODUCT_DELETE
	@ID VARCHAR
AS
 BEGIN TRY
	DELETE FROM PRODUCT
		WHERE ID = @ID 
	COMMIT
 END TRY
BEGIN CATCH  
   -- Retorna el error.
  DECLARE @ErrorMessage nvarchar(4000),  @ErrorSeverity int;  
  SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();  
  RAISERROR(@ErrorMessage, @ErrorSeverity, 1);  
END CATCH;  
GO 
