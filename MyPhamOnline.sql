create database MyPhamOnline
go
use MyPhamOnline
go

CREATE TABLE DANHSACHSP
(
	MaDS INT IDENTITY(1,1),
	TenDS NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_DS PRIMARY KEY(MaDS)
)
GO
CREATE TABLE THUONGHIEU
(
	MaTH INT IDENTITY(1,1),
	TenTH NVARCHAR(100) NOT NULL,
	TieuSu NTEXT,
	CONSTRAINT PK_TH PRIMARY KEY(MaTH)
)
GO

CREATE TABLE SANPHAM
(
	MaSP INT IDENTITY(1,1),
	TenSP NVARCHAR(100) NOT NULL,
	GiaBan MONEY CHECK (GiaBan>=0),
	MoTa NTEXT,
	AnhBia VARCHAR(50),
	NgayCapNhat SMALLDATETIME,
	SoLuongBan INT CHECK(SoLuongBan>0),
	MaDS INT,
	MaTH INT,
	TenSX int,
	CONSTRAINT PK_SP PRIMARY KEY(MaSP)
)
GO

CREATE TABLE SANXUAT
(
	MaSP INT IDENTITY(1,1),
	TenSX NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_SX PRIMARY KEY(MaSP)
)
GO

CREATE TABLE KHACHHANG
(
	MaKH INT IDENTITY(1,1),
	HoTen NVARCHAR(50) NOT NULL,
	TaiKhoan VARCHAR(15) UNIQUE,
	MatKhau VARCHAR(15) NOT NULL,
	Email VARCHAR(50) UNIQUE,
	DiaChi NVARCHAR(50),
	DienThoai VARCHAR(10),
	NgaySinh SMALLDATETIME,
	CONSTRAINT PK_KH PRIMARY KEY(MaKH)
)
GO

CREATE TABLE DONDATHANG
(
	MaDonHang INT IDENTITY(1,1),
	DaThanhToan BIT DEFAULT(0),
	TinhTrangGiaoHang INT DEFAULT(1),
	NgayDat SMALLDATETIME,
	NgayGiao SMALLDATETIME,
	MaKH INT,
	CONSTRAINT PK_DDH PRIMARY KEY(MaDonHang)
)
GO

CREATE TABLE CHITIETDATHANG
(
	MaDonHang INT,
	MaSP INT,
	SoLuong INT CHECK(SoLuong>0),
	DonGia DECIMAL(9,2) CHECK(DonGia>=0),
	CONSTRAINT PK_CTDH PRIMARY KEY(MaDonHang,MaSP)
)
GO
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SP_DS FOREIGN KEY (MaDS) REFERENCES DANHSACHSP(MaDS)
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SP_TH FOREIGN KEY (MaTH) REFERENCES THUONGHIEU(MaTH)
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_DDH_KH FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
ALTER TABLE CHITIETDATHANG ADD CONSTRAINT FK_CTDH_DDH FOREIGN KEY (MaDonHang) REFERENCES DONDATHANG(MaDonHang)
ALTER TABLE CHITIETDATHANG ADD CONSTRAINT FK_CTDH_S FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
ALTER TABLE SANXUAT ADD CONSTRAINT FK_SX_SP FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
GO
 SET IDENTITY_INSERT [dbo].[DANHSACHSP] ON
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (1, N'SỮA RỬA MẶT & TONER')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (2, N'TÁI TẠO')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (3, N'SERUM')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (4, N'KEM DƯỠNG ẨM / BẢO VỆ')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (5, N'MẮT / MÔI')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (6, N'MẶT NẠ & PEEL')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (7, N'CHỐNG NẮNG / SPF')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (8, N'VIÊN UỐNG')
INSERT [dbo].[DANHSACHSP] ([MaDS], [TenDS]) VALUES (9, N'BỘ SẢN PHẨM')
SET IDENTITY_INSERT [dbo].[DANHSACHSP] OFF

