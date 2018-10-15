--TRUNCATE TABLE product;
INSERT INTO product
SELECT
TOP 10000
Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id) id,
S.name name  ,
DATEADD(D, S.CONT, convert(datetime,'27-10-18 10:15:00 PM',5)) spectacle_date,
DATEADD(D, S.CONT, convert(datetime,'27-10-18 10:15:00 PM',5))-1 arrival_date,
DATEADD(D, S.CONT, convert(datetime,'27-10-18 10:15:00 PM',5))+1 departure_date ,
T.id transport_type,
S.id spectacle_type ,
L.id lodging_type,
S.name description,
Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id) code,
CONCAT (Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id),'.png') image_ref,
C1.id source_city ,
C2.id target_city ,
GETDATE() create_date ,
GETDATE() update_date,
2 cost_total
FROM 
CITY C1,
CITY C2,
LODGING L,
( SELECT Row_Number() Over (Order By S0.id) CONT,S0.*
FROM SPECTACLE S0) S,
TRANSPORT T
WHERE C1.country_short_name = 'CO'
--C1.id = 1 --Bogotá
AND C2.id = 861 --Madrid 
--AND L.id = 1 --Hilton
--AND S.id = 40 --F.C. Barcelona / Real Madrid C.F.
--AND T.id = 3 -- American Airlines
Order By C1.id,S.id, L.id, T.id;
COMMIT;
