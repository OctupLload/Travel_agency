CREATE OR REPLACE PACKAGE pkg_positions AS 
    PROCEDURE p_create_position(p_new_position_name IN positions.position_name%TYPE);
    PROCEDURE p_read_position;
    PROCEDURE p_update_position(p_position_id IN positions.position_id%TYPE,
                                p_new_value IN positions.position_name%TYPE);
    PROCEDURE p_delete_position(p_position_id IN positions.position_id%TYPE);
END pkg_positions;
/

CREATE OR REPLACE PACKAGE BODY pkg_positions AS
    PROCEDURE p_create_position(p_new_position_name IN positions.position_name%TYPE) IS
        v_ins_position_id positions.position_id%TYPE;
        null_err EXCEPTION;
    BEGIN
        IF p_new_position_name IS NOT NULL THEN
            INSERT INTO positions(position_name)
                VALUES(p_new_position_name)
                RETURNING position_id INTO v_ins_position_id;
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_position_id);
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_position;
    
    PROCEDURE p_read_position IS
        CURSOR cur_read_position IS
            SELECT position_id, position_name
            FROM positions;
        v_position_id positions.position_id%TYPE;
        v_position_name positions.position_name%TYPE;
    BEGIN
        DBMS_OUTPUT.put_line('position_id ' || 'position_name');
        OPEN cur_read_position;
            LOOP
                FETCH cur_read_position
                    INTO v_position_id, v_position_name;
                EXIT WHEN cur_read_position%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_position_id || '      ' || v_position_name);
            END LOOP;
        CLOSE cur_read_position;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_position;
    
    PROCEDURE p_update_position(p_position_id IN positions.position_id%TYPE,
                                p_new_value IN positions.position_name%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF (p_position_id IS NOT NULL AND p_new_value IS NOT NULL) THEN
                UPDATE positions
                SET position_name = p_new_value
                WHERE position_id = p_position_id;
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record updated successfully');
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_update_position;
    
    PROCEDURE p_delete_position(p_position_id IN positions.position_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_position_id IS NOT NULL THEN
            DELETE FROM positions
            WHERE position_id = p_position_id;
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record deleted successfully');
        ELSE
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_delete_position;
END pkg_positions;
/