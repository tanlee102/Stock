-- CREATE PROCEDURE PREC_DATLENH
-- (@macp varchar(20),@loaigd varchar(1), @soluongx int, @giadatx float)
-- AS
-- BEGIN
--     IF EXISTS (SELECT * FROM dbo.LENHDAT WHERE MACP = @macp) 
--         BEGIN
--             EXEC PREC_LENHDAT_MACP @macp = @macp , @loaigd = @loaigd, @soluongx = @soluongx , @giadatx = @giadatx;
--         END
--     ELSE
--         BEGIN
            
--         END

-- EXEC PREC_LENHDAT_MACP @macp = 'ACB' , @loaigd = 'M', @soluongx = 1000 , @giadatx = 1400;
-- EXEC PREC_LENHDAT_MACP @macp = 'ACB' , @loaigd = 'M', @soluongx = 1000 , @giadatx = 1200;
-- EXEC PREC_LENHDAT_MACP @macp = 'ACB' , @loaigd = 'M', @soluongx = 1000 , @giadatx = 1100;

EXEC PREC_LENHDAT_MACP @macp = 'ARB' , @loaigd = 'B', @soluongx =100000 , @giadatx = 300.100;


-- DELETE FROM LENHKHOP;
-- DELETE FROM LENHDAT;
-- DELETE FROM BANGTRUCTUYEN;

-- SELECT  GIADAT, SUM(SOLUONG) AS SOLUONG
--  FROM LENHDAT
--  WHERE MACP = 'ACB' AND LOAIGD = 'M' AND SOLUONG > 0
--  GROUP BY GIADAT ORDER BY GIADAT DESC

-- CREATE TRIGGER [dbo].[AFTER_DATLENH]
-- ON [dbo].[LENHDAT]
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN

--     DECLARE @macp varchar(20)
--     SELECT @macp = MACP FROM INSERTED
--      PRINT('First Statement: ' + @macp)

--     EXEC PREC_SET_BENBAN_BGT @macp = @macp
--     EXEC PREC_SET_BENMUA_BGT @macp = @macp

-- END
-- GO
-- ALTER TABLE [dbo].[LENHDAT] ENABLE TRIGGER [AFTER_DATLENH]
-- GO


-- CREATE TRIGGER [dbo].[AFTER_KHOPLENH]
-- ON [dbo].[LENHKHOP]
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN

--     DECLARE @macp varchar(20);
--     SELECT @macp = a.MACP FROM LENHDAT a, INSERTED b WHERE a.ID = b.IDLENHDAT

--     UPDATE dbo.BANGTRUCTUYEN 
-- 	SET GiaKhopLenh = (SELECT GIAKHOP FROM INSERTED),
-- 		KLKhopLenh = (SELECT SOLUONGKHOP FROM INSERTED),
--         TongKL = TongKL + (SELECT SOLUONGKHOP FROM INSERTED)
-- 	WHERE dbo.BANGTRUCTUYEN.MACP = @macp
    
-- END
-- GO
-- ALTER TABLE [dbo].[LENHDAT] ENABLE TRIGGER [AFTER_DATLENH]
-- GO

-- EXEC PREC_SET_BENBAN_BGT @macp = 'FLC'
-- EXEC PREC_SET_BENMUA_BGT @macp = 'FLC'


-- CREATE TRIGGER AFTER_DATLENH
-- ON dbo.LENHDAT
-- AFTER INSERT
-- AS
-- BEGIN

--     DECLARE @macp nchar(20)
--     PRINT('Record(s) inserted successfully')
--     SELECT @macp = MACP FROM INSERTED

--     EXEC PREC_SET_BENBAN_BGT @macp = @macp
--     EXEC PREC_SET_BENMUA_BGT @macp = @macp

-- END