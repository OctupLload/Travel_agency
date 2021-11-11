CONNECT &user_name/&user_password@&db_name

--For table passports
CREATE SEQUENCE passports_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table pass_cust
CREATE SEQUENCE pass_cust_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1	
    CACHE 20;
    
--For table customers
CREATE SEQUENCE customers_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;
    
--For table positions
CREATE SEQUENCE positions_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table staff
CREATE SEQUENCE staff_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;
    
--For table hotels
CREATE SEQUENCE hotels_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table tr_operators
CREATE SEQUENCE tr_operators_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table tours
CREATE SEQUENCE tours_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table airlines
CREATE SEQUENCE airlines_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table flights
CREATE SEQUENCE flights_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table tickets
CREATE SEQUENCE tickets_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

--For table treaties
CREATE SEQUENCE treaties_seq
    MINVALUE 1 
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

DISCONNECT