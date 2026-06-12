WITH staging AS (
    SELECT *
    FROM {{source('sock_data_marts', 'stg_data')}}
),
 cleaned AS (
    SELECT 
        SOCK_AGE_DAYS,
        CASE WHEN LOWER(sock_type) = 'knee_high' THEN 1 ELSE 0 END AS knee_high_sock,
        CASE WHEN LOWER(sock_type) = 'crew'  THEN 1 ELSE 0 END  AS crew_sock,
        CASE WHEN LOWER(sock_type) = 'no_show'  THEN 1  ELSE 0 END AS no_show_sock,
        COLOR_INTENSITY,
        WASHER_SPIN_RPM,
        WASH_TEMP_C,
        DRYER_LINT_GRAMS,
        CASE 
            WHEN LOWER(LOAD_SIZE) = 'small' THEN 1
            WHEN LOWER(LOAD_SIZE) = 'medium' THEN 2
            WHEN LOWER(LOAD_SIZE) = 'large' THEN 3
            ELSE 1
        END AS LOAD_SIZE,
        CASE 
            WHEN LOWER(PHASE_OF_MOON) = 'new' THEN 1
            WHEN LOWER(PHASE_OF_MOON) = 'half' THEN 2
            WHEN LOWER(PHASE_OF_MOON) = 'full' THEN 3
            WHEN LOWER(PHASE_OF_MOON) = 'crescent' THEN 4
            ELSE null
        END AS PHASE_OF_MOON,
        DESPERATION_INDEX,
        TARGET_VANISHED
    FROM staging
        
 )

SELECT *
FROM cleaned