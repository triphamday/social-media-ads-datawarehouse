USE SocialMediaAds_DW;
GO

SELECT
	F.event_id,
	F.date,
	F.time,

	DIM_advertisement.ad_id,
	DIM_advertisement.target_gender,
	DIM_advertisement.target_age_group,
	DIM_advertisement.target_interests,
	DIM_advertisement.ad_platform_id,
	DIM_advertisement.ad_type_id,
	DIM_advertisement.campaign_id,

	DIM_ad_platform.ad_platform,

	DIM_ad_type.ad_type,

	DIM_campaign.name,
	DIM_campaign.duration_days,
	DIM_campaign.total_budget,

	DIM_date.day,
	DIM_date.month,
	DIM_date.quarter,
	DIM_date.year,
	DIM_date.day_of_week,

	DIM_time.second,
	DIM_time.minute,
	DIM_time.hour,
	DIM_time.time_of_day,

	DIM_user.user_gender,
	DIM_user.user_age,
	DIM_user.age_group,
	DIM_user.location_id,
	DIM_user.country_id,
	DIM_user.interests,

	DIM_event_type.event_type_name,

	DIM_location.location_name,

	DIM_country.country_name

FROM FACT_advertisement_event  F
	INNER JOIN DIM_advertisement DIM_advertisement ON F.ad_id = DIM_advertisement.ad_id
		INNER JOIN DIM_ad_platform ON DIM_ad_platform.ad_platform_id = DIM_advertisement.ad_platform_id
		INNER JOIN DIM_ad_type ON DIM_ad_type.ad_type_id = DIM_advertisement.ad_type_id
		INNER JOIN DIM_campaign ON DIM_campaign.campaign_id = DIM_advertisement.campaign_id
	INNER JOIN DIM_date ON F.date = DIM_date.date
	INNER JOIN DIM_time ON F.time = DIM_time.time
	INNER JOIN DIM_event_type ON F.event_type_id = DIM_event_type.event_type_id
	INNER JOIN DIM_user ON DIM_user.user_id = F.user_id
		INNER JOIN DIM_location ON DIM_location.location_id = DIM_user.location_id
		INNER JOIN DIM_country ON DIM_country.country_id = DIM_user.country_id


-- Remove after
SELECT *
FROM [DIM_ad_platform]

SELECT *
FROM [DIM_ad_type]

SELECT campaign_id, name
FROM [DIM_campaign]

SELECT 
	MIN(location_id) AS MIN_location_id,
	MAX(location_id) AS MAX_location_id
FROM [DIM_location]
