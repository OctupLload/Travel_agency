CREATE OR REPLACE PACKAGE pkg_airlines AS 
    PROCEDURE p_create_airline(p_new_airline_name IN airlines.airline_name%TYPE);
    PROCEDURE p_read_airline;
    PROCEDURE p_update_airline(p_airline_id IN airlines.airline_id%TYPE, 
                               p_new_value IN airlines.airline_name%TYPE);
    PROCEDURE p_delete_airline(p_airline_id IN airlines.airline_id%TYPE);
END pkg_airlines;
/

CREATE OR REPLACE PACKAGE BODY pkg_airlines AS
    PROCEDURE p_create_airline (p_new_airline_name IN airlines.airline_name%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_new_airline_name IS NOT NULL THEN
            INSERT INTO airlines(airline_name)
                VALUES(p_new_airline_name);
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully');
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_airline;
    
    PROCEDURE p_read_airline IS
        CURSOR cur_read_airline IS
            SELECT airline_id, airline_name
            FROM airlines;
        v_airline_id airlines.airline_id%TYPE;
        v_airline_name airlines.airline_name%TYPE;
    BEGIN
        DBMS_OUTPUT.put_line('airline_id ' || 'airline_name');
        OPEN cur_read_airline;
            LOOP
                FETCH cur_read_airline
                    INTO v_airline_id, v_airline_name;
                EXIT WHEN cur_read_airline%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_airline_id || '      ' || v_airline_name);
            END LOOP;
        CLOSE cur_read_airline;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_airline;
    
    PROCEDURE p_update_airline (p_airline_id IN airlines.airline_id%TYPE,
                                p_new_value IN airlines.airline_name%TYPE)IS
        null_err EXCEPTION;
    BEGIN
        IF (p_airline_id IS NOT NULL OR p_new_value IS NOT NULL) THEN
                UPDATE airlines
                SET airline_name = p_new_value
                WHERE airline_id = p_airline_id;
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
    END p_update_airline;
    
    PROCEDURE p_delete_airline (p_airline_id IN airlines.airline_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_airline_id IS NOT NULL THEN
            DELETE FROM airlines
            WHERE airline_id = p_airline_id;
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
    END p_delete_airline;
END pkg_airlines;
/