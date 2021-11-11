CREATE OR REPLACE TRIGGER T_B_CUSTOMERS
                             BEFORE INSERT 
                                    ON CUSTOMERS
                                    FOR EACH ROW
                           BEGIN
                                IF :NEW.CUSTOMER_ID IS NULL THEN 
                                    SELECT SEQ_CUSTOMERS.NEXTVAL
                                        INTO :NEW.CUSTOMER_ID
                                    FROM dual;
                                END IF;
                           END;
