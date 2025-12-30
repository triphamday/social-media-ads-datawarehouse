USE [SocialMediaAds_DW];
GO

--- Check Key 
SELECT fk.name AS foreign_key_name,
       tp.name AS parent_table,
       cp.name AS parent_column,
       tr.name AS referenced_table,
       cr.name AS referenced_column
FROM sys.foreign_keys AS fk
JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables AS tp ON fkc.parent_object_id = tp.object_id
JOIN sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
JOIN sys.tables AS tr ON fkc.referenced_object_id = tr.object_id
JOIN sys.columns AS cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
ORDER BY tp.name, fk.name;


-- Xóa toàn bộ key
USE [SocialMediaAds_DW];
GO

-- Xóa toàn bộ khóa ngoại hiện có
ALTER TABLE DIM_advertisement DROP CONSTRAINT FK_dim_ad_platform;
ALTER TABLE DIM_advertisement DROP CONSTRAINT FK_dim_ad_type;
ALTER TABLE DIM_advertisement DROP CONSTRAINT FK_dim_campaign;
ALTER TABLE DIM_campaign DROP CONSTRAINT FK_dim_campaign_enddate;
ALTER TABLE DIM_campaign DROP CONSTRAINT FK_dim_campaign_startdate;
ALTER TABLE DIM_user DROP CONSTRAINT FK_dim_user_country;
ALTER TABLE DIM_user DROP CONSTRAINT FK_dim_user_location;
ALTER TABLE FACT_advertisement_event DROP CONSTRAINT FK_fact_event_ad;
ALTER TABLE FACT_advertisement_event DROP CONSTRAINT FK_fact_event_date;
ALTER TABLE FACT_advertisement_event DROP CONSTRAINT FK_fact_event_eventtype;
ALTER TABLE FACT_advertisement_event DROP CONSTRAINT FK_fact_event_time;
ALTER TABLE FACT_advertisement_event DROP CONSTRAINT FK_fact_event_user;
GO


