SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PREC_LENHDAT_MACP]
(@macp varchar(20),@loaigd varchar(1), @soluongx int, @giadatx float)
AS
BEGIN

-- DECLARE @loaigd varchar(1)= 'B';
-- DECLARE @soluongx int = 3000;
-- DECLARE @giadatx FLOAT = 6000;

DECLARE @soluongbd int = @soluongx;
DECLARE @id int;
DECLARE @soluong int;
DECLARE @giadat FLOAT;

DECLARE @EXIT BIT = 0;

IF(@loaigd = 'B')
    DECLARE cursorLenhDat CURSOR FOR  -- khai báo con trỏ cursorLenhDat 
    SELECT ID, SOLUONG, GIADAT FROM LENHDAT WHERE MACP = @macp AND LOAIGD = 'M' AND GIADAT >= @giadatx AND TRANGTHAILENH <> 'KHOP HET' ORDER BY GIADAT DESC , ID ASC; 
ELSE
    DECLARE cursorLenhDat CURSOR FOR  -- khai báo con trỏ cursorLenhDat 
    SELECT ID, SOLUONG, GIADAT FROM LENHDAT WHERE MACP = @macp AND LOAIGD = 'B' AND GIADAT <= @giadatx AND TRANGTHAILENH <> 'KHOP HET' ORDER BY GIADAT ASC , ID ASC;

---------------------------------------
OPEN cursorLenhDat
--------
    FETCH NEXT FROM cursorLenhDat     -- Đọc dòng đầu tiên
        INTO @id, @soluong, @giadat

    WHILE @@FETCH_STATUS = 0 AND @EXIT = 0       --vòng lặp WHILE khi đọc Cursor thành công
    BEGIN
        ------------       
        IF @soluongx >= @soluong
            BEGIN

                INSERT INTO dbo.LENHKHOP (SOLUONGKHOP, GIAKHOP, IDLENHDAT)
                VALUES (@soluong, @giadat, @id);

                UPDATE LENHDAT
                SET SOLUONG = 0, TRANGTHAILENH= 'KHOP HET'
                WHERE ID = @id;

                SET @soluongx = @soluongx - @soluong;

                FETCH NEXT FROM cursorLenhDat     -- Đọc dòng tiep
                    INTO @id, @soluong, @giadat

            END


        ELSE
            BEGIN

                IF @soluongx > 0
                BEGIN

                    SET @soluong = @soluong - @soluongx;
                
                    INSERT INTO dbo.LENHKHOP (SOLUONGKHOP, GIAKHOP, IDLENHDAT)
                    VALUES (@soluongx, @giadat, @id);

                    UPDATE LENHDAT
                    SET SOLUONG = @soluong, TRANGTHAILENH= 'KHOP LENH 1 PHAN'
                    WHERE ID = @id;

                    SET @soluongx = 0;

                END;
                

                SET @EXIT = 1;
            END

    END
------
CLOSE cursorLenhDat              -- Đóng Cursor
DEALLOCATE cursorLenhDat

IF @soluongx > 0
BEGIN

    IF @soluongbd = @soluongx
        INSERT INTO dbo.LENHDAT (MACP, LOAIGD, LOAILENH, SOLUONG, GIADAT, TRANGTHAILENH)
        VALUES (@macp, @loaigd, 'LO', @soluongx, @giadatx, 'CHUA KHOP');
    ELSE 
        INSERT INTO dbo.LENHDAT (MACP, LOAIGD, LOAILENH, SOLUONG, GIADAT, TRANGTHAILENH)
        VALUES (@macp, @loaigd, 'LO', @soluongx, @giadatx, 'KHOP LENH 1 PHAN');

END;

END

-- EXEC dbo.PREC_LENHDAT @loaigd = 'B', @soluongx = 1000 , @giadatx = 11000;
GO
