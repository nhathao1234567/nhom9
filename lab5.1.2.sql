--bai1
--In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của
bạn.
create proc inra @name nvarchar(20)
 as
  begin print'Xin chào ' + @name
  end

exec inra N'Duy Ân'

------ Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.
--create proc inrab @s1 int, @s2 int
create proc inrab @s1 int, @s2 int
as 
  begin
   declare @tg int =0;
   set @tg = @s1 + @s2
   print'Tổng là: '  + cast(@tg as varchar(15))
  end

exec inrab 5,6
----------
--Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
create proc inrac @n int
as
  begin
  declare @tong int = 0, @i int =0;
     while  @i < @n 
	   begin 
	    set @tong = @tong + @i 
	    set @i = @i + 2 
		end
	print 'TỔNG CHẴN: ' + cast(@tong as varchar(15))
  end
  exec inrac 12
-----
--Nhập vào 2 số. In ra ước chung lớn nhất
create proc inrad @a int, @b int
as
  begin
      while (@a != @b) 
	     begin 
		    if (@a >@b)
			 set @a = @a - @b
            else
			set   @b = @b- @a
         end
		 return @a
  end
 declare @c  int
 exec @c= inrad 5,6
 print   @c
--bai2
---Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
create proc nhapvaoa @manv varchar(4)
as
  begin
    select* from NHANVIEN where MANV=@manv 
  end
exec nhapvaoa'002'
---
select COUNT(MANV) FROM NHANVIEN
-----Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA

create   proc nhapvaob 
	@manv int, @Ddiem_DA nvarchar(15)
as
begin 
	select COUNT(MANV) as 'So luong', MADA, TENPHG, DDIEM_DA	
	from NHANVIEN inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
				  inner join DEAN on DEAN.PHONG = NHANVIEN.PHG
	where MADA=@manv and DDIEM_DA = @Ddiem_DA
	GROUP BY TENPHG, MADA, DDIEM_DA
end

exec nhapvaob'003', 'Nha Trang'
---Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là @Trphg và các nhân viên này không có thân nhân.
create proc nhapvaoh 
	@MaTP varchar(5)
as
begin
	select HONV, TENNV, TENPHG, NHANVIEN.MANV, THANNHAN.*
	from NHANVIEN inner join PHONGBAN on PHONGBAN.MAPHG = NHANVIEN.PHG
				  left outer join THANNHAN on THANNHAN.MA_NVIEN = NHANVIEN.MANV
	where THANNHAN.MA_NVIEN is null and TRPHG = @MaTP
end
exec nhapvaoh'003'
--Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có mã @Mapb hay không
create proc nhapvaoj
	@MaNV varchar(5), @MaPB varchar(5)
as
begin
	if exists(select * from NHANVIEN where MANV = @MaNV and PHG = @MaPB)
		print 'Nhan Vien: ' + @MaNV+' co trong phong ban: ' + @MaPB
	else
		print 'Nhan Vien: ' + @MaNV+' khong co trong phong ban ' + @MaPB
end

exec nhapvaoj '004 ','1'
