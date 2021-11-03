CREATE OR REPLACE PACKAGE pkg_tr_operators AS 
    PROCEDURE p_create_operator(p_new_operator_name IN tr_operators.operator_name%TYPE);
    PROCEDURE p_read_operator;
    PROCEDURE p_update_operator(p_operator_id IN tr_operators.operator_id%TYPE,
                                p_new_operator_name IN tr_operators.operator_name%TYPE);
    PROCEDURE p_delete_operator(p_operator_id IN tr_operators.operator_id%TYPE);
END pkg_tr_operators;
/

CREATE OR REPLACE PACKAGE BODY pkg_tr_operators AS
    PROCEDURE p_create_operator(p_new_operator_name IN tr_operators.operator_name%TYPE) IS
        v_ins_operator_id tr_operators.operator_id%TYPE;
        null_err EXCEPTION;
    BEGIN
        IF p_new_operator_name IS NOT NULL THEN
            INSERT INTO tr_operators(operator_name)
                VALUES(p_new_operator_name)
                RETURNING operator_id INTO v_ins_operator_id;
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_operator_id);
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_operator;
    
    PROCEDURE p_read_operator IS
        v_operator_id tr_operators.operator_id%TYPE;
        v_operator_name tr_operators.operator_name%TYPE;
        CURSOR cur_read_operator IS
            SELECT operator_id, operator_name
            FROM tr_operators;
    BEGIN
        DBMS_OUTPUT.put_line('operator_id   airline_name');
        OPEN cur_read_operator;
            LOOP
                FETCH cur_read_operator
                    INTO v_operator_id, v_operator_name;
                EXIT WHEN cur_read_operator%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_operator_id || '      ' || v_operator_name);
            END LOOP;
        CLOSE cur_read_operator;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_operator;
    
    PROCEDURE p_update_operator(p_operator_id IN tr_operators.operator_id%TYPE,
                                p_new_operator_name IN tr_operators.operator_name%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF (p_operator_id IS NOT NULL AND p_new_operator_name IS NOT NULL) THEN
                UPDATE tr_operators
                SET operator_name = p_new_operator_name
                WHERE operator_id = p_operator_id;
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
    END p_update_operator;
    
    PROCEDURE p_delete_operator(p_operator_id IN tr_operators.operator_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_operator_id IS NOT NULL THEN
            DELETE FROM tr_operators
            WHERE operator_id = p_operator_id;
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
    END p_delete_operator;
END pkg_tr_operators;
/