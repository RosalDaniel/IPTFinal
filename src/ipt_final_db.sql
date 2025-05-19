-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2025 at 03:07 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ipt_final_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Marketing', 'marketing test', '2025-05-19 12:58:11', '2025-05-19 12:58:11'),
(2, 'Engineering', 'engineering testtt', '2025-05-19 12:58:27', '2025-05-19 12:58:27'),
(3, 'Human Resource', 'human resource dept', '2025-05-19 12:58:46', '2025-05-19 12:58:46');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `position` varchar(100) NOT NULL,
  `hire_date` date NOT NULL,
  `status` varchar(20) DEFAULT NULL CHECK (`status` in ('Active','Inactive')),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `user_id`, `department_id`, `position`, `hire_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 5, 3, 'Supervisor', '2025-05-19', 'Active', '2025-05-19 12:59:55', '2025-05-19 12:59:55');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(50) DEFAULT NULL CHECK (`type` in ('Leave','Equipment','Resources','Onboarding','Department Transfer')),
  `employee_id` int(11) DEFAULT NULL,
  `employee_email` varchar(255) DEFAULT NULL,
  `items` text NOT NULL,
  `status` varchar(20) DEFAULT NULL CHECK (`status` in ('Pending','Approved','Rejected')),
  `submission_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `type`, `employee_id`, `employee_email`, `items`, `status`, `submission_date`, `last_updated`) VALUES
(1, 'Onboarding', 1, NULL, 'Newly hire', 'Pending', '2025-05-19 12:59:55', '2025-05-19 12:59:55'),
(2, 'Resources', 1, NULL, 'paper (1), pen (1)', 'Pending', '2025-05-19 13:00:30', '2025-05-19 13:00:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(10) DEFAULT NULL CHECK (`title` in ('Mr','Mrs')),
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT NULL CHECK (`role` in ('Admin','User')),
  `status` varchar(20) DEFAULT NULL CHECK (`status` in ('Active','Inactive')),
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `title`, `first_name`, `last_name`, `email`, `role`, `status`, `password_hash`, `created_at`, `updated_at`) VALUES
(1, 'Mr', 'admin', 'admin', 'admin@gmail.com', 'User', 'Active', '$2b$10$R0aZeyaV2Th5MjuAp2SH0OZCKQSE0X32TLTJJowH6ov8VMLOZIqwG', '2025-05-19 12:42:48', '2025-05-19 12:42:48'),
(2, 'Mr', 'henry', 'magsayo', 'henry@gmail.com', 'User', 'Active', '$2b$10$abRKywwIpusRVtYB0F1xb.A2kuarDYscuZtmElzYqJILTQ6008Era', '2025-05-19 12:43:37', '2025-05-19 12:43:37'),
(3, 'Mr', 'jomari', 'marson', 'jomari@gmail.com', 'User', 'Active', '$2b$10$e7ElXKzbG.u9SZg.SsWnVeLt45vQfce2Tw7RGH23zSQJOEJbzeAJG', '2025-05-19 12:43:57', '2025-05-19 12:43:57'),
(4, 'Mr', 'marianne', 'napisa', 'marianne@gmail.com', 'User', 'Active', '$2b$10$7y91WQqEjwfLg4.t/NBFQOPo9rLHrw1/sGLT8KJes/pBuuJQ7MuCa', '2025-05-19 12:44:21', '2025-05-19 12:44:21'),
(5, 'Mrs', 'dhannica', 'rangas', 'dhannica@gmail.com', 'User', 'Active', '$2b$10$X5itli95gWrRMsJ0BhkhAeM4oYIAkTK.iTkqgOxgAIaFhvg8cJjAu', '2025-05-19 12:59:34', '2025-05-19 12:59:34');

-- --------------------------------------------------------

--
-- Table structure for table `workflows`
--

CREATE TABLE `workflows` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `request_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `current_step` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workflows`
--

INSERT INTO `workflows` (`id`, `request_id`, `employee_id`, `current_step`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Initial Onboarding', 'Pending', '2025-05-19 12:59:55', '2025-05-19 12:59:55'),
(2, 2, 1, 'Requesting Resources Approval', 'Pending', '2025-05-19 13:00:30', '2025-05-19 13:00:30'),
(3, NULL, 1, 'Requesting Resources Approval', 'Pending', '2025-05-19 13:00:40', '2025-05-19 13:00:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `workflows`
--
ALTER TABLE `workflows`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `workflows`
--
ALTER TABLE `workflows`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
