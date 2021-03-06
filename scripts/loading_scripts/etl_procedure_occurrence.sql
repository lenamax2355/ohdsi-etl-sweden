/* Procedure occurrence with nomesco codes.
Simple first letter mapping for nomesco chapters.
*/

INSERT INTO procedure_occurrence (
    person_id,
    procedure_concept_id,
    procedure_date,
    procedure_type_concept_id,

    visit_occurrence_id,
    procedure_source_value
)
    SELECT  lpnr,
            CASE WHEN procedure_map.target_concept_id IS NULL
                 THEN 0 -- not mappable
                 ELSE procedure_map.target_concept_id
            END as concept_id,

            CASE WHEN utdatuma IS NULL
                THEN to_date( '19000101', 'yyyymmdd') -- Should not happen
                ELSE to_date( utdatuma::varchar, 'yyyymmdd')
            END as procedure_date,

            CASE WHEN code_type = 'op1'
                THEN 44786630 -- Primary Procedure
                ELSE 44786631 -- Secondary Procedure
            END as procedure_type_concept_id,

            visit_id,
            code as procedure_source_value
    FROM (
        SELECT lpnr, indatuma, utdatuma, code_type, code, visit_id
        FROM etl_input.patient_sluten_long

        UNION ALL

        SELECT lpnr, indatuma, indatuma as utdatuma, code_type, code, visit_id
        FROM etl_input.patient_oppen_long

        UNION ALL

        SELECT lpnr, indatuma, indatuma as utdatuma, code_type, code, visit_id
        FROM etl_input.patient_dag_kiru_long
    ) patient_reg

    LEFT JOIN source_to_concept_map AS procedure_map
        ON patient_reg.code = procedure_map.source_code
        AND procedure_map.source_vocabulary_id = 'KVA-NOMESCO'

    -- Only operation codes
    WHERE code_type like 'op%'
;
