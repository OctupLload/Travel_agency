create or replace PROCEDURE p_create_all (p_table_name IN VARCHAR) AS
    v_pk_col_name VARCHAR(100);
    v_result CLOB;
    v_text VARCHAR2(1000);
BEGIN
    SELECT column_name 
        INTO v_pk_col_name
    FROM user_tab_columns
    WHERE column_id = 1 AND
          table_name = UPPER(v_table_name);


    EXECUTE IMMEDIATE 'ALTER TABLE '||p_table_name||
                      ' ADD CONSTRAINT PK_'||p_table_name||' PRIMARY KEY('||v_pk_col_name||')';

    EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_'||p_table_name||'
                MINVALUE 1 
                START WITH 1
                INCREMENT BY 1
                CACHE 20';

    DECLARE 
        v_constraint_type VARCHAR(20);
        v_index_name VARCHAR(100);
        v_pk_column VARHCAR(100);
    BEGIN
        SELECT constraint_type, index_name 
            INTO v_constraint_type, v_index_name
        FROM user_constraints 
        WHERE constraint_type = 'P' AND 
              table_name = p_table_name;
        
        SELECT column_name
            INTO v_pk_column
        FROM user_ind_columns
        WHERE index_name = v_index_name;
    
        EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER T_B_'||p_table_name||'
                             BEFORE INSERT 
                                    ON '||p_table_name||'
                                    FOR EACH ROW
                           BEGIN
                                IF :NEW.'||v_pk_column||' IS NULL THEN 
                                    SELECT SEQ_'||p_table_name||'.NEXTVAL
                                        INTO :NEW.'||v_pk_column||'
                                    FROM dual;
                                END IF;
                           END;';
    END; 
    
 
END p_create_all;