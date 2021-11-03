CREATE OR REPLACE PACKAGE pkg_treaties AS 
    PROCEDURE p_create_treaty(p_new_customer_id IN treaties.customer_id%TYPE,
                              p_new_employee_id IN treaties.employee_id%TYPE,
                              p_new_tour_id IN treaties.tour_id%TYPE,
                              p_new_ticket_id IN treaties.ticket_id%TYPE);
    PROCEDURE p_read_treaty;
    PROCEDURE p_update_treaty(p_treaty_id IN treaties.treaty_id%TYPE,
                              p_new_customer_id IN treaties.customer_id%TYPE,
                              p_new_employee_id IN treaties.employee_id%TYPE,
                              p_new_tour_id IN treaties.tour_id%TYPE,
                              p_new_ticket_id IN treaties.ticket_id%TYPE);
    PROCEDURE p_delete_treaty(p_treaty_id IN treaties.treaty_id%TYPE);
END pkg_treaties;
/

CREATE OR REPLACE PACKAGE BODY pkg_treaties AS
    PROCEDURE p_create_treaty(p_new_customer_id IN treaties.customer_id%TYPE,
                              p_new_employee_id IN treaties.employee_id%TYPE,
                              p_new_tour_id IN treaties.tour_id%TYPE,
                              p_new_ticket_id IN treaties.ticket_id%TYPE) IS
        v_ins_treaty_id treaties.treaty_id%TYPE;
        v_count_customer INTEGER;
        v_count_employee INTEGER;
        v_count_tour INTEGER;
        v_count_ticket INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(customer_id)
            INTO v_count_customer
        FROM customers
        WHERE customer_id = p_new_customer_id;
        
        SELECT COUNT(employee_id)
            INTO v_count_employee
        FROM staff
        WHERE employee_id = p_new_employee_id;
        
        SELECT COUNT(tour_id)
            INTO v_count_tour
        FROM tours
        WHERE tour_id = p_new_tour_id;
        
        SELECT COUNT(ticket_id)
            INTO v_count_ticket
        FROM tickets
        WHERE ticket_id = p_new_ticket_id;

        IF (p_new_customer_id IS NOT NULL AND
            p_new_employee_id IS NOT NULL AND
            p_new_tour_id IS NOT NULL AND
            p_new_ticket_id IS NOT NULL) THEN
            IF (v_count_customer >=1 AND
                v_count_employee >=1 AND
                v_count_tour >=1 AND
                v_count_ticket >=1) THEN
                INSERT INTO treaties(customer_id, employee_id, tour_id, ticket_id)
                    VALUES(p_new_customer_id, p_new_employee_id, p_new_tour_id, p_new_ticket_id)
                    RETURNING treaty_id INTO v_ins_treaty_id;
                COMMIT;
                DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_treaty_id); 
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
                                  Customers, Staff, Tours, Tickets.');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_treaty;
    
    PROCEDURE p_read_treaty IS
        v_treaty_id treaties.treaty_id%TYPE;
        v_customer_id treaties.customer_id%TYPE;
        v_employee_id treaties.employee_id%TYPE;
        v_tour_id treaties.tour_id%TYPE;
        v_ticket_id treaties.ticket_id%TYPE;
        CURSOR cur_read_treaty IS
            SELECT treaty_id, customer_id, employee_id, tour_id, ticket_id
            FROM treaties;
    BEGIN
        DBMS_OUTPUT.put_line('treaty_id  customer_id  employee_id  tour_id  ticket_id');
        OPEN cur_read_treaty;
            LOOP
                FETCH cur_read_treaty
                    INTO v_treaty_id, v_customer_id, v_employee_id, v_tour_id, v_ticket_id;
                EXIT WHEN cur_read_treaty%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_treaty_id||'    '||
                                     v_customer_id||'    '||
                                     v_employee_id||'    '||
                                     v_tour_id||'    '||
                                     v_ticket_id);
            END LOOP;
        CLOSE cur_read_treaty;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_treaty;
    
    PROCEDURE p_update_treaty(p_treaty_id IN treaties.treaty_id%TYPE,
                              p_new_customer_id IN treaties.customer_id%TYPE,
                              p_new_employee_id IN treaties.employee_id%TYPE,
                              p_new_tour_id IN treaties.tour_id%TYPE,
                              p_new_ticket_id IN treaties.ticket_id%TYPE) IS
        v_count_customer INTEGER;
        v_count_employee INTEGER;
        v_count_tour INTEGER;
        v_count_ticket INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(customer_id)
            INTO v_count_customer
        FROM customers
        WHERE customer_id = p_new_customer_id;
        
        SELECT COUNT(employee_id)
            INTO v_count_employee
        FROM staff
        WHERE employee_id = p_new_employee_id;
        
        SELECT COUNT(tour_id)
            INTO v_count_tour
        FROM tours
        WHERE tour_id = p_new_tour_id;
        
        SELECT COUNT(ticket_id)
            INTO v_count_ticket
        FROM tickets
        WHERE ticket_id = p_new_ticket_id;

        IF (p_treaty_id IS NOT NULL AND
            p_new_customer_id IS NOT NULL AND
            p_new_employee_id IS NOT NULL AND
            p_new_tour_id IS NOT NULL AND
            p_new_ticket_id IS NOT NULL) THEN
            IF (v_count_customer >=1 AND
                v_count_employee >=1 AND
                v_count_tour >=1 AND
                v_count_ticket >=1) THEN
                UPDATE treaties
                SET customer_id = p_new_customer_id,
                    employee_id = p_new_employee_id,
                    tour_id = p_new_tour_id,
                    ticket_id = p_new_ticket_id
                WHERE treaty_id = p_treaty_id;
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
    END p_update_treaty;
    
    PROCEDURE p_delete_treaty(p_treaty_id IN treaties.treaty_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_treaty_id IS NOT NULL THEN
            DELETE FROM treaties
            WHERE treaty_id = p_treaty_id;
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
    END p_delete_treaty;
END pkg_treaties;
/