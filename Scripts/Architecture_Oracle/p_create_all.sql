/* ----Description------
Generation code:
    Constraint on line 21 to 22
    Sequence on line 24 to 28
    Trigger on line 30 to 57
    Package/Packag body on line 60 to 350
    Upload Package/Packge body in file on line 330 to 349
*/

create or replace PROCEDURE p_create_all (p_table_name IN VARCHAR) AS
    v_pk_col_name VARCHAR(100);
    v_text VARCHAR2(1000);
BEGIN
    SELECT column_name 
        INTO v_pk_col_name
    FROM user_tab_columns
    WHERE column_id = 1 AND
          table_name = UPPER(p_table_name);


--    EXECUTE IMMEDIATE 'ALTER TABLE '||p_table_name||
--                      ' ADD CONSTRAINT PK_'||p_table_name||' PRIMARY KEY('||v_pk_col_name||')';
--
--    EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_'||p_table_name||'
--                MINVALUE 1 
--                START WITH 1
--                INCREMENT BY 1
--                CACHE 20';
--
--    DECLARE 
--        v_constraint_type VARCHAR(20);
--        v_index_name VARCHAR(100);
--        v_pk_column VARCHAR(100);
--    BEGIN
--        SELECT constraint_type, index_name 
--            INTO v_constraint_type, v_index_name
--        FROM user_constraints 
--        WHERE constraint_type = 'P' AND 
--              table_name = p_table_name;
--        
--        SELECT column_name
--            INTO v_pk_column
--        FROM user_ind_columns
--        WHERE index_name = v_index_name;
--    
--        EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER T_B_'||p_table_name||'
--                             BEFORE INSERT 
--                                    ON '||p_table_name||'
--                                    FOR EACH ROW
--                           BEGIN
--                                IF :NEW.'||v_pk_column||' IS NULL THEN 
--                                    SELECT SEQ_'||p_table_name||'.NEXTVAL
--                                        INTO :NEW.'||v_pk_column||'
--                                    FROM dual;
--                                END IF;
--                           END;';
--    END; 
        
    --Block to generate CRUD package for table
    DECLARE 
        v_col_name VARCHAR(100);
        v_create_text_parm VARCHAR2(1000);
        v_read_text_parm VARCHAR2(1000);
        v_update_text_parm VARCHAR2(1000);
        v_delete_text_parm VARCHAR2(1000);
        v_create_text_body VARCHAR2(1000);
        v_read_text_body VARCHAR2(1000);
        v_update_text_body VARCHAR2(1000);
        v_delete_text_body VARCHAR2(1000);
        v_query_text_parm VARCHAR2(500);
        v_query_text_arg VARCHAR2(500);
        v_varbls VARCHAR2(500);
        v_count_col INTEGER;
        v_four_tab VARCHAR(100):= chr(9)||chr(9)||chr(9)||chr(9);
        v_head_result CLOB;
        v_body_result CLOB;
        v_all_result CLOB;
        CURSOR cur_get_col_name IS 
            SELECT column_name FROM user_tab_columns
            where table_name = p_table_name AND 
                  column_id != '1'
            ORDER BY column_id;
    BEGIN
        SELECT COUNT(*)
            INTO v_count_col
        FROM user_tab_columns
        WHERE table_name = p_table_name AND 
              column_id != 1;
        
        v_head_result := 'CREATE OR REPLACE PACKAGE PKG_'||p_table_name||' AS'||chr(10);
        v_create_text_parm:= chr(9)||chr(9)||'PROCEDURE p_create(';
        v_read_text_parm:=  chr(9)||chr(9)||'PROCEDURE p_read;'||chr(10);
        v_update_text_parm:= chr(9)||chr(9)||'PROCEDURE p_update(P_'||v_pk_col_name||' IN '||
                                                     p_table_name||'.'||
                                                     v_pk_col_name||'%TYPE,'||chr(10);
        v_delete_text_parm:= chr(9)||chr(9)||'PROCEDURE p_delete(P_'||
                                              v_pk_col_name||' IN '||
                                              p_table_name||'.'||v_pk_col_name||'%TYPE);'||chr(10)||
                    'END PKG_'||p_table_name||';'||chr(10)||
                    '/'||chr(10);
                                                     
        OPEN cur_get_col_name;   
            LOOP
                FETCH cur_get_col_name
                    INTO v_col_name;
                    EXIT WHEN cur_get_col_name%NOTFOUND;
                    IF cur_get_col_name%ROWCOUNT < v_count_col THEN
                        v_create_text_parm:= v_create_text_parm||'P_NEW_'||v_col_name||' IN '||
                                              p_table_name||'.'||v_col_name||'%TYPE,'||chr(10);
                        v_update_text_parm:= v_update_text_parm||v_four_tab||'P_NEW_'||v_col_name||' IN '||
                                              p_table_name||'.'||v_col_name||'%TYPE,'||chr(10);
                    ELSE 
                        v_create_text_parm:= v_create_text_parm||v_four_tab||'P_NEW_'||v_col_name||' IN '||
                                              p_table_name||'.'||v_col_name||'%TYPE);'||chr(10);
                        v_update_text_parm:= v_update_text_parm||v_four_tab||
                                             'P_NEW_'||v_col_name||' IN '||
                                              p_table_name||'.'||v_col_name||'%TYPE);'||chr(10);
                    END IF;
            END LOOP;
        CLOSE cur_get_col_name;
        v_head_result:= v_head_result||v_create_text_parm||v_read_text_parm||
                   v_update_text_parm||v_delete_text_parm;
        
        v_body_result:= 'CREATE OR REPLACE PACKAGE BODY PKG_'||p_table_name||' AS'||chr(10);
        v_create_text_body:= TRIM(TRAILING ';' FROM TRIM(TRAILING chr(10) FROM v_create_text_parm))||chr(10)||
                             chr(9)||chr(9)||chr(9)||'IS'||chr(10)||
                             chr(9)||chr(9)||'null_err EXCEPTION;'||chr(10)||
                             chr(9)||'BEGIN'||chr(10)||chr(9);
            IF v_count_col = 1 THEN
                SELECT column_name 
                    INTO v_col_name
                FROM user_tab_columns
                WHERE table_name = p_table_name AND 
                      column_id != '1';
                      
                v_create_text_body:= TRIM(both chr(9) FROM v_create_text_body)||chr(9)||
                    'IF P_NEW_'||v_col_name||' IS NOT NULL THEN'||chr(10)||
                     chr(9)||chr(9)||'INSERT INTO '||p_table_name||'('||v_col_name||')'||chr(10)||
                     chr(9)||chr(9)||chr(9)||'VALUES(P_NEW_'||v_col_name||');';
            ELSE 
                v_create_text_body:= v_create_text_body ||
                            'IF (';
                v_query_text_parm:= 'INSERT INTO (';
                v_query_text_arg:= ' VALUES (';
                OPEN cur_get_col_name;
                    LOOP
                        FETCH cur_get_col_name
                            INTO v_col_name;
                        EXIT WHEN cur_get_col_name%NOTFOUND;
                        IF cur_get_col_name%ROWCOUNT < v_count_col THEN 
                            v_create_text_body:= v_create_text_body||
                            'P_NEW_'||v_col_name||' IS NOT NULL AND'||chr(10);
                            v_query_text_parm:= v_query_text_parm||' '||v_col_name||', ';
                            v_query_text_arg:= v_query_text_arg||'P_NEW_'||v_col_name||', ';
                        ELSE 
                            v_create_text_body:= v_create_text_body||
                            'P_NEW_'||v_col_name||' IS NOT NULL) THEN '||chr(10);
                            v_query_text_parm:= v_query_text_parm||' '||v_col_name||')';
                            v_query_text_arg:= v_query_text_arg||'P_NEW_'||v_col_name||');';
                        END IF;
                    END LOOP;
                CLOSE cur_get_col_name;
            END IF;
        v_create_text_body:= v_create_text_body||v_query_text_parm||chr(10)||
                             v_query_text_arg||chr(10)||
                             'COMMIT;'||chr(10)||
                             'DBMS_OUTPUT.put_line(''0: Record inserted successfully'');'||chr(10)||
                             'ELSE '||chr(10)||
                             'RAISE null_err;'||chr(10)||
                             'END IF;'||chr(10)||
                             'EXCEPTION'||chr(10)||
                             'WHEN null_err THEN'||chr(10)||
                             'DBMS_OUTPUT.put_line(''The value is NULL. Enter the correct value'');'||chr(10)||
                             'WHEN OTHERS THEN'||chr(10)||
                             'DBMS_OUTPUT.put_line(SQLCODE || '' : '' || SQLERRM);'||chr(10)||
                             'END p_create;'||chr(10);
                             
        v_read_text_body:= TRIM(TRAILING ';' FROM TRIM(TRAILING chr(10) FROM v_read_text_parm))||chr(10)||
                             chr(9)||chr(9)||chr(9)||'IS'||chr(10)||
                             chr(9)||'CURSOR CUR_READ IS '||chr(10)||
                             'SELECT '||v_pk_col_name||',';
                                OPEN cur_get_col_name;
                                    LOOP
                                        FETCH cur_get_col_name
                                            INTO v_col_name;
                                        EXIT WHEN cur_get_col_name%NOTFOUND;
                                        IF cur_get_col_name%ROWCOUNT < v_count_col THEN
                                            v_read_text_body:= v_read_text_body ||v_col_name||', ';
                                        ELSE
                                            v_read_text_body:= v_read_text_body ||v_col_name||chr(10);
                                        END IF;
                                    END LOOP;
                                CLOSE cur_get_col_name;
                             v_read_text_body:= v_read_text_body || 'FROM '||p_table_name||';'||chr(10);
        v_varbls:= 'V_'||v_pk_col_name||' '||p_table_name||'.'||v_pk_col_name||'%TYPE;'||chr(10);
        OPEN cur_get_col_name;
            LOOP
                FETCH cur_get_col_name
                    INTO v_col_name;
                EXIT WHEN cur_get_col_name%NOTFOUND;
                v_varbls:= v_varbls||'V_'||v_col_name||' '||p_table_name||'.'||v_col_name||'%TYPE;'||chr(10);
            END LOOP;
        CLOSE cur_get_col_name;
        v_read_text_body:= v_read_text_body||v_varbls||chr(9)||
                          'BEGIN'||chr(10)||chr(10)||
                          'OPEN CUR_READ;'||chr(10)||
                            'LOOP'||chr(10)||
                                'FETCH CUR_READ'||chr(10)||
                                        'INTO V_'||v_pk_col_name||', ';
            OPEN cur_get_col_name;
                LOOP
                    FETCH cur_get_col_name
                        INTO v_col_name;
                    EXIT WHEN cur_get_col_name%NOTFOUND;
                    IF cur_get_col_name%ROWCOUNT < v_count_col THEN
                        v_read_text_body:= v_read_text_body ||' V_'||v_col_name||', ';
                    ELSE
                        v_read_text_body:= v_read_text_body ||' V_'||v_col_name||';'||chr(10);
                    END IF;
                END LOOP;
            CLOSE cur_get_col_name;
                                        
            v_read_text_body:= v_read_text_body||'EXIT WHEN CUR_READ%NOTFOUND;'||chr(10)||
                              'DBMS_OUTPUT.put_line(V_'||v_pk_col_name||'||''  ''||';
                              OPEN cur_get_col_name;
                                    LOOP
                                        FETCH cur_get_col_name
                                            INTO v_col_name;
                                        EXIT WHEN cur_get_col_name%NOTFOUND;
                                        IF cur_get_col_name%ROWCOUNT < v_count_col THEN
                                            v_read_text_body:= v_read_text_body ||'V_'||v_col_name||'||''  ''|| ';
                                        ELSE
                                            v_read_text_body:= v_read_text_body ||'V_'||v_col_name||');'||chr(10);
                                        END IF;
                                    END LOOP;
                                CLOSE cur_get_col_name;
                                
            v_read_text_body:= v_read_text_body||'END LOOP;'||chr(10)||
                                'CLOSE CUR_READ;'||chr(10)||
                                'EXCEPTION'||chr(10)||
                                'WHEN OTHERS THEN'||chr(10)||
                                'DBMS_OUTPUT.put_line(SQLCODE || '': '' || SQLERRM);'||chr(10)||
                                'END P_READ;'||chr(10);             
                                
        v_update_text_body:= TRIM(TRAILING ';' FROM TRIM(TRAILING chr(10) FROM v_update_text_parm))||chr(10)||
                             chr(9)||chr(9)||chr(9)||'IS'||chr(10)||
                             chr(9)||chr(9)||'null_err EXCEPTION;'||chr(10)||
                             chr(9)||'BEGIN'||chr(10)||chr(9);
            IF v_count_col = 1 THEN
                SELECT column_name 
                    INTO v_col_name
                FROM user_tab_columns
                WHERE table_name = p_table_name AND 
                      column_id != '1';
                      
                v_update_text_body:= TRIM(both chr(9) FROM v_update_text_body)||chr(9)||
                    'IF P_NEW_'||v_col_name||' IS NOT NULL THEN'||chr(10)||
                    'UPDATE '||p_table_name||chr(10)||
                    'SET '||v_col_name||' = P_NEW_'||v_col_name||chr(10)||
                    'WHERE '||v_pk_col_name||' = P_'||v_pk_col_name||';'||chr(10);
            ELSE 
                v_update_text_body:= v_update_text_body ||
                            'IF (';
                v_query_text_arg:= 'UPDATE '||p_table_name||chr(10)||'SET ';
                OPEN cur_get_col_name;
                    LOOP
                        FETCH cur_get_col_name
                            INTO v_col_name;
                        EXIT WHEN cur_get_col_name%NOTFOUND;
                        IF cur_get_col_name%ROWCOUNT < v_count_col THEN 
                            v_update_text_body:= v_update_text_body||
                            'P_NEW_'||v_col_name||' IS NOT NULL AND'||chr(10);
                            v_query_text_arg:= v_query_text_arg||v_col_name||' = P_NEW_'||v_col_name||','||chr(10);
                        ELSE 
                            v_update_text_body:= v_update_text_body||
                            'P_NEW_'||v_col_name||' IS NOT NULL) THEN '||chr(10);
                            v_query_text_arg:= v_query_text_arg||v_col_name||' = P_NEW_'||v_col_name;
                            
                        END IF;
                    END LOOP;
                CLOSE cur_get_col_name;
                v_query_text_arg:= v_query_text_arg||chr(10)||
                             'WHERE '||v_pk_col_name||' = P_'||v_pk_col_name||';'||chr(10);
            END IF;
        v_update_text_body:= v_update_text_body||chr(10)||
                             v_query_text_arg||chr(10)||
                             'COMMIT;'||chr(10)||
                             'DBMS_OUTPUT.put_line(''0: Record updated successfully'');'||chr(10)||
                             'ELSE '||chr(10)||
                             'RAISE null_err;'||chr(10)||
                             'END IF;'||chr(10)||
                             'EXCEPTION'||chr(10)||
                             'WHEN null_err THEN'||chr(10)||
                             'DBMS_OUTPUT.put_line(''The value is NULL. Enter the correct value'');'||chr(10)||
                             'WHEN OTHERS THEN'||chr(10)||
                             'DBMS_OUTPUT.put_line(SQLCODE || '' : '' || SQLERRM);'||chr(10)||
                             'END p_update;'||chr(10);
        
        v_delete_text_body:= REPLACE(TRIM(BOTH chr(9) FROM v_delete_text_parm),
                                    ';'||chr(10)||'END PKG_'||p_table_name||';'||chr(10)||'/')||
                                    'IS'||chr(10)||
                                'null_err EXCEPTION;'||chr(10)||
                             'BEGIN'||chr(10)||
                                'IF p_'||v_pk_col_name||' IS NOT NULL THEN'||chr(10)||
                                    'DELETE FROM '||p_table_name||chr(10)||
                                    'WHERE '||v_pk_col_name||' = p_'||v_pk_col_name||';'||chr(10)||
                                    'COMMIT;'||chr(10)||
                                    'DBMS_OUTPUT.put_line(''0: Record deleted successfully'');'||chr(10)||
                                'ELSE'||chr(10)||
                                    'RAISE null_err;'||chr(10)||
                                'END IF;'||chr(10)||
                             'EXCEPTION'||chr(10)||
                                'WHEN null_err THEN'||chr(10)||
                                    'DBMS_OUTPUT.put_line(''The value is NULL. Enter the correct value'');'||chr(10)||
                                'WHEN OTHERS THEN'||chr(10)||
                                    'DBMS_OUTPUT.put_line(SQLCODE || '': '' || SQLERRM);'||chr(10)||
                             'END p_delete;';
                             
        v_body_result:= v_body_result||chr(10)||
                        v_create_text_body||chr(10)||
                        v_read_text_body||chr(10)||
                        v_update_text_body||chr(10)||
                        v_delete_text_body||chr(10)||
                        'END PKG_'||p_table_name||';'||chr(10)||
                        '/';
        
        v_all_result:= v_head_result||chr(10)||
                       v_body_result;
                       
        EXECUTE IMMEDIATE 'CREATE OR REPLACE DIRECTORY uploaded_objects AS ''D:\''';
        DECLARE
          l_file    UTL_FILE.FILE_TYPE;
          l_buffer  VARCHAR2(32767);
          l_amount  BINARY_INTEGER := 32767;
          l_pos     INTEGER := 1;
        BEGIN
          
          l_file := UTL_FILE.fopen('UPLOADED_OBJECTS', 'PKG_template.sql', 'w', 32767);
        
          LOOP
            DBMS_LOB.read (v_all_result, l_amount, l_pos, l_buffer);
            UTL_FILE.put(l_file, l_buffer);
            l_pos := l_pos + l_amount;
          END LOOP;
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLERRM);
            UTL_FILE.fclose(l_file);
        END;
    END;
END p_create_all;