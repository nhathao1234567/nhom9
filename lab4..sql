--bai1
--“TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.
declare @tbThongKe table(MaPB int, LuongTB float)

insert into @tbThongKe
	select PHG, AVG(Luong) from NHANVIEN group by PHG

select * from @tbThongKe

select TENNV,PHG, LUONG, LuongTB, 
TinhTrang = case
when LUONG > LuongTB then 'Khong Tang Luong'
else 'Tang Luong'
end
	from NHANVIEN a 
inner join @tbThongKe b
on a.PHG = b.MaPB

-- Nếu lương nhân viên nhỏ hơn trung bình lương mà nhân viên đó đang làm việc thì xếp loại “nhanvien”, ngược lại xếp loại “truongphong”
DECLARE @TBTHONGKE TABLE(MAPB INT, LUONGTB FLOAT)
INSERT INTO @TBTHONGKE 
SELECT PHG, AVG(LUONG) FROM NHANVIEN GROUP BY PHG
SELECT * FROM @TBTHONGKE
SELECT TENNV,PHG, LUONG, LUONGTB,
TINHTRANG = CASE 
WHEN LUONG > LUONGTB THEN 'TRUONG PHONG'
ELSE 'NHAN VIEN'
END
FROM NHANVIEN A
INNER JOIN @TBTHONGKE B
ON A.PHG = B.MAPB



--Viết chương trình hiển thị TenNV

select TENNV = case 
when PHAI = 'Nam' then 'Mr. ' + TENNV
when PHAI = N'Nữ' then 'Ms. ' + TENNV
else 'khong biet' 
end
	from NHANVIEN


--Viết chương trình tính thuế mà nhân viên phải đóng theo công thức

select TENNV, LUONG,
Thue = case 
	when LUONG between 0 and 25000 then LUONG * 0.1
	when LUONG between 25000 and 30000 then LUONG * 0.12
	when LUONG between 30000 and 40000 then LUONG * 0.15
	when LUONG between 40000 and 50000 then LUONG * 0.2
	else LUONG * 0.25
	end
from NHANVIEN

-- Bai2 
--thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
select * from NHANVIEN
declare @i int = 2, @dem int ;
set @dem = (select COUNT(*) from NHANVIEN)
while (@i < @dem)
begin 
	if (@i = 4)
		begin
			set @i = @i + 2;
			continue;
		end
	select MANV, HONV, TENLOT, TENNV from NHANVIEN
	where CAST(MANV as int) = @i ;
	set @i = @i + 2;
end
--BAI3
--Nhận thông báo “ thêm dư lieu thành cong” từ khối Try 
BEGIN TRY 
INSERT PHONGBAN (TENPHG, MAPHG, TRPHG,NG_NHANCHUC)
VALUES('KE HOACH',111,'019','2020-12-12')
PRINT'CHE THANH CONG'
END TRY
BEGIN CATCH
PRINT 'LOI' + CONVERT(VARCHAR, ERROR_NUMBER(),1)
+ '=>' + ERROR_MESSAGE()
END CATCH
--BAI4
DECLARE @TONG1 INT = 0,@D INT = 10,@F INT
SET @F = 1
WHILE (@F<=@D)
BEGIN
if (@F %2 =0)
SET @TONG1 = @TONG1 + @F
SET @F = @F + 1 
if(@F = 4)
SET @TONG1 = @TONG1 - 4
END
PRINT ('KET QUA: ' )
PRINT @TONG1


