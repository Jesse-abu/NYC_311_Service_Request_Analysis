CREATE TABLE nyc311_subset AS
WITH deduplicated_data AS (
    SELECT 
		*,
		ROW_NUMBER() OVER(
            PARTITION BY unique_key 
            ORDER BY created_date DESC
        ) as rn
    FROM "service-requests"
)

SELECT 
    unique_key,
    
    -- Parse Date/Time: SQLite uses datetime() function for ISO-8601 strings
    datetime(created_date) AS created_at,
    datetime(closed_date) AS closed_at,
	datetime(resolution_action_updated_date) AS resolution_date_update,
	
	resolution_description,
    
    -- Handle Invalid Records: Logic for resolution time
    CASE 
        WHEN datetime(closed_date) >= datetime(created_date) 
        THEN julianday(closed_date) - julianday(created_date) 
        ELSE NULL 
    END AS days_to_close,
	agency,
	agency_name,
	complaint_type,
	descriptor,
	location_type,
	incident_zip,
	incident_address,

    -- Clean text fields
    UPPER(TRIM(city)) AS city,
	facility_type,
    status,
	borough,

    -- Perform validation checks (e.g., invalid coordinates)
    latitude,
    longitude,
    CASE 
        WHEN latitude IS NULL OR longitude IS NULL THEN 'Missing'
        -- New York City bounding box validation
        WHEN latitude NOT BETWEEN 40.47 AND 40.92 OR longitude NOT BETWEEN -74.26 AND -73.70 THEN 'Invalid'
        ELSE 'Valid'
    END AS geo_status,
	
	location,
	zip_codes

FROM deduplicated_data
-- Filter for duplicates (rn=1) and ensure mandatory date fields exist
WHERE rn = 1 
  AND created_date IS NOT NULL;