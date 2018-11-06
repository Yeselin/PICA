DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT
DECLARE @ID INT
SET @Lower = 1 ---- The lowest random number
SET @Upper = 50 ---- The highest random number

UPDATE product
SET image_ref =(@Lower + ABS(CRYPT_GEN_RANDOM(1) % (@Upper-@Lower+1)))


update  A
  set A.image_ref = B.IMAGE_REF
  from dbo.product a inner join [dbo].[PRODUCTO_TMP] B on A.image_ref = CONVERT (VARCHAR(500) ,[ID_IMAGE]);