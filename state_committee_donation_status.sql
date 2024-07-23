CREATE OR REPLACE TABLE `stac-labs.wa_sharing.state_committee_donation_status` AS
SELECT 
    s.*, 
    m.person_id, 
    p.myv_van_id, 
    n.VANID,
    CASE 
        WHEN m.person_id IS NULL THEN 'Not matched'
        WHEN n.VANID IS NOT NULL THEN 'Donated'
        ELSE 'Not Donated'
    END AS donation_status
FROM 
    `demsstaclabs.WA_sharing.state_committee_members` s
LEFT JOIN 
    `demsstaclabs.WA_sharing.state_committee_members_matched` m
    ON CAST(m.matchback_id AS INT) = s.matchback_id
LEFT JOIN 
    `democrats.analytics_wa.person` p 
    ON m.person_id = p.person_id
LEFT JOIN 
    `stac-labs.wa_sharing.wa_ngp_export_07_17_24` n
    ON p.myv_van_id = n.VANID;
