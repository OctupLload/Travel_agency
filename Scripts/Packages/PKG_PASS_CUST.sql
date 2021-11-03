CREATE OR REPLACE PACKAGE pkg_pass_cust AS 
    PROCEDURE p_create_pass_cust(p_new_customer_id IN pass_cust.customer_id%TYPE,
                                 p_new_passport_id IN pass_cust.passport_id%TYPE);
    PROCEDURE p_read_pass_cust;
    PROCEDURE p_update_pass_cust(p_pass_cust_id IN pass_cust.pass_cust_id%TYPE,
                                 p_new_customer_id IN pass_cust.customer_id%TYPE,
                                 p_new_passport_id IN pass_cust.passport_id%TYPE);
    PROCEDURE p_delete_pass_cust(p_pass_cust_id IN pass_cust.pass_cust_id%TYPE);
END pkg_pass_cust;
/

CREATE OR REPLACE PACKAGE BODY pkg_pass_cust AS
    PROCEDURE p_create_pass_cust(p_new_customer_id IN pass_cust.customer_id%TYPE,
                                 p_new_passport_id IN pass_cust.passport_id%TYPE) IS
        v_count_customer INTEGER;
        v_count_passport INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(customer_id)
            INTO v_count_customer
        FROM customers
        WHERE customer_id = p_new_customer_id;
        
        SELECT COUNT(passport_id)
            INTO v_count_passport
        FROM passports
        WHERE passport_id = p_new_passport_id;
        
        IF (p_new_customer_id IS NOT NULL AND 
            p_new_passport_id IS NOT NULL) THEN
            IF(v_count_customer >= 1 AND v_count_passport >=1) THEN
                INSERT INTO pass_cust(customer_id, passport_id)
                VALUES(p_new_customer_id, p_new_passport_id);
                COMMIT;
                DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully'); 
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
            DBMS_OUTPUT.put_line(SQLCODE()||': There are no necessary entries in the tables of  
                                  Customers and Passports.');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_pass_cust;
    
    PROCEDURE p_read_pass_cust IS
        v_pass_cust_id pass_cust.pass_cust_id%TYPE;
        v_customer_id pass_cust.customer_id%TYPE;
        v_passport_id pass_cust.passport_id%TYPE;
        CURSOR cur_read_pass_cust IS
            SELECT pass_cust_id, customer_id, passport_id
            FROM pass_cust;
    BEGIN
        DBMS_OUTPUT.put_line('pass_cust_id   customer_id   passport_id');
        OPEN cur_read_pass_cust;
            LOOP
                FETCH cur_read_pass_cust
                    INTO v_pass_cust_id, v_customer_id, v_passport_id;
                EXIT WHEN cur_read_pass_cust%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_pass_cust_id||'               '||
                                     v_customer_id||'             '||
                                     v_passport_id);
            END LOOP;
        CLOSE cur_read_pass_cust;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_pass_cust;
    
    PROCEDURE p_update_pass_cust(p_pass_cust_id IN pass_cust.pass_cust_id%TYPE,
                                 p_new_customer_id IN pass_cust.customer_id%TYPE,
                                 p_new_passport_id IN pass_cust.passport_id%TYPE) IS
        v_count_customer INTEGER;
        v_count_passport INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(customer_id)
            INTO v_count_customer
        FROM customers
        WHERE customer_id = p_new_customer_id;
        
        SELECT COUNT(passport_id)
            INTO v_count_passport
        FROM passports
        WHERE passport_id = p_new_passport_id;
        
        IF (p_pass_cust_id IS NOT NULL AND
            p_new_customer_id IS NOT NULL AND
            p_new_passport_id IS NOT NULL) THEN
            IF(v_count_customer >= 1 AND v_count_passport >=1) THEN
                UPDATE pass_cust
                SET customer_id = p_new_customer_id, passport_id = p_new_passport_id
                WHERE pass_cust_id = p_pass_cust_id;
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
            DBMS_OUTPUT.put_line(SQLCODE()||': There are no necessary entries in the tables of  
                                  Customers and Passports.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_update_pass_cust;
    
    PROCEDURE p_delete_pass_cust(p_pass_cust_id IN pass_cust.pass_cust_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_pass_cust_id IS NOT NULL THEN
            DELETE FROM pass_cust
            WHERE pass_cust_id = p_pass_cust_id;
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
    END p_delete_pass_cust;
END pkg_pass_cust;
/