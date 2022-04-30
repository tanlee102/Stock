-- CREATE TABLE BANGTRUCTUYEN (
--     MACP int,

--     GiaMua1 float,
--     KLMua1 int,
--     GiaMua2 float,
--     KLMua2 int,
--     GiaMua3 float,
--     KLMua3 int,

--     GiaKhopLenh float,
--     KLKhopLenh int,

--     GiaBan1 float,
--     KLBan1 int,
--     GiaBan2 float,
--     KLBan2 int,
--     GiaBan3 float,
--     KLBan3 int,

--     TongKL int,
-- );

-- INSERT INTO dbo.BANGTRUCTUYEN (MACP, GiaMua1, KLMua1, GiaMua2, KLMua2, GiaMua3, KLMua3, GiaKhopLenh, KLKhopLenh, GiaBan1, KLBan1, GiaBan2, KLBan2, GiaBan3, KLBan3, TongKL) 
-- VALUES ('AUB', 12000, 100, 12000, 100, 12000, 100, 12000, 100, 12000, 100, 12000, 100, 12000, 100, 10000);

-- USE master;
-- GO
-- ALTER DATABASE CHUNGKHOAN
--     SET ENABLE_BROKER WITH ROLLBACK IMMEDIATE;
-- GO
-- USE CHUNGKHOAN;
-- GO

INSERT INTO dbo.BANGTRUCTUYEN (MACP) 
VALUES ('ACB');
