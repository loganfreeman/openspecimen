LOAD DATA INFILE 'H://caTissue//work//workspace//catissuecoreNew/SQL/DBUpgrade/Common/CAModelCSVs/DYEXTN_ATTRIBUTE_RECORD.csv' 
APPEND 
INTO TABLE DYEXTN_ATTRIBUTE_RECORD 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(IDENTIFIER NULLIF IDENTIFIER='\\N',ENTITY_ID NULLIF ENTITY_ID='\\N',ATTRIBUTE_ID NULLIF ATTRIBUTE_ID='\\N',RECORD_ID NULLIF RECORD_ID='\\N')