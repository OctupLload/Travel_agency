CREATE OR REPLACE FUNCTION f_get_ddl_query(p_owner IN VARCHAR2,
                                           p_object_name IN VARCHAR2,
                                           p_object_type IN VARCHAR2 DEFAULT NULL)
                  RETURN CLOB IS
    v_result CLOB;
    v_count INTEGER;
    v_type VARCHAR(50);
    v_similar_err EXCEPTION;
BEGIN
    IF p_object_type IS NULL THEN
        SELECT COUNT(object_name) AS count_dubl
            INTO v_count
        FROM all_objects
        WHERE owner = p_owner AND
              object_name = p_object_name
        GROUP BY object_name;
        
        IF v_count = 1 AND (p_object_type IS NULL) THEN
            SELECT object_type 
            INTO v_type
            FROM all_objects
            WHERE owner = p_owner AND
                  object_name = p_object_name;
        ELSE 
            RAISE v_similar_err;
        END IF;
    ELSE
        v_type:= p_object_type;
    END IF;
    
    CASE v_type
        WHEN 'TABLE' THEN
            DECLARE
                v_table_name VARCHAR(250);
                v_pk_column VARCHAR(150);
                v_column_name VARCHAR(250);
                v_column_type VARCHAR(250);
                v_column_lenght INTEGER;
                v_constr_name VARCHAR(250);
                v_row_count INTEGER;
                CURSOR cur_table IS
                    SELECT table_name, column_name, data_type, data_length
                    FROM all_tab_columns
                    WHERE owner = p_owner AND
                          table_name = p_object_name;
            BEGIN
                SELECT constraint_name
                    INTO v_constr_name
                FROM all_constraints
                WHERE owner = p_owner AND
                    table_name = p_object_name AND
                    constraint_type = 'P';
                          
                SELECT COUNT(column_name)
                    INTO v_row_count
                FROM all_tab_columns
                WHERE owner = p_owner AND
                      table_name = p_object_name;
                    
                SELECT column_name
                    INTO v_pk_column
                FROM all_tab_columns
                WHERE owner = p_owner AND
                      table_name = p_object_name AND
                      column_id = 1;
                          
                v_result:= 'CREATE TABLE '||p_object_name||' ('||chr(10);
                OPEN cur_table;
                    LOOP
                        FETCH cur_table
                            INTO v_table_name, v_column_name, v_column_type, v_column_lenght;
                        EXIT WHEN cur_table%NOTFOUND;
                        IF cur_table%ROWCOUNT < v_row_count THEN
                            v_result:= CONCAT(v_result, chr(9)||v_column_name||chr(9)||v_column_type||
                                                        '('||v_column_lenght||'),'||chr(10));
                        ELSE
                            v_result:= CONCAT(v_result, chr(9)||v_column_name||chr(9)||v_column_type||
                                                    '('||v_column_lenght||')'||chr(10));
                        END IF;
                    END LOOP;
                CLOSE cur_table;
                v_result:= CONCAT(v_result, chr(9)||');'||chr(10)||chr(10));
            
                v_result:= CONCAT(v_result, 'ALTER TABLE '||p_object_name||chr(10)||
                                            'ADD CONSTRAINT '||v_constr_name||
                                            ' UNIQUE('||v_pk_column||')');
                RETURN v_result;
            END;
        WHEN 'INDEX' THEN
            DECLARE 
                v_table_name VARCHAR(250);
                v_uniq_val VARCHAR(250);
                v_column_name VARCHAR(250);
            BEGIN
                SELECT alc.table_name, alc.column_name, ali.uniqueness
                    INTO v_table_name, v_column_name, v_uniq_val
                FROM all_ind_columns alc, all_indexes ali
                WHERE alc.index_name = p_object_name AND
                      alc.index_owner  = p_owner AND
                      ali.owner = p_owner AND
                      ali.index_name = p_object_name;
                      
                IF v_uniq_val = 'UNIQUE' THEN
                    v_result:= 'CREATE INDEX UNIQUE '||p_object_name||chr(10)||
                           chr(9)||'ON '||v_table_name||'('||v_column_name||')';
                    RETURN v_result;
                ELSE 
                    v_result:= 'CREATE INDEX '||p_object_name||chr(10)||
                           chr(9)||'ON '||v_table_name||'('||v_column_name||')';
                    RETURN v_result;
                END IF;
            END;
        WHEN 'SEQUENCE' THEN
            DECLARE 
                v_min_value INTEGER;
                v_start_wh INTEGER;
                v_inc_by INTEGER;
                v_cache INTEGER;
            BEGIN
                SELECT min_value, increment_by, last_number, cache_size
                    INTO v_min_value, v_inc_by, v_start_wh, v_cache
                FROM all_sequences
                WHERE sequence_owner = p_owner AND
                      sequence_name = p_object_name;
                      
                v_result:= 'CREATE SEQUENCE '||p_object_name||chr(10)||
                           chr(9)||'MINVALUE '||v_min_value||chr(10)||
                           chr(9)||'START WITH '||v_start_wh||chr(10)||
                           chr(9)||'INCREMENT BY '||v_inc_by||chr(10)||
                           chr(9)||'CACHE '||v_cache||chr(10)||';';
                RETURN v_result;                   
            END;
        WHEN 'TRIGGER' THEN
            DECLARE
                v_trig_desc VARCHAR2(1000);
                v_trig_body VARCHAR2(1000);
            BEGIN
                SELECT description, trigger_body
                    INTO v_trig_desc, v_trig_body
                FROM all_triggers
                WHERE owner = p_owner AND
                      trigger_name = p_object_name;
                      
                v_result:= CONCAT('CREATE OR REPLACE TRIGGER ', v_trig_desc);
                v_result:= CONCAT(v_result, v_trig_body);
                RETURN v_result;  
            END;
        WHEN 'PACKAGE' THEN
            DECLARE 
                v_pkg_text VARCHAR(1000);
                CURSOR cur_pkg IS
                    SELECT text
                    FROM user_source
                    WHERE type = p_object_type AND
                          name = p_object_name
                    ORDER BY line;
            BEGIN
                OPEN cur_pkg;
                    LOOP
                        FETCH cur_pkg
                            INTO v_pkg_text;
                        EXIT WHEN cur_pkg%NOTFOUND;
                        v_result:= CONCAT(v_result, v_pkg_text);
                    END LOOP;
                CLOSE cur_pkg;
                RETURN v_result;
            END;
        WHEN 'PACKAGE BODY' THEN
            DECLARE 
                v_pkg_text VARCHAR(1000);
                CURSOR cur_pkg IS
                    SELECT text
                    FROM user_source
                    WHERE type = p_object_type AND
                          name = p_object_name
                    ORDER BY line;
            BEGIN
                OPEN cur_pkg;
                    LOOP
                        FETCH cur_pkg
                            INTO v_pkg_text;
                        EXIT WHEN cur_pkg%NOTFOUND;
                        v_result:= CONCAT(v_result, v_pkg_text);
                    END LOOP;
                CLOSE cur_pkg;
                RETURN v_result;
            END;
    END CASE;
EXCEPTION
    WHEN v_similar_err THEN
        DBMS_OUTPUT.put_line(SQLCODE||': There are several objects with the same name. 
        Specify the object type.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(SQLCODE||': '||SQLERRM);
END f_get_ddl_query;
/