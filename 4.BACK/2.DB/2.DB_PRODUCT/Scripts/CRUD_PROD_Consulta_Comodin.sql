DROP PROCEDURE PRODUCT_CONSULTA_COMODIN;
GO
CREATE PROCEDURE PRODUCT_CONSULTA_COMODIN
@NAME VARCHAR (30)
  AS
 BEGIN TRY
  SELECT 
	ID				AS VARCHAR,
	NAME			AS VARCHAR,
	SPECTACLE_DATE	AS VARCHAR,
	ARRIVAL_DATE	AS VARCHAR,
	DEPARTURE_DATE	AS VARCHAR,
	TRANSPORT_TYPE	AS VARCHAR,
	SPECTACLE_TYPE	AS VARCHAR,
	LODGING_TYPE	AS VARCHAR,
	DESCRIPTION		AS VARCHAR,
	CODE			AS VARCHAR,
	IMAGE_REF		AS VARCHAR,
	SOURCE_CITY		AS VARCHAR,
	TARGET_CITY		AS VARCHAR,
	CREATE_DATE		AS VARCHAR,
	UPDATE_DATE		AS VARCHAR,
	COST_TOTAL		AS VARCHAR
  FROM PRODUCT
		WHERE NAME LIKE '%'+ @name +'%'
 END TRY
 BEGIN CATCH  
   -- Retorna el error.
  DECLARE @ErrorMessage nvarchar(4000),  @ErrorSeverity int;  
  SELECT @ErrorMessage = ERROR_MESSAGE(),@ErrorSeverity = ERROR_SEVERITY();  
  RAISERROR(@ErrorMessage, @ErrorSeverity, 1);  
END CATCH; 
GO

/*
DECLARE @NAME varchar(30)
SET @NAME = 'BARCELONA'
	SELECT * FROM PRODUCT
		WHERE NAME LIKE '%'+ @name +'%' 
*/