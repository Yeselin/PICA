BEGIN

INSERT INTO product2
SELECT
TOP 1000000
Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id) ,
S.name name  ,
DATEADD(D, S.CONT, convert(datetime,'27-10-18 10:15:00 PM',5)) spectacle_date,
DATEADD(D, S.CONT, convert(datetime,'27-10-18 10:15:00 PM',5))-1 arrival_date,
DATEADD(D, S.CONT, convert(datetime,'27-10-18 10:15:00 PM',5))+1 departure_date ,
T.id transport_type,
S.id spectacle_type ,
L.id lodging_type,
S.name description,
Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id) code,
--CONCAT (Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id),'.png') image_ref,
CONCAT (Row_Number() Over (Order By C1.id,S.id, L.id, T.id, C2.id),'.png') image_ref,
C1.id source_city ,
C2.id target_city ,
GETDATE() create_date ,
GETDATE() update_date,
300 cost,
1 status
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


Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (1,'yojvmf5pvy.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (2,'tqodwbygkq.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (3,'cd9yuhoatm.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (4,'0kk6fkmq4v.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (5,'r30mnqtxkn.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (6,'xw1h7dtawh.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (7,'wfuo38yzfc.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (8,'7mi3prjyhb.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (9,'ykowkh9281.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (10,'43tfr2k7kb.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (11,'rbdjdihfcu.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (12,'5mvbe8mo50.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (13,'lsc4fydt8x.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (14,'z2btra0fti.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (15,'ox1i3ywiav.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (16,'i6x69iraoq.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (17,'c8wwal14gd.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (18,'882w9915h9.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (19,'ropzxtk8ko.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (20,'6thzbla35m.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (21,'qtlfzs2t6k.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (22,'v13pkqstr1.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (23,'a79bve710n.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (24,'02akkzkpc3.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (25,'jg5y50y07i.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (26,'sof9ddofwe.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (27,'frbrcxkpu6.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (28,'whlz7gfge2.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (29,'qbqmbjdtbw.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (30,'oi56ndepc8.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (31,'7m4ihahd44.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (32,'pyrzv1dx3p.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (33,'h0v4zqlfck.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (34,'7mif81zqbk.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (35,'x507jtulsx.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (36,'vgoxr3l5dq.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (37,'5sm1yuyp3s.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (38,'z4021ppopr.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (39,'anoa85nho8.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (40,'whm6hio214.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (41,'gz4bdhdnvx.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (42,'zf5axcl6i2.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (43,'ojdj2p76cy.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (44,'bmt8ofbi2k.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (45,'qqyeannak4.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (46,'j1lfvz1e75.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (47,'ltmv55zbcb.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (48,'kksz8b1my6.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (49,'sohp9siz5e.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (50,'49jve3raa2.jpg');
Insert into PRODUCTO_TMP (ID_IMAGE,IMAGE_REF) values (51,'schhid2aln.jpg');

END
