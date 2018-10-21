DROP PROCEDURE PR_CREATE_CAMPAIGN;
GO
CREATE PROCEDURE PR_CREATE_CAMPAIGN
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

INSERT INTO [dbo].[campana]
           ([name]
           ,[percentage]
           ,[create_date]
           ,[update_date]
           ,[start_date]
           ,[effective_date]
           ,[image_ref]
           ,[product_id]
           ,[is_active])
     VALUES
           (@name,
            @percentage,
            GETDATE(),
            GETDATE(),
            @start_date,
            @effective_date,
            @image_ref,
            @product_id,
            @is_active)


	SELECT @ErrorSeverity = 20100, @ErrorMessage = 'OK';
	
END TRY
 BEGIN CATCH  
   -- Retorna el error.
  --SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();
  --RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al insertar la campaña ',@name);
  
END CATCH; 
GO 