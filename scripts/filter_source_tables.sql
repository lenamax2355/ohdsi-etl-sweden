/* Filter from the source tables */

-- Delete rows with dates that are not in the format yyyymmdd or empty
-- e.g. '.', 20030, '   1', '2011-02-' and '2012' are deleted
-- Delete rows without an age
DELETE FROM etl_input.patient_sluten
WHERE indatuma  !~ '\d{8}' OR utdatuma !~ '\d{8}'
   OR indatuma IS NULL     OR utdatuma IS NULL
   OR alder IS NULL
;

DELETE FROM etl_input.patient_oppen
WHERE indatuma  !~ '\d{8}'
   OR indatuma IS NULL
   OR alder IS NULL
;

DELETE FROM etl_input.patient_dag_kiru
WHERE indatuma  !~ '\d{8}'
   OR indatuma IS NULL
   OR alder IS NULL
;

DELETE FROM etl_input.patient_sluten_long
WHERE indatuma  !~ '\d{8}' OR utdatuma !~ '\d{8}'
   OR indatuma IS NULL OR utdatuma IS NULL
   OR alder IS NULL
;

DELETE FROM etl_input.patient_oppen_long
WHERE indatuma  !~ '\d{8}'
   OR indatuma IS NULL
   OR alder IS NULL
;

DELETE FROM etl_input.patient_dag_kiru_long
WHERE indatuma  !~ '\d{8}'
   OR indatuma IS NULL
   OR alder IS NULL
;

-- With drugs this problem not yet arises.
DELETE FROM etl_input.drug
WHERE edatum  !~ '\d{1,2}/\d{1,2}/\d{4}'
   OR alder IS NULL
;
