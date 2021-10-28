-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2021 at 12:45 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `kd_buku` int(11) NOT NULL,
  `judul_buku` varchar(300) NOT NULL,
  `isbn` int(13) NOT NULL,
  `pengarang` varchar(50) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `halaman` int(11) NOT NULL,
  `tahun_terbit` int(4) NOT NULL,
  `gambar` longblob NOT NULL,
  `sinopsis` varchar(500) NOT NULL,
  `kd_kategori` int(11) NOT NULL,
  `kd_penerbit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_pengadaan`
--

CREATE TABLE `data_pengadaan` (
  `no_pengadaan` int(11) NOT NULL,
  `tanggal_pengaadan` date NOT NULL,
  `kd_buku` int(11) NOT NULL,
  `asal_buku` varchar(50) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `keterangan` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_siswa`
--

CREATE TABLE `data_siswa` (
  `kd_siswa` int(11) NOT NULL,
  `nama_siswa` varchar(50) NOT NULL,
  `nisn` int(10) NOT NULL,
  `kelamin` varchar(10) NOT NULL,
  `agama` varchar(10) NOT NULL,
  `tangal_lahir` date NOT NULL,
  `tempat_lahir` varchar(30) NOT NULL,
  `alamat` varchar(300) NOT NULL,
  `no_telp` int(13) NOT NULL,
  `foto` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_user`
--

CREATE TABLE `data_user` (
  `kd_user` int(11) NOT NULL,
  `password` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `nama_user` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `kd_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `no_pinjam` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `kd_siswa` int(11) NOT NULL,
  `keterangan` varchar(300) NOT NULL,
  `lama_pinjam` varchar(10) NOT NULL,
  `status` varchar(30) NOT NULL,
  `kd_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `penerbit`
--

CREATE TABLE `penerbit` (
  `kd_penerbit` int(11) NOT NULL,
  `nama_penerbit` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pengembalian`
--

CREATE TABLE `pengembalian` (
  `no_kembali` int(11) NOT NULL,
  `tanggal_transaksi` date NOT NULL,
  `denda` int(11) NOT NULL,
  `kd_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tmp_pinjam`
--

CREATE TABLE `tmp_pinjam` (
  `id` int(11) NOT NULL,
  `kd_user` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `kd_buku` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`kd_buku`),
  ADD KEY `idx_kategori` (`kd_kategori`),
  ADD KEY `idx_penerbit` (`kd_penerbit`);

--
-- Indexes for table `data_pengadaan`
--
ALTER TABLE `data_pengadaan`
  ADD PRIMARY KEY (`no_pengadaan`),
  ADD KEY `idx_buku` (`kd_buku`) USING BTREE;

--
-- Indexes for table `data_siswa`
--
ALTER TABLE `data_siswa`
  ADD PRIMARY KEY (`kd_siswa`);

--
-- Indexes for table `data_user`
--
ALTER TABLE `data_user`
  ADD PRIMARY KEY (`kd_user`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`kd_kategori`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`no_pinjam`),
  ADD KEY `idx_siswa` (`kd_siswa`),
  ADD KEY `idx_user` (`kd_user`);

--
-- Indexes for table `penerbit`
--
ALTER TABLE `penerbit`
  ADD PRIMARY KEY (`kd_penerbit`);

--
-- Indexes for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`no_kembali`),
  ADD KEY `idx_user` (`kd_user`);

--
-- Indexes for table `tmp_pinjam`
--
ALTER TABLE `tmp_pinjam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`kd_user`),
  ADD KEY `idx_buku` (`kd_buku`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori` (`kd_kategori`),
  ADD CONSTRAINT `buku_ibfk_2` FOREIGN KEY (`kd_penerbit`) REFERENCES `penerbit` (`kd_penerbit`);

--
-- Constraints for table `data_pengadaan`
--
ALTER TABLE `data_pengadaan`
  ADD CONSTRAINT `data_pengadaan_ibfk_1` FOREIGN KEY (`kd_buku`) REFERENCES `buku` (`kd_buku`);

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`kd_siswa`) REFERENCES `data_siswa` (`kd_siswa`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`kd_user`) REFERENCES `data_user` (`kd_user`);

--
-- Constraints for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`kd_user`) REFERENCES `data_user` (`kd_user`);

--
-- Constraints for table `tmp_pinjam`
--
ALTER TABLE `tmp_pinjam`
  ADD CONSTRAINT `tmp_pinjam_ibfk_1` FOREIGN KEY (`kd_buku`) REFERENCES `buku` (`kd_buku`),
  ADD CONSTRAINT `tmp_pinjam_ibfk_2` FOREIGN KEY (`kd_user`) REFERENCES `data_user` (`kd_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
