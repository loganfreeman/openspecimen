LOAD DATA INFILE 'H://caTissue//work//workspace//catissuecoreNew/SQL/DBUpgrade/Common/CAModelCSVs/DYEXTN_TEXTAREA.csv' 
APPEND 
INTO TABLE DYEXTN_TEXTAREA 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(IDENTIFIER NULLIF IDENTIFIER='\\N',TEXTAREA_COLUMNS NULLIF TEXTAREA_COLUMNS='\\N',TEXTAREA_ROWS NULLIF TEXTAREA_ROWS='\\N')