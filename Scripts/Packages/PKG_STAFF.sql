CREATE OR REPLACE PACKAGE pkg_staff AS 
    PROCEDURE p_create_employee(p_new_last_name IN staff.last_name%TYPE,
                                p_new_first_name IN staff.first_name%TYPE,
                                p_new_surname IN staff.surname%TYPE,
                                p_new_address IN staff.address%TYPE,
                                p_new_phone_number IN staff.phone_number%TYPE,
                                p_new_position_id IN staff.position_id%TYPE);
    PROCEDURE p_read_employee;
    PROCEDURE p_update_employee(p_employee_id IN staff.employee_id%TYPE,
                                p_new_last_name IN staff.last_name%TYPE,
                                p_new_first_name IN staff.first_name%TYPE,
                                p_new_surname IN staff.surname%TYPE,
                                p_new_address IN staff.address%TYPE,
                                p_new_phone_number IN staff.phone_number%TYPE,
                                p_new_position_id IN staff.position_id%TYPE);
    PROCEDURE p_delete_employee(p_employee_id IN staff.employee_id%TYPE);
END pkg_staff;
/

CREATE OR REPLACE PACKAGE BODY pkg_staff AS
    PROCEDURE p_create_employee(p_new_last_name IN staff.last_name%TYPE,
                                p_new_first_name IN staff.first_name%TYPE,
                                p_new_surname IN staff.surname%TYPE,
                                p_new_address IN staff.address%TYPE,
                                p_new_phone_number IN staff.phone_number%TYPE,
                                p_new_position_id IN staff.position_id%TYPE) IS
        v_ins_employee_id staff.employee_id%TYPE;
        v_count_position INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(position_id)
            INTO v_count_position
        FROM positions
        WHERE position_id = p_new_position_id;
        
        IF (p_new_last_name IS NOT NULL AND
            p_new_first_name IS NOT NULL AND
            p_new_surname IS NOT NULL AND
            p_new_address IS NOT NULL AND
            p_new_phone_number IS NOT NULL AND
            p_new_position_id IS NOT NULL) THEN
            IF (v_count_position >= 1) THEN
                INSERT INTO staff(last_name, first_name, surname,
                                  address, phone_number, position_id)
                    VALUES(p_new_last_name, p_new_first_name, p_new_surname,
                           p_new_address, p_new_phone_number, p_new_position_id)
                    RETURNING employee_id INTO v_ins_employee_id;
                COMMIT;
                DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_employee_id); 
            ELSE
                RAISE integrity_err;
            END IF;
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN integrity_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': There are no necessary entries in the tables of Positions.');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_employee;
    
    PROCEDURE p_read_employee IS
        v_employee_id staff.employee_id%TYPE;
        v_last_name staff.last_name%TYPE;
        v_first_name staff.first_name%TYPE;
        v_surname staff.surname%TYPE;
        v_address staff.address%TYPE;
        v_phone_number staff.phone_number%TYPE;
        v_position_id staff.position_id%TYPE;
        CURSOR cur_read_employee IS
            SELECT employee_id, last_name, first_name, surname,
                   address, phone_number, position_id
            FROM staff;
    BEGIN
        DBMS_OUTPUT.put_line('employee_id  last_name  first_name  surname address  phone_number  position_id');
        OPEN cur_read_employee;
            LOOP
                FETCH cur_read_employee
                    INTO v_employee_id, v_last_name, v_first_name, v_surname,
                         v_address, v_phone_number, v_position_id;
                EXIT WHEN cur_read_employee%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_employee_id||'  '||
                                     v_last_name||'  '||
                                     v_first_name||'  '||
                                     v_surname||'  '||
                                     v_address||'  '||
                                     v_phone_number||'  '||
                                     v_position_id);
            END LOOP;
        CLOSE cur_read_employee;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_employee;
    
    PROCEDURE p_update_employee(p_employee_id IN staff.employee_id%TYPE,
                                p_new_last_name IN staff.last_name%TYPE,
                                p_new_first_name IN staff.first_name%TYPE,
                                p_new_surname IN staff.surname%TYPE,
                                p_new_address IN staff.address%TYPE,
                                p_new_phone_number IN staff.phone_number%TYPE,
                                p_new_position_id IN staff.position_id%TYPE) IS
        v_count_position INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(position_id)
            INTO v_count_position
        FROM positions
        WHERE position_id = p_new_position_id;
        
        IF (p_new_last_name IS NOT NULL AND
            p_new_first_name IS NOT NULL AND
            p_new_surname IS NOT NULL AND
            p_new_address IS NOT NULL AND
            p_new_phone_number IS NOT NULL AND
            p_new_position_id IS NOT NULL) THEN
            IF (v_count_position >= 1) THEN
                UPDATE staff
                SET last_name = p_new_last_name, 
                    first_name = p_new_first_name,
                    surname = p_new_surname,
                    address = p_new_address,
                    phone_number = p_new_phone_number, 
                    position_id = p_new_position_id;
                COMMIT;
                DBMS_OUTPUT.put_line(SQLCODE()||': Record updated successfully'); 
            ELSE
                RAISE integrity_err;
            END IF;
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN integrity_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': There are no necessary entries in the tables of Positions');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_update_employee;
    
    PROCEDURE p_delete_employee(p_employee_id IN staff.employee_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_employee_id IS NOT NULL THEN
            DELETE FROM staff
            WHERE employee_id = p_employee_id;
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
    END p_delete_employee;
END pkg_staff;
/