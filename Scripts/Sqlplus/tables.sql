CONNECT &user_name/&user_password@&db_name

CREATE TABLE airlines (
    airline_id   INTEGER NOT NULL,
    airline_name VARCHAR2(150) NOT NULL
);

COMMENT ON TABLE airlines IS
    'Information about airlines.';

COMMENT ON COLUMN airlines.airline_id IS
    'Airline ID.';

COMMENT ON COLUMN airlines.airline_name IS
    'Title of the airline.';

ALTER TABLE airlines ADD CONSTRAINT pk_airlines PRIMARY KEY ( airline_id );

CREATE TABLE customers (
    customer_id  INTEGER NOT NULL,
    last_name    VARCHAR2(40) NOT NULL,
    first_name   VARCHAR2(40) NOT NULL,
    surname      VARCHAR2(40),
    birthdate    DATE NOT NULL,
    phone_number VARCHAR2(15) NOT NULL
);

COMMENT ON TABLE customers IS
    'Information about customers.';

COMMENT ON COLUMN customers.customer_id IS
    'Customer ID.';

COMMENT ON COLUMN customers.last_name IS
    'Last name.';

COMMENT ON COLUMN customers.first_name IS
    'First name.';

COMMENT ON COLUMN customers.surname IS
    'Surname.';

COMMENT ON COLUMN customers.birthdate IS
    'Birthdate.';

COMMENT ON COLUMN customers.phone_number IS
    'Phone number.';

ALTER TABLE customers ADD CONSTRAINT pk_customers PRIMARY KEY ( customer_id );

CREATE TABLE flights (
    flight_id      INTEGER NOT NULL,
    departure_date DATE NOT NULL,
    departure_time DATE NOT NULL,
    airline_id     INTEGER NOT NULL
);

COMMENT ON TABLE flights IS
    'Information about flights.';

COMMENT ON COLUMN flights.flight_id IS
    'Flight ID.';

COMMENT ON COLUMN flights.departure_date IS
    'Departure date.';

COMMENT ON COLUMN flights.departure_time IS
    'Departure time.';

COMMENT ON COLUMN flights.airline_id IS
    'Airline ID.';

CREATE INDEX idx_airline_id ON
    flights (
        airline_id
    ASC );

ALTER TABLE flights ADD CONSTRAINT pk_flights PRIMARY KEY ( flight_id );

CREATE TABLE hotels (
    hotel_id    INTEGER NOT NULL,
    hotel_name  VARCHAR2(150) NOT NULL,
    star_rating VARCHAR2(10) NOT NULL,
    rating      VARCHAR2(10) NOT NULL
);

COMMENT ON TABLE hotels IS
    'Information about hotels.';

COMMENT ON COLUMN hotels.hotel_id IS
    'Hotel ID.';

COMMENT ON COLUMN hotels.hotel_name IS
    'Title of the hotel.';

COMMENT ON COLUMN hotels.star_rating IS
    'Classification of the hotel by star rating.';

COMMENT ON COLUMN hotels.rating IS
    'Hotel rating by reviews.';

ALTER TABLE hotels ADD CONSTRAINT pk_hotels PRIMARY KEY ( hotel_id );

CREATE TABLE pass_cust (
    pass_cust_id INTEGER NOT NULL,
    customer_id  INTEGER NOT NULL,
    passport_id  INTEGER NOT NULL
);

COMMENT ON TABLE pass_cust IS
    'Information about the number of customer passports.';

COMMENT ON COLUMN pass_cust.pass_cust_id IS
    'passports customers id';

COMMENT ON COLUMN pass_cust.customer_id IS
    'Customer ID.';

COMMENT ON COLUMN pass_cust.passport_id IS
    'Passport ID.';

CREATE INDEX idx_customer_id ON
    pass_cust (
        customer_id
    ASC );

CREATE INDEX idx_passport_id ON
    pass_cust (
        passport_id
    ASC );

ALTER TABLE pass_cust ADD CONSTRAINT pk_pass_cust PRIMARY KEY ( pass_cust_id );

