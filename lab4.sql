------ B1 ------------

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

--------------------------------------------------------

declare @tbThongKe table(MaPB int, LuongTB float)

insert into @tbThongKe
	select PHG, AVG(Luong) from NHANVIEN group by PHG

select * from @tbThongKe

select TENNV,PHG, LUONG, LuongTB, 
TinhTrang = case
when LUONG > LuongTB then 'Truong Phong'
else 'Nhan VIen'
end
	from NHANVIEN a 
inner join @tbThongKe b
on a.PHG = b.MaPB

----------------------------------------------

select TENNV = case 
when PHAI = 'Nam' then 'Mr. ' + TENNV
when PHAI = N'Nữ' then 'Ms. ' + TENNV
else 'khong biet' 
end
	from NHANVIEN


--------------------------------------------------------

select TENNV, LUONG,
Thue = case 
	when LUONG between 0 and 25000 then LUONG * 0.1
	when LUONG between 25000 and 30000 then LUONG * 0.12
	when LUONG between 30000 and 40000 then LUONG * 0.15
	when LUONG between 40000 and 50000 then LUONG * 0.2
	else LUONG * 0.25
	end
from NHANVIEN

--------------- B2 --------------

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
