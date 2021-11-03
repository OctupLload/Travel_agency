--In this package has pipelined function on line 178
--Pipelined function returns record from view named v_inf_tour

CREATE OR REPLACE PACKAGE pkg_tours AS 
    PROCEDURE p_create_tour(p_new_country IN tours.country%TYPE,
                            p_new_city IN tours.city%TYPE,
                            p_new_cost IN tours.cost%TYPE,
                            p_new_operator_id IN tours.operator_id%TYPE,
                            p_new_hotel_id IN tours.hotel_id%TYPE);
    PROCEDURE p_read_tour;
    PROCEDURE p_update_tour(p_tour_id IN tours.tour_id%TYPE,
                            p_new_country IN tours.country%TYPE,
                            p_new_city IN tours.city%TYPE,
                            p_new_cost IN tours.cost%TYPE,
                            p_new_operator_id IN tours.operator_id%TYPE,
                            p_new_hotel_id IN tours.hotel_id%TYPE);
    PROCEDURE p_delete_tour(p_tour_id IN tours.tour_id%TYPE);
    TYPE t_tour_row IS RECORD(
            tour_id INTEGER,
            country VARCHAR(40),
            hotel_name VARCHAR(50), 
            tr_operator VARCHAR(50),
            cost NUMBER(15,2)
        );
    TYPE t_tour_table IS TABLE OF t_tour_row; 
    FUNCTION f_get_tour(p_tour_id IN tours.tour_id%TYPE) RETURN t_tour_table PIPELINED;
END pkg_tours;
/

CREATE OR REPLACE PACKAGE BODY pkg_tours AS
    PROCEDURE p_create_tour(p_new_country IN tours.country%TYPE,
                            p_new_city IN tours.city%TYPE,
                            p_new_cost IN tours.cost%TYPE,
                            p_new_operator_id IN tours.operator_id%TYPE,
                            p_new_hotel_id IN tours.hotel_id%TYPE) IS
        v_count_operator INTEGER;
        v_count_hotel INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(operator_id)
            INTO v_count_operator
        FROM tr_operators
        WHERE operator_id = p_new_operator_id;
        
        SELECT COUNT(hotel_id)
            INTO v_count_hotel
        FROM hotels
        WHERE hotel_id = p_new_hotel_id;
        
        IF (p_new_country IS NOT NULL AND
            p_new_city IS NOT NULL AND
            p_new_cost IS NOT NULL AND
            p_new_operator_id IS NOT NULL AND
            p_new_hotel_id IS NOT NULL) THEN
            IF(v_count_operator >= 1 AND v_count_hotel >=1) THEN
                INSERT INTO tours(country, city, cost, operator_id, hotel_id)
                VALUES(p_new_country, p_new_city, p_new_cost, p_new_operator_id, p_new_hotel_id);
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
    END p_create_tour;
    
    PROCEDURE p_read_tour IS
        v_tour_id tours.tour_id%TYPE;
        v_country tours.country%TYPE;
        v_city tours.city%TYPE;
        v_cost tours.cost%TYPE;
        v_operator_id tours.operator_id%TYPE;
        v_hotel_id tours.hotel_id%TYPE;
        CURSOR cur_read_tour IS
            SELECT tour_id, country, city, cost, operator_id, hotel_id
            FROM tours;
    BEGIN
        DBMS_OUTPUT.put_line('tour_id  country  city  cost  operator_id  hotel_id');
        OPEN cur_read_tour;
            LOOP
                FETCH cur_read_tour
                    INTO v_tour_id, v_country, v_city, v_cost, v_operator_id, v_hotel_id;
                EXIT WHEN cur_read_tour%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_tour_id||'   '||
                                     v_country||'   '||
                                     v_city||'   '||
                                     v_cost||'   '||
                                     v_operator_id||'   '||
                                     v_hotel_id);
            END LOOP;
        CLOSE cur_read_tour;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_tour;
    
    PROCEDURE p_update_tour(p_tour_id IN tours.tour_id%TYPE,
                            p_new_country IN tours.country%TYPE,
                            p_new_city IN tours.city%TYPE,
                            p_new_cost IN tours.cost%TYPE,
                            p_new_operator_id IN tours.operator_id%TYPE,
                            p_new_hotel_id IN tours.hotel_id%TYPE) IS
        v_count_operator INTEGER;
        v_count_hotel INTEGER;
        integrity_err EXCEPTION;
        null_err EXCEPTION;
    BEGIN
        SELECT COUNT(operator_id)
            INTO v_count_operator
        FROM tr_operators
        WHERE operator_id = p_new_operator_id;
        
        SELECT COUNT(hotel_id)
            INTO v_count_hotel
        FROM hotels
        WHERE hotel_id = p_new_hotel_id;
        
        IF (p_tour_id IS NOT NULL AND
            p_new_country IS NOT NULL AND
            p_new_city IS NOT NULL AND
            p_new_cost IS NOT NULL AND
            p_new_operator_id IS NOT NULL AND
            p_new_hotel_id IS NOT NULL) THEN
            IF(v_count_operator >= 1 AND v_count_hotel >=1) THEN
                UPDATE tours
                SET country = p_new_country,
                    city = p_new_city,
                    cost = p_new_cost,
                    operator_id = p_new_operator_id,
                    hotel_id = p_new_hotel_id
                WHERE tour_id = p_tour_id;
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
    END p_update_tour;
    
    PROCEDURE p_delete_tour(p_tour_id IN tours.tour_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_tour_id IS NOT NULL THEN
            DELETE FROM tours
            WHERE tour_id = p_tour_id;
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
    END p_delete_tour;  
    
    FUNCTION f_get_tour(p_tour_id IN tours.tour_id%TYPE) 
        RETURN t_tour_table PIPELINED IS
        t_tour_list t_tour_row;
    BEGIN
        FOR i IN 1..1 LOOP
            SELECT tour_id, country, hotel_name, tr_operator, price
                INTO t_tour_list
            FROM v_inf_tour
            WHERE tour_id = p_tour_id;
            PIPE ROW(t_tour_list);
        END LOOP;
        RETURN;
    END f_get_tour;
END pkg_tours;
/