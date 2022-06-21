-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 20, 2021 at 09:14 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `keuangan`
--
CREATE DATABASE IF NOT EXISTS `keuangan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `keuangan`;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_akun`
--

CREATE TABLE `jenis_akun` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_akun`
--

INSERT INTO `jenis_akun` (`id`, `nama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ASSET', NULL, NULL, NULL),
(2, 'LIABLITIES', NULL, NULL, NULL),
(3, 'MODAL', NULL, NULL, NULL),
(4, 'PENDAPATAN', NULL, NULL, NULL),
(5, 'BEBAN', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_akun`
--

CREATE TABLE `master_akun` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `jenis_akun_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_akun` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `saldo_normal` enum('DEBIT','KREDIT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `header` tinyint(4) NOT NULL DEFAULT 0,
  `sub_header` int(1) NOT NULL DEFAULT 0,
  `komponen` varchar(244) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cabang_id` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_akun`
--

INSERT INTO `master_akun` (`id`, `jenis_akun_id`, `kode_akun`, `nama`, `saldo_normal`, `header`, `sub_header`, `komponen`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1', '1.0.0', 'ASSET', 'DEBIT', 1, 0, NULL, 0, NULL, NULL, NULL),
(3, '1', '1.1.1', 'KAS', 'DEBIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(4, '1', '1.1.2', 'KAS KECIL', 'DEBIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(5, '1', '1.1.4', 'PIUTANG DAGANG', 'DEBIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(6, '1', '1.1.5', 'PERSEDIAAN DAGANG', 'DEBIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(7, '1', '1.1.6', 'PERLENGKAPAN KANTOR', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(8, '1', '1.1.7', 'SEWA DIBAYAR DIMUKA', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(9, '1', '1.1.8', 'PPN MASUKAN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(11, '1', '1.2.1', 'PERALATAN KANTOR', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(12, '1', '1.2.2', 'AKUMULASI PENYUSUTAN PERALATAN KANTOR', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(13, '1', '1.2.3', 'GEDUNG', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(14, '1', '1.2.4', 'AKUMULASI PENYUSUTAN GEDUNG', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(15, '1', '1.2.5', 'TANAH', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(16, '1', '1.2.6', 'AKUMULASI PENYUSUTAN TANAH', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(17, '1', '1.2.7', 'KENDARAAN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(18, '1', '1.2.8', 'AKUMULASI PENYUSUTAN KENDARAAN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(19, '2', '2.0.0', 'LIABILITIES', 'KREDIT', 1, 0, NULL, 0, NULL, NULL, NULL),
(21, '2', '2.1.1', 'UTANG DAGANG', 'KREDIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(23, '2', '2.2.1', 'UTANG BANK', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(24, '2', '2.2.2', 'UTANG LEASING', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(25, '2', '2.2.3', 'UTANG PIHAK LAINNYA', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(26, '2', '2.3.1', 'PPN KELUARAN', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(27, '3', '3.0.0', 'EKUITAS', 'KREDIT', 1, 0, NULL, 0, NULL, NULL, NULL),
(28, '3', '3.1.0', 'MODAL DI SETOR', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(29, '3', '3.2.0', 'PRIVE', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(30, '3', '3.3.0', 'SALDO LABA', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(31, '4', '4.0.0', 'PENDAPATAN', 'KREDIT', 1, 0, NULL, 0, NULL, NULL, NULL),
(32, '4', '4.1.1', 'PENJUALAN', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(33, '4', '4.1.2', 'PENDAPATAN LAINNYA', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(34, '4', '4.1.3', 'RETUR PENJUALAN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(35, '4', '4.1.4', 'DISKON PENJUALAN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(36, '5', '5.0.0', 'BEBAN', 'DEBIT', 1, 0, NULL, 0, NULL, NULL, NULL),
(39, '4', '4.2.2', 'DISKON PEMBELIAN', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(40, '5', '5.3.1', 'BEBAN GAJI', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(41, '5', '5.4.1', 'BEBAN SEWA', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(42, '5', '5.5.1', 'BEBAN OPERASIONAL', 'DEBIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(43, '5', '5.6.1', 'BEBAN LAIN - LAIN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(44, '4', '4.2.1', 'HARGA POKOK PENJUALAN', 'DEBIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(45, '1', '1.1.3', 'KAS BANK', 'DEBIT', 0, 1, NULL, 0, NULL, NULL, NULL),
(46, '1', '1.1.2-2', 'KAS KECIL KASIR ASRI', 'DEBIT', 0, 0, '1.1.2', 1, NULL, NULL, NULL),
(47, '5', '5.5.1-1', 'BEBAN OPERASIONAL - LISTRIK', 'DEBIT', 0, 0, '5.5.1', 0, '2021-05-23 06:30:49', NULL, NULL),
(48, '5', '5.5.1-2', 'BEBAN OPERASIONAL - AIR', 'DEBIT', 0, 0, '5.5.1', 0, '2021-05-23 06:30:49', NULL, NULL),
(49, '5', '5.5.1-3', 'BEBAN OPERASIONAL - BENSIN MOBIL', 'DEBIT', 0, 0, '5.5.1', 0, '2021-05-23 06:30:49', NULL, NULL),
(51, '1', '1.1.3-1', 'BANK BCA - 123123123', 'DEBIT', 1, 0, '1.1.3', 0, NULL, NULL, NULL),
(52, '1', '1.1.5-1', 'GUDANG - BBM LIMBANGAN', 'DEBIT', 0, 0, '1.1.5', 1, '2021-07-17 23:36:00', NULL, NULL),
(55, '1', '1.1.2-1', 'KAS KECIL INDUK BBM LIMBANGAN', 'DEBIT', 0, 0, '1.1.2', 1, NULL, NULL, NULL),
(56, '1', '1.1.2-3', 'KAS KECIL KASIR ASRI', 'DEBIT', 0, 0, '1.1.2', 2, NULL, NULL, NULL),
(59, '2', '2.1.1-1', 'UTANG DAGANG - CABANG BBM LIMBANGAN', 'KREDIT', 0, 0, '2.1.1', 0, NULL, NULL, NULL),
(62, '1', '1.1.4-1', 'PIUTANG DAGANG - CABANG BBM LIMBANGAN', 'DEBIT', 0, 0, '1.1.4', 0, NULL, NULL, NULL),
(64, '5', '5.5.1-4', 'BEBAN OPERASIONAL - UANG JALAN MOBIL', 'DEBIT', 0, 0, '5.5.1', 0, '2021-05-23 06:30:49', NULL, NULL),
(65, '3', '3.4.0', 'SETORAN CABANG', 'KREDIT', 0, 0, NULL, 0, NULL, NULL, NULL),
(66, '1', '1.1.3-2', 'BANK BCA - 123123123123 - SETORAN HARIAN', 'DEBIT', 1, 0, '1.1.3', 0, NULL, NULL, NULL),
(72, '1', '1.1.2-4', 'KAS KECIL - BBM KADUNGORA', 'DEBIT', 0, 0, '1.1.2', 15, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL),
(73, '1', '1.1.4-2', 'PIUTANG DAGANG - CABANG BBM KADUNGORA', 'DEBIT', 0, 0, '1.1.4', 0, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL),
(74, '2', '2.1.1-2', 'UTANG DAGANG - CABANG BBM KADUNGORA', 'KREDIT', 0, 0, '2.1.1', 0, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL),
(75, '1', '1.1.5-2', 'GUDANG - BBM KADUNGORA', 'DEBIT', 0, 0, '1.1.5', 15, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL),
(76, '1', '1.1.2-5', 'KAS KECIL - NURLELA', 'DEBIT', 0, 0, '1.1.2', 15, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL),
(77, '1', '1.1.4-3', 'PIUTANG DAGANG - CABANG BBM MEGA BAJA', 'DEBIT', 0, 0, '1.1.4', 0, '2021-10-05 12:00:14', '2021-10-05 12:00:14', NULL),
(78, '2', '2.1.1-3', 'UTANG DAGANG - CABANG BBM MEGA BAJA', 'KREDIT', 0, 0, '2.1.1', 0, '2021-10-05 12:00:15', '2021-10-05 12:00:15', NULL),
(79, '1', '1.1.4-4', 'PIUTANG DAGANG - LUCKY', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-05 13:32:04', '2021-10-05 13:32:04', NULL),
(80, '2', '2.1.1-4', 'UTANG DAGANG - LUCKY', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-05 13:32:04', '2021-10-05 13:32:04', NULL),
(81, '1', '1.1.4-5', 'PIUTANG DAGANG - EMIR', 'DEBIT', 0, 0, '1.1.4', 1, '2021-10-05 14:21:08', '2021-10-05 14:21:08', NULL),
(82, '2', '2.1.1-5', 'UTANG DAGANG - EMIR', 'KREDIT', 0, 0, '2.1.1', 1, '2021-10-05 14:21:08', '2021-10-05 14:21:08', NULL),
(83, '1', '1.1.4-6', 'PIUTANG DAGANG - DANI', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:07:47', '2021-10-12 14:07:47', NULL),
(84, '2', '2.1.1-6', 'UTANG DAGANG - DANI', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:07:47', '2021-10-12 14:07:47', NULL),
(85, '1', '1.1.4-7', 'PIUTANG DAGANG - EMIR', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:10:50', '2021-10-12 14:10:50', NULL),
(86, '2', '2.1.1-7', 'UTANG DAGANG - EMIR', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:10:50', '2021-10-12 14:10:50', NULL),
(87, '1', '1.1.4-8', 'PIUTANG DAGANG - HADIYAN', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:14:01', '2021-10-12 14:14:01', NULL),
(88, '2', '2.1.1-8', 'UTANG DAGANG - HADIYAN', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:14:01', '2021-10-12 14:14:01', NULL),
(89, '1', '1.1.4-9', 'PIUTANG DAGANG - DESI', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:15:32', '2021-10-12 14:15:32', NULL),
(90, '2', '2.1.1-9', 'UTANG DAGANG - DESI', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:15:32', '2021-10-12 14:15:32', NULL),
(91, '1', '1.1.4-10', 'PIUTANG DAGANG - BOBI', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:16:20', '2021-10-12 14:16:20', NULL),
(92, '2', '2.1.1-10', 'UTANG DAGANG - BOBI', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:16:20', '2021-10-12 14:16:20', NULL),
(93, '1', '1.1.4-11', 'PIUTANG DAGANG - UCU', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:17:55', '2021-10-12 14:17:55', NULL),
(94, '2', '2.1.1-11', 'UTANG DAGANG - UCU', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:17:55', '2021-10-12 14:17:55', NULL),
(95, '1', '1.1.4-12', 'PIUTANG DAGANG - NANI', 'DEBIT', 0, 0, '1.1.4', 15, '2021-10-12 14:18:03', '2021-10-12 14:18:03', NULL),
(96, '2', '2.1.1-12', 'UTANG DAGANG - NANI', 'KREDIT', 0, 0, '2.1.1', 15, '2021-10-12 14:18:03', '2021-10-12 14:18:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_beban`
--

CREATE TABLE `master_beban` (
  `id` int(11) NOT NULL,
  `master_akun_id` int(11) NOT NULL,
  `nominal` double NOT NULL,
  `catatan` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `nomor_jurnal` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_beban`
--

INSERT INTO `master_beban` (`id`, `master_akun_id`, `nominal`, `catatan`, `user_id`, `cabang_id`, `nomor_jurnal`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 64, 5000, 'BEBAN OPERASIONAL - UANG JALAN MOBIL - Uang Jalan ke Kadungora', 3, 15, '21100714', '2021-10-07 02:22:10', '2021-10-07 14:24:09', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_jurnal`
--

CREATE TABLE `master_jurnal` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reff` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_jurnal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `master_akun_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` double NOT NULL,
  `jenis` enum('DEBIT','KREDIT') COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_jurnal`
--

INSERT INTO `master_jurnal` (`id`, `reff`, `nomor_jurnal`, `master_akun_id`, `nominal`, `jenis`, `keterangan`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '2110051', '2110051', '55', 10000000, 'DEBIT', 'Setor Modal Awal', 2, 1, '2021-10-04 17:00:00', '2021-10-05 12:09:34', NULL),
(2, '2110051', '2110051', '28', 10000000, 'KREDIT', 'Setor Modal Awal', 2, 1, '2021-10-04 17:00:00', '2021-10-05 12:09:34', NULL),
(3, '2110052', '2110052', '55', 4000000, 'KREDIT', 'KAS KELUAR PEMBELIAN NOMOR TRANSAKSI #1', 2, 1, '2021-10-04 17:00:00', '2021-10-05 12:11:37', NULL),
(4, '2110052', '2110052', '52', 4000000, 'DEBIT', 'PEMBELIAN NOMOR TRANSAKSI #1', 2, 1, '2021-10-04 17:00:00', '2021-10-05 12:11:37', NULL),
(9, '2110053', '2110053', '73', 750000, 'DEBIT', 'PIUTANG PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-1', 2, 1, '2021-10-04 17:00:00', '2021-10-05 13:26:30', NULL),
(10, '2110053', '2110053', '32', 750000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-1', 2, 1, '2021-10-04 17:00:00', '2021-10-05 13:26:30', NULL),
(11, '2110053', '2110053', '44', 500000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-1', 2, 1, '2021-10-04 17:00:00', '2021-10-05 13:26:31', NULL),
(12, '2110053', '2110053', '52', 500000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-1', 2, 1, '2021-10-04 17:00:00', '2021-10-05 13:26:31', NULL),
(13, '2110054', '2110054', '59', 750000, 'KREDIT', 'UTANG PO#051021-1', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:30:32', NULL),
(14, '2110054', '2110054', '75', 750000, 'DEBIT', 'UTANG PO#051021-1', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:30:32', NULL),
(15, '2110055', '2110055', '76', 200000, 'DEBIT', 'KAS MASUK PENJUALAN NOMOR TRANSAKSI #BBM-15-051021-2', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:32:55', NULL),
(16, '2110055', '2110055', '32', 200000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-051021-2', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:32:55', NULL),
(17, '2110055', '2110055', '44', 150000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-051021-2', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:32:56', NULL),
(18, '2110055', '2110055', '75', 150000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-051021-2', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:32:56', NULL),
(19, '2110056', '2110056', '76', 200000, 'KREDIT', 'SETOR KAS - ASRI NOVIYANTI#Setor Sore Hari', 3, 15, '2021-10-05 13:35:10', '2021-10-05 13:35:10', NULL),
(20, '2110056', '2110056', '72', 200000, 'DEBIT', 'SETOR KAS - ASRI NOVIYANTI#Setor Sore Hari', 3, 15, '2021-10-05 13:35:10', '2021-10-05 13:35:10', NULL),
(21, '2110057', '2110057', '72', 200000, 'KREDIT', 'SETORAN SECARA TRANSFER #LAPORAN SETORAN HARI INI MELALUI TRANSFER', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:46:02', NULL),
(22, '2110057', '2110057', '65', 200000, 'DEBIT', 'SETORAN SECARA TRANSFER #LAPORAN SETORAN HARI INI MELALUI TRANSFER', 3, 15, '2021-10-04 17:00:00', '2021-10-05 13:46:02', NULL),
(23, '2110058', '2110058', '65', 200000, 'KREDIT', 'SETORAN SECARA TRANSFER #LAPORAN SETORAN HARI INI MELALUI TRANSFER', 3, 1, '2021-10-04 17:00:00', '2021-10-05 13:46:02', NULL),
(24, '2110058', '2110058', '51', 200000, 'DEBIT', 'SETORAN SECARA TRANSFER #LAPORAN SETORAN HARI INI MELALUI TRANSFER', 3, 1, '2021-10-04 17:00:00', '2021-10-05 13:46:02', NULL),
(25, '2110059', '2110059', '81', 400000, 'DEBIT', 'PIUTANG PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-3', 2, 1, '2021-10-04 17:00:00', '2021-10-05 14:22:25', NULL),
(26, '2110059', '2110059', '32', 400000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-3', 2, 1, '2021-10-04 17:00:00', '2021-10-05 14:22:25', NULL),
(27, '2110059', '2110059', '44', 100000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-3', 2, 1, '2021-10-04 17:00:00', '2021-10-05 14:22:25', NULL),
(28, '2110059', '2110059', '52', 100000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-051021-3', 2, 1, '2021-10-04 17:00:00', '2021-10-05 14:22:25', NULL),
(29, '21100610', '21100610', '73', 400000, 'DEBIT', 'PIUTANG PENJUALAN NOMOR TRANSAKSI #BBM-1-061021-1', 2, 1, '2021-10-05 17:00:00', '2021-10-06 12:55:43', NULL),
(30, '21100610', '21100610', '32', 400000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-061021-1', 2, 1, '2021-10-05 17:00:00', '2021-10-06 12:55:43', NULL),
(31, '21100610', '21100610', '44', 250000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-061021-1', 2, 1, '2021-10-05 17:00:00', '2021-10-06 12:55:43', NULL),
(32, '21100610', '21100610', '52', 250000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-061021-1', 2, 1, '2021-10-05 17:00:00', '2021-10-06 12:55:43', NULL),
(33, '21100611', '21100611', '59', 400000, 'KREDIT', 'UTANG PO#061021-2', 3, 15, '2021-10-05 17:00:00', '2021-10-06 12:57:56', NULL),
(34, '21100611', '21100611', '75', 400000, 'DEBIT', 'UTANG PO#061021-2', 3, 15, '2021-10-05 17:00:00', '2021-10-06 12:57:56', NULL),
(35, '21100612', '21100612', '55', 1000000, 'KREDIT', 'Narik Modal untuk kebutuhan sehari hari', 2, 1, '2021-10-05 17:00:00', '2021-10-06 14:41:44', NULL),
(36, '21100612', '21100612', '29', 1000000, 'DEBIT', 'Narik Modal untuk kebutuhan sehari hari', 2, 1, '2021-10-05 17:00:00', '2021-10-06 14:41:44', NULL),
(37, '21100713', '21100713', '76', 1300000, 'DEBIT', 'KAS MASUK PENJUALAN NOMOR TRANSAKSI #BBM-15-071021-1', 3, 15, '2021-10-06 17:00:00', '2021-10-07 12:00:18', NULL),
(38, '21100713', '21100713', '32', 1300000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-071021-1', 3, 15, '2021-10-06 17:00:00', '2021-10-07 12:00:18', NULL),
(39, '21100713', '21100713', '44', 1000000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-071021-1', 3, 15, '2021-10-06 17:00:00', '2021-10-07 12:00:18', NULL),
(40, '21100713', '21100713', '75', 1000000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-071021-1', 3, 15, '2021-10-06 17:00:00', '2021-10-07 12:00:18', NULL),
(41, '21100714', '21100714', '64', 5000, 'DEBIT', 'BEBAN OPERASIONAL - UANG JALAN MOBIL - Uang Jalan ke Kadungora', 3, 15, '2021-10-07 14:24:09', '2021-10-07 14:24:09', NULL),
(42, '21100714', '21100714', '76', 5000, 'KREDIT', 'BEBAN OPERASIONAL - UANG JALAN MOBIL - Uang Jalan ke Kadungora', 3, 15, '2021-10-07 14:24:09', '2021-10-07 14:24:09', NULL),
(43, '21100715', '21100715', '40', 80000, 'DEBIT', 'PEMBAYARAN GAJI - Gaji Harian', 3, 15, '2021-10-06 17:00:00', '2021-10-07 14:42:38', NULL),
(44, '21100715', '21100715', '76', 80000, 'KREDIT', 'PEMBAYARAN GAJI - Gaji Harian', 3, 15, '2021-10-06 17:00:00', '2021-10-07 14:42:38', NULL),
(45, '21100716', '21100716', '76', 1215000, 'KREDIT', 'SETOR KAS - NURLELA#setor', 3, 15, '2021-10-07 15:13:06', '2021-10-07 15:13:06', NULL),
(46, '21100716', '21100716', '72', 1215000, 'DEBIT', 'SETOR KAS - NURLELA#setor', 3, 15, '2021-10-07 15:13:06', '2021-10-07 15:13:06', NULL),
(47, '21100717', '21100717', '72', 121500, 'KREDIT', 'SETORAN SECARA TUNAI #Setoran', 3, 15, '2021-10-06 17:00:00', '2021-10-07 15:13:37', NULL),
(48, '21100717', '21100717', '65', 121500, 'DEBIT', 'SETORAN SECARA TUNAI #Setoran', 3, 15, '2021-10-06 17:00:00', '2021-10-07 15:13:37', NULL),
(49, '21100718', '21100718', '65', 121500, 'KREDIT', 'SETORAN SECARA TUNAI #Setoran', 3, 1, '2021-10-06 17:00:00', '2021-10-07 15:13:38', NULL),
(50, '21100718', '21100718', '55', 121500, 'DEBIT', 'SETORAN SECARA TUNAI #Setoran', 3, 1, '2021-10-06 17:00:00', '2021-10-07 15:13:38', NULL),
(51, '21100719', '21100719', '72', 1093500, 'KREDIT', 'SETORAN SECARA TRANSFER #Transfer Setor nya sore', 3, 15, '2021-10-06 17:00:00', '2021-10-07 15:14:28', NULL),
(52, '21100719', '21100719', '65', 1093500, 'DEBIT', 'SETORAN SECARA TRANSFER #Transfer Setor nya sore', 3, 15, '2021-10-06 17:00:00', '2021-10-07 15:14:28', NULL),
(53, '21100720', '21100720', '65', 1093500, 'KREDIT', 'SETORAN SECARA TRANSFER #Transfer Setor nya sore', 3, 1, '2021-10-06 17:00:00', '2021-10-07 15:14:28', NULL),
(54, '21100720', '21100720', '51', 1093500, 'DEBIT', 'SETORAN SECARA TRANSFER #Transfer Setor nya sore', 3, 1, '2021-10-06 17:00:00', '2021-10-07 15:14:28', NULL),
(55, '21101121', '21101121', '73', 3000000, 'DEBIT', 'PIUTANG PENJUALAN NOMOR TRANSAKSI #BBM-1-111021-1', 2, 1, '2021-10-10 17:00:00', '2021-10-11 04:48:37', NULL),
(56, '21101121', '21101121', '32', 3000000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-111021-1', 2, 1, '2021-10-10 17:00:00', '2021-10-11 04:48:37', NULL),
(57, '21101121', '21101121', '44', 1500000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-111021-1', 2, 1, '2021-10-10 17:00:00', '2021-10-11 04:48:37', NULL),
(58, '21101121', '21101121', '52', 1500000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-111021-1', 2, 1, '2021-10-10 17:00:00', '2021-10-11 04:48:37', NULL),
(59, '21101122', '21101122', '59', 3000000, 'KREDIT', 'UTANG PO#111021-3', 3, 15, '2021-10-10 17:00:00', '2021-10-11 04:52:44', NULL),
(60, '21101122', '21101122', '75', 3000000, 'DEBIT', 'UTANG PO#111021-3', 3, 15, '2021-10-10 17:00:00', '2021-10-11 04:52:44', NULL),
(61, '21101223', '21101223', '76', 7500000, 'DEBIT', 'KAS MASUK PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-11 17:00:00', '2021-10-12 12:53:55', NULL),
(62, '21101223', '21101223', '32', 7500000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-11 17:00:00', '2021-10-12 12:53:55', NULL),
(63, '21101223', '21101223', '44', 500000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-11 17:00:00', '2021-10-12 12:53:56', NULL),
(64, '21101223', '21101223', '75', 500000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-11 17:00:00', '2021-10-12 12:53:56', NULL),
(65, '21101223', '21101223', '76', 7500000, 'KREDIT', 'RETUR-KAS MASUK PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-12 13:03:05', '2021-10-12 13:03:05', NULL),
(66, '21101223', '21101223', '34', 7500000, 'DEBIT', 'RETUR-PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-12 13:03:05', '2021-10-12 13:03:05', NULL),
(67, '21101223', '21101223', '44', 500000, 'KREDIT', 'RETUR-PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-12 13:03:05', '2021-10-12 13:03:05', NULL),
(68, '21101223', '21101223', '75', 500000, 'DEBIT', 'RETUR-PENJUALAN NOMOR TRANSAKSI #BBM-15-121021-1', 3, 15, '2021-10-12 13:03:05', '2021-10-12 13:03:05', NULL),
(69, '21101524', '21101524', '56', 1500000, 'DEBIT', 'KAS MASUK PENJUALAN NOMOR TRANSAKSI #BBM-1-151021-1', 2, 1, '2021-10-14 17:00:00', '2021-10-15 02:33:41', NULL),
(70, '21101524', '21101524', '32', 1500000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-151021-1', 2, 1, '2021-10-14 17:00:00', '2021-10-15 02:33:41', NULL),
(71, '21101524', '21101524', '44', 500000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-151021-1', 2, 1, '2021-10-14 17:00:00', '2021-10-15 02:33:41', NULL),
(72, '21101524', '21101524', '52', 500000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-1-151021-1', 2, 1, '2021-10-14 17:00:00', '2021-10-15 02:33:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_04_21_052151_create_master_akun', 1),
(5, '2021_04_21_052308_create_jenis_akun', 1),
(6, '2021_04_21_054830_create_master_jurnal', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `performance`
--

CREATE TABLE `performance` (
  `id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `penjualan` double DEFAULT 0,
  `retur_penjualan` double NOT NULL DEFAULT 0,
  `diskon_penjualan` double NOT NULL DEFAULT 0,
  `hpp` double DEFAULT 0,
  `pendapatan_lainnya` double NOT NULL DEFAULT 0,
  `beban_operasional` double NOT NULL DEFAULT 0,
  `beban_gaji` double DEFAULT 0,
  `beban_sewa` double DEFAULT 0,
  `beban_lainnya` double NOT NULL DEFAULT 0,
  `laba` double DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jenis_akun`
--
ALTER TABLE `jenis_akun`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_akun`
--
ALTER TABLE `master_akun`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_akun` (`kode_akun`);

--
-- Indexes for table `master_beban`
--
ALTER TABLE `master_beban`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_jurnal`
--
ALTER TABLE `master_jurnal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `akun` (`master_akun_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `performance`
--
ALTER TABLE `performance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_akun`
--
ALTER TABLE `jenis_akun`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `master_akun`
--
ALTER TABLE `master_akun`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `master_beban`
--
ALTER TABLE `master_beban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `master_jurnal`
--
ALTER TABLE `master_jurnal`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `performance`
--
ALTER TABLE `performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `persediaan`
--
CREATE DATABASE IF NOT EXISTS `persediaan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `persediaan`;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_barang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merek_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `satuan_id` int(3) NOT NULL DEFAULT 0,
  `harga_beli` double NOT NULL,
  `harga_ritel` double NOT NULL DEFAULT 0,
  `harga_konsumen` double NOT NULL DEFAULT 0,
  `harga_lainnya` double NOT NULL DEFAULT 0,
  `rak` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis` enum('FIFO','AVERAGE','','') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'FIFO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id`, `kode_barang`, `nama`, `jenis_id`, `merek_id`, `satuan_id`, `harga_beli`, `harga_ritel`, `harga_konsumen`, `harga_lainnya`, `rak`, `jenis`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'S00001', 'Spandek 6 Meter', '2', '1', 5, 2000, 10000, 20000, 0, '', 'FIFO', '2021-03-01 21:28:34', '2021-09-29 13:20:22', NULL),
(33, 'BBM0001', 'BONDECK CUSTOM', '2', '1', 6, 2000, 23000, 26000, 0, '', 'FIFO', '2021-03-01 21:28:34', '2021-03-11 21:09:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_gaji`
--

CREATE TABLE `detail_gaji` (
  `id` int(11) NOT NULL,
  `master_gaji_id` varchar(255) NOT NULL,
  `pegawai_id` varchar(255) NOT NULL,
  `gaji_pokok` double NOT NULL DEFAULT 0,
  `uang_makan` double NOT NULL DEFAULT 0,
  `bonus` double NOT NULL DEFAULT 0,
  `tambahan_lainnya` double NOT NULL DEFAULT 0,
  `catatan` varchar(512) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_gaji`
--

INSERT INTO `detail_gaji` (`id`, `master_gaji_id`, `pegawai_id`, `gaji_pokok`, `uang_makan`, `bonus`, `tambahan_lainnya`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1', '1', 50000, 10000, 20000, 0, 'Gaji Harian', '2021-10-06 17:00:00', '2021-10-07 14:42:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_opname`
--

CREATE TABLE `detail_opname` (
  `id` int(11) NOT NULL,
  `master_opname_id` int(11) NOT NULL,
  `master_barang_id` int(11) NOT NULL,
  `jumlah_tercatat` double NOT NULL DEFAULT 0,
  `jumlah_fisik` double NOT NULL DEFAULT 0,
  `perbedaan` double NOT NULL DEFAULT 0,
  `harga` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembayaran`
--

CREATE TABLE `detail_pembayaran` (
  `id` int(11) NOT NULL,
  `penjualan_id` int(11) DEFAULT NULL,
  `pembelian_id` int(11) DEFAULT NULL,
  `nominal` double NOT NULL DEFAULT 0,
  `catatan` varchar(512) DEFAULT NULL,
  `cara_pembayaran` enum('TUNAI','TRANSFER') NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nomor_jurnal` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_pembayaran`
--

INSERT INTO `detail_pembayaran` (`id`, `penjualan_id`, `pembelian_id`, `nominal`, `catatan`, `cara_pembayaran`, `cabang_id`, `user_id`, `nomor_jurnal`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, 4000000, 'LUNAS', 'TUNAI', 1, 2, '2110052', '2021-10-05 12:11:37', '2021-10-05 12:11:37', NULL),
(3, 2, NULL, 0, 'PEMBAYARAN DOWN PAYMENT', 'TUNAI', 1, 2, '2110053', '2021-10-05 13:26:30', '2021-10-05 13:26:30', NULL),
(4, 3, NULL, 200000, 'LUNAS', 'TUNAI', 15, 3, '2110055', '2021-10-05 13:32:55', '2021-10-05 13:32:55', NULL),
(5, 4, NULL, 0, 'PEMBAYARAN DOWN PAYMENT', 'TUNAI', 1, 2, '2110059', '2021-10-05 14:22:25', '2021-10-05 14:22:25', NULL),
(6, 5, NULL, 0, 'PEMBAYARAN DOWN PAYMENT', 'TUNAI', 1, 2, '21100610', '2021-10-06 12:55:43', '2021-10-06 12:55:43', NULL),
(7, NULL, 2, 150000, 'Tunai  Tanggal 06-10-2021', 'TUNAI', 15, 3, '', '2021-10-06 15:09:04', '2021-10-06 15:09:04', NULL),
(8, 6, NULL, 1300000, 'LUNAS', 'TUNAI', 15, 3, '21100713', '2021-10-07 12:00:18', '2021-10-07 12:00:18', NULL),
(9, 7, NULL, 0, 'PEMBAYARAN DOWN PAYMENT', 'TUNAI', 1, 2, '21101121', '2021-10-11 04:48:37', '2021-10-11 04:48:37', NULL),
(10, 8, NULL, 7500000, 'LUNAS', 'TUNAI', 15, 3, '21101223', '2021-10-12 12:53:56', '2021-10-12 12:53:56', NULL),
(11, 9, NULL, 1500000, 'LUNAS', 'TUNAI', 1, 2, '21101524', '2021-10-15 02:33:41', '2021-10-15 02:33:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `id` int(11) NOT NULL,
  `master_pembelian_id` int(11) NOT NULL,
  `barang_id` varchar(255) NOT NULL,
  `jumlah` double NOT NULL DEFAULT 0,
  `harga` double NOT NULL DEFAULT 0,
  `diskon` double NOT NULL DEFAULT 0,
  `total` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_pembelian`
--

INSERT INTO `detail_pembelian` (`id`, `master_pembelian_id`, `barang_id`, `jumlah`, `harga`, `diskon`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '1', 300, 5000, 0, 1500000, '2021-10-05 12:11:37', '2021-10-05 12:11:37', NULL),
(2, 1, '33', 500, 5000, 0, 2500000, '2021-10-05 12:11:38', '2021-10-05 12:11:38', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id` int(11) NOT NULL,
  `master_penjualan_id` int(11) NOT NULL,
  `barang_id` varchar(255) NOT NULL,
  `jumlah` double NOT NULL DEFAULT 0,
  `harga` double NOT NULL DEFAULT 0,
  `harga_beli` double NOT NULL DEFAULT 0,
  `diskon` double NOT NULL DEFAULT 0,
  `total` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id`, `master_penjualan_id`, `barang_id`, `jumlah`, `harga`, `harga_beli`, `diskon`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 2, '1', 100, 7500, 0, 0, 750000, '2021-10-05 13:26:30', '2021-10-05 13:26:30', NULL),
(4, 3, '1', 20, 10000, 0, 0, 200000, '2021-10-05 13:32:55', '2021-10-05 13:32:55', NULL),
(5, 4, '1', 20, 20000, 0, 0, 400000, '2021-10-05 14:22:25', '2021-10-05 14:22:25', NULL),
(6, 5, '1', 50, 8000, 0, 0, 400000, '2021-10-06 12:55:43', '2021-10-06 12:55:43', NULL),
(7, 6, '1', 130, 10000, 0, 0, 1300000, '2021-10-07 12:00:18', '2021-10-07 12:00:18', NULL),
(8, 7, '33', 300, 10000, 0, 0, 3000000, '2021-10-11 04:48:37', '2021-10-11 04:48:37', NULL),
(9, 8, '33', 50, 150000, 0, 0, 7500000, '2021-10-12 12:53:56', '2021-10-12 12:53:56', NULL),
(10, 9, '1', 100, 15000, 2000, 0, 1500000, '2021-10-15 02:33:41', '2021-10-15 02:33:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_piutang`
--

CREATE TABLE `detail_piutang` (
  `id` int(11) NOT NULL,
  `penjualan_id` varchar(255) NOT NULL,
  `nominal` double NOT NULL DEFAULT 0,
  `cara_pembayaran` enum('TUNAI','TRANSFER','','') NOT NULL,
  `catatan` text DEFAULT NULL,
  `nomor_jurnal` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `detail_po`
--

CREATE TABLE `detail_po` (
  `id` int(11) NOT NULL,
  `master_po_id` int(11) NOT NULL,
  `barang_id` varchar(255) NOT NULL,
  `jumlah` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_po`
--

INSERT INTO `detail_po` (`id`, `master_po_id`, `barang_id`, `jumlah`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '1', 100, '2021-10-05 12:13:18', '2021-10-05 12:13:18', NULL),
(2, 1, '33', 200, '2021-10-05 12:13:18', '2021-10-05 12:13:18', NULL),
(3, 2, '1', 100, '2021-10-05 13:25:05', '2021-10-05 13:25:05', NULL),
(4, 3, '1', 50, '2021-10-06 12:43:57', '2021-10-06 12:43:57', NULL),
(5, 4, '33', 300, '2021-10-11 04:32:05', '2021-10-11 04:32:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_transfer_persediaan`
--

CREATE TABLE `detail_transfer_persediaan` (
  `id` int(11) NOT NULL,
  `master_transfer_persediaan_id` varchar(255) NOT NULL,
  `master_barang_id` varchar(255) NOT NULL,
  `jumlah` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gudang`
--

CREATE TABLE `gudang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `utama` tinyint(1) NOT NULL DEFAULT 0,
  `kode_akun_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kode_akun` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gudang`
--

INSERT INTO `gudang` (`id`, `nama`, `alamat`, `utama`, `kode_akun_id`, `kode_akun`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'GUDANG - BBM LIMBANGAN', 'Limbangan', 1, '52', '1.1.5-1', 1, NULL, NULL, NULL),
(5, 'GUDANG - BBM KADUNGORA', 'Kadungora Garut Jawa Barat', 1, '75', '1.1.5-2', 15, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `harga_beli`
--

CREATE TABLE `harga_beli` (
  `id` int(11) NOT NULL,
  `master_barang_id` int(11) NOT NULL,
  `saldo_awal` double NOT NULL DEFAULT 0,
  `saldo` double DEFAULT NULL,
  `harga_beli` double DEFAULT NULL,
  `jenis` varchar(255) DEFAULT NULL,
  `gudang_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `harga_beli`
--

INSERT INTO `harga_beli` (`id`, `master_barang_id`, `saldo_awal`, `saldo`, `harga_beli`, `jenis`, `gudang_id`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 0, 30, 5000, 'PEMBELIAN_1', 1, 2, 1, '2021-10-05 12:11:38', '2021-10-15 02:33:41', NULL),
(2, 33, 0, 200, 5000, 'PEMBELIAN_1', 1, 2, 1, '2021-10-05 12:11:38', '2021-10-11 04:48:37', NULL),
(3, 1, 0, 0, 7500, 'PURCHASE_ORDER_PO#051021-1', 5, 3, 15, '2021-10-05 13:30:32', '2021-10-07 12:00:18', NULL),
(4, 1, 0, 0, 8000, 'PURCHASE_ORDER_PO#061021-2', 5, 3, 15, '2021-10-06 12:57:56', '2021-10-07 12:00:18', NULL),
(5, 33, 0, 250, 10000, 'PURCHASE_ORDER_PO#111021-3', 5, 3, 15, '2021-10-11 04:52:44', '2021-10-12 12:53:56', NULL),
(6, 33, 50, 50, 10000, 'RETUR_8', 5, 3, 15, '2021-10-12 01:03:02', '2021-10-12 12:53:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `harga_jual`
--

CREATE TABLE `harga_jual` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_barang` int(11) NOT NULL,
  `nama_harga` enum('RETAIL','KONSUMEN','LAINNYA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` double NOT NULL DEFAULT 0,
  `catatan` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `harga_jual`
--

INSERT INTO `harga_jual` (`id`, `id_barang`, `nama_harga`, `harga`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(25, 1, 'RETAIL', 15000, 'HARGA RETAIL', '2021-09-28 14:17:10', '2021-09-28 14:17:10', NULL),
(26, 1, 'KONSUMEN', 18000, 'HARGA KONSUMEN', '2021-09-28 14:17:10', '2021-09-28 14:17:10', NULL),
(27, 1, 'LAINNYA', 0, 'HARGA LAINNYA', '2021-09-28 14:17:10', '2021-09-28 14:17:10', NULL),
(28, 33, 'RETAIL', 25000, 'HARGA RETAIL', '2021-09-28 14:17:10', '2021-09-28 14:17:10', NULL),
(29, 33, 'KONSUMEN', 28000, 'HARGA KONSUMEN', '2021-09-28 14:17:10', '2021-09-28 14:17:10', NULL),
(30, 33, 'LAINNYA', 0, 'HARGA LAINNYA', '2021-09-28 14:17:10', '2021-09-28 14:17:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `harga_jual2`
--

CREATE TABLE `harga_jual2` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_barang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `satuan_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `harga_jual2`
--

INSERT INTO `harga_jual2` (`id`, `kode_barang`, `satuan_id`, `harga`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'S00013', '3', '2000', 'sadad', '2021-03-11 15:27:39', '2021-03-11 15:27:39', NULL),
(2, 'S00013', '1', '1000', NULL, '2021-03-11 15:27:39', '2021-03-11 15:27:39', NULL),
(3, 'a00006', '1', '100000', NULL, '2021-03-11 16:51:11', '2021-03-11 16:51:11', NULL),
(5, 'B00007', '2', '10000', 'fhdh', '2021-03-11 17:01:41', '2021-03-11 17:01:41', NULL),
(6, 'B00007', '1', '10000', 'dfgdgf', '2021-03-11 17:05:19', '2021-03-11 17:05:19', NULL),
(7, 'B00007', '2', '5000', 'sdfsf', '2021-03-11 17:06:09', '2021-03-11 17:06:09', NULL),
(8, 'B00007', '3', '10000', 'asdasd', '2021-03-11 17:06:37', '2021-03-11 17:06:37', NULL),
(9, 'B00007', '1', '10000', 'safas', '2021-03-11 17:46:13', '2021-03-11 17:46:13', NULL),
(10, 'B00007', '2', '1000', 'dfsdff', '2021-03-11 17:46:33', '2021-03-11 17:46:33', NULL),
(11, 'B00003', '2', '10000', 'sadasda', '2021-03-11 17:48:47', '2021-03-11 17:48:47', NULL),
(13, 'a00006', '2', '10000', '345wer', '2021-03-11 19:37:14', '2021-03-11 19:37:14', NULL),
(15, 'S00001', '2', '100000', 'gbgbg', '2021-03-11 19:49:37', '2021-03-11 19:49:37', NULL),
(16, 'D00019', '2', '200000', 'asdasd', '2021-03-11 20:44:18', '2021-03-11 20:44:18', NULL),
(17, 'D00019', '3', '50000', 'asdasd', '2021-03-11 20:44:18', '2021-03-11 20:44:18', NULL),
(18, 'B00027', '2', '17500', 'asdasd', '2021-03-11 20:57:58', '2021-03-11 20:57:58', NULL),
(19, 'X00008', '1', '10000', 'dgdfgdfg', '2021-03-12 07:10:30', '2021-03-12 07:10:30', NULL),
(20, 'X00008', '2', '5000', 'vnvnvbn', '2021-03-12 07:11:21', '2021-03-12 07:11:21', NULL),
(21, 'D00027', '1', '10000', 'sadasdasdasd', '2021-03-12 07:44:35', '2021-03-12 07:44:35', NULL),
(22, 'B00029', '2', '10000', 'sdadasd', '2021-03-12 07:48:49', '2021-03-12 07:48:49', NULL),
(23, 'B00030', '2', '10000', 'sdadasd', '2021-03-12 07:49:10', '2021-03-12 07:49:10', NULL),
(24, 'X00008', '3', '100000', 'fghfgh', '2021-03-12 14:19:56', '2021-03-12 14:19:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_barang`
--

CREATE TABLE `jenis_barang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_barang`
--

INSERT INTO `jenis_barang` (`id`, `nama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Bahan Jadi', NULL, NULL, NULL),
(2, 'Bahan Baku', NULL, NULL, NULL),
(3, 'asf', '2021-03-11 12:41:58', '2021-03-11 12:41:58', NULL),
(4, 'BBM Trust', '2021-03-11 12:49:35', '2021-03-11 12:49:35', NULL),
(5, 'asdasd', '2021-03-11 12:50:54', '2021-03-11 12:50:54', NULL),
(6, 'asdasd', '2021-03-11 12:52:43', '2021-03-11 12:52:43', NULL),
(7, 'Bahan Bahan', '2021-03-11 13:04:02', '2021-03-11 13:04:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kartu_persediaan`
--

CREATE TABLE `kartu_persediaan` (
  `id` int(11) NOT NULL,
  `nomor_transaksi` varchar(255) NOT NULL,
  `master_barang_id` int(11) NOT NULL,
  `jenis` enum('DEBIT','KREDIT','','') NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `catatan` varchar(512) DEFAULT NULL,
  `gudang_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kartu_persediaan`
--

INSERT INTO `kartu_persediaan` (`id`, `nomor_transaksi`, `master_barang_id`, `jenis`, `jumlah`, `harga`, `catatan`, `gudang_id`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'PEMBELIAN#1', 1, 'DEBIT', 300, 5000, 'PEMBELIAN BARANG NOMOR TRANSAKSI #1', 1, 2, 1, '2021-10-05 12:11:38', '2021-10-05 12:11:38', NULL),
(2, 'PEMBELIAN#1', 33, 'DEBIT', 500, 5000, 'PEMBELIAN BARANG NOMOR TRANSAKSI #1', 1, 2, 1, '2021-10-05 12:11:38', '2021-10-05 12:11:38', NULL),
(5, 'BBM-1-051021-1', 1, 'KREDIT', 100, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-1-051021-1', 1, 2, 1, '2021-10-05 13:26:30', '2021-10-05 13:26:30', NULL),
(6, 'PO#051021-1', 1, 'DEBIT', 100, 7500, 'PURCHASE_ORDER#PO#051021-1', 5, 3, 15, '2021-10-05 13:30:32', '2021-10-05 13:30:32', NULL),
(7, 'BBM-15-051021-2', 1, 'KREDIT', 20, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-15-051021-2', 5, 3, 15, '2021-10-05 13:32:55', '2021-10-05 13:32:55', NULL),
(8, 'BBM-1-051021-3', 1, 'KREDIT', 20, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-1-051021-3', 1, 2, 1, '2021-10-05 14:22:25', '2021-10-05 14:22:25', NULL),
(9, 'BBM-1-061021-1', 1, 'KREDIT', 50, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-1-061021-1', 1, 2, 1, '2021-10-06 12:55:43', '2021-10-06 12:55:43', NULL),
(10, 'PO#061021-2', 1, 'DEBIT', 50, 8000, 'PURCHASE_ORDER#PO#061021-2', 5, 3, 15, '2021-10-06 12:57:56', '2021-10-06 12:57:56', NULL),
(11, 'BBM-15-071021-1', 1, 'KREDIT', 130, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-15-071021-1', 5, 3, 15, '2021-10-07 12:00:18', '2021-10-07 12:00:18', NULL),
(12, 'BBM-1-111021-1', 33, 'KREDIT', 300, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-1-111021-1', 1, 2, 1, '2021-10-11 04:48:37', '2021-10-11 04:48:37', NULL),
(13, 'PO#111021-3', 33, 'DEBIT', 300, 10000, 'PURCHASE_ORDER#PO#111021-3', 5, 3, 15, '2021-10-11 04:52:44', '2021-10-11 04:52:44', NULL),
(14, 'BBM-15-121021-1', 33, 'KREDIT', 50, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-15-121021-1', 5, 3, 15, '2021-10-12 12:53:56', '2021-10-12 12:53:56', NULL),
(15, 'BBM-15-121021-1', 33, 'DEBIT', 50, 0, 'RETUR PENJUALAN BARANG NOMOR TRANSAKSI #BBM-15-121021-1', 5, 3, 15, '2021-10-12 01:03:02', '2021-10-12 12:53:56', NULL),
(16, 'BBM-1-151021-1', 1, 'KREDIT', 100, 0, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-1-151021-1', 1, 2, 1, '2021-10-15 02:33:41', '2021-10-15 02:33:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_bank`
--

CREATE TABLE `master_bank` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_rekening` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_bank` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_akun_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_bank`
--

INSERT INTO `master_bank` (`id`, `nomor_rekening`, `nama_bank`, `kode_akun_id`, `catatan`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '129084091840', 'BCA', '51', 'sadasd', 1, NULL, NULL, NULL),
(2, '11111111111', 'BCA', '51', 'REKENING UNTUK SETORAN HARIAN', 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_cabang`
--

CREATE TABLE `master_cabang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_cabang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_telepon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_akun_id` int(11) DEFAULT NULL,
  `kontak_id` int(11) NOT NULL,
  `sales` enum('YA','TIDAK') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TIDAK',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_cabang`
--

INSERT INTO `master_cabang` (`id`, `kode_cabang`, `nama`, `alamat`, `nomor_telepon`, `kode_akun_id`, `kontak_id`, `sales`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'BBM-1', 'LIMBANGAN', 'JL Raya Limbangan ', '123123123', 55, 1, 'YA', '2021-04-29 08:51:14', '2021-04-29 08:51:14', NULL),
(15, 'BBM-2', 'KADUNGORA', 'Kadungora Garut Jawa Barat', '0821165628211', 72, 39, 'TIDAK', '2021-10-05 11:48:35', '2021-10-05 11:48:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_divisi`
--

CREATE TABLE `master_divisi` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_divisi`
--

INSERT INTO `master_divisi` (`id`, `nama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'PENJUALAN', NULL, NULL, NULL),
(2, 'SALES', NULL, NULL, NULL),
(3, 'KEUANGAN', NULL, NULL, NULL),
(4, 'GUDANG', NULL, NULL, NULL),
(5, 'PABRIK', NULL, NULL, NULL),
(6, 'ANGKUTAN BARANG', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_gaji`
--

CREATE TABLE `master_gaji` (
  `id` int(11) NOT NULL,
  `nomor_jurnal` varchar(255) NOT NULL,
  `kategori` enum('HARIAN','MINGGUAN','BULANAN','') DEFAULT NULL,
  `uang_makan` enum('DIBAYARKAN','TIDAK DIBAYARKAN','','') DEFAULT NULL,
  `bonus` enum('DIBAYARKAN','TIDAK DIBAYARKAN','','') DEFAULT NULL,
  `berdasarkan` enum('ABSENSI','SELURUH PEGAWAI','MANUAL','') DEFAULT NULL,
  `nominal` double NOT NULL,
  `jumlah_pegawai` double NOT NULL,
  `catatan` varchar(512) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `cabang_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_gaji`
--

INSERT INTO `master_gaji` (`id`, `nomor_jurnal`, `kategori`, `uang_makan`, `bonus`, `berdasarkan`, `nominal`, `jumlah_pegawai`, `catatan`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '21100715', 'HARIAN', 'DIBAYARKAN', 'DIBAYARKAN', '', 80000, 1, 'Gaji Harian', '3', '15', '2021-10-06 17:00:00', '2021-10-07 14:42:38', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_jabatan`
--

CREATE TABLE `master_jabatan` (
  `id` bigint(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_jabatan`
--

INSERT INTO `master_jabatan` (`id`, `nama`, `grade`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'STAFF GUDANG', NULL, NULL, NULL, NULL),
(2, 'SUPERVISOR SUPIR', NULL, NULL, NULL, NULL),
(3, 'SUPERVISOR GUDANG', NULL, NULL, NULL, NULL),
(4, 'SUPIR', NULL, NULL, NULL, NULL),
(5, 'SALES', NULL, NULL, NULL, NULL),
(6, 'KASIR', NULL, NULL, NULL, NULL),
(7, 'ADMINISTRASI', NULL, NULL, NULL, NULL),
(8, 'KOMISARIS', NULL, NULL, NULL, NULL),
(9, 'DIREKTUR UTAMA', NULL, NULL, NULL, NULL),
(10, 'DIREKTUR', NULL, NULL, NULL, NULL),
(11, 'IT SUPPORT', NULL, NULL, NULL, NULL),
(12, 'STAFF AKUNTING', NULL, NULL, NULL, NULL),
(13, 'KEPALA AKUNTING', NULL, NULL, NULL, NULL),
(14, 'KENEK', NULL, NULL, NULL, NULL),
(15, 'SUPERVISOR TOKO', NULL, NULL, NULL, NULL),
(16, 'KARYAWAN', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_kontak`
--

CREATE TABLE `master_kontak` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe` enum('PELANGGAN','SUPPLIER','KARYAWAN') COLLATE utf8mb4_unicode_ci NOT NULL,
  `telepon` double DEFAULT NULL,
  `identitas` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `info_lain` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_perusahaan` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `npwp` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `akun_piutang_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `akun_utang_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wic` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_kontak`
--

INSERT INTO `master_kontak` (`id`, `nama`, `tipe`, `telepon`, `identitas`, `email`, `info_lain`, `nama_perusahaan`, `npwp`, `alamat`, `akun_piutang_id`, `akun_utang_id`, `wic`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'BBM LIMBANGAN', 'SUPPLIER', NULL, NULL, NULL, NULL, NULL, NULL, '', '62', '59', 0, NULL, 0, NULL, NULL, NULL),
(39, 'CABANG BBM - KADUNGORA', 'PELANGGAN', 821165628211, NULL, NULL, NULL, NULL, NULL, 'Kadungora Garut Jawa Barat', '73', '74', 0, NULL, 0, '2021-10-05 11:48:36', '2021-10-05 11:48:36', NULL),
(40, 'MEGA BAJA', 'SUPPLIER', 827174124, NULL, NULL, NULL, NULL, NULL, 'GARUT', '77', '78', 0, 3, 1, '2021-10-05 12:00:14', '2021-10-05 12:00:15', NULL),
(41, 'Lucky', 'PELANGGAN', 82116562811, NULL, NULL, NULL, NULL, NULL, 'Bandung', '79', '80', 0, 3, 15, '2021-10-05 13:32:04', '2021-10-05 13:32:04', NULL),
(42, 'Emir', 'PELANGGAN', 213123123, NULL, NULL, NULL, NULL, NULL, 'Tasik', '81', '82', 0, 2, 1, '2021-10-05 14:21:08', '2021-10-05 14:21:08', NULL),
(43, 'Dani', 'PELANGGAN', 92123123, NULL, NULL, NULL, NULL, NULL, 'Jl Cipadung Raya', '83', '84', 0, 3, 15, '2021-10-12 14:07:47', '2021-10-12 14:07:47', NULL),
(44, 'Emir', 'PELANGGAN', 123123123, NULL, NULL, NULL, NULL, NULL, 'Bandung', '85', '86', 0, 3, 15, '2021-10-12 14:10:50', '2021-10-12 14:10:50', NULL),
(45, 'Hadiyan', 'PELANGGAN', 123123123, NULL, NULL, NULL, NULL, NULL, 'Bandung', '87', '88', 0, 3, 15, '2021-10-12 14:14:01', '2021-10-12 14:14:01', NULL),
(46, 'Desi', 'PELANGGAN', 123123123, NULL, NULL, NULL, NULL, NULL, 'Evilia 10', '89', '90', 0, 3, 15, '2021-10-12 14:15:31', '2021-10-12 14:15:32', NULL),
(47, 'Bobi', 'PELANGGAN', 13123123123, NULL, NULL, NULL, NULL, NULL, 'asdads', '91', '92', 0, 3, 15, '2021-10-12 14:16:20', '2021-10-12 14:16:20', NULL),
(48, 'Ucu', 'PELANGGAN', 123123123, NULL, NULL, NULL, NULL, NULL, 'Dadan', '93', '94', 0, 3, 15, '2021-10-12 14:17:55', '2021-10-12 14:17:55', NULL),
(49, 'Nani', 'PELANGGAN', 0, NULL, NULL, NULL, NULL, NULL, 'Dadan123123213', '95', '96', 0, 3, 15, '2021-10-12 14:18:03', '2021-10-12 14:18:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_opname`
--

CREATE TABLE `master_opname` (
  `id` int(11) NOT NULL,
  `nomor_opname` varchar(255) NOT NULL,
  `tipe` int(11) NOT NULL DEFAULT 0,
  `kategori` int(11) NOT NULL DEFAULT 0,
  `catatan` varchar(255) NOT NULL,
  `gudang_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `nomor_jurnal` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_opname`
--

INSERT INTO `master_opname` (`id`, `nomor_opname`, `tipe`, `kategori`, `catatan`, `gudang_id`, `user_id`, `cabang_id`, `nomor_jurnal`, `created_at`, `updated_at`, `deleted_at`) VALUES
(4, 'OPNAME#2109301', 1, 2, 'Produksi Masuk', '1', 1, 1, NULL, '2021-09-29 17:00:00', '2021-09-29 17:00:00', NULL),
(5, 'OPNAME#2110032', 1, 3, 'Buka Cabang Baru', '2', 2, 2, NULL, '2021-10-02 17:00:00', '2021-10-02 17:00:00', NULL),
(6, 'OPNAME#2110033', 0, 0, 'asdsadsad', '2', 2, 2, NULL, '2021-10-02 17:00:00', '2021-10-02 17:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_pegawai`
--

CREATE TABLE `master_pegawai` (
  `id` int(11) NOT NULL,
  `ktp` varchar(255) DEFAULT NULL,
  `nama` varchar(255) NOT NULL,
  `jenis_kelamin` enum('LAKI - LAKI','PEREMPUAN','','') NOT NULL DEFAULT 'LAKI - LAKI',
  `alamat` text NOT NULL,
  `kelurahan` varchar(255) NOT NULL,
  `kecamatan` varchar(255) NOT NULL,
  `kota` varchar(255) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `pendidikan_terakhir` varchar(255) DEFAULT NULL,
  `nomor_telepon` varchar(255) DEFAULT NULL,
  `nomor_rekening` varchar(255) DEFAULT NULL,
  `npwp` varchar(255) DEFAULT NULL,
  `status_gaji` int(1) NOT NULL,
  `gaji_pokok` double NOT NULL,
  `uang_makan` double NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `divisi_id` int(11) DEFAULT NULL,
  `jabatan_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `master_pegawai`
--

INSERT INTO `master_pegawai` (`id`, `ktp`, `nama`, `jenis_kelamin`, `alamat`, `kelurahan`, `kecamatan`, `kota`, `tanggal_lahir`, `tanggal_masuk`, `pendidikan_terakhir`, `nomor_telepon`, `nomor_rekening`, `npwp`, `status_gaji`, `gaji_pokok`, `uang_makan`, `avatar`, `divisi_id`, `jabatan_id`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '3205385412020000', 'NURLELA', 'PEREMPUAN', 'Kp.Banen RT01/RW 11 ', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '2002-12-14', '2020-01-01', 'SMP', '085524742774', NULL, NULL, 1, 45000, 10000, 'default.jpg', 1, '1', 0, 15, '2021-05-26 17:05:25', NULL, NULL),
(2, '3205385711990001', 'ASRI NOVIYANTI', 'PEREMPUAN', 'Kp.Ciseureuh RT01/RW14 ', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1999-11-17', '2020-01-01', 'SMA', '083862098237', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '7', 0, 1, '2021-05-26 17:05:25', NULL, NULL),
(3, '3205124505940001', 'SITI NURAENI', 'PEREMPUAN', 'Kp.Wedasari RT05/RW04', 'Mekarsari', 'Cibatu', 'Garut', '1994-05-05', '2020-01-01', 'SMP', '082295499430', NULL, NULL, 1, 66000, 10000, 'default.jpg', 1, '15', 0, 1, '2021-05-26 17:05:25', NULL, NULL),
(4, '3671071311910004', 'ASEP SUPRIATNA', 'LAKI - LAKI', 'Kp.Wedasari RT01/RW04 ', 'Mekarsari', 'Cibatu', 'Garut', '1991-11-13', '2020-01-01', 'SMA', '082310193408', NULL, NULL, 1, 70000, 10000, 'default.jpg', 1, '3', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(5, '332916170190004', 'FADLI', 'LAKI - LAKI', 'Kp.Sasak Beusi RT04/RW11', 'Sindang Suka', 'Cibatu', 'Garut', '1990-01-17', '2020-01-01', 'SMP', '089636039353', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(6, '3205401502830001', 'PAK USMAN', 'LAKI - LAKI', 'Kp.Lembur Kulon RT02/RW02', 'Cipareaun', 'Cibiuk', 'Garut', '1963-02-15', '2020-01-01', 'SMA', NULL, NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '1', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(7, NULL, 'HERI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(8, '3205122210910001', 'USEP SOPANDI', 'LAKI - LAKI', 'Kp.Kopeng RT03/RW01 ', 'Sindang Suka', 'Cibatu', 'Garut', '1991-10-22', '2020-01-01', 'SMP', NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(9, '3205380506860001', 'YADI SURYADI', 'LAKI - LAKI', 'Kp.Cangkudu RT02/RW01', 'Galihpakuwon', 'BL. Limbangan', 'Garut', '1979-04-08', '2020-01-01', 'SD', '082317205594', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(10, '3205120205750002', 'ENANG PARDINA', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10 ', 'Mekarsari', 'Cibatu', 'Garut', '1975-02-05', '2020-01-01', 'SD', NULL, NULL, NULL, 1, 55000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(11, '1971040510690001', 'SYARIP', 'LAKI - LAKI', 'Kp.Kopeng RT02/RW01', 'Sindang Suka', 'Cibatu', 'Garut', '1969-05-10', '2020-01-01', 'SD', '085383297672', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(12, '3205120808720001', 'AGUS SUDRAJAT', 'LAKI - LAKI', 'Kp.Cipacing Hilir RT01/RW02 ', 'Mekarsari', 'Cibatu', 'Garut', '1972-07-15', '2020-01-01', 'SMP', '082315038766', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(13, '3204050101650082', 'NANA SUMEGA', 'LAKI - LAKI', 'Kp.Tagog Wetan RT03/RW04 ', 'Cangkudu', 'BL. Limbangan', 'Garut', '1965-01-01', '2020-01-01', 'SD', '082149467379', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(14, '3207341008800004', 'ENDE HAMDAN', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1980-10-08', '2020-01-01', 'SMP', '083825534209', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(15, NULL, 'MANG JAJA', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(16, '3205380111930001', 'CECEP KURNIAWAN', 'LAKI - LAKI', 'Kp.Sasak Beusi RT02/RW11', 'Sindang Suka', 'Cibatu', 'Garut', '1992-12-08', '2020-01-01', 'SMA', '085721638437', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '1', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(17, '3205120202830003', 'MASNEN', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt01.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1983-02-02', '2020-01-01', 'SD', '089603740487', NULL, NULL, 1, 55000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(18, '1971043006810004', 'ASEP SUBARJAH', 'LAKI - LAKI', 'Kp.Cigalumpit RT01/RW10', 'Sindang Suka', 'Cibatu', 'Garut', '1981-06-30', '2020-01-01', 'SD', '089603740487', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(19, '3205122205910001', 'RUHIAT ARDIANSYAH', 'LAKI - LAKI', 'Kp.Cipeujeuh RT01/RW06', 'Sukemarang', 'Kersamanah', 'Garut', '1991-05-22', '2020-01-01', 'SMP', '088247093509', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(20, '1971041401990002', 'FAISAL RAMDAN', 'LAKI - LAKI', 'Kp.Kopeng RT02/RW01', 'Sindang Suka', 'Cibatu', 'Garut', '1999-01-14', '2020-01-01', 'SMA', '082119230932', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(21, '3205121401980004', 'ARIYANTO', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt01.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1998-01-14', '2020-01-01', 'SMP', '083861568665', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(22, '3205120505010003', 'ADI SAPUTRA', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt01.RW10', 'Mekarsari', 'Cibatu', 'Garut', '2001-05-05', '2020-01-01', 'SD', '083120459934', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(23, NULL, 'ARIF RUSMANA', 'LAKI - LAKI', 'Kp.Cikelepu RT01/RW07', 'Dunguswiru', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, '082216187889', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(24, '3205120501930002', 'AGUS RUHIAT', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10 ', 'Mekarsari', 'Cibatu', 'Garut', '1993-05-01', '2020-01-01', 'SD', '089632543495', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(25, NULL, 'HAMDANI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, '085798201353', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(26, NULL, 'MANG ACENG', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(27, '3205122803980001', 'DENI RUSTANDI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1998-03-28', '2020-01-01', 'SMP', NULL, NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(28, NULL, 'MANG IIN', 'LAKI - LAKI', 'Kp.Gadog Hilir RT/RW', 'Sindang Suka', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, '081321262451', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(29, '3205140407800010', 'IMAM SARIPUDIN', 'LAKI - LAKI', 'Kp.Cibitung Kulon RT03/RW02', 'Cibunar', 'Malangbong', 'Garut', '1980-04-07', '2020-01-01', 'SMP', '082321433259', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:01:14', NULL, NULL),
(30, NULL, 'MANG MAMAT', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(31, NULL, 'ASEP IRAWAN', 'LAKI - LAKI', 'Kp.Salam', 'Cibunar', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, '08990675737', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(32, '3205120801840001', 'ANDI ROHENDI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1984-08-01', '2020-01-01', 'SD', NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(33, NULL, 'HERMAN', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(34, NULL, 'RIZKI', 'LAKI - LAKI', 'Kp.Salam', 'Cibunar', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(35, NULL, 'A REPI', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(36, '3205385903930002', 'ERSAN SUKMAYA', 'LAKI - LAKI', 'Kp.Pulosari RT01/RW0', 'Cijolang', 'BL. Limbangan', 'Garut', '1993-03-19', '2020-01-01', 'SD', NULL, NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(37, NULL, 'ABAH.HOLID', 'LAKI - LAKI', 'Kp.Cikurantung RT09/RW02', 'Cirapuhan', 'Selaawi', 'Garut', '1963-08-08', '2020-01-01', 'SD', NULL, NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(38, '3205385302950004', 'LINDA AMELIA RAMDANI', 'PEREMPUAN', 'Kp.Banen RT01/RW 11', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1995-02-13', '2020-01-01', 'SMK', NULL, NULL, NULL, 1, 30000, 10000, 'default.jpg', 1, '6', 0, 1, '2021-05-26 17:05:25', NULL, NULL),
(39, '3205384506970009', 'NENG YULIANTIN', 'LAKI - LAKI', 'KP. WEDA SARI', 'MEKARSARI', 'CIBATU', 'GARUT', '1997-06-05', '2020-06-01', NULL, NULL, NULL, '943769190443000', 3, 0, 0, 'default.jpg', 1, '9', 0, 1, '2021-05-26 17:02:48', NULL, NULL),
(40, '3205121506690003', 'SARWONO', 'LAKI - LAKI', 'KP.BABAKAN LOA RT02/RW03 ', 'CIBATU', 'CIBATU', 'GARUT', '1969-03-06', '2018-01-07', 'SMA', '082315521016', NULL, NULL, 1, 2000000, 40000, 'default.jpg', 1, '5', 0, 1, '2021-05-26 17:01:10', NULL, NULL),
(41, '3273200110860003', 'PURWIDI SAKTI.S.SOS', 'LAKI - LAKI', 'JL KAWALI 3 NO 20 RT05/RW17', 'ANTAPANI', 'ANTAPANI', 'BANDUNG', '1986-01-10', '2020-05-28', 'SARJANA', NULL, NULL, NULL, 1, 1500000, 20000, 'default.jpg', 1, '5', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(42, '00', 'NENG', 'PEREMPUAN', 'KP BATUKARUT LIMBANGAN TIMUR', 'LIMBANGAN', 'BL LIMBANGAN', 'GARUT', '1997-05-06', '2020-06-06', 'SMP', NULL, NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-26 17:05:25', NULL, NULL),
(43, '3205131703730003', 'TETEN', 'LAKI - LAKI', 'KP.BINUANG RT01/RW11', 'KERSAMANAH', 'KERSAMANAH', 'GARUT', '1973-05-03', '2017-01-14', NULL, '081224582086', NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-26 17:02:48', NULL, NULL),
(44, '3205126607990001', 'KAMILA JULIANTI', 'PEREMPUAN', 'KP.WEDASARI RT05/RW04', 'MEKARSARI', 'CIBATU', 'GARUT', '1999-02-07', '2020-06-30', NULL, '083825953726', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '6', 0, 1, '2021-05-26 17:05:25', NULL, NULL),
(45, '320512250578003', 'ATEN ARIPIN', 'LAKI - LAKI', 'KP.WEDASARI RT005/RW 004', 'MEKARSARI', 'CIBATU', 'GARUT', '1978-05-25', '2020-06-30', 'SD', '085324884799', 'BCA - 1480980570', '55.485.291.3-443.000', 1, 0, 0, 'default.jpg', 1, '8', 0, 1, '2021-05-26 16:58:52', NULL, NULL),
(46, '3205122012990003', 'RIDWAN RAMDANI SONJAYA', 'LAKI - LAKI', 'KP.PULO RT 004/ RW 001 ', 'SINDANG SUKA', 'CIBATU', 'GARUT', '0199-12-20', '2020-07-03', 'SMP', NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(47, '3205120708020002', 'ALDI JAELANI', 'LAKI - LAKI', 'KP CADAS BODAS RT 002/RW 010', 'MEKARSARI', 'CIBATU', 'GARUT', '2002-08-07', '2020-07-03', NULL, NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:02:48', NULL, NULL),
(48, NULL, 'NCENG SUKMANA', 'LAKI - LAKI', 'KP.CADAS BODAS  RT 001/RW 010\r\n', 'MEKARSARI', 'CIBATU', 'GARUT', '1973-08-05', '2020-07-03', 'SD', NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:03:32', NULL, NULL),
(49, '3204100401810003', 'RURI JANUAR WIJAYA', 'LAKI - LAKI', 'KOMP. MARGAHAYU PERMAI JLN PERMAI 26 NO 7 RT010/ RW 009', 'MEKAR RAHAYU', 'MARGAASIH', 'BANDUNG', '1981-01-04', '2018-02-08', 'SMA', '085694955601', NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-26 17:01:10', NULL, NULL),
(50, '3273052908700002', 'H.WAGIA AGUSDIYANA SE ', 'LAKI - LAKI', 'JL.JATI HANAP RT 004/ RW 010', 'JATIHANDAP', 'MANDALA JATI', 'BANDUNG', '1970-08-29', '2019-12-01', 'SARJANA', '081809252630', NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-26 17:01:10', NULL, NULL),
(51, '3205121903750001', 'BASIRIN', 'LAKI - LAKI', 'KP.CADAS BODAS RT001/RW010', 'MEKARSARI', 'CIBATU', 'GARUT', '1975-03-19', '2020-07-04', 'SD', NULL, NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-26 17:02:10', NULL, NULL),
(52, '3205144508010005', 'AJENG WIDI', 'PEREMPUAN', 'KP SUKARESMI, RT02/RW01', 'CIBUNAR', 'MALAMBONG', 'GARUT', '2001-05-08', '2020-08-03', NULL, '085722847834', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '6', 0, 1, '2021-05-26 17:05:25', NULL, NULL),
(53, '32051228012123123123', 'LUCKY ANGGARA', 'LAKI - LAKI', 'KP.CADAS BODAS, RT02/RW10 DS.MEKARSARI KEC CIBATU', 'MEKARSARI', 'CIBATU', 'GARUT', '1984-04-04', '2021-01-11', 'SMA', NULL, NULL, NULL, 3, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-26 17:02:10', '2021-06-08 15:54:11', NULL),
(56, '123123', 'asd', 'LAKI - LAKI', 'asdasdasd', 'asd', 'asd', 'asd', '2021-06-10', '2021-06-10', NULL, '1231231231', '1233', '12312', 1, 0, 0, '', 1, '1', 0, 1, '2021-06-09 15:27:35', '2021-06-09 15:27:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_pembelian`
--

CREATE TABLE `master_pembelian` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_transaksi` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kontak_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `diskon` double NOT NULL,
  `ongkir` double NOT NULL,
  `pajak_masukan` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `metode_pembayaran` enum('Lunas','Kredit','Cash On Delivery (COD)') COLLATE utf8mb4_unicode_ci NOT NULL,
  `kredit` tinyint(1) DEFAULT NULL,
  `down_payment` double DEFAULT NULL,
  `sisa_pembayaran` double DEFAULT NULL,
  `cara_pembayaran` enum('Tunai','Transfer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_jatuh_tempo` datetime DEFAULT NULL,
  `retur` enum('Iya','Tidak') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `nomor_jurnal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_pembelian`
--

INSERT INTO `master_pembelian` (`id`, `nomor_transaksi`, `kontak_id`, `total`, `diskon`, `ongkir`, `pajak_masukan`, `grand_total`, `metode_pembayaran`, `kredit`, `down_payment`, `sisa_pembayaran`, `cara_pembayaran`, `bank_id`, `tanggal_jatuh_tempo`, `retur`, `user_id`, `cabang_id`, `nomor_jurnal`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1', '40', 4000000, 0, 0, 0, 4000000, 'Lunas', 0, 0, 0, 'Tunai', NULL, NULL, 'Tidak', '2', 1, '2110052', 'Pembelian Barang', '2021-10-04 17:00:00', '2021-10-04 17:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_penjualan`
--

CREATE TABLE `master_penjualan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_transaksi` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kontak_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `diskon` double NOT NULL,
  `ongkir` double NOT NULL,
  `pajak_keluaran` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `metode_pembayaran` enum('Lunas','Kredit','Cash On Delivery (COD)') COLLATE utf8mb4_unicode_ci NOT NULL,
  `kredit` tinyint(1) DEFAULT NULL,
  `down_payment` double DEFAULT NULL,
  `sisa_pembayaran` double DEFAULT NULL,
  `cara_pembayaran` enum('Tunai','Transfer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tanggal_jatuh_tempo` datetime DEFAULT NULL,
  `retur` enum('Iya','Tidak') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `nomor_jurnal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_penjualan`
--

INSERT INTO `master_penjualan` (`id`, `nomor_transaksi`, `kontak_id`, `total`, `diskon`, `ongkir`, `pajak_keluaran`, `grand_total`, `metode_pembayaran`, `kredit`, `down_payment`, `sisa_pembayaran`, `cara_pembayaran`, `bank_id`, `tanggal_jatuh_tempo`, `retur`, `sales_id`, `catatan`, `user_id`, `cabang_id`, `nomor_jurnal`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'BBM-1-051021-1', '39', 750000, 0, 0, 0, 750000, 'Kredit', 1, 0, 750000, 'Tunai', NULL, '2021-12-05 13:25:30', 'Tidak', NULL, 'asdasdasd', 2, 1, '2110053', '2021-10-05 13:26:30', '2021-10-05 13:26:30', NULL),
(3, 'BBM-15-051021-2', '41', 200000, 0, 0, 0, 200000, 'Lunas', 0, 0, 0, 'Tunai', NULL, NULL, 'Tidak', NULL, 'Catatan Aja ini Mah', 3, 15, '2110055', '2021-10-05 13:32:55', '2021-10-05 13:32:55', NULL),
(4, 'BBM-1-051021-3', '42', 400000, 0, 0, 0, 400000, 'Kredit', 1, 0, 400000, 'Tunai', NULL, '2021-11-05 00:00:00', 'Tidak', '40', 'Dibayar Bulan Depan', 2, 1, '2110059', '2021-10-05 14:22:25', '2021-10-05 14:22:25', NULL),
(5, 'BBM-1-061021-1', '39', 400000, 0, 0, 0, 400000, 'Kredit', 1, 0, 400000, 'Tunai', NULL, '2021-12-06 12:55:34', 'Tidak', NULL, 'asdasdasd', 2, 1, '21100610', '2021-10-06 12:55:43', '2021-10-06 12:55:43', NULL),
(6, 'BBM-15-071021-1', '41', 1300000, 0, 0, 0, 1300000, 'Lunas', 0, 0, 0, 'Tunai', NULL, NULL, 'Tidak', NULL, NULL, 3, 15, '21100713', '2021-10-07 12:00:18', '2021-10-07 12:00:18', NULL),
(7, 'BBM-1-111021-1', '39', 3000000, 0, 0, 0, 3000000, 'Kredit', 1, 0, 3000000, 'Tunai', NULL, '2021-12-11 04:48:28', 'Tidak', NULL, 'asdasdasd', 2, 1, '21101121', '2021-10-11 04:48:37', '2021-10-11 04:48:37', NULL),
(8, 'BBM-15-121021-1', '41', 7500000, 0, 0, 0, 7500000, 'Lunas', 0, 0, 0, 'Tunai', NULL, NULL, 'Iya', NULL, 'Dadadadadaad', 3, 15, '21101223', '2021-10-12 12:53:56', '2021-10-12 13:03:02', NULL),
(9, 'BBM-1-151021-1', '42', 1500000, 0, 0, 0, 1500000, 'Lunas', 0, 0, 0, 'Tunai', NULL, NULL, 'Tidak', NULL, 'Lunas asdasdasd', 2, 1, '21101524', '2021-10-15 02:33:41', '2021-10-15 02:33:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_po`
--

CREATE TABLE `master_po` (
  `id` int(11) NOT NULL,
  `kode_po` varchar(255) NOT NULL,
  `master_penjualan_id` int(11) NOT NULL,
  `nomor_transaksi` varchar(255) NOT NULL,
  `tujuan_cabang_id` int(11) NOT NULL,
  `status` enum('SEND','APPROVED','REJECTED','SELESAI') NOT NULL,
  `catatan` varchar(512) NOT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nomor_jurnal` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_po`
--

INSERT INTO `master_po` (`id`, `kode_po`, `master_penjualan_id`, `nomor_transaksi`, `tujuan_cabang_id`, `status`, `catatan`, `cabang_id`, `user_id`, `nomor_jurnal`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'PO#051021-1', 2, 'BBM-1-051021-1', 1, 'SELESAI', 'asdasdasdasdsadasdasd', 15, 3, '2110054', '2021-10-05 06:24:57', '2021-10-05 13:30:32', NULL),
(3, 'PO#061021-2', 5, 'BBM-1-061021-1', 1, 'SELESAI', 'asdasdasdasd', 15, 3, '21100611', '2021-10-06 05:43:48', '2021-10-06 12:57:56', NULL),
(4, 'PO#111021-3', 7, 'BBM-1-111021-1', 1, 'SELESAI', 'PO Bondeck Kostum', 15, 3, '21101122', '2021-10-10 21:31:51', '2021-10-11 04:52:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_presensi`
--

CREATE TABLE `master_presensi` (
  `id` int(11) NOT NULL,
  `pegawai_id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam_masuk` time DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `status` enum('MASUK','TIDAK MASUK','SETENGAH HARI','TIDAK ABSEN PULANG','TIDAK ABSEN MASUK') DEFAULT NULL,
  `catatan` varchar(255) NOT NULL,
  `cabang_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `master_setor`
--

CREATE TABLE `master_setor` (
  `id` int(11) NOT NULL,
  `cabang_id_dari` varchar(255) NOT NULL,
  `cabang_id_ke` varchar(255) NOT NULL,
  `kode_akun_id_dari` varchar(12) NOT NULL,
  `kode_akun_id_ke` varchar(12) NOT NULL,
  `lawan_akun` int(11) NOT NULL DEFAULT 65,
  `nominal` double NOT NULL DEFAULT 0,
  `tipe` enum('TUNAI','TRANSFER') DEFAULT NULL,
  `catatan` varchar(512) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `status` enum('SEND','REJECTED','APPROVED') DEFAULT NULL,
  `nomor_jurnal_dari` varchar(255) DEFAULT NULL,
  `nomor_jurnal_ke` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_setor`
--

INSERT INTO `master_setor` (`id`, `cabang_id_dari`, `cabang_id_ke`, `kode_akun_id_dari`, `kode_akun_id_ke`, `lawan_akun`, `nominal`, `tipe`, `catatan`, `user_id`, `cabang_id`, `status`, `nomor_jurnal_dari`, `nomor_jurnal_ke`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '15', '1', '72', '51', 65, 200000, 'TRANSFER', 'LAPORAN SETORAN HARI INI MELALUI TRANSFER', 3, 15, 'APPROVED', '2110057', '2110058', '2021-10-05 06:35:12', '2021-10-05 13:46:02', NULL),
(2, '15', '1', '72', '55', 65, 121500, 'TUNAI', 'Setoran', 3, 15, 'APPROVED', '21100717', '21100718', '2021-10-07 08:13:09', '2021-10-07 15:13:38', NULL),
(3, '15', '1', '72', '51', 65, 1093500, 'TRANSFER', 'Transfer Setor nya sore', 3, 15, 'APPROVED', '21100719', '21100720', '2021-10-07 08:14:03', '2021-10-07 15:14:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_transfer_persediaan`
--

CREATE TABLE `master_transfer_persediaan` (
  `id` int(11) NOT NULL,
  `nomor_transfer` varchar(255) NOT NULL,
  `dari` varchar(255) DEFAULT NULL,
  `ke` varchar(255) DEFAULT NULL,
  `nominal` double DEFAULT NULL,
  `catatan` varchar(255) NOT NULL,
  `nomor_jurnal` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `merek_barang`
--

CREATE TABLE `merek_barang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `merek_barang`
--

INSERT INTO `merek_barang` (`id`, `nama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'BBM', NULL, NULL, NULL),
(2, 'BBM Trust', '2021-03-11 13:05:32', '2021-03-11 13:05:32', NULL),
(3, 'LUCKY YO', '2021-03-11 20:35:15', '2021-03-11 20:35:15', NULL),
(4, 'DESI YO', '2021-03-11 20:40:35', '2021-03-11 20:40:35', NULL),
(5, 'LULA', '2021-03-11 20:41:55', '2021-03-11 20:41:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2021_03_08_135321_create_barang', 1),
(5, '2021_03_08_135735_create_jenis_barang', 2),
(6, '2021_03_08_135744_create_merek_barang', 2),
(7, '2021_03_08_135819_create_satuan_barang', 2),
(9, '2021_03_12_042032_create_master_kontak', 3),
(10, '2021_03_13_070812_create_harga_jual', 4),
(11, '2021_03_14_012140_create_gudang', 5),
(12, '2021_03_12_032541_create_master_penjualan', 6),
(15, '2021_04_09_013131_create_tabel_detail_penjualan', 7),
(16, '2021_04_12_034728_create_master_bank', 8),
(17, '2021_04_26_042935_create_master_persediaan', 9),
(18, '2021_04_26_050136_create_kartu_persediaan', 9),
(20, '2021_04_30_054712_create_master_cabang', 10),
(22, '2021_05_01_060934_create_role', 11),
(23, '2021_05_01_062510_create_master_pegawai', 11);

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id` int(11) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `sub_title` varchar(255) NOT NULL,
  `untuk_user_id` int(11) NOT NULL,
  `dari_user_id` int(11) NOT NULL,
  `status` enum('UNREAD','READ','','') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ability` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `header` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `nama`, `ability`, `header`, `created_at`, `updated_at`) VALUES
(1, 'SUPER USER', '[{\"action\" : \"manage\", \"subject\" : \"all\"}]', 'superuser', '2021-10-05 10:53:33', NULL),
(2, 'KEPALA CABANG', '[{\"action\" : \"manage\", \"subject\" : \"header\"},{\"action\" : \"manage\", \"subject\" : \"auth\"},{\"action\" : \"manage\", \"subject\" : \"dashboard_cabang\"},{\"action\" : \"manage\", \"subject\" : \"laporan_persediaan\"},{\"action\" : \"manage\", \"subject\" : \"laporan_kasir\"},{\"action\" : \"manage\", \"subject\" : \"laporan_cabang\"},{\"action\" : \"manage\", \"subject\" : \"laporan_neraca\"},{\"action\" : \"manage\", \"subject\" : \"laporan_laba_rugi\"},{\"action\" : \"manage\", \"subject\" : \"master_barang\"},{\"action\" : \"manage\", \"subject\" : \"master_kontak\"},{\"action\" : \"manage\", \"subject\" : \"transaksi_penjualan\"},{\"action\" : \"manage\", \"subject\" : \"transaksi_po\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_beban\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi_neraca\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi_laba_rugi\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi_daftar\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_kas\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_utang_piutang\"}]', 'cabang', '2021-10-05 10:53:33', NULL),
(3, 'MANAJER', '[{\"action\" : \"manage\", \"subject\" : \"all\"}]', 'manajer', '2021-10-05 10:53:33', NULL),
(4, 'KASIR', '[{\"action\" : \"manage\", \"subject\" : \"header\"},{\"action\" : \"manage\", \"subject\" : \"auth\"},{\"action\" : \"manage\", \"subject\" : \"dashboard_kasir\"},{\"action\" : \"manage\", \"subject\" : \"laporan_kasir\"},{\"action\" : \"manage\", \"subject\" : \"master_kontak\"},{\"action\" : \"manage\", \"subject\" : \"transaksi_penjualan\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_kas\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi\"}]', 'kasir', '2021-10-05 10:53:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `satuan_barang`
--

CREATE TABLE `satuan_barang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `satuan_barang`
--

INSERT INTO `satuan_barang` (`id`, `kode_satuan`, `nama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(0, '-', 'TIDAK ADA SATUAN', NULL, NULL, NULL),
(1, 'BTG', 'BATANG', NULL, NULL, NULL),
(2, 'DUS', 'DUS', NULL, NULL, NULL),
(3, 'KG', 'KILOGRAM', NULL, NULL, NULL),
(4, 'KLG', 'KALENG', NULL, NULL, NULL),
(5, 'LBR', 'LEMBAR', NULL, NULL, NULL),
(6, 'MTR', 'METER', NULL, NULL, NULL),
(7, 'PCS', 'PIECES', NULL, NULL, NULL),
(8, 'UNIT', 'UNIT', NULL, NULL, NULL),
(9, 'RL', 'ROLL', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `timeline_po`
--

CREATE TABLE `timeline_po` (
  `id` int(11) NOT NULL,
  `master_po_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `subtitle` varchar(512) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `ability` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pegawai_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `kode_akun_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `role_id`, `ability`, `password`, `remember_token`, `pegawai_id`, `cabang_id`, `kode_akun_id`, `created_at`, `updated_at`) VALUES
(1, 'lucky', 2, '[{\"action\" : \"manage\", \"subject\" : \"header\"},{\"action\" : \"manage\", \"subject\" : \"auth\"},{\"action\" : \"manage\", \"subject\" : \"dashboard_cabang\"},{\"action\" : \"manage\", \"subject\" : \"laporan_persediaan\"},{\"action\" : \"manage\", \"subject\" : \"laporan_kasir\"},{\"action\" : \"manage\", \"subject\" : \"laporan_cabang\"},{\"action\" : \"manage\", \"subject\" : \"laporan_neraca\"},{\"action\" : \"manage\", \"subject\" : \"laporan_laba_rugi\"},{\"action\" : \"manage\", \"subject\" : \"master_barang\"},{\"action\" : \"manage\", \"subject\" : \"master_kontak\"},{\"action\" : \"manage\", \"subject\" : \"transaksi_penjualan\"},{\"action\" : \"manage\", \"subject\" : \"transaksi_po\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_beban\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_akuntansi_daftar\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_kas\"},{\"action\" : \"manage\", \"subject\" : \"keuangan_utang_piutang\"}]', '123456', NULL, 1, 1, '0', NULL, NULL),
(2, 'asri', 4, '[{\"action\" : \"manage\", \"subject\" : \"all\"}]', '123456', NULL, 3, 1, '56', NULL, NULL),
(3, 'nurlela', 2, '[{\"action\" : \"manage\", \"subject\" : \"all\"}]', '123456', NULL, 1, 15, '76', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_barang` (`kode_barang`);

--
-- Indexes for table `detail_gaji`
--
ALTER TABLE `detail_gaji`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_opname`
--
ALTER TABLE `detail_opname`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_pembayaran`
--
ALTER TABLE `detail_pembayaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_piutang`
--
ALTER TABLE `detail_piutang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_po`
--
ALTER TABLE `detail_po`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_transfer_persediaan`
--
ALTER TABLE `detail_transfer_persediaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gudang`
--
ALTER TABLE `gudang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `harga_beli`
--
ALTER TABLE `harga_beli`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `harga_jual`
--
ALTER TABLE `harga_jual`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `harga_jual2`
--
ALTER TABLE `harga_jual2`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jenis_barang`
--
ALTER TABLE `jenis_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kartu_persediaan`
--
ALTER TABLE `kartu_persediaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_bank`
--
ALTER TABLE `master_bank`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_bank_nomor_rekening_unique` (`nomor_rekening`);

--
-- Indexes for table `master_cabang`
--
ALTER TABLE `master_cabang`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_cabang_kode_cabang_unique` (`kode_cabang`);

--
-- Indexes for table `master_divisi`
--
ALTER TABLE `master_divisi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_gaji`
--
ALTER TABLE `master_gaji`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_jabatan`
--
ALTER TABLE `master_jabatan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_kontak`
--
ALTER TABLE `master_kontak`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_opname`
--
ALTER TABLE `master_opname`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_pegawai`
--
ALTER TABLE `master_pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_pembelian`
--
ALTER TABLE `master_pembelian`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_penjualan`
--
ALTER TABLE `master_penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_po`
--
ALTER TABLE `master_po`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_presensi`
--
ALTER TABLE `master_presensi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_setor`
--
ALTER TABLE `master_setor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_transfer_persediaan`
--
ALTER TABLE `master_transfer_persediaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merek_barang`
--
ALTER TABLE `merek_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `satuan_barang`
--
ALTER TABLE `satuan_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timeline_po`
--
ALTER TABLE `timeline_po`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `detail_gaji`
--
ALTER TABLE `detail_gaji`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `detail_opname`
--
ALTER TABLE `detail_opname`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_pembayaran`
--
ALTER TABLE `detail_pembayaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `detail_piutang`
--
ALTER TABLE `detail_piutang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_po`
--
ALTER TABLE `detail_po`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `detail_transfer_persediaan`
--
ALTER TABLE `detail_transfer_persediaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gudang`
--
ALTER TABLE `gudang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `harga_beli`
--
ALTER TABLE `harga_beli`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `harga_jual`
--
ALTER TABLE `harga_jual`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `harga_jual2`
--
ALTER TABLE `harga_jual2`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `jenis_barang`
--
ALTER TABLE `jenis_barang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kartu_persediaan`
--
ALTER TABLE `kartu_persediaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `master_bank`
--
ALTER TABLE `master_bank`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `master_cabang`
--
ALTER TABLE `master_cabang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `master_divisi`
--
ALTER TABLE `master_divisi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `master_gaji`
--
ALTER TABLE `master_gaji`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `master_jabatan`
--
ALTER TABLE `master_jabatan`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `master_kontak`
--
ALTER TABLE `master_kontak`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `master_opname`
--
ALTER TABLE `master_opname`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `master_pegawai`
--
ALTER TABLE `master_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `master_pembelian`
--
ALTER TABLE `master_pembelian`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `master_penjualan`
--
ALTER TABLE `master_penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `master_po`
--
ALTER TABLE `master_po`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_presensi`
--
ALTER TABLE `master_presensi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_setor`
--
ALTER TABLE `master_setor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `master_transfer_persediaan`
--
ALTER TABLE `master_transfer_persediaan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `merek_barang`
--
ALTER TABLE `merek_barang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `satuan_barang`
--
ALTER TABLE `satuan_barang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `timeline_po`
--
ALTER TABLE `timeline_po`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
