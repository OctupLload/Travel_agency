CREATE OR REPLACE PACKAGE pkg_customers AS 
    PROCEDURE p_create_customer(p_new_last_name IN customers.last_name%TYPE,
                                p_new_first_name IN customers.first_name%TYPE,
                                p_new_surname IN customers.surname%TYPE,
                                p_new_birthdate IN customers.birthdate%TYPE,
                                p_new_phone_number IN customers.phone_number%TYPE);
    PROCEDURE p_read_customer;
    PROCEDURE p_update_customer(p_customer_id IN customers.customer_id%TYPE,
                                p_new_last_name IN customers.last_name%TYPE,
                                p_new_first_name IN customers.first_name%TYPE,
                                p_new_surname IN customers.surname%TYPE,
                                p_new_birthdate IN customers.birthdate%TYPE,
                                p_new_phone_number IN customers.phone_number%TYPE);
    PROCEDURE p_delete_customer(p_customer_id IN customers.customer_id%TYPE);
END pkg_customers;
/

CREATE OR REPLACE PACKAGE BODY pkg_customers AS
    PROCEDURE p_create_customer(p_new_last_name IN customers.last_name%TYPE,
                                p_new_first_name IN customers.first_name%TYPE,
                                p_new_surname IN customers.surname%TYPE,
                                p_new_birthdate IN customers.birthdate%TYPE,
                                p_new_phone_number IN customers.phone_number%TYPE) IS
        v_ins_customer_id customers.customer_id%TYPE;
        null_err EXCEPTION;
    BEGIN
        IF (p_new_last_name IS NOT NULL OR
            p_new_first_name IS NOT NULL OR
            p_new_surname  IS NOT NULL OR
            p_new_birthdate  IS NOT NULL OR
            p_new_phone_number IS NOT NULL) THEN
            INSERT INTO customers(last_name,
                                  first_name,
                                  surname,
                                  birhdate,
                                  phone_number)
                VALUES(p_new_last_name,
                       p_new_first_name,
                       p_new_surname,
                       p_new_birhdate,
                       p_new_phone_number)
                RETURNING customer_id INTO v_ins_customer_id;
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_customer_id);
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_customer;
    
    PROCEDURE p_read_customer IS
        v_customer_id customers.customer_id%TYPE;
        v_last_name customers.last_name%TYPE;
        v_first_name customers.first_name%TYPE;
        v_surname customers.surname%TYPE;
        v_birthdate customers.birthdate%TYPE;
        v_phone_number customers.phone_number%TYPE;
        CURSOR cur_read_customer IS 
            SELECT customer_id, last_name, first_name, surname, birthdate, phone_number
            FROM customers;
    BEGIN
        DBMS_OUTPUT.put('customer_id   last_name  first_name  ');
        DBMS_OUTPUT.put_line('surname  birthdate  phone_number');
        OPEN cur_read_customer;
            LOOP
                FETCH cur_read_customer
                    INTO v_customer_id,
                         v_last_name,
                         v_first_name,
                         v_surname,
                         v_birthdate,
                         v_phone_number;
                EXIT WHEN cur_read_customer%NOTFOUND;  
                DBMS_OUTPUT.put(v_customer_id ||'  '||v_last_name||'  '||v_first_name||'  ');
                DBMS_OUTPUT.put_line( v_surname||'  '||v_birthdate||'  '||v_phone_number);
            END LOOP;
        CLOSE cur_read_customer;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_customer;
    
    PROCEDURE p_update_customer(p_customer_id IN customers.customer_id%TYPE,
                                p_new_last_name IN customers.last_name%TYPE,
                                p_new_first_name IN customers.first_name%TYPE,
                                p_new_surname IN customers.surname%TYPE,
                                p_new_birthdate IN customers.birthdate%TYPE,
                                p_new_phone_number IN customers.phone_number%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF (p_customer_id IS NOT NULL AND
            p_new_last_name IS NOT NULL AND
            p_new_first_name  IS NOT NULL AND
            p_new_surname  IS NOT NULL AND
            p_new_birthdate  IS NOT NULL) THEN
                UPDATE customers
                SET last_name = p_new_last_name,
                    first_name = p_new_first_name,
                    surname = p_new_surname,
                    birthdate = p_new_birthdate,
                    phone_number = p_new_phone_number
                WHERE customer_id = p_customer_id;
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
    END p_update_customer;
    
    PROCEDURE p_delete_customer(p_customer_id IN customers.customer_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_customer_id IS NOT NULL THEN
            DELETE FROM customers
            WHERE customer_id = p_customer_id;
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
    END p_delete_customer;
END pkg_customers;
/