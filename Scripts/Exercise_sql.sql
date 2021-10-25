--Author Mixailenko Eduard
--Date: 25.10.2021

--DDL queries
--Creating table
CREATE TABLE cities (
    city_id INTEGER NOT NULL,
    country VARCHAR(150) NOT NULL,
    title VARCHAR(150) NOT NULL
);

--Adding a primary key to a table
ALTER TABLE cities
    ADD CONSTRAINT pk_cities PRIMARY KEY (city_id);

--Renaming title column to the city_name
ALTER TABLE cities
    RENAME COLUMN title TO city_name;

--Changing country column to unused
ALTER TABLE cities 
    SET UNUSED COLUMN country;

--Deleting unused columns
ALTER TABLE cities
    DROP UNUSED COLUMNS;

--Deleting data from a table 
TRUNCATE TABLE cities;

--Creating sequences for tables
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
    
--DML queries to fill all tables
--For passports table
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4279, 178988, 'УФМС России в г.Октябрьский',
    TO_DATE('16.11.2018','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4918 , 122717, 'УВД г.Батайск',
    TO_DATE('13.02.2021','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL,4970 , 186430, 'ОВД России по г.Северск',
    TO_DATE('15.05.2020','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4919, 804008, 'УФМС России по г.Химки',
    TO_DATE('29.12.2019','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4139, 423983, 'ОВД России по г.Хабаровск',
    TO_DATE('21.07.2015','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4420, 262971, 'УФМС России по г.Тверь',
    TO_DATE('27.02.2013','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4187, 301697, 'ОУФМС России по г.Киров',
    TO_DATE('03.03.2014','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4586, 642120, 'УФМС России в г.Златоуст',
    TO_DATE('14.10.2015','dd.mm.yyyy'));

INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4873, 838200, 'ОВД России по г.Москва',
    TO_DATE('15.09.2020','dd.mm.yyyy'));

INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 4546, 746896, 'ОУФМС России по г.Балаково',
    TO_DATE('26.01.2013','dd.mm.yyyy'));
    
INSERT INTO passports(passport_id, series, passport_num, issued_by, date_of_issue)
    VALUES(passports_seq.NEXTVAL, 72, 3463128, 'ФМС 525133',
    TO_DATE('09.03.2013','dd.mm.yyyy'));

--For customers table
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Завражина', 'Ася', 'Венедиктовна',
        TO_DATE('21.12.1980','dd.mm.yyyy'), '+79701732691');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Щедрин', 'Афанасий', 'Макарович',
        TO_DATE('07.12.1976','dd.mm.yyyy'), '+79224299592');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Горелов', 'Егор', 'Львович',
        TO_DATE('11.11.1973','dd.mm.yyyy'), '+79967438854');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Мамкин', 'Ефим', 'Антонович',
        TO_DATE('08.08.1980','dd.mm.yyyy'), '+79970301633');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Высоцкий', 'Игнат', 'Николаевич',
        TO_DATE('18.07.1982','dd.mm.yyyy'), '+79493084893');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Справцева', 'Любовь', 'Аркадивна',
        TO_DATE('24.06.1985','dd.mm.yyyy'), '+79279774900');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Бабичева', 'Мария', 'Кирилловна',
        TO_DATE('18.11.1970','dd.mm.yyyy'), '+79850609591');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Бакаринцев', 'Павел', 'Панкратович',
        TO_DATE('17.12.1961','dd.mm.yyyy'), '+79540828642');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Клычева', 'Полина', 'Антоновна',
        TO_DATE('09.06.1968','dd.mm.yyyy'), '+79404120891');
    
INSERT INTO customers(customer_id, last_name, first_name, surname, birthdate, phone_number)
    VALUES(customers_seq.NEXTVAL, 'Аронова', 'Елена', 'Яковна',
        TO_DATE('01.09.1974','dd.mm.yyyy'), '+79127022948');
    
--For pass_cust table
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 1, 1);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 2, 2);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 3, 3);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 4, 4);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 5, 5);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 6, 6);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 7, 7);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 8, 8);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 9, 9);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 10, 10);
INSERT INTO pass_cust(pass_cust_id, customer_id, passport_id) VALUES(pass_cust_seq.NEXTVAL, 10, 11);
    
--For positions table
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Директор');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Заместитель директора');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Менеджер по бронированию и продажам');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Менеджер по маркетингу и рекламе');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Менеджер по работе с клиентами');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Менеджер по кадрам');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Бухгалтер');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Агент по бронированию');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Агент по продажам');
    
INSERT INTO positions(position_id, position_name)
    VALUES(positions_seq.NEXTVAL, 'Стажер');
    
--For staff table
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Турова', 'Евгения', 'Валерьевна',
        'г.Невинномысск, Лесной пер., д.11 кв.54', '+79857625075', 3);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Тукай', 'Настасья', 'Алексеевна',
        'г.Уссурийск, Гагарина ул., д.2 кв.60', '+79902609522', 10);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Набережная', 'Ева', 'Феоктистова',
        'г.Раменское, Заслонова ул., д.9 кв.16', '+79895110906', 9);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Жиренкова', 'Екатерина', 'Валентиновна',
        'г.Хасавюрт, Заречный пер., д.1 кв.75', '+79496307121', 8);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Беляков', 'Филипп', 'Максимович',
        'г.Томск, Дачная ул., д.15 кв.140', '+79083047687', 2);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Корольков', 'Илья', 'Сергеевич',
        'г.Камышин, Школьный пер., д.19 кв.98', '+79491789982', 1);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Камкин', 'Аркадий', 'Филиппович',
        'г.Северодвинск, Лесная ул., д.20 кв.86', '+79035730701', 7);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Агальцова', 'Оксана', 'Прохоровна',
        'г.Ульяновск, Чкалова ул., д.24 кв.184', '+79087795437', 6);
        
INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Нустров', 'Макар', 'Игнатьевич',
        'г.Коломна, Садовая ул., д.23 кв.105', '+79401746978', 4);

INSERT INTO staff(employee_id,last_name,first_name,surname,address,phone_number,position_id)
    VALUES(staff_seq.NEXTVAL, 'Эрдниев', 'Валерий', 'Леонидович',
        'г.Кызыл, Березовая ул., д.1 кв.181', '+79344258110', 5);
        
--For hotels table
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'GrandPocc', '5', '7/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Москва', '4', '5/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Busan', '6', '7/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Anilana', '3', '4/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'AVANI', '4', '6/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Super Lanka', '6', '5/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Heritan', '4', '4/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Parus', '3', '5/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Hilton', '6', '4/10');
INSERT INTO hotels(hotel_id, hotel_name, star_rating, rating)
    VALUES(hotels_seq.NEXTVAL, 'Amoroma', '5', '5/10');
    
--For tr_operators table
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Alean');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Anex Tour');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Biblio Globus');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Coral');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Delfin');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Pac Group');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Panteon');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Pegas Touristik');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'PlanTravel');
INSERT INTO tr_operators(operator_id, operator_name)
    VALUES(tr_operators_seq.NEXTVAL, 'Premiera');
    
--For tours table
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Austria', 'Vienna', 45000, 1, 4);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'France', 'Paris', 60000, 4, 2);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Germany', 'Hamburg', 47000, 2, 3);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Italy', 'Rome', 73000, 3, 1);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Spain', 'Madrid', 64000, 9, 6);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Hungary', 'Budapest', 55000, 5, 7);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Denmark', 'Copenhagen', 80000, 6, 5);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Portugal', 'Lisbon', 77000, 7, 8);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Estonia', 'Tallinn', 64000, 8, 10);
    
INSERT INTO tours(tour_id, country, city, cost, operator_id, hotel_id)
    VALUES(tours_seq.NEXTVAL, 'Turkey', 'Istanbul', 67000, 10, 9);
    
--For airlines table
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Red Wings');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Smartavia');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Azur air');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Nordwind');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Utair');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Ural airlines');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Rossiya');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Победа');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'S7 Airlines');
INSERT INTO airlines(airline_id, airline_name) VALUES(airlines_seq.NEXTVAL, 'Aeroflot');

--For flights table
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('12.05.2021','DD.MM.YYYY'),
        TO_DATE('12.05.2021 12:15:30', 'dd.mm.yyyy hh24:mi:ss'), 1);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('12.05.2021','dd.mm.yyyy'),
        TO_DATE('12.05.2021 12:30:30', 'dd.mm.yyyy hh24:mi:ss'), 2);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('12.05.2021','dd.mm.yyyy'), 
        TO_DATE('12.05.2021 13:10:00', 'dd.mm.yyyy hh24:mi:ss'), 3);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('12.05.2021','dd.mm.yyyy'), 
        TO_DATE('12.05.2021 13:35:00', 'dd.mm.yyyy hh24:mi:ss'), 4);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('13.05.2021','dd.mm.yyyy'),
        TO_DATE('13.05.2021 13:50:00', 'dd.mm.yyyy hh24:mi:ss'), 5);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('13.05.2021','dd.mm.yyyy'),
        TO_DATE('13.05.2021 14:25:00', 'dd.mm.yyyy hh24:mi:ss'), 6);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('13.05.2021','dd.mm.yyyy'),
        TO_DATE('13.05.2021 15:10:00', 'dd.mm.yyyy hh24:mi:ss'), 7);
        
INSERT INTO flights(flight_id, departure_date, departure_time, airline_id)
    VALUES(flights_seq.NEXTVAL, TO_DATE('13.05.2021','dd.mm.yyyy'),
        TO_DATE('12.05.2021 15:50:00', 'dd.mm.yyyy hh24:mi:ss'), 8);

--For tickets table
INSERT INTO tickets(ticket_id, class_of_service, flight_id)
    VALUES (tickets_seq.NEXTVAL, 'first', 1);
INSERT INTO tickets(ticket_id, class_of_service, flight_id)
    VALUES (tickets_seq.NEXTVAL, 'economy', 2);
INSERT INTO tickets(ticket_id, class_of_service, flight_id)
    VALUES (tickets_seq.NEXTVAL, 'first', 3);
INSERT INTO tickets(ticket_id, class_of_service, flight_id)
    VALUES (tickets_seq.NEXTVAL, 'business', 4);
INSERT INTO tickets(ticket_id, class_of_service, flight_id)
    VALUES (tickets_seq.NEXTVAL, 'business', 5);
    
--For treaties table
INSERT INTO  treaties(treaty_id, customer_id, employee_id, tour_id, ticket_id)
    VALUES(treaties_seq.NEXTVAL, 1, 3, 1, 1);
INSERT INTO  treaties(treaty_id, customer_id, employee_id, tour_id, ticket_id)
    VALUES(treaties_seq.NEXTVAL, 2, 3, 2, 2);
INSERT INTO  treaties(treaty_id, customer_id, employee_id, tour_id, ticket_id)
    VALUES(treaties_seq.NEXTVAL, 3, 3, 5, 3);
INSERT INTO  treaties(treaty_id, customer_id, employee_id, tour_id, ticket_id)
    VALUES(treaties_seq.NEXTVAL, 4, 5, 6, 4);
INSERT INTO  treaties(treaty_id, customer_id, employee_id, tour_id, ticket_id)
    VALUES(treaties_seq.NEXTVAL, 5, 5, 7, 5);