SET IDENTITY_INSERT [dbo].[THUONGHIEU] ON
INSERT [dbo].[THUONGHIEU] ([MaTH], [TenTH],[TieuSu]) VALUES (1, N'Murad', N'Công Murad care được thành lập tại Hàn Quốc vào năm 1947')
INSERT [dbo].[THUONGHIEU] ([MaTH], [TenTH],[TieuSu]) VALUES (2, N'Channel', N'Chanel là tên thông dụng của một hãng thời trang Pháp')
INSERT [dbo].[THUONGHIEU] ([MaTH], [TenTH],[TieuSu]) VALUES (3, N'Dior', N'Christian Dior S.E, thường được gọi là Dior, là công ty hàng hóa xa xỉ nổi tiếng của Pháp thuộc quyền kiểm soát và điều hành bởi tỷ phú Bernard Arnault')
INSERT [dbo].[THUONGHIEU] ([MaTH], [TenTH],[TieuSu]) VALUES (4, N'3CE', N'3CE là tên viết tắt của 3 Concept Eyes, là thương hiệu mỹ phẩm Hàn Quốc thành lập vào tháng 1 năm 2009, là công ty con trực thuộc công ty Stylenanda')
INSERT [dbo].[THUONGHIEU] ([MaTH], [TenTH],[TieuSu]) VALUES (5, N'Vichy', N'Vichy là nhãn hiệu dược mỹ phẩm Pháp được tin dùng trên toàn thế giới, trực thuộc tập đoàn L’Oréal. ')
INSERT [dbo].[THUONGHIEU] ([MaTH], [TenTH],[TieuSu]) VALUES (6, N'La Roche-Posay', N'La Roche-Posay chính là tên ngôi làng có nguồn nước khoáng duy nhất trên thế giới giàu selenium tự nhiên và cũng là thành phần chính trong tất cả sản phẩm của nhãn hàng. Cũng tại đây năm 1905, trung tâm trị liệu khoáng đầu tiên được xây dựng. Từ đó đến nay La Roche-Posay đã trở thành trung tâm trị liệu khoáng hàng đầu của Châu Âu dành cho những làn da nhạy cảm và bị thương tổn đấy!')
SET IDENTITY_INSERT [dbo].[THUONGHIEU] OFF

