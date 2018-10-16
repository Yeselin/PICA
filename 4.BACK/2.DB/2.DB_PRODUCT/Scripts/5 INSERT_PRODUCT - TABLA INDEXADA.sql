--Copia de la tabla no indexada PRODUCT2 a la tabla indexada PRODUCT
INSERT INTO product
SELECT
name  ,
spectacle_date,
arrival_date,
departure_date ,
transport_type,
spectacle_type ,
lodging_type,
description,
code,
image_ref,
source_city ,
target_city ,
create_date ,
update_date,
cost_total
FROM product2
GO
DROP TABLE PRODUCT2
GO
