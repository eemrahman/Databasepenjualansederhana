# Nomor 1

CREATE DATABASE 21312027_sbd21a;
USE 21312027_sbd21a;

# Nomor 2

CREATE TABLE detail_transaksi (id CHAR(5), id_tampil_transaksi CHAR(4), id_barang CHAR(6), jumlah INT(11));

CREATE TABLE tampil_transaksi(id CHAR(4), id_pembeli CHAR(8), PRIMARY KEY (id));

CREATE TABLE pembeli (id CHAR(8), nama VARCHAR(50), email VARCHAR(50), PRIMARY KEY (id));

CREATE TABLE barang(id CHAR(6), nama VARCHAR(50), harga INT(11), stok INT(11), PRIMARY KEY (id));
# Pengerjaan relasi memanfaatkan GUI

# Nomor 3
INSERT INTO barang VALUES
('ABRG01', 'Asus ROG Phone 5', 5500000, 20),
('ABRG02', 'Lenovo Legion Duel', 4500000, 10),
('ABRG03','ZTE nubia Red Magic',6800000,15),
('ABRG04','Xiaomi Black Shark 3 Pro', 6000000, 25);

INSERT INTO pembeli VALUES
('APMBL001', 'Tether', 'tether@yahoo.com'),
('APMBL002', 'Cardano', 'cardano@gmail.com'),
('APMBL003', 'tron', 'tron@gmail.com');

INSERT INTO tampil_transaksi VALUES
('TR01', 'APMBL001'),
('TR03', 'APMBL001'),
('TR02', 'APMBL002');

INSERT INTO detail_transaksi VALUES
('DTR01', 'TR01', 'ABRG02', 1),
('DTR02', 'TR01', 'ABRG04', 2),
('DTR03', 'TR02', 'ABRG01', 1),
('DTR04', 'TR03', 'ABRG03', 2),
('DTR05', 'TR03', 'ABRG04', 2);

#Nomor 4
SELECT * FROM pembeli WHERE nama = "Cardano";

#Nomor 5
SELECT 
COUNT(id) AS 'Total Barang', 
SUM(stok) AS 'Total Jumlah Stok Barang'
FROM barang;

#Nomor 6
SELECT tampil_transaksi.id, pembeli.nama 
FROM tampil_transaksi, pembeli
WHERE pembeli.id = tampil_transaksi.id_pembeli 
ORDER BY id;

#Nomor 7
SELECT tampil_transaksi.id AS 'ID Transaksi', 
pembeli.nama AS 'Nama Pembeli', 
SUM(detail_transaksi.jumlah) AS 'Total Barang', 
SUM(barang.harga * detail_transaksi.jumlah) AS 'Total Harga' FROM tampil_transaksi
JOIN pembeli ON pembeli.id = tampil_transaksi.id_pembeli
JOIN detail_transaksi ON detail_transaksi.id_tampil_transaksi = tampil_transaksi.id
JOIN barang ON barang.id = detail_transaksi.id_barang 
GROUP BY tampil_transaksi.id
ORDER BY tampil_transaksi.id;

# Nomor 8
CREATE VIEW V_Pemesanan AS SELECT tampil_transaksi.id, pembeli.nama 
FROM tampil_transaksi, pembeli
WHERE pembeli.id = tampil_transaksi.id_pembeli 
ORDER BY id;

SELECT * FROM V_Pemesanan;

#nomor 9
DELIMITER $$

CREATE
    PROCEDURE `21312027_sbd21a`.`SP_cariTransaksi`()
    BEGIN
SELECT tampil_transaksi.id AS 'ID Transaksi', 
pembeli.nama AS 'Nama Pembeli', 
SUM(detail_transaksi.jumlah) AS 'Total Barang', 
SUM(barang.harga * detail_transaksi.jumlah) AS 'Total Harga' FROM tampil_transaksi
JOIN pembeli ON pembeli.id = tampil_transaksi.id_pembeli
JOIN detail_transaksi ON detail_transaksi.id_tampil_transaksi = tampil_transaksi.id
JOIN barang ON barang.id = detail_transaksi.id_barang 
GROUP BY tampil_transaksi.id
ORDER BY tampil_transaksi.id;
    END$$

DELIMITER ;