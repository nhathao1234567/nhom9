--bai1
--“TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.
--“KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương trong phòng mà nhân viên đó đang làm việc.

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



