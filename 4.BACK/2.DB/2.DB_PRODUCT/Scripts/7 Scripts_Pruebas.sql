USE [DB_PRODUCT]
GO

DECLARE	@return_value int,
		@id varchar(max),
		@name varchar(max),
		@spectacle_date varchar(max),
		@arrival_date varchar(max),
		@departure_date varchar(max),
		@transport_type varchar(max),
		@spectacle_type varchar(max),
		@lodging_type varchar(max),
		@description varchar(max),
		@code varchar(max),
		@image_ref varchar(max),
		@source_city varchar(max),
		@target_city varchar(max),
		@create_date varchar(max),
		@update_date varchar(max),
		@cost_total varchar(max),
		@ErrorSeverity int,
		@ErrorMessage varchar(max)

EXEC	@return_value = [dbo].[PR_READ_PRODUCT]
		@P_ID = N'2000000',
		@id = @id OUTPUT,
		@name = @name OUTPUT,
		@spectacle_date = @spectacle_date OUTPUT,
		@arrival_date = @arrival_date OUTPUT,
		@departure_date = @departure_date OUTPUT,
		@transport_type = @transport_type OUTPUT,
		@spectacle_type = @spectacle_type OUTPUT,
		@lodging_type = @lodging_type OUTPUT,
		@description = @description OUTPUT,
		@code = @code OUTPUT,
		@image_ref = @image_ref OUTPUT,
		@source_city = @source_city OUTPUT,
		@target_city = @target_city OUTPUT,
		@create_date = @create_date OUTPUT,
		@update_date = @update_date OUTPUT,
		@cost_total = @cost_total OUTPUT,
		@ErrorSeverity = @ErrorSeverity OUTPUT,
		@ErrorMessage = @ErrorMessage OUTPUT

SELECT	@id as N'@id',
		@name as N'@name',
		@spectacle_date as N'@spectacle_date',
		@arrival_date as N'@arrival_date',
		@departure_date as N'@departure_date',
		@transport_type as N'@transport_type',
		@spectacle_type as N'@spectacle_type',
		@lodging_type as N'@lodging_type',
		@description as N'@description',
		@code as N'@code',
		@image_ref as N'@image_ref',
		@source_city as N'@source_city',
		@target_city as N'@target_city',
		@create_date as N'@create_date',
		@update_date as N'@update_date',
		@cost_total as N'@cost_total',
		@ErrorSeverity as N'@ErrorSeverity',
		@ErrorMessage as N'@ErrorMessage'

SELECT	'Return Value' = @return_value

GO
