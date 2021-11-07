CREATE OR REPLACE FUNCTION f_get_ddl_query(p_owner IN VARCHAR2,
                                           p_object_name IN VARCHAR2,
                                           p_object_type IN VARCHAR2 
                                               DEFAULT NULL)
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
        GROUP BY object_name
        having count(object_name) > 1;
        
        IF v_count = 1 THEN
            SELECT object_type 
                INTO v_type
            FROM all_objects
            WHERE owner = p_owner AND
                  object_name = p_object_name; 
            v_result:= DBMS_METADATA.get_ddl(v_type, p_object_name, p_owner); 
            RETURN v_result;
        ELSE 
            RAISE v_similar_err;
        END IF;
    ELSE 
        v_result:= DBMS_METADATA.get_ddl(p_object_type, p_object_name, p_owner);
        RETURN v_result;
    END IF;
    
EXCEPTION
    WHEN v_similar_err THEN
        DBMS_OUTPUT.put_line(SQLCODE||': There are several objects with the same name.
                                         Specify the object type.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(SQLCODE||': '||SQLERRM);
END f_get_ddl_query;
/