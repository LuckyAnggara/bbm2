-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2021 at 11:01 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.15

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
  `komponen` varchar(244) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cabang_id` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_akun`
--

INSERT INTO `master_akun` (`id`, `jenis_akun_id`, `kode_akun`, `nama`, `saldo_normal`, `header`, `komponen`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1', '1.0.0', 'ASSET', 'DEBIT', 1, NULL, 0, NULL, NULL, NULL),
(3, '1', '1.1.1', 'KAS', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(4, '1', '1.1.2', 'KAS KECIL', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(5, '1', '1.1.4', 'PIUTANG DAGANG', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(6, '1', '1.1.5', 'PERSEDIAAN DAGANG', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(7, '1', '1.1.6', 'PERLENGKAPAN KANTOR', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(8, '1', '1.1.7', 'SEWA DIBAYAR DIMUKA', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(9, '1', '1.1.8', 'PPN MASUKAN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(11, '1', '1.2.1', 'PERALATAN KANTOR', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(12, '1', '1.2.2', 'AKUMULASI PENYUSUTAN PERALATAN KANTOR', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(13, '1', '1.2.3', 'GEDUNG', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(14, '1', '1.2.4', 'AKUMULASI PENYUSUTAN GEDUNG', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(15, '1', '1.2.5', 'TANAH', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(16, '1', '1.2.6', 'AKUMULASI PENYUSUTAN TANAH', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(17, '1', '1.2.7', 'KENDARAAN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(18, '1', '1.2.8', 'AKUMULASI PENYUSUTAN KENDARAAN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(19, '2', '2.0.0', 'LIABILITIES', 'KREDIT', 1, NULL, 0, NULL, NULL, NULL),
(21, '2', '2.1.1', 'UTANG DAGANG', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(23, '2', '2.2.1', 'UTANG BANK', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(24, '2', '2.2.2', 'UTANG LEASING', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(25, '2', '2.2.3', 'UTANG PIHAK LAINNYA', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(26, '2', '2.3.1', 'PPN KELUARAN', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(27, '3', '3.0.0', 'EKUITAS', 'KREDIT', 1, NULL, 0, NULL, NULL, NULL),
(28, '3', '3.1.0', 'MODAL DI SETOR', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(29, '3', '3.2.0', 'PRIVE', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(30, '3', '3.3.0', 'SALDO LABA', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(31, '4', '4.0.0', 'PENDAPATAN', 'KREDIT', 1, NULL, 0, NULL, NULL, NULL),
(32, '4', '4.1.1', 'PENJUALAN', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(33, '4', '4.1.2', 'PENDAPATAN LAINNYA', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(34, '4', '4.1.3', 'RETUR PENJUALAN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(35, '4', '4.1.4', 'DISKON PENJUALAN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(36, '5', '5.0.0', 'BEBAN', 'DEBIT', 1, NULL, 0, NULL, NULL, NULL),
(39, '5', '5.1.3', 'DISKON PEMBELIAN', 'KREDIT', 0, NULL, 0, NULL, NULL, NULL),
(40, '5', '5.3.1', 'BEBAN GAJI', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(41, '5', '5.4.1', 'BEBAN SEWA', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(42, '5', '5.5.1', 'BEBAN OPERASIONAL', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(43, '5', '5.6.1', 'BEBAN LAIN - LAIN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(44, '5', '5.2.1', 'HARGA POKOK PENJUALAN', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(45, '1', '1.1.3', 'KAS BANK', 'DEBIT', 0, NULL, 0, NULL, NULL, NULL),
(46, '1', '1.1.2-1', 'KAS KECIL KASIR LUCKY ANGGARA', 'DEBIT', 0, '1.1.2', 0, NULL, NULL, NULL),
(47, '5', '5.5.1-1', 'BEBAN OPERASIONAL LISTRIK', 'DEBIT', 0, '5.5.1', 0, '2021-05-23 13:30:49', NULL, NULL),
(48, '5', '5.5.1-2', 'BEBAN OPERASIONAL AIR', 'DEBIT', 0, '5.5.1', 0, '2021-05-23 13:30:49', NULL, NULL),
(49, '5', '5.5.1-3', 'BEBAN OPERASIONAL BENSIN MOBIL', 'DEBIT', 0, '5.5.1', 1, '2021-05-23 13:30:49', NULL, NULL),
(51, '1', '1.1.3-1', 'BANK BCA - 123123123', 'DEBIT', 1, '1.1.3', 0, NULL, NULL, NULL);

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
(1, '2106161', '2106161', '51', 5000, 'DEBIT', 'TRANSFER DOWN PAYMENT PENJUALAN NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-15 20:42:02', '2021-06-16 08:42:02', NULL),
(2, '2106161', '2106161', '5', 45000, 'DEBIT', 'PIUTANG PENJUALAN NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-15 20:42:02', '2021-06-16 08:42:02', NULL),
(3, '2106161', '2106161', '32', 50000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-15 20:42:02', '2021-06-16 08:42:02', NULL),
(4, '2106161', '2106161', '44', 25000, 'DEBIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-15 20:42:02', '2021-06-16 08:42:02', NULL),
(5, '2106161', '2106161', '6', 25000, 'KREDIT', 'PENJUALAN NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-15 20:42:02', '2021-06-16 08:42:02', NULL),
(6, '2106162', '2106162', '46', 10000, 'DEBIT', 'KAS MASUK PEMBAYARAN PIUTANG NOMOR TRANSAKSI BBM-160621-1', 1, 1, '2021-06-15 20:45:17', '2021-06-16 08:45:17', NULL),
(7, '2106162', '2106162', '5', 10000, 'KREDIT', 'PEMBAYARAN PIUTANG NOMOR TRANSAKSI BBM-160621-1', 1, 1, '2021-06-15 20:45:17', '2021-06-16 08:45:17', NULL);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `master_beban`
--
ALTER TABLE `master_beban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_jurnal`
--
ALTER TABLE `master_jurnal`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  `gudang_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `harga_beli` double NOT NULL,
  `rak` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis` enum('FIFO','AVERAGE','','') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'FIFO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id`, `kode_barang`, `nama`, `jenis_id`, `merek_id`, `gudang_id`, `harga_beli`, `rak`, `jenis`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'S00001', 'Spandek 6 Meter', '2', '1', '1', 2000, '', 'FIFO', '2021-03-02 04:28:34', '2021-03-12 04:09:59', NULL),
(2, 'B00002', 'Batu', '1', '1', '1', 0, '', 'FIFO', '2021-03-08 02:01:18', '2021-03-12 04:11:23', '2021-03-12 04:11:23'),
(3, 'B00003', 'Batu', '1', '1', '1', 0, '', 'FIFO', '2021-03-08 02:02:10', '2021-03-12 04:12:30', '2021-03-12 04:12:30'),
(4, 'E00004', 'Emir', '2', '1', '1', 0, '', 'FIFO', '2021-03-08 05:00:35', '2021-03-12 04:06:28', '2021-03-12 04:06:28'),
(5, '100005', '123123', '1', '1', '1', 0, '', 'FIFO', '2021-03-09 17:24:40', '2021-03-10 01:36:41', '2021-03-10 01:36:41'),
(6, 'a00006', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-09 17:54:16', '2021-03-12 04:12:41', '2021-03-12 04:12:41'),
(7, 'B00007', 'Beton', '1', '1', '1', 0, '', 'FIFO', '2021-03-09 21:31:40', '2021-03-12 04:12:25', '2021-03-12 04:12:25'),
(8, 'X00008', 'xzczxcz', '2', '1', '1', 5000, '', 'FIFO', '2021-03-09 21:45:58', '2021-03-09 21:45:58', NULL),
(9, '100009', '123', '1', '1', '1', 2000, '', 'FIFO', '2021-03-09 21:56:49', '2021-03-09 21:56:49', NULL),
(10, 'A00010', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-09 22:17:39', '2021-03-12 04:12:28', '2021-03-12 04:12:28'),
(11, 'Y00011', 'YOYOYO', '2', '2', '1', 0, '', 'FIFO', '2021-03-11 22:23:46', '2021-03-12 04:12:52', '2021-03-12 04:12:52'),
(12, 'B00012', 'BATOK', '2', '2', '1', 0, '', 'FIFO', '2021-03-11 22:25:32', '2021-03-11 22:25:32', NULL),
(13, 'S00013', 'sadasd', '2', '1', '1', 0, '', 'FIFO', '2021-03-11 22:27:39', '2021-03-11 22:27:39', NULL),
(14, 'D00014', 'da', '3', '2', '1', 0, '', 'FIFO', '2021-03-12 02:02:35', '2021-03-12 02:02:35', NULL),
(15, 'A00015', 'aku', '2', '2', '1', 0, '', 'FIFO', '2021-03-12 02:06:53', '2021-03-12 02:06:53', NULL),
(16, 'L00016', 'lukiki', '2', '2', '1', 0, '', 'FIFO', '2021-03-12 02:09:09', '2021-03-12 02:09:09', NULL),
(17, 'L00017', 'lulu', '2', '2', '1', 0, '', 'FIFO', '2021-03-12 02:09:29', '2021-03-12 02:09:29', NULL),
(18, 'I00018', 'in', '2', '2', '1', 0, '', 'FIFO', '2021-03-12 02:11:33', '2021-03-12 02:11:33', NULL),
(19, 'D00019', 'David', '1', '3', '1', 0, '', 'FIFO', '2021-03-12 03:44:18', '2021-03-12 03:44:18', NULL),
(20, 'A00020', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:46:34', '2021-03-12 04:12:32', '2021-03-12 04:12:32'),
(21, 'A00021', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:46:36', '2021-03-12 03:46:36', NULL),
(22, 'A00022', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:46:38', '2021-03-12 03:46:38', NULL),
(23, 'A00023', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:46:38', '2021-03-12 03:46:38', NULL),
(24, 'A00024', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:46:46', '2021-03-12 03:46:46', NULL),
(25, 'A00025', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:47:39', '2021-03-12 03:47:39', NULL),
(26, 'A00026', 'asdasd', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:47:49', '2021-03-12 03:47:49', NULL),
(27, 'B00027', 'BESI BETON', '1', '1', '1', 0, '', 'FIFO', '2021-03-12 03:57:24', '2021-03-12 04:12:48', '2021-03-12 04:12:48'),
(28, 'D00027', 'Detik', '1', '1', '2', 0, 'BA-1', 'FIFO', '2021-03-12 14:44:35', '2021-03-12 14:44:35', NULL),
(29, 'B00029', 'Botak', '1', '2', '2', 0, 'asdasd', 'FIFO', '2021-03-12 14:48:49', '2021-03-12 14:48:49', NULL),
(30, 'B00030', 'Botak', '1', '2', '2', 0, 'asdasd', 'FIFO', '2021-03-12 14:49:10', '2021-03-12 14:49:54', '2021-03-12 14:49:54'),
(31, 'J00030', 'Jakarta', '3', NULL, '3', 0, NULL, 'FIFO', '2021-03-12 14:57:48', '2021-03-12 14:57:48', NULL),
(32, 'J00032', 'Jakarta', '3', '2', '3', 0, 'asdasd', 'FIFO', '2021-03-12 14:57:54', '2021-03-12 14:57:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_opname`
--

CREATE TABLE `detail_opname` (
  `id` int(11) NOT NULL,
  `master_opname_id` int(11) NOT NULL,
  `master_barang_id` int(11) NOT NULL,
  `jumlah_tercatat` double NOT NULL,
  `jumlah_fisik` double NOT NULL,
  `perbedaan` double NOT NULL,
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
  `penjualan_id` varchar(255) DEFAULT NULL,
  `pembelian_id` varchar(255) DEFAULT NULL,
  `nominal` double NOT NULL DEFAULT 0,
  `cara_pembayaran` enum('TUNAI','TRANSFER','','') NOT NULL,
  `catatan` text DEFAULT NULL,
  `nomor_jurnal` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `cabang_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_pembayaran`
--

INSERT INTO `detail_pembayaran` (`id`, `penjualan_id`, `pembelian_id`, `nominal`, `cara_pembayaran`, `catatan`, `nomor_jurnal`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1', NULL, 5000, 'TRANSFER', 'PEMBAYARAN DOWN PAYMENT', '2106161', '1', '1', '2021-06-16 08:42:02', '2021-06-16 08:42:02', NULL),
(2, '1', NULL, 10000, 'TUNAI', 'asdasdasd', '2106162', '1', '1', '2021-06-15 17:00:00', '2021-06-16 08:45:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `master_pembelian_id` bigint(20) NOT NULL,
  `kode_barang_id` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `diskon` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `master_penjualan_id` bigint(20) NOT NULL,
  `kode_barang_id` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `diskon` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id`, `master_penjualan_id`, `kode_barang_id`, `jumlah`, `harga`, `diskon`, `total`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'X00008', 5, 10000, 0, 50000, '2021-06-16 08:42:02', '2021-06-16 08:42:02', NULL);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gudang`
--

INSERT INTO `gudang` (`id`, `nama`, `alamat`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Tidak di tentukan', '', NULL, NULL, NULL),
(2, 'Gudang Bandung', 'Bandung', NULL, NULL, NULL),
(3, 'Jakarta', 'asdasd', '2021-03-12 14:57:23', '2021-03-12 14:57:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `harga_jual`
--

CREATE TABLE `harga_jual` (
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
-- Dumping data for table `harga_jual`
--

INSERT INTO `harga_jual` (`id`, `kode_barang`, `satuan_id`, `harga`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'S00013', '3', '2000', 'sadad', '2021-03-11 22:27:39', '2021-03-11 22:27:39', NULL),
(2, 'S00013', '1', '1000', NULL, '2021-03-11 22:27:39', '2021-03-11 22:27:39', NULL),
(3, 'a00006', '1', '100000', NULL, '2021-03-11 23:51:11', '2021-03-11 23:51:11', NULL),
(5, 'B00007', '2', '10000', 'fhdh', '2021-03-12 00:01:41', '2021-03-12 00:01:41', NULL),
(6, 'B00007', '1', '10000', 'dfgdgf', '2021-03-12 00:05:19', '2021-03-12 00:05:19', NULL),
(7, 'B00007', '2', '5000', 'sdfsf', '2021-03-12 00:06:09', '2021-03-12 00:06:09', NULL),
(8, 'B00007', '3', '10000', 'asdasd', '2021-03-12 00:06:37', '2021-03-12 00:06:37', NULL),
(9, 'B00007', '1', '10000', 'safas', '2021-03-12 00:46:13', '2021-03-12 00:46:13', NULL),
(10, 'B00007', '2', '1000', 'dfsdff', '2021-03-12 00:46:33', '2021-03-12 00:46:33', NULL),
(11, 'B00003', '2', '10000', 'sadasda', '2021-03-12 00:48:47', '2021-03-12 00:48:47', NULL),
(13, 'a00006', '2', '10000', '345wer', '2021-03-12 02:37:14', '2021-03-12 02:37:14', NULL),
(15, 'S00001', '2', '100000', 'gbgbg', '2021-03-12 02:49:37', '2021-03-12 02:49:37', NULL),
(16, 'D00019', '2', '200000', 'asdasd', '2021-03-12 03:44:18', '2021-03-12 03:44:18', NULL),
(17, 'D00019', '3', '50000', 'asdasd', '2021-03-12 03:44:18', '2021-03-12 03:44:18', NULL),
(18, 'B00027', '2', '17500', 'asdasd', '2021-03-12 03:57:58', '2021-03-12 03:57:58', NULL),
(19, 'X00008', '1', '10000', 'dgdfgdfg', '2021-03-12 14:10:30', '2021-03-12 14:10:30', NULL),
(20, 'X00008', '2', '5000', 'vnvnvbn', '2021-03-12 14:11:21', '2021-03-12 14:11:21', NULL),
(21, 'D00027', '1', '10000', 'sadasdasdasd', '2021-03-12 14:44:35', '2021-03-12 14:44:35', NULL),
(22, 'B00029', '2', '10000', 'sdadasd', '2021-03-12 14:48:49', '2021-03-12 14:48:49', NULL),
(23, 'B00030', '2', '10000', 'sdadasd', '2021-03-12 14:49:10', '2021-03-12 14:49:10', NULL),
(24, 'X00008', '3', '100000', 'fghfgh', '2021-03-12 21:19:56', '2021-03-12 21:19:56', NULL);

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
(3, 'asf', '2021-03-11 19:41:58', '2021-03-11 19:41:58', NULL),
(4, 'BBM Trust', '2021-03-11 19:49:35', '2021-03-11 19:49:35', NULL),
(5, 'asdasd', '2021-03-11 19:50:54', '2021-03-11 19:50:54', NULL),
(6, 'asdasd', '2021-03-11 19:52:43', '2021-03-11 19:52:43', NULL),
(7, 'Bahan Bahan', '2021-03-11 20:04:02', '2021-03-11 20:04:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kartu_persediaan`
--

CREATE TABLE `kartu_persediaan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_transaksi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `master_barang_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis` enum('DEBIT','KREDIT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEBIT',
  `jumlah` double NOT NULL DEFAULT 0,
  `harga` double NOT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `cabang_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kartu_persediaan`
--

INSERT INTO `kartu_persediaan` (`id`, `nomor_transaksi`, `master_barang_id`, `jenis`, `jumlah`, `harga`, `catatan`, `user_id`, `cabang_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'BBM-160621-1', '8', 'KREDIT', 5, 5000, 'PENJUALAN BARANG NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-16 08:42:02', '2021-06-16 08:42:02', NULL),
(3, 'BBM-160621-1', '8', 'DEBIT', 5, 5000, 'RETUR PENJUALAN BARANG NOMOR TRANSAKSI #BBM-160621-1', 1, 1, '2021-06-15 20:59:39', '2021-06-16 08:42:02', NULL);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_bank`
--

INSERT INTO `master_bank` (`id`, `nomor_rekening`, `nama_bank`, `kode_akun_id`, `catatan`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '129084091840', 'BCA', '51', 'sadasd', NULL, NULL, NULL);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_cabang`
--

INSERT INTO `master_cabang` (`id`, `kode_cabang`, `nama`, `alamat`, `nomor_telepon`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'BBM001', 'BBM Limbangan (Pusat)', 'JL Raya Limbangan ', '123123123', '2021-04-29 15:51:14', '2021-04-29 15:51:14', NULL),
(2, 'BBM002', 'BBM Kadungora', 'Jl Raya Kadungora', 'xzczxc', '2021-04-29 15:51:47', '2021-04-29 15:51:47', NULL),
(3, 'BBM003', 'BBM Wado', 'Jl Raya Wado', '123123', '2021-04-29 15:51:47', '2021-04-29 15:51:47', NULL);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_kontak`
--

INSERT INTO `master_kontak` (`id`, `nama`, `tipe`, `telepon`, `identitas`, `email`, `info_lain`, `nama_perusahaan`, `npwp`, `alamat`, `akun_piutang_id`, `akun_utang_id`, `wic`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Lucky Anggara', 'PELANGGAN', 82116562811, NULL, NULL, NULL, NULL, NULL, 'Jl Kp Pasir Honje Nomor 37 RT 03 RW 14\r\nBandung\r\nJawa Barat', NULL, NULL, 0, NULL, NULL, NULL),
(2, 'Desi Evilia', 'SUPPLIER', 123123, NULL, NULL, NULL, NULL, NULL, 'Jl Kp Pasir Honje Nomor 37 RT 03 RW 14\r\nBandung\r\nJawa Barat', NULL, NULL, 0, NULL, NULL, NULL),
(3, 'Indah', 'PELANGGAN', 123123, NULL, NULL, NULL, NULL, NULL, 'asdasda', NULL, NULL, 1, '2021-04-12 23:56:46', '2021-04-12 23:56:46', NULL),
(4, 'yora', 'PELANGGAN', NULL, NULL, NULL, NULL, NULL, NULL, 'asdasd', NULL, NULL, 1, '2021-04-14 21:03:54', '2021-04-14 21:03:54', NULL),
(5, 'asdasd', 'PELANGGAN', 23123, NULL, NULL, NULL, NULL, NULL, 'asdasd', NULL, NULL, 1, '2021-04-14 21:04:08', '2021-04-14 21:04:08', NULL),
(6, 'asdas', 'PELANGGAN', NULL, NULL, NULL, NULL, NULL, NULL, 'asdas', NULL, NULL, 1, '2021-04-14 21:04:22', '2021-04-14 21:04:22', NULL),
(7, 'aaaaaaa', 'PELANGGAN', 124124, NULL, NULL, NULL, NULL, NULL, 'aaaa', NULL, NULL, 1, '2021-04-14 21:04:53', '2021-04-14 21:04:53', NULL),
(8, 'dddddddd', 'PELANGGAN', NULL, NULL, NULL, NULL, NULL, NULL, 'dddasd', NULL, NULL, 1, '2021-04-14 21:39:15', '2021-04-14 21:39:15', NULL),
(9, 'david', 'PELANGGAN', 123123, NULL, NULL, NULL, NULL, NULL, 'asdasdasd', NULL, NULL, 0, '2021-04-21 21:07:13', '2021-04-21 21:07:13', NULL),
(10, 'Ivan', 'SUPPLIER', 123123, NULL, NULL, NULL, NULL, NULL, 'asdasd', NULL, NULL, 0, '2021-04-25 23:49:36', '2021-04-25 23:49:36', NULL),
(11, 'Paron', 'SUPPLIER', 123123, NULL, NULL, NULL, NULL, NULL, 'Jakarta', NULL, NULL, 0, '2021-04-25 23:50:45', '2021-04-25 23:50:45', NULL),
(12, 'Paron', 'SUPPLIER', 123123, NULL, NULL, NULL, NULL, NULL, 'Jakarta', NULL, NULL, 0, '2021-04-25 23:50:46', '2021-04-25 23:50:46', NULL),
(13, 'Paron2', 'SUPPLIER', 123123, NULL, NULL, NULL, NULL, NULL, 'asdasd', NULL, NULL, 0, '2021-04-25 23:51:19', '2021-04-25 23:51:19', NULL),
(14, 'asdasd', 'PELANGGAN', 123123, NULL, NULL, NULL, NULL, NULL, 'asdasd', NULL, NULL, 1, '2021-05-05 09:59:11', '2021-05-05 09:59:11', NULL);

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
  `user_id` int(11) DEFAULT NULL,
  `cabang_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, '3205385412020000', 'NURLELA', 'PEREMPUAN', 'Kp.Banen RT01/RW 11 ', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '2002-12-14', '2020-01-01', 'SMP', '085524742774', NULL, NULL, 0, 45000, 10000, 'default.jpg', 1, '1', 0, 2, '2021-05-27 00:05:25', NULL, NULL),
(2, '3205385711990001', 'ASRI NOVIYANTI', 'PEREMPUAN', 'Kp.Ciseureuh RT01/RW14 ', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1999-11-17', '2020-01-01', 'SMA', '083862098237', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '7', 0, 1, '2021-05-27 00:05:25', NULL, NULL),
(3, '3205124505940001', 'SITI NURAENI', 'PEREMPUAN', 'Kp.Wedasari RT05/RW04', 'Mekarsari', 'Cibatu', 'Garut', '1994-05-05', '2020-01-01', 'SMP', '082295499430', NULL, NULL, 1, 66000, 10000, 'default.jpg', 1, '15', 0, 1, '2021-05-27 00:05:25', NULL, NULL),
(4, '3671071311910004', 'ASEP SUPRIATNA', 'LAKI - LAKI', 'Kp.Wedasari RT01/RW04 ', 'Mekarsari', 'Cibatu', 'Garut', '1991-11-13', '2020-01-01', 'SMA', '082310193408', NULL, NULL, 0, 70000, 10000, 'default.jpg', 1, '3', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(5, '332916170190004', 'FADLI', 'LAKI - LAKI', 'Kp.Sasak Beusi RT04/RW11', 'Sindang Suka', 'Cibatu', 'Garut', '1990-01-17', '2020-01-01', 'SMP', '089636039353', NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(6, '3205401502830001', 'PAK USMAN', 'LAKI - LAKI', 'Kp.Lembur Kulon RT02/RW02', 'Cipareaun', 'Cibiuk', 'Garut', '1963-02-15', '2020-01-01', 'SMA', NULL, NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '1', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(7, NULL, 'HERI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(8, '3205122210910001', 'USEP SOPANDI', 'LAKI - LAKI', 'Kp.Kopeng RT03/RW01 ', 'Sindang Suka', 'Cibatu', 'Garut', '1991-10-22', '2020-01-01', 'SMP', NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(9, '3205380506860001', 'YADI SURYADI', 'LAKI - LAKI', 'Kp.Cangkudu RT02/RW01', 'Galihpakuwon', 'BL. Limbangan', 'Garut', '1979-04-08', '2020-01-01', 'SD', '082317205594', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(10, '3205120205750002', 'ENANG PARDINA', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10 ', 'Mekarsari', 'Cibatu', 'Garut', '1975-02-05', '2020-01-01', 'SD', NULL, NULL, NULL, 0, 55000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(11, '1971040510690001', 'SYARIP', 'LAKI - LAKI', 'Kp.Kopeng RT02/RW01', 'Sindang Suka', 'Cibatu', 'Garut', '1969-05-10', '2020-01-01', 'SD', '085383297672', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(12, '3205120808720001', 'AGUS SUDRAJAT', 'LAKI - LAKI', 'Kp.Cipacing Hilir RT01/RW02 ', 'Mekarsari', 'Cibatu', 'Garut', '1972-07-15', '2020-01-01', 'SMP', '082315038766', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(13, '3204050101650082', 'NANA SUMEGA', 'LAKI - LAKI', 'Kp.Tagog Wetan RT03/RW04 ', 'Cangkudu', 'BL. Limbangan', 'Garut', '1965-01-01', '2020-01-01', 'SD', '082149467379', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(14, '3207341008800004', 'ENDE HAMDAN', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1980-10-08', '2020-01-01', 'SMP', '083825534209', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(15, NULL, 'MANG JAJA', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(16, '3205380111930001', 'CECEP KURNIAWAN', 'LAKI - LAKI', 'Kp.Sasak Beusi RT02/RW11', 'Sindang Suka', 'Cibatu', 'Garut', '1992-12-08', '2020-01-01', 'SMA', '085721638437', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '1', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(17, '3205120202830003', 'MASNEN', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt01.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1983-02-02', '2020-01-01', 'SD', '089603740487', NULL, NULL, 0, 55000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(18, '1971043006810004', 'ASEP SUBARJAH', 'LAKI - LAKI', 'Kp.Cigalumpit RT01/RW10', 'Sindang Suka', 'Cibatu', 'Garut', '1981-06-30', '2020-01-01', 'SD', '089603740487', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(19, '3205122205910001', 'RUHIAT ARDIANSYAH', 'LAKI - LAKI', 'Kp.Cipeujeuh RT01/RW06', 'Sukemarang', 'Kersamanah', 'Garut', '1991-05-22', '2020-01-01', 'SMP', '088247093509', NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(20, '1971041401990002', 'FAISAL RAMDAN', 'LAKI - LAKI', 'Kp.Kopeng RT02/RW01', 'Sindang Suka', 'Cibatu', 'Garut', '1999-01-14', '2020-01-01', 'SMA', '082119230932', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(21, '3205121401980004', 'ARIYANTO', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt01.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1998-01-14', '2020-01-01', 'SMP', '083861568665', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(22, '3205120505010003', 'ADI SAPUTRA', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt01.RW10', 'Mekarsari', 'Cibatu', 'Garut', '2001-05-05', '2020-01-01', 'SD', '083120459934', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(23, NULL, 'ARIF RUSMANA', 'LAKI - LAKI', 'Kp.Cikelepu RT01/RW07', 'Dunguswiru', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, '082216187889', NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(24, '3205120501930002', 'AGUS RUHIAT', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10 ', 'Mekarsari', 'Cibatu', 'Garut', '1993-05-01', '2020-01-01', 'SD', '089632543495', NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(25, NULL, 'HAMDANI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, '085798201353', NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(26, NULL, 'MANG ACENG', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(27, '3205122803980001', 'DENI RUSTANDI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1998-03-28', '2020-01-01', 'SMP', NULL, NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(28, NULL, 'MANG IIN', 'LAKI - LAKI', 'Kp.Gadog Hilir RT/RW', 'Sindang Suka', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, '081321262451', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(29, '3205140407800010', 'IMAM SARIPUDIN', 'LAKI - LAKI', 'Kp.Cibitung Kulon RT03/RW02', 'Cibunar', 'Malangbong', 'Garut', '1980-04-07', '2020-01-01', 'SMP', '082321433259', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:01:14', NULL, NULL),
(30, NULL, 'MANG MAMAT', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(31, NULL, 'ASEP IRAWAN', 'LAKI - LAKI', 'Kp.Salam', 'Cibunar', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, '08990675737', NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(32, '3205120801840001', 'ANDI ROHENDI', 'LAKI - LAKI', 'Kp.Cicadas Bodas Rt02.RW10', 'Mekarsari', 'Cibatu', 'Garut', '1984-08-01', '2020-01-01', 'SD', NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(33, NULL, 'HERMAN', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(34, NULL, 'RIZKI', 'LAKI - LAKI', 'Kp.Salam', 'Cibunar', 'Cibatu', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(35, NULL, 'A REPI', 'LAKI - LAKI', 'Besi Baja Makmur', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1945-08-17', '2020-01-01', NULL, NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '14', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(36, '3205385903930002', 'ERSAN SUKMAYA', 'LAKI - LAKI', 'Kp.Pulosari RT01/RW0', 'Cijolang', 'BL. Limbangan', 'Garut', '1993-03-19', '2020-01-01', 'SD', NULL, NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(37, NULL, 'ABAH.HOLID', 'LAKI - LAKI', 'Kp.Cikurantung RT09/RW02', 'Cirapuhan', 'Selaawi', 'Garut', '1963-08-08', '2020-01-01', 'SD', NULL, NULL, NULL, 0, 50000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(38, '3205385302950004', 'LINDA AMELIA RAMDANI', 'PEREMPUAN', 'Kp.Banen RT01/RW 11', 'Limbangan Timur', 'BL. Limbangan', 'Garut', '1995-02-13', '2020-01-01', 'SMK', NULL, NULL, NULL, 0, 30000, 10000, 'default.jpg', 1, '6', 0, 1, '2021-05-27 00:05:25', NULL, NULL),
(39, '3205384506970009', 'NENG YULIANTIN', 'LAKI - LAKI', 'KP. WEDA SARI', 'MEKARSARI', 'CIBATU', 'GARUT', '1997-06-05', '2020-06-01', NULL, NULL, NULL, '943769190443000', 0, 0, 0, 'default.jpg', 1, '9', 0, 1, '2021-05-27 00:02:48', NULL, NULL),
(40, '3205121506690003', 'SARWONO', 'LAKI - LAKI', 'KP.BABAKAN LOA RT02/RW03 ', 'CIBATU', 'CIBATU', 'GARUT', '1969-03-06', '2018-01-07', 'SMA', '082315521016', NULL, NULL, 1, 2000000, 40000, 'default.jpg', 1, '5', 0, 1, '2021-05-27 00:01:10', NULL, NULL),
(41, '3273200110860003', 'PURWIDI SAKTI.S.SOS', 'LAKI - LAKI', 'JL KAWALI 3 NO 20 RT05/RW17', 'ANTAPANI', 'ANTAPANI', 'BANDUNG', '1986-01-10', '2020-05-28', 'SARJANA', NULL, NULL, NULL, 1, 1500000, 20000, 'default.jpg', 1, '5', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(42, '00', 'NENG', 'PEREMPUAN', 'KP BATUKARUT LIMBANGAN TIMUR', 'LIMBANGAN', 'BL LIMBANGAN', 'GARUT', '1997-05-06', '2020-06-06', 'SMP', NULL, NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-27 00:05:25', NULL, NULL),
(43, '3205131703730003', 'TETEN', 'LAKI - LAKI', 'KP.BINUANG RT01/RW11', 'KERSAMANAH', 'KERSAMANAH', 'GARUT', '1973-05-03', '2017-01-14', NULL, '081224582086', NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-27 00:02:48', NULL, NULL),
(44, '3205126607990001', 'KAMILA JULIANTI', 'PEREMPUAN', 'KP.WEDASARI RT05/RW04', 'MEKARSARI', 'CIBATU', 'GARUT', '1999-02-07', '2020-06-30', NULL, '083825953726', NULL, NULL, 1, 40000, 10000, 'default.jpg', 1, '6', 0, 1, '2021-05-27 00:05:25', NULL, NULL),
(45, '320512250578003', 'ATEN ARIPIN', 'LAKI - LAKI', 'KP.WEDASARI RT005/RW 004', 'MEKARSARI', 'CIBATU', 'GARUT', '1978-05-25', '2020-06-30', 'SD', '085324884799', 'BCA - 1480980570', '55.485.291.3-443.000', 0, 0, 0, 'default.jpg', 1, '8', 0, 1, '2021-05-26 23:58:52', NULL, NULL),
(46, '3205122012990003', 'RIDWAN RAMDANI SONJAYA', 'LAKI - LAKI', 'KP.PULO RT 004/ RW 001 ', 'SINDANG SUKA', 'CIBATU', 'GARUT', '0199-12-20', '2020-07-03', 'SMP', NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(47, '3205120708020002', 'ALDI JAELANI', 'LAKI - LAKI', 'KP CADAS BODAS RT 002/RW 010', 'MEKARSARI', 'CIBATU', 'GARUT', '2002-08-07', '2020-07-03', NULL, NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:02:48', NULL, NULL),
(48, NULL, 'NCENG SUKMANA', 'LAKI - LAKI', 'KP.CADAS BODAS  RT 001/RW 010\r\n', 'MEKARSARI', 'CIBATU', 'GARUT', '1973-08-05', '2020-07-03', 'SD', NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:03:32', NULL, NULL),
(49, '3204100401810003', 'RURI JANUAR WIJAYA', 'LAKI - LAKI', 'KOMP. MARGAHAYU PERMAI JLN PERMAI 26 NO 7 RT010/ RW 009', 'MEKAR RAHAYU', 'MARGAASIH', 'BANDUNG', '1981-01-04', '2018-02-08', 'SMA', '085694955601', NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-27 00:01:10', NULL, NULL),
(50, '3273052908700002', 'H.WAGIA AGUSDIYANA SE ', 'LAKI - LAKI', 'JL.JATI HANAP RT 004/ RW 010', 'JATIHANDAP', 'MANDALA JATI', 'BANDUNG', '1970-08-29', '2019-12-01', 'SARJANA', '081809252630', NULL, NULL, 1, 0, 0, 'default.jpg', 1, '5', 0, 1, '2021-05-27 00:01:10', NULL, NULL),
(51, '3205121903750001', 'BASIRIN', 'LAKI - LAKI', 'KP.CADAS BODAS RT001/RW010', 'MEKARSARI', 'CIBATU', 'GARUT', '1975-03-19', '2020-07-04', 'SD', NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '4', 0, 1, '2021-05-27 00:02:10', NULL, NULL),
(52, '3205144508010005', 'AJENG WIDI', 'PEREMPUAN', 'KP SUKARESMI, RT02/RW01', 'CIBUNAR', 'MALAMBONG', 'GARUT', '2001-05-08', '2020-08-03', NULL, '085722847834', NULL, NULL, 1, 50000, 10000, 'default.jpg', 1, '6', 0, 1, '2021-05-27 00:05:25', NULL, NULL),
(53, '32051228012123123123', 'LUCKY ANGGARA', 'LAKI - LAKI', 'KP.CADAS BODAS, RT02/RW10 DS.MEKARSARI KEC CIBATU', 'MEKARSARI', 'CIBATU', 'GARUT', '1984-04-04', '2021-01-11', 'SMA', NULL, NULL, NULL, 0, 40000, 10000, 'default.jpg', 1, '16', 0, 1, '2021-05-27 00:02:10', '2021-06-08 22:54:11', NULL),
(56, '123123', 'asd', 'LAKI - LAKI', 'asdasdasd', 'asd', 'asd', 'asd', '2021-06-10', '2021-06-10', NULL, '1231231231', '1233', '12312', 0, 0, 0, '', 1, '1', 0, 1, '2021-06-09 22:27:35', '2021-06-09 22:27:35', NULL);

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
(1, 'BBM-160621-1', '1', 50000, 0, 0, 0, 50000, 'Kredit', 1, 5000, 35000, 'Transfer', '1', '2021-06-16 00:00:00', 'Tidak', '1', NULL, 1, 1, '2106161', '2021-06-16 08:42:02', '2021-06-16 08:59:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_persediaan`
--

CREATE TABLE `master_persediaan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_transaksi` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_transaksi` enum('Penjualan','Pembelian') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Approve','Reject','Retur') COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_presensi`
--

CREATE TABLE `master_presensi` (
  `id` int(11) NOT NULL,
  `pegawai_id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam_masuk` datetime DEFAULT NULL,
  `jam_keluar` datetime DEFAULT NULL,
  `catatan` varchar(255) NOT NULL,
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
(2, 'BBM Trust', '2021-03-11 20:05:32', '2021-03-11 20:05:32', NULL),
(3, 'LUCKY YO', '2021-03-12 03:35:15', '2021-03-12 03:35:15', NULL),
(4, 'DESI YO', '2021-03-12 03:40:35', '2021-03-12 03:40:35', NULL),
(5, 'LULA', '2021-03-12 03:41:55', '2021-03-12 03:41:55', NULL);

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
  `name` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`action`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `satuan_barang`
--

CREATE TABLE `satuan_barang` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `satuan_barang`
--

INSERT INTO `satuan_barang` (`id`, `nama`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Meter', NULL, NULL, NULL),
(2, 'KG', '2021-03-11 22:22:43', '2021-03-11 22:22:43', NULL),
(3, 'Roll', '2021-03-11 22:27:27', '2021-03-11 22:27:27', NULL),
(4, 'CM', '2021-03-12 03:43:34', '2021-03-12 03:43:34', NULL),
(5, 'KILOGRAM', '2021-03-12 03:43:47', '2021-03-12 03:43:47', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ability` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `users` (`id`, `username`, `role`, `ability`, `password`, `remember_token`, `pegawai_id`, `cabang_id`, `kode_akun_id`, `created_at`, `updated_at`) VALUES
(1, 'lucky', 'admin', '[{\"action\" : \"manage\", \"subject\" : \"All\"}]', '123456', NULL, 1, 1, '46', NULL, NULL);

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
-- Indexes for table `harga_jual`
--
ALTER TABLE `harga_jual`
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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_penjualan_nomor_transaksi_unique` (`nomor_transaksi`);

--
-- Indexes for table `master_penjualan`
--
ALTER TABLE `master_penjualan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_penjualan_nomor_transaksi_unique` (`nomor_transaksi`);

--
-- Indexes for table `master_persediaan`
--
ALTER TABLE `master_persediaan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_persediaan_nomor_transaksi_unique` (`nomor_transaksi`);

--
-- Indexes for table `master_presensi`
--
ALTER TABLE `master_presensi`
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `detail_opname`
--
ALTER TABLE `detail_opname`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_pembayaran`
--
ALTER TABLE `detail_pembayaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `detail_piutang`
--
ALTER TABLE `detail_piutang`
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `harga_jual`
--
ALTER TABLE `harga_jual`
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `master_bank`
--
ALTER TABLE `master_bank`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `master_cabang`
--
ALTER TABLE `master_cabang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `master_divisi`
--
ALTER TABLE `master_divisi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `master_jabatan`
--
ALTER TABLE `master_jabatan`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `master_kontak`
--
ALTER TABLE `master_kontak`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `master_opname`
--
ALTER TABLE `master_opname`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_pegawai`
--
ALTER TABLE `master_pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `master_pembelian`
--
ALTER TABLE `master_pembelian`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_penjualan`
--
ALTER TABLE `master_penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `master_persediaan`
--
ALTER TABLE `master_persediaan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_presensi`
--
ALTER TABLE `master_presensi`
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
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `satuan_barang`
--
ALTER TABLE `satuan_barang`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
