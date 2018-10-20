DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT
DECLARE @ID INT
SET @Lower = 1 ---- The lowest random number
SET @Upper = 50 ---- The highest random number

UPDATE product 
SET image_ref = CONCAT((@Lower + ABS(CRYPT_GEN_RANDOM(1) % (@Upper-@Lower+1))),'.jpg')