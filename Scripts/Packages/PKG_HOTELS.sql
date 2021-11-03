CREATE OR REPLACE PACKAGE pkg_hotels AS 
    PROCEDURE p_create_hotel(p_new_hotel_name IN hotels.hotel_name%TYPE,
                             p_new_star_rating IN hotels.star_rating%TYPE,
                             p_new_rating IN hotels.rating%TYPE);
    PROCEDURE p_read_hotel;
    PROCEDURE p_update_hotel(p_hotel_id IN hotels.hotel_id%TYPE,   
                             p_new_hotel_name IN hotels.hotel_name%TYPE,
                             p_new_star_rating IN hotels.star_rating%TYPE,
                             p_new_rating IN hotels.rating%TYPE);
    PROCEDURE p_delete_hotel(p_hotel_id IN hotels.hotel_id%TYPE);
END pkg_hotels;
/

CREATE OR REPLACE PACKAGE BODY pkg_hotels AS
    PROCEDURE p_create_hotel(p_new_hotel_name IN hotels.hotel_name%TYPE,
                             p_new_star_rating IN hotels.star_rating%TYPE,
                             p_new_rating IN hotels.rating%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_new_hotel_name IS NOT NULL THEN
            INSERT INTO hotels(hotel_name, star_rating, rating)
                VALUES(p_new_hotel_name, p_new_star_rating, p_new_rating);
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
    END p_create_hotel;
    
    PROCEDURE p_read_hotel IS
        v_hotel_id hotels.hotel_id%TYPE;
        v_hotel_name hotels.hotel_name%TYPE;
        CURSOR cur_read_hotel IS
            SELECT hotel_id, hotel_name
            FROM hotels;
    BEGIN
        DBMS_OUTPUT.put_line('hotel_id   hotel_name');
        OPEN cur_read_hotel;
            LOOP
                FETCH cur_read_hotel
                    INTO v_hotel_id, v_hotel_name;
                EXIT WHEN cur_read_hotel%NOTFOUND;  
                DBMS_OUTPUT.put_line(v_hotel_id || '      ' || v_hotel_name);
            END LOOP;
        CLOSE cur_read_hotel;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_hotel;
    
    PROCEDURE p_update_hotel(p_hotel_id IN hotels.hotel_id%TYPE,   
                             p_new_hotel_name IN hotels.hotel_name%TYPE,
                             p_new_star_rating IN hotels.star_rating%TYPE,
                             p_new_rating IN hotels.rating%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF (p_hotel_id IS NOT NULL AND
            p_new_hotel_name IS NOT NULL AND
            p_new_star_rating IS NOT NULL AND 
            p_new_rating IS NOT NULL) THEN
                UPDATE hotels
                SET hotel_name = p_new_hotel_name,
                    star_rating = p_new_star_rating,
                    rating = p_new_rating
                WHERE hotel_id = p_hotel_id;
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
    END p_update_hotel;
    
    PROCEDURE p_delete_hotel(p_hotel_id IN hotels.hotel_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_hotel_id IS NOT NULL THEN
            DELETE FROM hotels
            WHERE hotel_id = p_hotel_id;
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
    END p_delete_hotel;
END pkg_hotels;
/