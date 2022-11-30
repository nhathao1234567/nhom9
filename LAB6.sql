--Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì xuất thông báo “luong phải >15000’
create trigger insertnhanvien on NHANVIEN
for insert
as 
 if(select luong from inserted)<15000
  begin 
     print'luong phai lon hon 15000'
     rollback transaction
   end
select* from NHANVIEN 
insert into NHANVIEN
values ('Tran', 'Thanh','Huy','021','2020-12-12','Da Nang','Nam',16000,'004',1)
--Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
create trigger insertnhanvien2 on NHANVIEN
for insert
as
  declare @tuoi int
  set @tuoi = YEAR(GETDATE()) - (select YEAR(NgSinh) from inserted)
  if (@tuoi < 18 or @tuoi > 65)
  begin 
   print'tuoi khong hop le'
   rollback transaction
  end
  ----Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
insert into NHANVIEN
values ('Tran', 'Thanh','Huy','022','2022-12-12','Da Nang','Nam',16000,'004',1)

create trigger insertnhanvien on NHANVIEN
for update 
as
    if(select dchi from inserted) like '%HCM%'
	begin
	    print'dia chi ko hop le'
		rollback transaction
    end
select * from NHANVIEN
update NHANVIEN set  HONV= 'tran'
where MANV ='018'
select * from NHANVIEN
----bai2
--Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động
--thêm mới nhân viên.
create trigger insertnhanvien2a on NHANVIEN 
after insert 
as
   begin
   select COUNT(case when UPPER (PHAI) =N'Nam' then 1 end) Nam,
   COUNT( case when UPPER (PHAI) = N'Nữ' then 1 end) Nữ
 from NHANVIEN

end
insert into NHANVIEN values ('tong','phuoc','quan','021','01-09-1975','275BD','nam',16000,'005',1)
select* from NHANVIEN

----Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng DEAN
create trigger insertnhanvien2c on DEAN
after delete
as
	begin 
	select ma_nvien, count (MADA) as ' so luong du an' from PHANCONG group by MA_NVIEN
	end
    select* from PHANCONG
    select* from DEAN
    insert into DEAN values('SQL server', 40,'BD',4)
    delete from DEAN where MADA=40
	
--bai3
---Xóa các thân nhân trong bảng thân nhân có liên quan khi thực hiện hành động xóa nhân viên trong bảng nhân viên.
create trigger delete_thannhan on NHANVIEN
instead of delete
as
  begin
     delete from THANNHAN where MA_NVIEN in(select MANV from deleted)
	 delete from NHANVIEN where MANV in(select MANV from deleted)
  end
select* from  NHANVIEN
select* from THANNHAN
select* from PHANCONG
insert into THANNHAN values ('020','khang','nam','03-23-2009','con')
delete from NHANVIEN WHERE MANV='020'
--Khi thêm một nhân viên mới thì tự động phân công cho nhân viên làm đề án có MADA là 1.
create trigger insertnhanvien3b on  NHANVIEN
after insert
as
  begin
    insert into PHANCONG values((select MANV from inderted),1,1,30)
  end
	insert into NHANVIEN values ('tong','phuoc','quan','022','01-09-1975','275BD','nam',16000,'005',1)
select * from NHANVIEN
select * from PHANCONG

