CREATE OR REPLACE PACKAGE pkg_flights AS 
    PROCEDURE p_create_flight(p_new_departure_date IN flights.departure_date%TYPE,
                              p_new_departure_time IN flights.departure_time%TYPE,
                              p_new_airline_id IN flights.airline_id%TYPE);
    PROCEDURE p_read_flight;
    PROCEDURE p_update_flight(p_flight_id IN flights.flight_id%TYPE,
                              p_new_departure_date IN flights.departure_date%TYPE,
                              p_new_departure_time IN flights.departure_time%TYPE,
                              p_new_airline_id IN flights.airline_id%TYPE);
    PROCEDURE p_delete_flight(p_flight_id IN flights.flight_id%TYPE);
END pkg_flights;
/

CREATE OR REPLACE PACKAGE BODY pkg_flights AS
    PROCEDURE p_create_flight(p_new_departure_date IN flights.departure_date%TYPE,
                              p_new_departure_time IN flights.departure_time%TYPE,
                              p_new_airline_id IN flights.airline_id%TYPE) IS
        v_ins_flight_id flights.flight_id%TYPE;
        v_count_airline INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(airline_id)
            INTO v_count_airline
        FROM airlines
        WHERE airline_id = p_new_airline_id;
        
        IF (p_new_departure_date IS NOT NULL AND
            p_new_departure_time IS NOT NULL AND
            p_new_airline_id IS NOT NULL) THEN
            IF (v_count_airline >= 1) THEN
                INSERT INTO flights(departure_date, departure_time, airline_id)
                    VALUES(p_new_departure_date, p_new_departure_time, p_new_airline_id)
                    RETURNING flight_id INTO v_ins_flight_id;
                COMMIT;
                DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_flight_id); 
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
    END p_create_flight;
    
    PROCEDURE p_read_flight IS
        v_flight_id flights.flight_id%TYPE;
        v_departure_date flights.departure_date%TYPE;
        v_departure_time flights.departure_time%TYPE;
        v_airline_id flights.airline_id%TYPE;
        CURSOR cur_read_flight IS
            SELECT flight_id, departure_date, departure_time, airline_id
            FROM flights;
    BEGIN
        DBMS_OUTPUT.put_line('flight_id  departure_date  departure_time  airline_id');
        OPEN cur_read_flight;
            LOOP
                FETCH cur_read_flight
                    INTO v_flight_id, v_departure_date, v_departure_time, v_airline_id;
                EXIT WHEN cur_read_flight%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_flight_id||'           '||
                                     v_departure_date||'       '||
                                     v_departure_time||'        '||
                                     v_airline_id);
            END LOOP;
        CLOSE cur_read_flight;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_flight;
    
    PROCEDURE p_update_flight(p_flight_id IN flights.flight_id%TYPE,
                              p_new_departure_date IN flights.departure_date%TYPE,
                              p_new_departure_time IN flights.departure_time%TYPE,
                              p_new_airline_id IN flights.airline_id%TYPE) IS
        v_count_airline INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(airline_id)
            INTO v_count_airline
        FROM airlines
        WHERE airline_id = p_new_airline_id;
        
        IF (p_flight_id IS NOT NULL AND
            p_new_departure_date IS NOT NULL AND
            p_new_departure_time IS NOT NULL AND
            p_new_airline_id IS NOT NULL) THEN
            IF (v_count_airline >= 1) THEN
                UPDATE flights
                SET departure_date = p_new_departure_date,
                    departure_time = p_new_departure_time,
                    airline_id = p_new_airline_id
                WHERE flight_id = p_flight_id;
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
    END p_update_flight;
    
    PROCEDURE p_delete_flight(p_flight_id IN flights.flight_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_flight_id IS NOT NULL THEN
            DELETE FROM flights
            WHERE flight_id = p_flight_id;
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
    END p_delete_flight;
END pkg_flights;
/