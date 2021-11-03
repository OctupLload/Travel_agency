CREATE OR REPLACE PACKAGE pkg_passports AS 
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
/

CREATE OR REPLACE PACKAGE BODY pkg_passports AS
    PROCEDURE p_create_passport(p_new_series IN passports.series%TYPE,
                                p_new_passport_num IN passports.passport_num%TYPE,
                                p_new_issued_by IN passports.issued_by%TYPE,
                                p_new_date_of_issue IN passports.date_of_issue%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF (p_new_series IS NOT NULL AND
            p_new_passport_num IS NOT NULL AND
            p_new_issued_by IS NOT NULL AND 
            p_new_date_of_issue IS NOT NULL)THEN
            INSERT INTO passports(series, passport_num, issued_by, date_of_issue)
                VALUES(p_new_series, p_new_passport_num, p_new_issued_by, p_new_date_of_issue);
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
    END p_create_passport;
    
    PROCEDURE p_read_passport IS
        v_passport_id passports.passport_id%TYPE;
        v_series passports.series%TYPE;
        v_passport_num passports.passport_num%TYPE;
        v_issued_by passports.issued_by%TYPE;
        v_date_of_issue passports.date_of_issue%TYPE;
        CURSOR cur_read_passport IS
            SELECT passport_id, series, passport_num, issued_by, date_of_issue
            FROM passports;
    BEGIN
        DBMS_OUTPUT.put_line('passport_id  series  passport_num  issued_by  date_of_issue');
        OPEN cur_read_passport;
            LOOP
                FETCH cur_read_passport
                    INTO v_passport_id, v_series, v_passport_num, v_issued_by, v_date_of_issue;
                EXIT WHEN cur_read_passport%NOTFOUND;  
                DBMS_OUTPUT.put(v_passport_id||'  '||v_series||'  '||v_passport_num||'  ');
                DBMS_OUTPUT.put_line(v_issued_by||'  '||v_date_of_issue);
            END LOOP;
        CLOSE cur_read_passport;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLCODE || ': ' || SQLERRM);
    END p_read_passport;
    
    PROCEDURE p_update_passport(p_passport_id IN passports.passport_id%TYPE,
                                p_new_series IN passports.series%TYPE,
                                p_new_passport_num IN passports.passport_num%TYPE,
                                p_new_issued_by IN passports.issued_by%TYPE,
                                p_new_date_of_issue IN passports.date_of_issue%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF (p_passport_id IS NOT NULL AND
            p_new_series IS NOT NULL AND
            p_new_passport_num IS NOT NULL AND
            p_new_issued_by IS NOT NULL AND
            p_new_date_of_issue IS NOT NULL) THEN
                UPDATE passports
                SET series = p_new_series,
                    passport_num = p_new_passport_num,
                    issued_by = p_new_issued_by,
                    date_of_issue = p_new_date_of_issue
                WHERE passport_id = p_passport_id;
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
    END p_update_passport;
    
    PROCEDURE p_delete_passport(p_passport_id IN passports.passport_id%TYPE) IS
        null_err EXCEPTION;
    BEGIN
        IF p_passport_id IS NOT NULL THEN
            DELETE FROM passports
            WHERE passport_id = p_passport_id;
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
    END p_delete_passport;
END pkg_passports;
/