--For user tables
DECLARE
    v_ddl CLOB;
    v_object_type VARCHAR(50) := 'TABLE';
    v_object_name VARCHAR(50) := 'AIRLINES';
BEGIN
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
    dbms_metadata.set_transform_param(dbms_metadata.session_transform,'TABLESPACE',false);
    v_ddl := DBMS_METADATA.get_ddl(v_object_type, v_object_name);
    DBMS_OUTPUT.PUT_LINE(v_ddl);
END;
/
/* Result:
CREATE TABLE "INTERN"."AIRLINES" 
   (	"AIRLINE_ID" NUMBER(*,0) NOT NULL ENABLE, 
        "AIRLINE_NAME" VARCHAR2(150) NOT NULL ENABLE, 
        CONSTRAINT "PK_AIRLINES" PRIMARY KEY ("AIRLINE_ID")
        USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
*/

--For user indexes
DECLARE
    v_ddl CLOB;
    v_object_type VARCHAR(50) := 'INDEX';
    v_object_name VARCHAR(50) := 'IDX_HOTEL_ID';
BEGIN
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
    dbms_metadata.set_transform_param(dbms_metadata.session_transform,'TABLESPACE',false);
    v_ddl := DBMS_METADATA.get_ddl(v_object_type, v_object_name);
    DBMS_OUTPUT.PUT_LINE(v_ddl);
END;
/

/*  Result:
CREATE INDEX "INTERN"."IDX_HOTEL_ID" ON "INTERN"."TOURS" ("HOTEL_ID") 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
*/

--For user sequences
DECLARE
    v_ddl CLOB;
    v_object_type VARCHAR(50) := 'SEQUENCE';
    v_object_name VARCHAR(50) := 'AIRLINES_SEQ';
BEGIN
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
    dbms_metadata.set_transform_param(dbms_metadata.session_transform,'TABLESPACE',false);
    v_ddl := DBMS_METADATA.get_ddl(v_object_type, v_object_name);
    DBMS_OUTPUT.PUT_LINE(v_ddl);
END;
/

/*  Result:
    CREATE SEQUENCE  "INTERN"."AIRLINES_SEQ"  
    MINVALUE 1 
    MAXVALUE 9999999999999999999999999999 
    INCREMENT BY 1 
    START WITH 21 
    CACHE 20 
    NOORDER  
    NOCYCLE
*/

--For user triggers
DECLARE
    v_ddl CLOB;
    v_object_type VARCHAR(50) := 'TRIGGER';
    v_object_name VARCHAR(50) := 'T_B_CUSTOMERS';
BEGIN
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
    dbms_metadata.set_transform_param(dbms_metadata.session_transform,'TABLESPACE',false);
    v_ddl := DBMS_METADATA.get_ddl(v_object_type, v_object_name);
    DBMS_OUTPUT.PUT_LINE(v_ddl);
END;
/

/*  Result:
CREATE OR REPLACE TRIGGER "INTERN"."T_B_CUSTOMERS" 
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

ALTER TRIGGER "INTERN"."T_B_CUSTOMERS" ENABLE
*/

--For user packages
DECLARE
    v_ddl CLOB;
    v_object_type VARCHAR(50) := 'PACKAGE';
    v_object_name VARCHAR(50) := 'PKG_PASSPORTS';
BEGIN
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',false);
    DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true);
    dbms_metadata.set_transform_param(dbms_metadata.session_transform,'TABLESPACE',false);
    v_ddl := DBMS_METADATA.get_ddl(v_object_type, v_object_name);
    DBMS_OUTPUT.PUT_LINE(v_ddl);
END;
/

/* Result:
CREATE OR REPLACE PACKAGE "INTERN"."PKG_PASSPORTS" AS 
    PROCEDURE p_create_passport(p_new_series IN passports.series%TYPE,
                                p_new_passport_num IN passports.passport_num%TYPE,
                                p_new_issued_by IN passports.issued_by%TYPE,
                                p_new_date_of_issue IN passports.date_of_issue%TYPE);
    PROCEDURE p_read_passport;
    PROCEDURE p_update_passport(p_passport_id IN passports.passport_id%TYPE,
                                p_new_series IN passports.series%TYPE,
                                p_new_passport_num IN passports.passport_num%TYPE,
                                p_new_issued_by IN passports.issued_by%TYPE,
                                p_new_date_of_issue IN passports.date_of_issue%TYPE);
    PROCEDURE p_delete_passport(p_passport_id IN passports.passport_id%TYPE);
END pkg_passports;

CREATE OR REPLACE PACKAGE BODY "INTERN"."PKG_PASSPORTS" AS
    PROCEDURE p_create_passport(p_new_series IN passports.series%TYPE,
                                p_new_passport_num IN passports.passport_num%TYPE,
                                p_new_issued_by IN passports.issued_by%TYPE,
                                p_new_date_of_issue IN passports.date_of_issue%TYPE) IS
        v_ins_passport_id passports.passport_id%TYPE;
        null_err EXCEPTION;
    BEGIN
        IF (p_new_series IS NOT NULL AND
            p_new_passport_num IS NOT NULL AND
            p_new_issued_by IS NOT NULL AND 
            p_new_date_of_issue IS NOT NULL)THEN
            INSERT INTO passports(series, passport_num, issued_by, date_of_issue)
                VALUES(p_new_series, p_new_passport_num, p_new_issued_by, p_new_date_of_issue)
                RETURNING passport_id INTO v_ins_passport_id;
            COMMIT;
            DBMS_OUTPUT.put_line(SQLCODE()||': Record inserted successfully. Record id = ' || v_ins_passport_id);
        ELSE 
            RAISE null_err;
        END IF;
    EXCEPTION
        WHEN null_err THEN
            DBMS_OUTPUT.put_line(SQLCODE()||': The value is NULL. Enter the correct value');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_create_passport;
    
    ...etc...
*/

