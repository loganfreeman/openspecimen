LOAD DATA INFILE 'H://caTissue//work//workspace//catissuecoreNew/SQL/DBUpgrade/Common/CAModelCSVs/DYEXTN_BYTE_ARRAY_TYPE_INFO.csv' 
APPEND 
INTO TABLE DYEXTN_BYTE_ARRAY_TYPE_INFO 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(IDENTIFIER NULLIF IDENTIFIER='\\N',CONTENT_TYPE NULLIF CONTENT_TYPE='\\N')