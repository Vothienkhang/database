CREATE DATABASE quan_ly_ban_hang;
USE quan_ly_ban_hang;

CREATE TABLE khach_hang (
    ma_khach_hang VARCHAR(5) PRIMARY KEY,
    ho_va_ten_lot VARCHAR(50) NOT NULL,
    ten VARCHAR(50) NOT NULL,
    dia_chi VARCHAR(255),
    email VARCHAR(50),
    dien_thoai VARCHAR(13)
);

CREATE TABLE san_pham (
    ma_san_pham INT AUTO_INCREMENT PRIMARY KEY,
    ten_sp VARCHAR(50) NOT NULL,
    mo_ta VARCHAR(255),
    so_luong INT NOT NULL CHECK (so_luong >= 0),
    don_gia DECIMAL(15,2) NOT NULL CHECK (don_gia >= 0)
);

CREATE TABLE hoa_don (
    ma_hoa_don INT AUTO_INCREMENT PRIMARY KEY,
    ngay_mua_hang DATE NOT NULL,
    ma_khach_hang VARCHAR(5) NOT NULL,
    trang_thai VARCHAR(30) NOT NULL,
    CONSTRAINT fk_hoa_don_khach_hang
        FOREIGN KEY (ma_khach_hang)
        REFERENCES khach_hang(ma_khach_hang)
);

CREATE TABLE hoa_don_chi_tiet (
    ma_hoa_don_chi_tiet INT AUTO_INCREMENT PRIMARY KEY,
    ma_hoa_don INT NOT NULL,
    ma_san_pham INT NOT NULL,
    so_luong INT NOT NULL CHECK (so_luong > 0),
    CONSTRAINT fk_hdct_hoa_don
        FOREIGN KEY (ma_hoa_don)
        REFERENCES hoa_don(ma_hoa_don),
    CONSTRAINT fk_hdct_san_pham
        FOREIGN KEY (ma_san_pham)
        REFERENCES san_pham(ma_san_pham)
);

INSERT INTO khach_hang (ma_khach_hang, ho_va_ten_lot, ten, dia_chi, email, dien_thoai)
VALUES
('KH001', 'Nguyen Van', 'An', '123 Le Loi, Q1, TP.HCM', 'an.nguyen@gmail.com', '0901234567'),
('KH002', 'Tran Thi', 'Binh', '45 Nguyen Trai, Q5, TP.HCM', 'binh.tran@gmail.com', '0912345678'),
('KH003', 'Le Hoang', 'Cuong', '78 Hai Ba Trung, Q3, TP.HCM', 'cuong.le@gmail.com', '0923456789'),
('KH004', 'Pham Thi', 'Dung', '12 Vo Van Tan, Q10, TP.HCM', 'dung.pham@gmail.com', '0934567890'),
('KH005', 'Do Minh', 'Em', '90 Cach Mang Thang 8, Q3, TP.HCM', 'em.do@gmail.com', '0945678901');


INSERT INTO san_pham (ten_sp, mo_ta, so_luong, don_gia)
VALUES
('Laptop Dell', 'Laptop Dell Inspiron 15', 10, 15000000.00),
('Chuot Logitech', 'Chuot khong day Logitech M185', 50, 250000.00),
('Ban phim Co', 'Ban phim co gaming RGB', 20, 850000.00),
('Man hinh LG', 'Man hinh LG 24 inch Full HD', 15, 3200000.00),
('Tai nghe Sony', 'Tai nghe chup tai Sony', 30, 1200000.00),
('USB 64GB', 'USB Sandisk 64GB', 100, 180000.00),
('Loa Bluetooth', 'Loa Bluetooth mini', 25, 650000.00);

INSERT INTO hoa_don (ngay_mua_hang, ma_khach_hang, trang_thai)
VALUES
('2016-12-05', 'KH001', 'chua thanh toan'),
('2016-12-10', 'KH002', 'da thanh toan'),
('2016-12-15', 'KH003', 'chua thanh toan'),
('2016-11-20', 'KH004', 'da thanh toan'),
('2016-12-25', 'KH005', 'chua thanh toan'),
('2017-01-05', 'KH001', 'da thanh toan');

INSERT INTO hoa_don_chi_tiet (ma_hoa_don, ma_san_pham, so_luong)
VALUES
-- Hoa don 1
(1, 1, 1),
(1, 2, 2),
(1, 3, 1),

-- Hoa don 2
(2, 2, 1),
(2, 4, 1),

-- Hoa don 3
(3, 1, 1),
(3, 2, 1),
(3, 3, 1),
(3, 4, 1),
(3, 5, 1),

-- Hoa don 4
(4, 6, 3),

-- Hoa don 5
(5, 1, 1),
(5, 2, 1),
(5, 3, 1),
(5, 4, 1),
(5, 5, 1),
(5, 6, 1),

-- Hoa don 6
(6, 7, 2);

-- 1. Hien thi so luong khach hang co trong bang khach_hang
SELECT COUNT(*) AS so_luong_khach_hang
FROM khach_hang;

-- 2. Hien thi don gia lon nhat trong bang san_pham
SELECT MAX(don_gia) AS don_gia_lon_nhat
FROM san_pham;

-- 3. Hien thi so luong san pham thap nhat trong bang san_pham
SELECT MIN(so_luong) AS so_luong_thap_nhat
FROM san_pham;

-- 4. Hien thi tong so luong san pham co trong bang san_pham
SELECT SUM(so_luong) AS tong_so_luong_san_pham
FROM san_pham;

-- 5. Hien thi so hoa don da xuat trong thang 12/2016 ma co trang thai chua thanh toan
SELECT COUNT(*) AS so_hoa_don_chua_thanh_toan_thang_12_2016
FROM hoa_don
WHERE MONTH(ngay_mua_hang) = 12
  AND YEAR(ngay_mua_hang) = 2016
  AND trang_thai = 'chua thanh toan';

-- 6. Hien thi ma hoa don va so loai san pham duoc mua trong tung hoa don
SELECT ma_hoa_don, COUNT(DISTINCT ma_san_pham) AS so_loai_san_pham
FROM hoa_don_chi_tiet
GROUP BY ma_hoa_don;

-- 7. Hien thi ma hoa don va so loai san pham duoc mua trong tung hoa don,
-- chi hien thi cac hoa don co tu 5 loai san pham tro len
SELECT ma_hoa_don, COUNT(DISTINCT ma_san_pham) AS so_loai_san_pham
FROM hoa_don_chi_tiet
GROUP BY ma_hoa_don
HAVING COUNT(DISTINCT ma_san_pham) >= 5;

-- 8. Hien thi thong tin bang hoa_don gom cac cot ma_hoa_don, ngay_mua_hang, ma_khach_hang,
-- sap xep theo thu tu giam dan cua ngay_mua_hang
SELECT ma_hoa_don, ngay_mua_hang, ma_khach_hang
FROM hoa_don
ORDER BY ngay_mua_hang DESC;
