CREATE TABLE passports (
    passport_id   INTEGER NOT NULL,
    series        VARCHAR2(10) NOT NULL,
    passport_num  VARCHAR2(10) NOT NULL,
    issued_by     VARCHAR2(50) NOT NULL,
    date_of_issue DATE NOT NULL
);

COMMENT ON TABLE passports IS
    'Information about the passport data of customers.';

COMMENT ON COLUMN passports.passport_id IS
    'Passport ID.';

COMMENT ON COLUMN passports.series IS
    'Passport series.';

COMMENT ON COLUMN passports.passport_num IS
    'Passport number.';

COMMENT ON COLUMN passports.issued_by IS
    'Passport is issued by (name of the authority).';

COMMENT ON COLUMN passports.date_of_issue IS
    'Date of issue of the passport.';

ALTER TABLE passports ADD CONSTRAINT pk_passports PRIMARY KEY ( passport_id );

CREATE TABLE positions (
    position_id   INTEGER NOT NULL,
    position_name VARCHAR2(150) NOT NULL
);

COMMENT ON TABLE positions IS
    'Information about positions.';

COMMENT ON COLUMN positions.position_id IS
    'Position ID.';

COMMENT ON COLUMN positions.position_name IS
    'Title of the position.';

ALTER TABLE positions ADD CONSTRAINT pk_positions PRIMARY KEY ( position_id );

CREATE TABLE staff (
    employee_id  INTEGER NOT NULL,
    last_name    VARCHAR2(40) NOT NULL,
    first_name   VARCHAR2(40) NOT NULL,
    surname      VARCHAR2(40),
    address      VARCHAR2(100) NOT NULL,
    phone_number VARCHAR2(15) NOT NULL,
    position_id  INTEGER NOT NULL
);

COMMENT ON TABLE staff IS
    'Information about staff.';

COMMENT ON COLUMN staff.employee_id IS
    'Employee ID.';

COMMENT ON COLUMN staff.last_name IS
    'Last name.';

COMMENT ON COLUMN staff.first_name IS
    'First name.';

COMMENT ON COLUMN staff.surname IS
    'Surname';

COMMENT ON COLUMN staff.address IS
    'Address.';

COMMENT ON COLUMN staff.phone_number IS
    'Phone number.';

COMMENT ON COLUMN staff.position_id IS
    'Position ID.';

CREATE INDEX idx_position_id ON
    staff (
        position_id
    ASC );

ALTER TABLE staff ADD CONSTRAINT pk_staff PRIMARY KEY ( employee_id );

CREATE TABLE tickets (
    ticket_id        INTEGER NOT NULL,
    class_of_service VARCHAR2(10) NOT NULL,
    flight_id        INTEGER NOT NULL
);

COMMENT ON TABLE tickets IS
    'Information about tickets.';

COMMENT ON COLUMN tickets.ticket_id IS
    'Ticket ID.';

COMMENT ON COLUMN tickets.class_of_service IS
    'Class of service.';

COMMENT ON COLUMN tickets.flight_id IS
    'Flight ID.';

CREATE INDEX idx_flight_id ON
    tickets (
        flight_id
    ASC );

ALTER TABLE tickets ADD CONSTRAINT pk_tickets PRIMARY KEY ( ticket_id );

CREATE TABLE tours (
    tour_id     INTEGER NOT NULL,
    country     VARCHAR2(20) NOT NULL,
    city        VARCHAR2(50) NOT NULL,
    cost        NUMBER(15, 2) NOT NULL,
    operator_id INTEGER NOT NULL,
    hotel_id    INTEGER NOT NULL
);

COMMENT ON TABLE tours IS
    'Information about tours.';

COMMENT ON COLUMN tours.tour_id IS
    'Tour ID.';

COMMENT ON COLUMN tours.country IS
    'Country.';

COMMENT ON COLUMN tours.city IS
    'City.';

COMMENT ON COLUMN tours.cost IS
    'Cost.';

COMMENT ON COLUMN tours.operator_id IS
    'Operator ID.';

