-- caua1: Xuất định dạng “tổng số giờ làm việc” kiểu decimal với 2 số thập phân.
SELECT THOIGIAN as tongthoigian,
CAST(THOIGIAN AS decimal(10,2)) as sothapphan
  FROM PHANCONG
 
 


  SELECT THOIGIAN as   tongthoigian,
  CONVERT(  decimal(6,2),16) as varchar
  FROM PHANCONG
  
  --Xuất định dạng “tổng số giờ làm việc” kiểu varchar
  SELECT THOIGIAN,
  CAST(THOIGIAN AS VARCHAR)
  FROM PHANCONG
  
  -- Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân.
 SELECT THOIGIAN + CONVERT(VARCHAR,101)
  FROM PHANCONG
  
  select TENPHG,CAST(AVG(LUONG) AS decimal(10,2))AS LUONGTRUNGBINH
	from PHONGBAN,NHANVIEN
	where maphg=PHG
	group by TENPHG


	-- Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace
	select TENPHG,LEFT(CAST(AVG(LUONG) AS VARCHAR),3)+ REPLACE(CAST(AVG(LUONG) AS VARCHAR),LEFT(CAST(AVG(LUONG) AS VARCHAR),3),',' ) AS LUONGTRUNGBINH
	from PHONGBAN,NHANVIEN
	where maphg=PHG
	group by TENPHG
--bÀI2


--Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
	SELECT TENDEAN, CEILING(SUM(THOIGIAN))AS TONGTHOIGIAN
	FROM DEAN,PHANCONG, CONGVIEC
	WHERE DEAN.MADA=CONGVIEC.MADA AND CONGVIEC.MADA=PHANCONG.MADA
	GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
	
	SELECT TENDEAN, FLOOR(SUM(THOIGIAN))AS TONGTHOIGIAN
	FROM DEAN,PHANCONG, CONGVIEC
	WHERE DEAN.MADA=CONGVIEC.MADA AND CONGVIEC.MADA=PHANCONG.MADA
	GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
	
	SELECT TENDEAN, ROUND(SUM(THOIGIAN),2)AS TONGTHOIGIAN
	FROM DEAN,PHANCONG, CONGVIEC
	WHERE DEAN.MADA=CONGVIEC.MADA AND CONGVIEC.MADA=PHANCONG.MADA
	GROUP BY TENDEAN
-- Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
	
	DECLARE @AVG_LUONG FLOAT
	SELECT @AVG_LUONG=AVG(LUONG)
	FROM NHANVIEN
	SELECT HONV,TENLOT,TENNV,ROUND(LUONG,2)
	FROM NHANVIEN
	WHERE LUONG>@AVG_LUONG AND PHG=5
--bÀI3
-- Dữ liệu cột HONV được viết in hoa toàn bộ
	
	SELECT UPPER(HONV),TENLOT,TENNV,DCHI
	FROM NHANVIEN,THANNHAN
	WHERE MA_NVIEN=MANV
	GROUP BY HONV,TENLOT,TENNV,DCHI
	HAVING COUNT(THANNHAN.MA_NVIEN)>2
-- Dữ liệu cột TENLOT được viết in thường toàn bộ toàn bộ	
	SELECT HONV,LOWER(TENLOT),TENNV,DCHI
	FROM NHANVIEN,THANNHAN
	WHERE MA_NVIEN=MANV
	GROUP BY HONV,TENLOT,TENNV,DCHI
	HAVING COUNT(THANNHAN.MA_NVIEN)>2
--Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố.

	 SELECT DCHI FROM NHANVIEN
  SELECT DCHI,CHARINDEX(' ',DCHI) FROM NHANVIEN
  SELECT DCHI, LEFT(DCHI,CHARINDEX(' ',DCHI)) AS 'SỐ NHÀ'FROM NHANVIEN
  /**BÀI 4**/
  -- Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
  
  SELECT HONV,TENLOT,TENNV
  FROM NHANVIEN
  where Year(NGSINH) Between 1960 and 1965
  -- Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.

  SELECT HONV,TENLOT,TENNV,YEAR(GETDATE())-YEAR(NGSINH) AS TUOI
  FROM NHANVIEN
 --Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy

  SELECT TENPHG, CONVERT(VARCHAR, NG_NHANCHUC,105) AS 'NGAY SINH',HONV,TENLOT,TENNV,COUNT(*) NHANVIEN
  FROM PHONGBAN, NHANVIEN
  WHERE   MANV=TRPHG and MAPHG=PHG
  GROUP BY TENPHG,NG_NHANCHUC,HONV,TENLOT,TENNV
 

 
 
  


	

	


	
	
  