CREATE DATABASE SocialMediaAds_DW

USE [SocialMediaAds_DW];
GO


-- =========================== A. TẠO CÁC BẢNG DIM ===========================
-- 1) DIM_time
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_time]') AND TYPE = N'U'
)
BEGIN 
	CREATE TABLE DIM_time (
		time TIME(0) PRIMARY KEY,
		hour INT,
		minute INT,
		second INT,
		time_of_day VARCHAR(100)
	);
	PRINT 'Table DIM_time is created'
END

SELECT * 
FROM [DIM_time]


-- 2) DIM_event_type
IF NOT EXISTS (
	SELECT 1
	from sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_event_type]') AND TYPE = N'U'
)
BEGIN 
	CREATE TABLE DIM_event_type (
		event_type_id INT PRIMARY KEY,
		event_type_name VARCHAR(100) NOT NULL
	);
	PRINT 'Table DIM_event_type is created'
END 
 
SELECT *
FROM [DIM_event_type]


-- 3) DIM_campaign
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_campaign]') AND TYPE = N'U'
)
BEGIN 
	CREATE TABLE DIM_campaign (
		campaign_id INT PRIMARY KEY, 
		name NVARCHAR(255) NOT NULL,
		start_date DATE,
		end_date DATE,
		duration_days INT,
		total_budget DECIMAL(18,2)
	);

	PRINT 'Table DIM_campaign is created' 
END 

SELECT *
FROM [dbo].DIM_campaign

-- 4) DIM_date
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_date]') AND TYPE = N'U'
)
BEGIN 
	CREATE TABLE DIM_date (
		date DATE PRIMARY KEY, 
		day INT NOT NULL,
		month INT,
		quarter INT,
		year INT,
		day_of_week VARCHAR(100)
	);

	PRINT 'Table DIM_date is created' 
END 

SELECT *
FROM [dbo].DIM_date

-- 5) DIM_ad_platform
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_ad_platform]') AND TYPE = N'U'
)
BEGIN 
	CREATE TABLE DIM_ad_platform (
		ad_platform_id INT PRIMARY KEY,
		ad_platform VARCHAR(100)
	);

	PRINT 'Table DIM_ad_platform is created' 
END 

SELECT *
FROM [dbo].DIM_ad_platform

-- 6) DIM_location
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_location]') AND TYPE = N'U'
)
BEGIN
	CREATE TABLE DIM_location (
		location_id INT PRIMARY KEY,
		location_name VARCHAR(100),
	);
	PRINT 'Table DIM_location is created'
END

SELECT *
FROM DIM_location


-- 7) DIM_country
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_country]') AND TYPE = N'U'
)
BEGIN
	CREATE TABLE DIM_country (
		country_id INT PRIMARY KEY,
		country_name VARCHAR(100)
	);

	PRINT 'Table DIM_country is created'
END

SELECT *
FROM DIM_country


-- 8) DIM_ad_type
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_ad_type]') AND TYPE = N'U'
)
BEGIN 
	CREATE TABLE DIM_ad_type (
		ad_type_id INT PRIMARY KEY,
		ad_type VARCHAR(100)
	);

	PRINT 'Table DIM_ad_type is created' 
END 

SELECT *
FROM [dbo].DIM_ad_type


-- =========================== B. TẠO DIM_advertisement ===========================
-- 9) DIM_advertisement
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_advertisement]') AND TYPE = N'U'
)
BEGIN
	CREATE TABLE DIM_advertisement (
		ad_id INT PRIMARY KEY,
		campaign_id INT,
		ad_platform_id INT,
		ad_type_id INT,
		target_gender VARCHAR(100),
		target_age_group VARCHAR(100),
		target_interests VARCHAR(100)
	);

	PRINT 'Table DIM_advertisement is created'
END

SELECT *
FROM DIM_advertisement

-- =========================== C. TẠO DIM_user ===========================
-- 10) DIM_user
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[DIM_user]') AND TYPE = N'U'
)
BEGIN
	CREATE TABLE DIM_user (
		user_id INT PRIMARY KEY,
		user_gender VARCHAR(100),
		user_age INT,
		age_group VARCHAR(100),
		location_id INT,
		country_id INT,
		interests VARCHAR(100)
	);

	PRINT 'Table DIM_user is created'
END

SELECT *
FROM DIM_user


-- =========================== D. TẠO FACT_advertisement_event ===========================
-- 11) FACT_advertisement_event
IF NOT EXISTS (
	SELECT 1
	FROM sys.all_objects
	WHERE object_id = OBJECT_ID(N'[dbo].[FACT_advertisement_event]') AND TYPE = N'U'
)
BEGIN
	CREATE TABLE FACT_advertisement_event (
		event_id INT PRIMARY KEY,
		ad_id INT,
		user_id INT,
		date DATE,
		time TIME(0),
		event_type_id INT
	);
	PRINT 'Table FACT_advertisement_event is created'
END

SELECT *
FROM FACT_advertisement_event


