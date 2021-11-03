CREATE OR REPLACE PACKAGE pkg_tickets AS 
    PROCEDURE p_create_ticket(p_new_class_of_service IN tickets.class_of_service%TYPE,
                              p_new_flight_id IN tickets.flight_id%TYPE);
    PROCEDURE p_read_ticket;
    PROCEDURE p_update_ticket(p_ticket_id IN tickets.ticket_id%TYPE,
                              p_new_class_of_service IN tickets.class_of_service%TYPE,
                              p_new_flight_id IN tickets.flight_id%TYPE);
    PROCEDURE p_delete_ticket(p_ticket_id IN tickets.ticket_id%TYPE);
END pkg_tickets;
/

CREATE OR REPLACE PACKAGE BODY pkg_tickets AS
    PROCEDURE p_create_ticket(p_new_class_of_service IN tickets.class_of_service%TYPE,
                              p_new_flight_id IN tickets.flight_id%TYPE) IS
        v_count_flight INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(flight_id)
            INTO v_count_flight
        FROM flights
        WHERE flight_id = p_new_flight_id;

        IF (p_new_class_of_service IS NOT NULL AND
            p_new_flight_id IS NOT NULL) THEN
            IF(v_count_flight >= 1) THEN
                INSERT INTO tickets(class_of_service, flight_id)
                VALUES(p_new_class_of_service, p_new_flight_id);
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
    END p_create_ticket;
    
    PROCEDURE p_read_ticket IS
        v_ticket_id tickets.ticket_id%TYPE;
        v_class_of_service tickets.class_of_service%TYPE;
        v_flight_id tickets.flight_id%TYPE;
        CURSOR cur_read_ticket IS
            SELECT ticket_id, class_of_service, flight_id
            FROM tickets;
    BEGIN
        DBMS_OUTPUT.put_line('ticket_id  class_of_service  flight_id');
        OPEN cur_read_ticket;
            LOOP
                FETCH cur_read_ticket
                    INTO v_ticket_id, v_class_of_service, v_flight_id;
                EXIT WHEN cur_read_ticket%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_ticket_id||'   '||
                                     v_class_of_service||'   '||
                                     v_flight_id);
            END LOOP;
        CLOSE cur_read_ticket;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_ticket;
    
    PROCEDURE p_update_ticket(p_ticket_id IN tickets.ticket_id%TYPE,
                              p_new_class_of_service IN tickets.class_of_service%TYPE,
                              p_new_flight_id IN tickets.flight_id%TYPE) IS
        v_count_flight INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(flight_id)
            INTO v_count_flight
        FROM flights
        WHERE flight_id = p_new_flight_id;

        IF (p_ticket_id IS NOT NULL AND
            p_new_class_of_service IS NOT NULL AND
            p_new_flight_id IS NOT NULL) THEN
            IF(v_count_flight >= 1) THEN
                UPDATE tickets
                SET class_of_service = p_new_class_of_service,
                    flight_id = p_new_flight_id
                WHERE ticket_id = p_ticket_id;
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
    END p_update_ticket;
    
    PROCEDURE p_delete_ticket(p_ticket_id IN tickets.ticket_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_ticket_id IS NOT NULL THEN
            DELETE FROM tickets
            WHERE ticket_id = p_ticket_id;
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
    END p_delete_ticket;
END pkg_tickets;
/