COMMENT ON COLUMN tours.hotel_id IS
    'Hotel ID.';

CREATE INDEX idx_operator_id ON
    tours (
        operator_id
    ASC );

CREATE INDEX idx_hotel_id ON
    tours (
        hotel_id
    ASC );

ALTER TABLE tours ADD CONSTRAINT pk_tours PRIMARY KEY ( tour_id );

CREATE TABLE tr_operators (
    operator_id   INTEGER NOT NULL,
    operator_name VARCHAR2(150) NOT NULL
);

COMMENT ON TABLE tr_operators IS
    'Information about tour operators.';

COMMENT ON COLUMN tr_operators.operator_id IS
    'Operator ID.';

COMMENT ON COLUMN tr_operators.operator_name IS
    'Title of the tour operator.';

ALTER TABLE tr_operators ADD CONSTRAINT pk_tr_operators PRIMARY KEY ( operator_id );

CREATE TABLE treaties (
    treaty_id   INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL,
    tour_id     INTEGER NOT NULL,
    ticket_id   INTEGER NOT NULL
);

COMMENT ON TABLE treaties IS
    'Information about treaties.';

COMMENT ON COLUMN treaties.treaty_id IS
    'Treaty ID.';

COMMENT ON COLUMN treaties.customer_id IS
    'Customer ID.';

COMMENT ON COLUMN treaties.employee_id IS
    'Employee ID.';

COMMENT ON COLUMN treaties.tour_id IS
    'Tour ID.';

COMMENT ON COLUMN treaties.ticket_id IS
    'Ticket ID.';

CREATE INDEX idx_treaties_customer_id ON
    treaties (
        customer_id
    ASC );

CREATE INDEX idx_treaties_employee_id ON
    treaties (
        employee_id
    ASC );

CREATE INDEX idx_treaties_tour_id ON
    treaties (
        tour_id
    ASC );

CREATE INDEX idx_treaties_ticket_id ON
    treaties (
        ticket_id
    ASC );

ALTER TABLE treaties ADD CONSTRAINT pk_treaties PRIMARY KEY ( treaty_id );

ALTER TABLE flights
    ADD CONSTRAINT fk_flights_airlines FOREIGN KEY ( airline_id )
        REFERENCES airlines ( airline_id );

ALTER TABLE pass_cust
    ADD CONSTRAINT fk_pass_cust_customers FOREIGN KEY ( customer_id )
        REFERENCES customers ( customer_id );

ALTER TABLE pass_cust
    ADD CONSTRAINT fk_pass_cust_passports FOREIGN KEY ( passport_id )
        REFERENCES passports ( passport_id );

ALTER TABLE staff
    ADD CONSTRAINT fk_staff_positions FOREIGN KEY ( position_id )
        REFERENCES positions ( position_id );

ALTER TABLE tickets
    ADD CONSTRAINT fk_tickets_flights FOREIGN KEY ( flight_id )
        REFERENCES flights ( flight_id );

ALTER TABLE tours
    ADD CONSTRAINT fk_tours_hotels FOREIGN KEY ( hotel_id )
        REFERENCES hotels ( hotel_id );

ALTER TABLE tours
    ADD CONSTRAINT fk_tours_tr_operators FOREIGN KEY ( operator_id )
        REFERENCES tr_operators ( operator_id );

ALTER TABLE treaties
    ADD CONSTRAINT fk_treaties_customers FOREIGN KEY ( customer_id )
        REFERENCES customers ( customer_id );

ALTER TABLE treaties
    ADD CONSTRAINT fk_treaties_staff FOREIGN KEY ( employee_id )
        REFERENCES staff ( employee_id );

ALTER TABLE treaties
    ADD CONSTRAINT fk_treaties_tickets FOREIGN KEY ( ticket_id )
        REFERENCES tickets ( ticket_id );

ALTER TABLE treaties
    ADD CONSTRAINT fk_treaties_tours FOREIGN KEY ( tour_id )
        REFERENCES tours ( tour_id );
        
DISCONNECT