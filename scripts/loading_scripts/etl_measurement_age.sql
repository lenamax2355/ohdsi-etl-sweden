/*
For each visit the age is reported. Save the age as observation.
*/

INSERT INTO measurement (
        person_id,
        measurement_concept_id,
        measurement_date,
        measurement_type_concept_id,
        value_as_number,
        measurement_source_value,
        value_source_value,
        unit_concept_id
        -- visit_occurrence_id
    )

SELECT  lpnr,
        4265453 as measurement_concept_id, -- Age
        indate,
        38000280 as measurement_type_concept_id, -- Observation record from EHR
        alder as value_as_number,
        'alder' as measurement_source_value,
        alder as value_source_value,
        9448 as unit_concept_id -- Unit = year
FROM (
    SELECT lpnr, to_date(indatuma::varchar,'yyyymmdd') as indate, alder
    FROM etl_input.patient_sluten

    UNION ALL

    SELECT lpnr, to_date(indatuma::varchar,'yyyymmdd') as indate, alder
    FROM etl_input.patient_oppen

    UNION ALL

    SELECT lpnr, to_date(indatuma::varchar,'yyyymmdd') as indate, alder
    FROM etl_input.patient_dag_kiru

    UNION ALL

    SELECT lpnr, to_date(edatum,'dd/mm/yyyy') as indate, alder
    FROM etl_input.drug

) patient_reg
-- Some dates are null, that is not allowed in OMOP
WHERE indate IS NOT NULL
;
