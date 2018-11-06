DROP PROCEDURE PR_CREATE_PRODUCT;
GO
CREATE PROCEDURE PR_CREATE_PRODUCT
    @name VARCHAR(MAX),
    @spectacle_date VARCHAR(MAX), 
    @arrival_date VARCHAR(MAX),
    @departure_date VARCHAR(MAX),
    @transport_type VARCHAR(MAX),
    @spectacle_type VARCHAR(MAX),
    @lodging_type VARCHAR(MAX),
    @description VARCHAR(MAX), 
    @code VARCHAR(MAX),
    @image_ref VARCHAR(MAX), 
    @source_city VARCHAR(MAX),
    @target_city VARCHAR(MAX),
    --@create_date VARCHAR(MAX),
    --@update_date VARCHAR(MAX),
	@cost VARCHAR(MAX),
	@status VARCHAR(MAX),
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR(MAX) OUTPUT
AS  
BEGIN TRY
INSERT INTO [dbo].[product]
           ([name]
           ,[spectacle_date]
           ,[arrival_date]
           ,[departure_date]
           ,[transport_type]
           ,[spectacle_type]
           ,[lodging_type]
           ,[description]
           ,[code]
           ,[image_ref]
           ,[source_city]
           ,[target_city]
           ,[create_date]
           ,[update_date]
           ,[cost]
		   ,[status])
     VALUES
           (@name,
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
            GETDATE(),
            GETDATE(),
            @cost,
			@status)


	SELECT @ErrorSeverity = 20100, @ErrorMessage = 'OK';
	
END TRY
 BEGIN CATCH  
   -- Retorna el error.
  --SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();
  --RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al insertar el producto ',@name);
  
END CATCH; 
GO 