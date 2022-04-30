SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PREC_SET_BENBAN_BGT]
(@macp varchar(20))
AS
BEGIN

-- DECLARE @macp VARCHAR(20) = 'ACB'
DECLARE @soluong int;
DECLARE @giadat float;
DECLARE @loopnumber int = 1;

DECLARE cursorUPDATE_CP CURSOR FOR  -- khai báo con trỏ cursorUPDATE_CP 
        SELECT TOP 3 GIADAT, SUM(SOLUONG) AS SOLUONG
        FROM LENHDAT 
        WHERE MACP = @macp AND LOAIGD = 'B' AND SOLUONG > 0
        GROUP BY GIADAT ORDER BY GIADAT ASC


OPEN cursorUPDATE_CP
--------
    FETCH NEXT FROM cursorUPDATE_CP     -- Đọc dòng đầu tiên
        INTO @giadat, @soluong

    WHILE @@FETCH_STATUS = 0     --vòng lặp WHILE khi đọc Cursor thành công
    BEGIN

        PRINT 'giadat: ' + convert(varchar(10), @giadat) + ' / soluong: ' + convert(varchar(10), @soluong) 

        IF @loopnumber = 1
            BEGIN
            IF EXISTS (SELECT MACP FROM dbo.BANGTRUCTUYEN WHERE MACP = @macp) -- nếu có sẵn mã cổ phiếu thì cập nhật giá
                BEGIN
                    UPDATE dbo.BANGTRUCTUYEN
                    SET GiaBan1 = @giadat, KLBan1 = @soluong 
                    WHERE MACP = @macp;
                END
            ELSE 
                BEGIN
                    INSERT INTO dbo.BANGTRUCTUYEN (MACP, GiaBan1, KLBan1, TongKL) 
                    VALUES (@macp, @giadat, @soluong, 0);
                END
            END

        IF @loopnumber = 2
            BEGIN
                UPDATE dbo.BANGTRUCTUYEN
                SET GiaBan2 = @giadat, KLBan2 = @soluong 
                WHERE MACP = @macp;
            END

        IF @loopnumber = 3
            BEGIN
                UPDATE dbo.BANGTRUCTUYEN
                SET GiaBan3 = @giadat, KLBan3 = @soluong 
                WHERE MACP = @macp;
            END


        SET @loopnumber = @loopnumber + 1;
        FETCH NEXT FROM cursorUPDATE_CP     -- Đọc dòng đầu tiên
        INTO @giadat, @soluong
    END

CLOSE cursorUPDATE_CP              -- Đóng Cursor
DEALLOCATE cursorUPDATE_CP

IF @loopnumber = 1
    BEGIN 
        UPDATE dbo.BANGTRUCTUYEN
        SET GiaBan1 = NULL, KLBan1 = NULL, GiaBan2 = NULL, KLBan2 = NULL , GiaBan3 = NULL, KLBan3 = NULL 
        WHERE MACP = @macp;
    END

IF @loopnumber = 2
    BEGIN 
        UPDATE dbo.BANGTRUCTUYEN
        SET GiaBan2 = NULL, KLBan2 = NULL, GiaBan3 = NULL, KLBan3 = NULL 
        WHERE MACP = @macp;
    END

IF @loopnumber = 3
    BEGIN 
        UPDATE dbo.BANGTRUCTUYEN
        SET GiaBan3 = NULL, KLBan3 = NULL 
        WHERE MACP = @macp;
    END

END
GO
