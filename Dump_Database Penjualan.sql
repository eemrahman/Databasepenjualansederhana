/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.4.24-MariaDB : Database - 21312027_sbd21a
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`21312027_sbd21a` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `21312027_sbd21a`;

/*Table structure for table `barang` */

DROP TABLE IF EXISTS `barang`;

CREATE TABLE `barang` (
  `id` char(6) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `barang` */

insert  into `barang`(`id`,`nama`,`harga`,`stok`) values ('ABRG01','Asus ROG Phone 5',5500000,20),('ABRG02','Lenovo Legion Duel',4500000,10),('ABRG03','ZTE nubia Red Magic',6800000,15),('ABRG04','Xiaomi Black Shark 3 Pro',6000000,25);

/*Table structure for table `detail_transaksi` */

DROP TABLE IF EXISTS `detail_transaksi`;

CREATE TABLE `detail_transaksi` (
  `id` char(5) DEFAULT NULL,
  `id_tampil_transaksi` char(4) DEFAULT NULL,
  `id_barang` char(6) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  KEY `for_id_tampil.detail_id_tampil` (`id_tampil_transaksi`),
  KEY `for_id_barang.detail_id.barang` (`id_barang`),
  CONSTRAINT `for_id_barang.detail_id.barang` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `for_id_tampil.detail_id_tampil` FOREIGN KEY (`id_tampil_transaksi`) REFERENCES `tampil_transaksi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `detail_transaksi` */

insert  into `detail_transaksi`(`id`,`id_tampil_transaksi`,`id_barang`,`jumlah`) values ('DTR01','TR01','ABRG02',1),('DTR02','TR01','ABRG04',2),('DTR03','TR02','ABRG01',1),('DTR04','TR03','ABRG03',2),('DTR05','TR03','ABRG04',2);

/*Table structure for table `pembeli` */

DROP TABLE IF EXISTS `pembeli`;

CREATE TABLE `pembeli` (
  `id` char(8) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `pembeli` */

insert  into `pembeli`(`id`,`nama`,`email`) values ('APMBL001','Tether','tether@yahoo.com'),('APMBL002','Cardano','cardano@gmail.com'),('APMBL003','tron','tron@gmail.com');

/*Table structure for table `tampil_transaksi` */

DROP TABLE IF EXISTS `tampil_transaksi`;

CREATE TABLE `tampil_transaksi` (
  `id` char(4) NOT NULL,
  `id_pembeli` char(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `for_id_pembeli.tampil_id.pembeli` (`id_pembeli`),
  CONSTRAINT `for_id_pembeli.tampil_id.pembeli` FOREIGN KEY (`id_pembeli`) REFERENCES `pembeli` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `tampil_transaksi` */

insert  into `tampil_transaksi`(`id`,`id_pembeli`) values ('TR01','APMBL001'),('TR03','APMBL001'),('TR02','APMBL002');

/* Procedure structure for procedure `SP_cariTransaksi` */

/*!50003 DROP PROCEDURE IF EXISTS  `SP_cariTransaksi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_cariTransaksi`()
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
    END */$$
DELIMITER ;

/*Table structure for table `v_pemesanan` */

DROP TABLE IF EXISTS `v_pemesanan`;

/*!50001 DROP VIEW IF EXISTS `v_pemesanan` */;
/*!50001 DROP TABLE IF EXISTS `v_pemesanan` */;

/*!50001 CREATE TABLE  `v_pemesanan`(
 `id` char(4) ,
 `nama` varchar(50) 
)*/;

/*View structure for view v_pemesanan */

/*!50001 DROP TABLE IF EXISTS `v_pemesanan` */;
/*!50001 DROP VIEW IF EXISTS `v_pemesanan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pemesanan` AS select `tampil_transaksi`.`id` AS `id`,`pembeli`.`nama` AS `nama` from (`tampil_transaksi` join `pembeli`) where `pembeli`.`id` = `tampil_transaksi`.`id_pembeli` order by `tampil_transaksi`.`id` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
