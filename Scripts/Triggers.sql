--Triggers for generating PK
--For table airlines
CREATE OR REPLACE TRIGGER t_b_airlines
    BEFORE INSERT 
        ON airlines
        FOR EACH ROW
BEGIN
    IF :NEW.airline_id IS NULL THEN 
        SELECT airlines_seq.NEXTVAL
            INTO :NEW.airline_id
        FROM dual;
    END IF;
END;
/

--For table customers
CREATE OR REPLACE TRIGGER t_b_customers
    BEFORE INSERT 
        ON customers
        FOR EACH ROW
BEGIN
    IF :NEW.customer_id IS NULL THEN 
        SELECT customers_seq.NEXTVAL
            INTO :NEW.customer_id
        FROM dual;
    END IF;
END;
/

--For table passports
CREATE OR REPLACE TRIGGER t_b_passports
    BEFORE INSERT 
        ON passports
        FOR EACH ROW
BEGIN
    IF :NEW.passport_id IS NULL THEN 
        SELECT passports_seq.NEXTVAL
            INTO :NEW.passport_id
        FROM dual;
    END IF;
END;
/

--For table positions
CREATE OR REPLACE TRIGGER t_b_positions
    BEFORE INSERT 
        ON positions
        FOR EACH ROW
BEGIN
    IF :NEW.position_id IS NULL THEN 
        SELECT positions_seq.NEXTVAL
            INTO :NEW.position_id
        FROM dual;
    END IF;
END;
/

--For table hotels
CREATE OR REPLACE TRIGGER t_b_hotels
    BEFORE INSERT 
        ON hotels
        FOR EACH ROW
BEGIN
    IF :NEW.hotel_id IS NULL THEN 
        SELECT hotels_seq.NEXTVAL
            INTO :NEW.hotel_id
        FROM dual;
    END IF;
END;
/

--For table tr_operators
CREATE OR REPLACE TRIGGER t_b_tr_operators
    BEFORE INSERT 
        ON tr_operators
        FOR EACH ROW
BEGIN
    IF :NEW.operator_id IS NULL THEN 
        SELECT tr_operators_seq.NEXTVAL
            INTO :NEW.operator_id
        FROM dual;
    END IF;
END;
/

--For table flights
CREATE OR REPLACE TRIGGER t_b_flights
    BEFORE INSERT 
        ON flights
        FOR EACH ROW
BEGIN
    IF :NEW.flight_id IS NULL THEN 
        SELECT flights_seq.NEXTVAL
            INTO :NEW.flight_id
        FROM dual;
    END IF;
END;
/

--For table staff
CREATE OR REPLACE TRIGGER t_b_staff
    BEFORE INSERT 
        ON staff
        FOR EACH ROW
BEGIN
    IF :NEW.employee_id IS NULL THEN 
        SELECT staff_seq.NEXTVAL
            INTO :NEW.employee_id
        FROM dual;
    END IF;
END;
/

--For table tours
CREATE OR REPLACE TRIGGER t_b_tours
    BEFORE INSERT 
        ON tours
        FOR EACH ROW
BEGIN
    IF :NEW.tour_id IS NULL THEN 
        SELECT tours_seq.NEXTVAL
            INTO :NEW.tour_id
        FROM dual;
    END IF;
END;
/

--For table pass_cust
CREATE OR REPLACE TRIGGER t_b_pass_cust
    BEFORE INSERT 
        ON pass_cust
        FOR EACH ROW
BEGIN
    IF :NEW.pass_cust_id IS NULL THEN 
        SELECT pass_cust_seq.NEXTVAL
            INTO :NEW.pass_cust_id
        FROM dual;
    END IF;
END;
/

--For table tickets
CREATE OR REPLACE TRIGGER t_b_tickets
    BEFORE INSERT 
        ON tickets
        FOR EACH ROW
BEGIN
    IF :NEW.ticket_id IS NULL THEN 
        SELECT tickets_seq.NEXTVAL
            INTO :NEW.ticket_id
        FROM dual;
    END IF;
END;
/

--For table treaties
CREATE OR REPLACE TRIGGER t_b_treaties
    BEFORE INSERT 
        ON treaties
        FOR EACH ROW
BEGIN
    IF :NEW.treaty_id IS NULL THEN 
        SELECT treaties_seq.NEXTVAL
            INTO :NEW.treaty_id
        FROM dual;
    END IF;
END;