SET IDENTITY_INSERT [dbo].[SANPHAM] ON
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (1, N'3ce white milk cream', 230000, N'Chi tiết sản phẩm: T3ce white milk cream:
Size: 148ml/chai
Lý do bạn cần sản phẩm này: Gel rửa mặt, tẩy trang 4 trong 1, ngoài việc loại bỏ tạp chất mà còn cân bằng hệ vi sinh giúp dưỡng ẩm và nuôi dưỡng làn da khỏe mạnh.

Công dụng chính: Là sản phẩm tẩy trang 4-trong-1
(1) Loại bỏ lớp trang điểm trên mặt, mắt và môi.
(2) Rửa sạch tạp chất và dầu thừa
(3) Nuôi dưỡng với prebiotic
(4) Cấp ẩm sâu
Đối tượng sử dụng: Phù hợp với tất cả mọi loại da, đặc biệt những làn da thường xuyên trang điểm, khô ráp, thiếu ẩm và bề mặt da không nhẵn mịn.

Xin trân trọng giới thiệu', N'3CE.jpg', 7, 4, '04/12/2021', 120)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (2, N'REPLENISHING MULTI-ACID PEEL', 250000, N'Chi tiết sản phẩm: REPLENISHING MULTI-ACID PEEL:
Size: 100ml/chai
Lý do bạn cần sản phẩm này: Dung dịch nuôi dưỡng và tẩy tế bào chết da hàng ngày, và hỗ trợ thúc đẩy quá trình tái tạo tế bào mới.
Công dụng chính: Với thiết kế có 2 phần nước và dầu, sản phẩm cùng lúc mang đến khả năng:
+ Phần chất lỏng bên dưới (Dung dịch tái tạo): Tái cấu trúc bề mặt da, để da mịn màng, tươi sáng. 
+ Phần acid béo bên trên: Nuôi dưỡng để da mềm mại, ẩm mượt
Đối tượng sử dụng: Sản phẩm phù hợp cho những làn da xỉn màu hoặc không đều màu, xuất hiện dấu hiệu lão hóa và có bề mặt da khô ráp thiếu mượt mà.

Xin trân trọng giới thiệu', N'MU1.jpg', 6, 1, '04/12/2021', 120)
INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (3, N'Xịt Khoáng La Roche-Posay Làm Dịu Và Bảo Vệ Da 300g Thermal Water Spring', 350000, N'Chi tiết sản phẩm: Xịt Khoáng La Roche-Posay:
Size: 40ml/chai
Lý do bạn cần sản phẩm này: Dung dịch nuôi dưỡng và tẩy tế bào chết da hàng ngày, và hỗ trợ thúc đẩy quá trình tái tạo tế bào mới.Huyết thanh dành cho mặt & mắt giúp làm giảm các dấu hiệu xỉn màu, mất nước, nếp nhăn trên da và quầng thâm và bọng mắt do căng thẳng hàng ngày. Sản phẩm còn giúp làm dịu các dấu hiệu kích ứng và tăng khả năng phục hồi của các làn da sau khi sử dụng công nghệ cao (lăn kim, laser, peel da...) hoặc sử dụng các sản phẩm không rõ nguồn gốc. 
Công dụng chính: Giải quyết các dấu hiệu của làn da thiếu sức sống do căng thẳng với các biểu biệu:
(1) Kích ứng (tấy đỏ, bỏng rát...) sau khi thực hiện liệu pháp công nghệ cao hoặc sử dụng mỹ phẩm không rõ nguồn gốc. 
(2) Da kém tươi.
(3) Mất độ ẩm.
(4) Da xuất hiện nếp & vết nhăn.
(5) Quầng thâm và bọng mắt.
Đối tượng sử dụng:Phù hợp với mọi loại da, đặc biệt với những đối tượng thường xuyên chịu căng thẳng ở cường độ cao và da đang kích ứng sau khi sử dụng công nghệ cao hoặc sử dụng sản phẩm không rõ nguồn gốc. 

Xin trân trọng giới thiệu', N'LA1.jpg', 5, 6, '04/12/2021', 120)

INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (4, N'Kem Dưỡng Vichy Aqualia Thermal Rehydrating Gel', 330000, N'Chi tiết sản phẩm: Kem Dưỡng Vichy Aqualia Thermal Rehydrating Gel:
Size: 50ml
Lý do bạn cần sản phẩm này: Với công nghệ Retinol Tri-Active mang tính đột phá, kết hợp hài hòa với chiết xuất hoa Swertia và peptide từ tảo đỏ (Red Algae), kem dưỡng ban đêm Retinol Youth Renewal Night Cream sẽ giúp hồi phục làn da nguyên bản - không chút khuyết điểm. 
Công dụng chính:(1) Xóa tan những dấu hiệu lão hóa
(2) Cải thiện bề mặt da trở nên mềm mại, mịn màng và săn chắc
(3) Khôi phục độ ẩm cần thiết cho da

Đối tượng sử dụng:Phù hợp với mọi loại da, đặc biệt những làn da đã xuất hiện nếp nhăn, mất đi độ săn chắc, bề mặt da không còn vẻ mịn màng và thiếu độ ẩm.

Xin trân trọng giới thiệu', N'VH1.jpg', 4, 5, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (5, N'BOY DE CHANEL FORTIFYING GEL MOISTURIZER', 130000, N'Chi tiết sản phẩm: BOY DE CHANEL FORTIFYING GEL MOISTURIZER:
Size:200ml/chai
Lý do bạn cần sản phẩm này: Sản phẩm giúp bạn loại bỏ tế bào chết, tạp chất dư thừa, thúc đẩy sản sinh tế bào mới và giúp các sản phẩm dưỡng hấp thụ tốt vào da. 
Công dụng chính:Làm sạch tế bào chết, thông thoáng lỗ chân lông, trả lại làn da tươi sáng mịn màng.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt những khách hàng đang gặp tình trạng tắc nghẽn lỗ chân lông và nhiều tế bào chết.

Xin trân trọng giới thiệu', N'CN1.jpg', 1, 2, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (6, N'Dior Capture Totale Dreamskin Advanced', 130000, N'Chi tiết sản phẩm: Dior Capture Totale Dreamskin Advanced:
Size:47ml/chai
Lý do bạn cần sản phẩm này: Là gel dưỡng không chứa dầu, Clarifying Oil-Free Water Gel có khả năng cô lập - cách ly vi khuẩn để làm dịu ngay tình trạng sưng viêm và ngăn ngừa mụn phát triển; đồng thời tích lũy & giữ độ ẩm trên da đến 5 ngày mà không hề gây cảm giác bết dính trên da.
Công dụng chính:Tích lũy độ ẩm, cân bằng hệ vi sinh để ngăn mụn phát triển, làm dịu cấp tốc tình trạng viêm sưng tấy đỏ nhờ các công nghệ độc quyền.
1. Công nghệ Quorum-Sensing (công nghệ cách ly vi khuẩn): giúp ngăn giao tiếp vi khuẩn nhờ thế vi khuẩn P.Acne bị cô lập, không phát triển. Kết quả là mụn không thể phát triển gây viêm tấy và lan rộng được.
2. Công nghệ Cumulative Hydration - Release độc quyền: giúp tích lũy và duy trì độ ẩm lên đến 5 ngày mà không hề gây cảm giác dày bí trên da.
Đối tượng sử dụng:Sản phẩm dành cho mọi loại da kể cả da nhạy cảm, đặc biệt phù hợp với da hỗn hợp dầu - da dầu và đang có mụn.

Xin trân trọng giới thiệu', N'DO1.jpg', 2, 3, '04/12/2021', 120)

INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (7, N'CITY SKIN OVERNIGHT DETOX MOISTURIZER', 330000, N'Chi tiết sản phẩm: CITY SKIN OVERNIGHT DETOX MOISTURIZER:
Size:50ml/hủ
Lý do bạn cần sản phẩm này: Công thức mang tính đột phá quyện hoà cùng cực phẩm chống oxy hoá từ chiết xuất tế bào gốc thực vật Marrubium và vitamin C thế hệ mới, giúp thải độc làn da trong đêm, làm bừng sáng vẻ đẹp rạng ngời vào hôm sau.
Công dụng chính:Thanh lọc, thải độc và trung hoà các độc tố và tạp chất do tia tử ngoại và ô nhiễm môi trường gây ra. Đồng thời, sản phẩm còn làm sáng, nâng cấp hàng rào bảo vệ da và tăng sinh collagen. 
Đối tượng sử dụng:
Phù hợp với mọi loại da, đặc biệt với những làn da tối & không đều màu, cháy nắng, sạm nám, tàn nhang, đồi mồi… do thường xuyên tiếp xúc với môi trường đầy bụi bẩn, ánh nắng mặt trời và sử dụng các thiết bị điện từ.
Xin trân trọng giới thiệu', N'MU2.jpg', 3, 1, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (8, N'Kem dưỡng ẩm dạng sáp 3CE Nursing Cream',330000, N'Chi tiết sản phẩm: Kem dưỡng ẩm dạng sáp 3CE Nursing Cream:
Size:50ml/hủ
Lý do bạn cần sản phẩm này: Công thức mang tính đột phá quyện hoà cùng cực phẩm chống oxy hoá từ chiết xuất tế bào gốc thực vật Marrubium và vitamin C thế hệ mới, giúp thải độc làn da trong đêm, làm bừng sáng vẻ đẹp rạng ngời vào hôm sau.
Công dụng chính:Thanh lọc, thải độc và trung hoà các độc tố và tạp chất do tia tử ngoại và ô nhiễm môi trường gây ra. Đồng thời, sản phẩm còn làm sáng, nâng cấp hàng rào bảo vệ da và tăng sinh collagen. 
Đối tượng sử dụng:
Phù hợp với mọi loại da, đặc biệt với những làn da tối & không đều màu, cháy nắng, sạm nám, tàn nhang, đồi mồi… do thường xuyên tiếp xúc với môi trường đầy bụi bẩn, ánh nắng mặt trời và sử dụng các thiết bị điện từ.

Xin trân trọng giới thiệu', N'CE2.jpg', 1, 4, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (9, N'3ce boosting sun primer', 230000, N'Chi tiết sản phẩm: 3ce boosting sun primer:
Size:50ml
Lý do bạn cần sản phẩm này: Sự hoà quyện giữa thành phần vitamin C thế hệ mới kết hợp công nghệ độc quyền MuraSol™ và Skin Repair System, sản phẩm vừa đem đến khả năng chống nắng và ô nhiễm hoàn hảo, vừa nuôi dưỡng làn da trở nên tươi sáng, rạng rỡ & săn chắc
Công dụng chính:(1) Chống nắng quang phổ rộng bảo vệ da hoàn hảo trước UVA/UVB,
(2) chống quá trình oxy hoá và gốc tự do bởi ô nhiễm môi trường,
(3) dưỡng ẩm và nâng cấp hàng rào bảo vệ da.
Đối tượng sử dụng:Phù hợp cho da thường đến khô, đặc biệt với những làn da tối & không đều màu, cháy nắng, sạm nám, tàn nhang, đồi mồi… do thường xuyên tiếp xúc với môi trường đầy bụi bẩn & ánh nắng.

Xin trân trọng giới thiệu', N'CE3.jpg', 5, 4, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (10, N'Kem Dưỡng Christian Dior Capture Totale Multi Perfection Tinted Moisturizer SPF20 50ml', 220000, N'Chi tiết sản phẩm:Kem Dưỡng Christian Dior Capture Totale Multi Perfection Tinted Moisturizer SPF20 50ml:
Size:200ml/chai
Lý do bạn cần sản phẩm này: Sản phẩm giúp bạn loại bỏ tế bào chết, tạp chất dư thừa, thúc đẩy sản sinh tế bào mới và giúp các sản phẩm dưỡng hấp thụ tốt vào da. 
Công dụng chính:Làm sạch tế bào chết, thông thoáng lỗ chân lông, trả lại làn da tươi sáng mịn màng.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt những khách hàng đang gặp tình trạng tắc nghẽn lỗ chân lông và nhiều tế bào chết.

Xin trân trọng giới thiệu', N'DO2.jpg', 3, 3, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (11, N'Dung Dịch BHA Hỗ Trợ Giảm Mụn, Nhờn Obagi Clenziderm MD Pore Therapy 148ml', 990000, N'Chi tiết sản phẩm: Dung Dịch BHA Hỗ Trợ Giảm Mụn, Nhờn Obagi Clenziderm MD Pore Therapy 148ml:
Size:120 viên/hộp.
Lý do bạn cần sản phẩm này: Thực phẩm bảo vệ sức khỏe.
Công dụng chính:Hỗ trợ chống oxy hóa, giúp hạn chế quá trình lão hóa, giúp đẹp da.
Đối tượng sử dụng:Phụ nữ ngoài 30 tuổi cần bổ sung vitamin và khoáng chất cho cơ thể.
Xin trân trọng giới thiệu', N'DO3.jpg', 6, 3, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (12, N'SUBLIMAGE LA CRÈME LUMIÈRE', 930000, N'Chi tiết sản phẩm:SUBLIMAGE LA CRÈME LUMIÈRE:
Size:50ml
Lý do bạn cần sản phẩm này: Với 5 loại vitamin, 5 loại khoáng chất, 5 loại peptide, cùng công nghệ Cumulative Hydration - Release Technology,  Nutrient-Charged Water Gel có khả năng cung cấp tức thời và khóa chặt độ ẩm trong da lên đến 5 ngày. 
Tuy dưỡng ẩm tuyệt vời là thế, nhưng sản phẩm tồn tại ở thể gel mát lạnh, tan chảy lập tức vào trong mà không hề lưu lại bất kỳ sự bóng bẩy hay bí bách nào trên da. 
Công dụng chính:Khóa độ ẩm cho da ngay tức thì và tăng khả năng giữ ẩm đến 5 ngày, đồng thời, tăng cường hàng rào bảo vệ, giúp làn da căng đầy, mềm mại. 
Đối tượng sử dụng:Phù hợp với mọi loại da, đặc biệt với làn da dầu nhưng thiếu độ ẩm, da xỉn màu, thô ráp, xuất hiện nếp nhăn. 

Xin trân trọng giới thiệu', N'CN3.jpg', 2, 2, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (13, N'SUBLIMAGE LE COFFRET', 130000, N'Chi tiết sản phẩm: SUBLIMAGE LE COFFRET:
Size:200ml/chai
Lý do bạn cần sản phẩm này: Sản phẩm giúp bạn loại bỏ tế bào chết, tạp chất dư thừa, thúc đẩy sản sinh tế bào mới và giúp các sản phẩm dưỡng hấp thụ tốt vào da. 
Công dụng chính:Làm sạch tế bào chết, thông thoáng lỗ chân lông, trả lại làn da tươi sáng mịn màng.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt những khách hàng đang gặp tình trạng tắc nghẽn lỗ chân lông và nhiều tế bào chết.

Xin trân trọng giới thiệu', N'CN4.jpg', 7, 2, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (14, N'Kem Chống Nắng Vichy Idéal Soleil SPF50', 130000, N'Chi tiết sản phẩm: Kem Chống Nắng Vichy Idéal Soleil SPF50:
Size:125ml
Lý do bạn cần sản phẩm này: Với khả năng chống nắng quang phổ rộng cùng công nghệ MuraSol độc quyền, sản phẩm giúp bảo vệ làn da hoàn hảo trước tác hại của tia UV.còn nuôi dưỡng làn da mịn màng nhờ các loại peptide chiết xuất từ nấm, và chiết xuất từ lúa mạch, hoa hướng dương và dưa chuột.
Hơn thế nữa, chất liệu trong suốt nhẹ tênh như vô hình cùng công nghệ Soft-Focus Complex sẽ làm mịn tức thì bề mặt da, giúp nếp da mịn màng như tấm nhung lụa thượng hạng.
Công dụng chính:1. Dưỡng da mịn màng
2. Chống nắng toàn diện
3. Làm mịn bề mặt da, và có thể dùng như kem lót để lớp nền đạt mức hoàn hảo
Đối tượng sử dụng:Sản phẩm phù hợp với tất cả các loại da, đặc biệt với các làn da có nhiều khuyết điểm như lỗ chân lông to, nếp nhăn, cấu trúc da thiếu mịn màng, da không đều màu...
Xin trân trọng giới thiệu', N'VH2.jpg', 6, 5, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (15, N'Nước Tẩy Trang Mineral Micellar Water Pureté Thermale', 233000, N'Chi tiết sản phẩm: Nước Tẩy Trang Mineral Micellar Water Pureté Thermale:
Size:100ml
Lý do bạn cần sản phẩm này: Sản phẩm giúp bạn loại bỏ tế bào chết, tạp chất dư thừa, thúc đẩy sản sinh tế bào mới và giúp các sản phẩm dưỡng hấp thụ tốt vào da. 
Công dụng chính:Làm sạch tế bào chết, thông thoáng lỗ chân lông, trả lại làn da tươi sáng mịn màng.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt những khách hàng đang gặp tình trạng tắc nghẽn lỗ chân lông và nhiều tế bào chết.

Xin trân trọng giới thiệu', N'VH3.jpg', 2, 5, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (16, N'Effaclar Gel', 183000, N'Chi tiết sản phẩm: Effaclar Gel:
Size:200ml/chai
Lý do bạn cần sản phẩm này: Sản phẩm giúp bạn loại bỏ tế bào chết, tạp chất dư thừa, thúc đẩy sản sinh tế bào mới và giúp các sản phẩm dưỡng hấp thụ tốt vào da. 
Công dụng chính:Loại bỏ triệt để bụi bẩn và bã nhờn trên da. Cho làn da sạch và tươi mát.
Kiểm soát độ bóng nhờn của da. Giảm khả năng xuất hiện của mụn.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt những khách hàng đang gặp tình trạng tắc nghẽn lỗ chân lông và nhiều tế bào chết.

Xin trân trọng giới thiệu', N'LA2.jpg', 8, 6, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (17, N'Kem dưỡng ẩm sáng da Laroche Posay Effaclar Mat', 133000, N'Chi tiết sản phẩm: Kem dưỡng ẩm sáng da Laroche Posay Effaclar Mat:
Size:40ml
Lý do bạn cần sản phẩm này: Sản phẩm giúp bạn loại bỏ tế bào chết, tạp chất dư thừa, thúc đẩy sản sinh tế bào mới và giúp các sản phẩm dưỡng hấp thụ tốt vào da. 
Công dụng chính:. Dưỡng da mịn màng
2. Chống nắng toàn diện
3. Làm mịn bề mặt da, và có thể dùng như kem lót để lớp nền đạt mức hoàn hảo
Đối tượng sử dụng:
Sản phẩm phù hợp với tất cả các loại da, đặc biệt với các làn da có nhiều khuyết điểm như lỗ chân lông to, nếp nhăn, cấu trúc da thiếu mịn màng, da không đều màu...

Xin trân trọng giới thiệu', N'LA3.jpg', 6, 6, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (18, N'Serum Trị Mụn Laroche Posay effaclar Ultra Concentre', 73000, N'Chi tiết sản phẩm: Serum Trị Mụn Laroche Posay effaclar Ultra Concentre:
Size:Hộp 30ml
Lý do bạn cần sản phẩm này: Serum Laroche posay Effaclar Ultra Concentre Serum trị mụn Effaclar với công thức cân...
Công dụng chính:Làm sạch tế bào chết, thông thoáng lỗ chân lông, trả lại làn da tươi sáng mịn màng.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt những khách hàng đang gặp tình trạng tắc nghẽn lỗ chân lông và nhiều tế bào chết.

Xin trân trọng giới thiệu', N'LA4.jpg', 7, 6, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (19, N'INVISIBLUR PERFECTING SHIELD BROAD SPECTRUM SPF 30', 21330000, N'Chi tiết sản phẩm: INVISIBLUR PERFECTING SHIELD BROAD SPECTRUM SPF 30:
Size:30ml/chai
Lý do bạn cần sản phẩm này: Với khả năng chống nắng quang phổ rộng cùng công nghệ MuraSol độc quyền, sản phẩm giúp bảo vệ làn da hoàn hảo trước tác hại của tia UV. Invisiblur Perfecting Shield Broad Spectrum SPF 30 PA +++ còn nuôi dưỡng làn da mịn màng nhờ các loại peptide chiết xuất từ nấm, và chiết xuất từ lúa mạch, hoa hướng dương và dưa chuột.
Hơn thế nữa, chất liệu trong suốt nhẹ tênh như vô hình cùng công nghệ Soft-Focus Complex sẽ làm mịn tức thì bề mặt da, giúp nếp da mịn màng như tấm nhung lụa thượng hạng.
Công dụng chính:1. Dưỡng da mịn màng
2. Chống nắng toàn diện
3. Làm mịn bề mặt da, và có thể dùng như kem lót để lớp nền đạt mức hoàn hảo
Đối tượng sử dụng:Sản phẩm phù hợp với tất cả các loại da, đặc biệt với các làn da có nhiều khuyết điểm như lỗ chân lông to, nếp nhăn, cấu trúc da thiếu mịn màng, da không đều màu...

Xin trân trọng giới thiệu', N'MU3.jpg', 7, 1, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (20, N'ES POMPHENOL SUNGUARD DIETARY SUPPLEMENT', 133000, N'Chi tiết sản phẩm: ES POMPHENOL SUNGUARD DIETARY SUPPLEMENT:
Size:60 viên/hộp
Lý do bạn cần sản phẩm này: Thực phẩm bảo vệ sức khoẻ

Công dụng chính:Hỗ trợ chống oxy hóa, hạn chế lão hóa da
Đối tượng sử dụng:Người có nhu cầu làm đẹp da, chăm sóc da

Xin trân trọng giới thiệu', N'MU4.jpg', 9, 1, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (21, N'REFRESHING CLEANSER', 199000, N'Chi tiết sản phẩm: REFRESHING CLEANSER:
Size:200ml/chai
Lý do bạn cần sản phẩm này: Sữa rửa mặt có khả năng làm sạch các sản phẩm trang điểm, tạp chất và đánh thức cảm giác sảng khoái. 
Công dụng chính:Làm sạch các lớp trang điểm, bụi bẩn, dầu thừa nhưng lại vô cùng dịu nhẹ và êm ái trên bề mặt da.
Đối tượng sử dụng:Phù hợp với tất cả mọi loại da, đặc biệt với những làn da thường xuyên trang điểm và đã xuất hiện các dấu hiệu lão hoá.

Xin trân trọng giới thiệu', N'MU5.jpg', 9, 1, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (22, N'HYDRATING TONER', 190000, N'Chi tiết sản phẩm: HYDRATING TONER:
Size:180ml/chai
Lý do bạn cần sản phẩm này: Toner cấp ẩm, hồi sinh da tức thì
Công dụng chính:Bổ sung độ ẩm và chuẩn bị da cho bước dưỡng da tiếp theo, đồng thời cân bằng ổn định da và trung hòa những tạp chất trên bề mặt da.
Đối tượng sử dụng:Phù hợp với tất cả làn da, đặc biệt là những làn da thiếu ẩm, đang bị tổn thương, kích ứng.

Xin trân trọng giới thiệu', N'MU6.jpg', 7, 1, '04/12/2021', 120)


INSERT [dbo].[SANPHAM] ([MaSP], [TenSP], [GiaBan], [Mota], [AnhBia], [MaDS], [MaTH], [Ngaycapnhat], [Soluongban]) VALUES (23, N'PREBIOTIC 3-IN-1 MULTIMIST', 330000, N'Chi tiết sản phẩm: PREBIOTIC 3-IN-1 MULTIMIST:
Size:100ml/chai
Lý do bạn cần sản phẩm này:Phun sương sinh học 3-trong-1 bổ sung Prebiotic, giúp da mịn màng, tươi khỏe.
Công dụng chính:(1) Nuôi dưỡng da với prebiotic
(2) Cấp ẩm sâu
(3) Hoạt động như lớp lót trang điểm và Xịt giữ lớp trang điểm
Đối tượng sử dụng:Phù hợp với tất cả các loại da, đặc biệt là những làn da thiếu độ ẩm, sạm màu, xuất hiện nếp nhăn, kết cấu da không đều màu và hỗ trợ trang điểm.

Xin trân trọng giới thiệu', N'MU7.jpg', 7, 1, '04/12/2021', 120)
SET IDENTITY_INSERT [dbo].[SANPHAM] OFF

SET IDENTITY_INSERT [dbo].[SANXUAT] ON
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (1, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (2, N'Mỹ')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (3, N'Pháp')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (4, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (5, N'Mỹ')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (6, N'Pháp')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (7, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (8, N'Mỹ')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (9, N'Pháp')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (10, N'Pháp')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (11, N'Pháp')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (12, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (13, N'Mỹ')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (14, N'Mỹ')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (15, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (16, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (17, N'Hàn Quốc')
INSERT [dbo].[SANXUAT] ([MaSP], [TenSX]) VALUES (18, N'Hàn Quốc')
SET IDENTITY_INSERT [dbo].[SANXUAT] OFF

SET IDENTITY_INSERT [dbo].[KHACHHANG] ON
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (1, N'Hoàng Hồng Vân', N'Phú Hòa', N'0988936592', N'luongvq', N'12345', '02/10/1982', N'luongvq@tdmu.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (2, N'Nguyễn Thanh trí', N'Quận 6', N'Chua có', N'thang', N'123456', '03/10/1981', N'ntluan@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (3, N'Phan Trương Hoàng Vũ', N'Sư Vạn Hạnh', N'Chua có', N'dqhoa', N'hoa', '04/10/1980', N'dqhoa@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (4, N'Nguyễn Viết Thành', N'Khu chung cư', N'0918544699', N'nnngan', N'ngan', '02/19/1982', N'nnngan@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (5, N'Hoàng Quang Thái', N'Cống Quỳnh', N'0908123456', N'dqhuong', N'huong', '06/13/1985', N'dqhuong@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (6, N'Trần Thị Thu Trang', N'Nơ Trang Long', N'Chua có', N'ttttrang', N'trang', '12/10/1990', N'ttrang@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (7, N'Nguyễn Thiên Thanh', N'Hai Bà Trưng', N'0908320111', N'ntthanh', N'thanh', '12/12/1986', N'ntthanh@t3h.hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (8, N'Trần Thị Hải Yến', N'Trần Hưng Đạo', N'8111111   ', N'tthyen', N'yen', '02/07/1988', N'tthyan@vol.vnn.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (9, N'Nguyễn Thị Thanh Mai', N'Trần Quang Diệu', N'81111222', N'nttmai', N'mai', '06/10/1992', NULL)
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (10, N'Nguyễn Thành Danh', N'Cộng Hòa', N'8103751', N'ntdanh', N'danh', '07/10/1978', N'ntdanh@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (11, N'Phạm Thị Nga', N'Q6 - Tp.HCM', N'0831564512', N'ptnga', N'nga', '03/20/1986', N'ptnhung@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (12, N'Lê Doanh Doanh', N'2Bis Hùng Vương', N'07077865', N'lddoanh', N'doanh', '02/11/1982', N'lddoanh@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (13, N'Đòan Ngọc Minh Tâm', N'2 Đinh Tiên Hòang', N'0909092222', N'dnmtam', N'tam', '10/21/1982', N'ndmtam@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [Hoten], [Diachi], [Dienthoai], [TaiKhoan], [Matkhau], [Ngaysinh], [Email]) VALUES (14, N'Trần Khải Nhi', N'3 Bùi Hữu Nghĩa', N'0909095555', N'tknhi', N'nhi', '11/24/1982', N'tknhi@yahoo.com')
SET IDENTITY_INSERT [dbo].[KHACHHANG] OFF

SET IDENTITY_INSERT [dbo].[DONDATHANG] ON
INSERT [dbo].[DONDATHANG] ([MaDonHang], [MaKH], [TinhTrangGiaoHang], [Ngaydat], [Ngaygiao]) VALUES (1, 1, 4, '05/10/2021','05/12/2021')
INSERT [dbo].[DONDATHANG] ([MaDonHang], [MaKH], [TinhTrangGiaoHang], [Ngaydat], [Ngaygiao]) VALUES (2, 1, 2, '05/07/2021','05/11/2021')
SET IDENTITY_INSERT [dbo].[DONDATHANG] OFF
INSERT [dbo].[CHITIETDATHANG] ([MaDonHang], [MaSP], [Soluong], [DonGia]) VALUES (1, 19, 1, 25000)
INSERT [dbo].[CHITIETDATHANG] ([MaDonHang], [MaSP], [Soluong], [DonGia]) VALUES (1, 23, 2, 25000)
INSERT [dbo].[CHITIETDATHANG] ([MaDonHang], [MaSP], [Soluong], [DonGia]) VALUES (2, 1, 1, 26000)
INSERT [dbo].[CHITIETDATHANG] ([MaDonHang], [MaSP], [Soluong], [DonGia]) VALUES (2, 17, 3, 18000)

CREATE TABLE ADMIN
(
	MaAdmin INT IDENTITY(1,1),
	HoTen NVARCHAR(50),
	DiaChi NVARCHAR(50),
	DienThoai VARCHAR(10),
	TenDN VARCHAR(15),
	MatKhau VARCHAR(15),
	NgaySinh SMALLDATETIME,
	Email VARCHAR(50),
	Quyen Int Default 1,
	CONSTRAINT PK_AM PRIMARY KEY(MaAdmin)
)
GO

SET IDENTITY_INSERT [dbo].[ADMIN] ON
INSERT [dbo].[ADMIN] ([MaAdmin], [HoTen], [DiaChi], [DienThoai], [TenDN], [MatKhau], [NgaySinh], [Email],[Quyen]) VALUES (1, N'Nguyễn Thanh Trí', N'Phú Hòa', N'0988936592', N'trint', N'12345', '02/10/1982', N'ntt@tdmu.edu.vn',1)
INSERT [dbo].[ADMIN] ([MaAdmin], [HoTen], [DiaChi], [DienThoai], [TenDN], [MatKhau], [NgaySinh], [Email],[Quyen]) VALUES (2, N'Hoàng Hồng Vân', N'Phú Tân', N'012344444', N'vanhh', N'12345', '01/02/1990', N'vanhh@tdmu.edu.vn',2)
INSERT [dbo].[ADMIN] ([MaAdmin], [HoTen], [DiaChi], [DienThoai], [TenDN], [MatKhau], [NgaySinh], [Email],[Quyen]) VALUES (3, N'	Phan Trương Hoàng Vũ', N'Phú Hòa', N'012344444', N'vupth', N'12345', '04/10/1995', N'vupth@tdmu.edu.vn',2)
SET IDENTITY_INSERT [dbo].[ADMIN] OFF

SELECT * FROM KHACHHANG