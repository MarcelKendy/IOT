-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 18, 2022 at 09:00 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iot`
--

-- --------------------------------------------------------

--
-- Table structure for table `batches`
--

DROP TABLE IF EXISTS `batches`;
CREATE TABLE IF NOT EXISTS `batches` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_soil_moisture` decimal(4,2) NOT NULL,
  `culture_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `batch_culture_id_foreign` (`culture_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `batches`
--

INSERT INTO `batches` (`id`, `name`, `location`, `current_soil_moisture`, `culture_id`, `created_at`, `updated_at`) VALUES
(5, 'Lote novo', 'Alto Paranaíba', '16.50', 6, '2022-07-18 20:22:47', '2022-07-18 20:39:54'),
(2, 'Lote 101', 'São Gotardo', '33.00', 2, '2022-07-16 18:17:04', '2022-07-18 20:40:10'),
(3, 'Lote 501', 'Matutina', '22.00', 1, '2022-07-16 23:38:34', '2022-07-18 20:40:01'),
(6, 'Lote B', 'Capelinha', '27.50', 4, '2022-07-18 20:29:43', '2022-07-18 20:40:05'),
(7, 'Lote Teste', 'teste', '16.50', 6, '2022-07-18 20:32:53', '2022-07-18 20:39:55');

-- --------------------------------------------------------

--
-- Table structure for table `cultures`
--

DROP TABLE IF EXISTS `cultures`;
CREATE TABLE IF NOT EXISTS `cultures` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soil_moisture` decimal(4,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cultures`
--

INSERT INTO `cultures` (`id`, `name`, `soil_moisture`, `created_at`, `updated_at`) VALUES
(1, 'Cenoura', '20.00', '2022-07-16 18:18:22', '2022-07-16 18:18:22'),
(2, 'Alho', '30.00', '2022-07-16 18:18:30', '2022-07-16 18:18:30'),
(3, 'Feijão', '24.55', '2022-07-18 16:32:31', '2022-07-18 16:32:31'),
(4, 'Beterraba', '27.00', '2022-07-18 16:33:53', '2022-07-18 16:35:10'),
(6, 'Arroz', '15.00', '2022-07-18 16:37:46', '2022-07-18 16:37:46');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2006_04_19_022736_create_cultures_table', 1),
(2, '2007_04_19_022736_create_batch_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2006_04_19_022736_create_parameters_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
CREATE TABLE IF NOT EXISTS `parameters` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `time_in_seconds` decimal(6,2) NOT NULL,
  `moisture_increase` decimal(4,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parameters`
--

INSERT INTO `parameters` (`id`, `time_in_seconds`, `moisture_increase`, `created_at`, `updated_at`) VALUES
(1, '5.50', '5.50', '2022-07-16 19:40:22', '2022-07-18 20:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
