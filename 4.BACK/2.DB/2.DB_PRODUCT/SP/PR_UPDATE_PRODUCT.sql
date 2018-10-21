DROP PROCEDURE PR_UPDATE_PRODUCT;
GO
CREATE PROCEDURE PR_UPDATE_PRODUCT  
    @id VARCHAR(MAX),
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
	@cost_total VARCHAR(MAX),
	@status VARCHAR(MAX),
	@ErrorSeverity INT OUTPUT,
	@ErrorMessage VARCHAR(MAX) OUTPUT
AS  
BEGIN TRY
   UPDATE [dbo].[product]
   SET [name]           = (CASE WHEN (@name = '' OR @name IS NULL) THEN name ELSE @name END)
      ,[spectacle_date] = (CASE WHEN (@spectacle_date = '' OR @spectacle_date IS NULL) THEN spectacle_date ELSE @spectacle_date END)
      ,[arrival_date]   = (CASE WHEN (@arrival_date = '' OR @arrival_date IS NULL) THEN arrival_date ELSE @arrival_date END)
      ,[departure_date] = (CASE WHEN (@departure_date = '' OR @departure_date IS NULL) THEN departure_date ELSE @departure_date END)
      ,[transport_type] = (CASE WHEN (@transport_type = '' OR @transport_type IS NULL) THEN transport_type ELSE @transport_type END)
      ,[spectacle_type] = (CASE WHEN (@spectacle_type = '' OR @spectacle_type IS NULL) THEN spectacle_type ELSE @spectacle_type END)
      ,[lodging_type]   = (CASE WHEN (@lodging_type = '' OR @lodging_type IS NULL) THEN lodging_type ELSE @lodging_type END)
      ,[description]    = (CASE WHEN (@description = '' OR @description IS NULL) THEN description ELSE @description END)
      ,[code]           = (CASE WHEN (@code = '' OR @code IS NULL) THEN code ELSE @code END)
      ,[image_ref]      = (CASE WHEN (@image_ref = '' OR @image_ref IS NULL) THEN image_ref ELSE @image_ref END)
      ,[source_city]    = (CASE WHEN (@source_city = '' OR @source_city IS NULL) THEN source_city ELSE @source_city END)
      ,[target_city]    = (CASE WHEN (@target_city = '' OR @target_city IS NULL) THEN target_city ELSE @target_city END)
      ,[update_date]    = GETDATE()
      ,[cost_total]     = (CASE WHEN (@cost_total = '' OR @cost_total IS NULL) THEN cost_total ELSE @cost_total END)
	  ,[status]         = (CASE WHEN (@status = '' OR @status IS NULL) THEN status ELSE @status END)
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
  SELECT @ErrorSeverity = -20001, @ErrorMessage = CONCAT ('Error al actualizar el producto ',@id);
  
END CATCH; 
GO 