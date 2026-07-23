-- =============================================================================
-- TASK 1: CREATE AUDIT AND ERROR LOG TABLES
-- =============================================================================

-- 1. Create the Unified Audit Log Table
CREATE TABLE dml_audit_log (
    audit_id            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    operation_type      VARCHAR2(10),     -- INSERT, UPDATE, or DELETE
    object_name         VARCHAR2(128),    -- Name of affected table
    operation_user      VARCHAR2(128),    -- DB user performing operation
    operation_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data            CLOB,             -- Data before change (UPDATE/DELETE)
    new_data            CLOB              -- Data after change (INSERT/UPDATE)
);

-- 2. Create the Error Log Table
CREATE TABLE error_log (
    error_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    procedure_name  VARCHAR2(128),
    error_message   VARCHAR2(4000),
    error_code      NUMBER,
    error_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =============================================================================
-- TASK 2: CREATE DML AUDIT TRIGGERS
-- =============================================================================

-- 1. Audit Trigger for ALLOWANCES
CREATE OR REPLACE TRIGGER trg_audit_allowances
AFTER INSERT OR UPDATE OR DELETE ON allowances
FOR EACH ROW
DECLARE
    v_op_type  VARCHAR2(10);
    v_old_data CLOB;
    v_new_data CLOB;
BEGIN
    IF INSERTING THEN
        v_op_type  := 'INSERT';
        v_new_data := 'ALLOWANCE_ID=' || :NEW.allowance_id || 
                      ', EMPLOYEE_ID=' || :NEW.employee_id || 
                      ', AMOUNT=' || :NEW.amount;
    ELSIF UPDATING THEN
        v_op_type  := 'UPDATE';
        v_old_data := 'ALLOWANCE_ID=' || :OLD.allowance_id || 
                      ', EMPLOYEE_ID=' || :OLD.employee_id || 
                      ', AMOUNT=' || :OLD.amount;
        v_new_data := 'ALLOWANCE_ID=' || :NEW.allowance_id || 
                      ', EMPLOYEE_ID=' || :NEW.employee_id || 
                      ', AMOUNT=' || :NEW.amount;
    ELSIF DELETING THEN
        v_op_type  := 'DELETE';
        v_old_data := 'ALLOWANCE_ID=' || :OLD.allowance_id || 
                      ', EMPLOYEE_ID=' || :OLD.employee_id || 
                      ', AMOUNT=' || :OLD.amount;
    END IF;

    INSERT INTO dml_audit_log (
        operation_type, object_name, operation_user, 
        operation_timestamp, old_data, new_data
    ) VALUES (
        v_op_type, 'ALLOWANCES', USER, 
        SYSTIMESTAMP, v_old_data, v_new_data
    );
END;
/

-- 2. Audit Trigger for ATTENDANCE
CREATE OR REPLACE TRIGGER trg_audit_attendance
AFTER INSERT OR UPDATE OR DELETE ON attendance
FOR EACH ROW
DECLARE
    v_op_type  VARCHAR2(10);
    v_old_data CLOB;
    v_new_data CLOB;
BEGIN
    IF INSERTING THEN
        v_op_type  := 'INSERT';
        v_new_data := 'ATTENDANCE_ID=' || :NEW.attendance_id || 
                      ', EMP_ID=' || :NEW.employee_id || 
                      ', STATUS=' || :NEW.status;
    ELSIF UPDATING THEN
        v_op_type  := 'UPDATE';
        v_old_data := 'ATTENDANCE_ID=' || :OLD.attendance_id || 
                      ', EMP_ID=' || :OLD.employee_id || 
                      ', STATUS=' || :OLD.status;
        v_new_data := 'ATTENDANCE_ID=' || :NEW.attendance_id || 
                      ', EMP_ID=' || :NEW.employee_id || 
                      ', STATUS=' || :NEW.status;
    ELSIF DELETING THEN
        v_op_type  := 'DELETE';
        v_old_data := 'ATTENDANCE_ID=' || :OLD.attendance_id || 
                      ', EMP_ID=' || :OLD.employee_id || 
                      ', STATUS=' || :OLD.status;
    END IF;

    INSERT INTO dml_audit_log (
        operation_type, object_name, operation_user, 
        operation_timestamp, old_data, new_data
    ) VALUES (
        v_op_type, 'ATTENDANCE', USER, 
        SYSTIMESTAMP, v_old_data, v_new_data
    );
END;
/

-- 3. Audit Trigger for COUNTRIES
CREATE OR REPLACE TRIGGER trg_audit_countries
AFTER INSERT OR UPDATE OR DELETE ON countries
FOR EACH ROW
DECLARE
    v_op_type  VARCHAR2(10);
    v_old_data CLOB;
    v_new_data CLOB;
BEGIN
    IF INSERTING THEN
        v_op_type  := 'INSERT';
        v_new_data := 'COUNTRY_ID=' || :NEW.country_id || 
                      ', COUNTRY_NAME=' || :NEW.country_name;
    ELSIF UPDATING THEN
        v_op_type  := 'UPDATE';
        v_old_data := 'COUNTRY_ID=' || :OLD.country_id || 
                      ', COUNTRY_NAME=' || :OLD.country_name;
        v_new_data := 'COUNTRY_ID=' || :NEW.country_id || 
                      ', COUNTRY_NAME=' || :NEW.country_name;
    ELSIF DELETING THEN
        v_op_type  := 'DELETE';
        v_old_data := 'COUNTRY_ID=' || :OLD.country_id || 
                      ', COUNTRY_NAME=' || :OLD.country_name;
    END IF;

    INSERT INTO dml_audit_log (
        operation_type, object_name, operation_user, 
        operation_timestamp, old_data, new_data
    ) VALUES (
        v_op_type, 'COUNTRIES', USER, 
        SYSTIMESTAMP, v_old_data, v_new_data
    );
END;
/

-- 4. Audit Trigger for DEPARTMENTS
CREATE OR REPLACE TRIGGER trg_audit_departments
AFTER INSERT OR UPDATE OR DELETE ON departments
FOR EACH ROW
DECLARE
    v_op_type  VARCHAR2(10);
    v_old_data CLOB;
    v_new_data CLOB;
BEGIN
    IF INSERTING THEN
        v_op_type  := 'INSERT';
        v_new_data := 'DEPT_ID=' || :NEW.department_id || 
                      ', DEPT_NAME=' || :NEW.department_name;
    ELSIF UPDATING THEN
        v_op_type  := 'UPDATE';
        v_old_data := 'DEPT_ID=' || :OLD.department_id || 
                      ', DEPT_NAME=' || :OLD.department_name;
        v_new_data := 'DEPT_ID=' || :NEW.department_id || 
                      ', DEPT_NAME=' || :NEW.department_name;
    ELSIF DELETING THEN
        v_op_type  := 'DELETE';
        v_old_data := 'DEPT_ID=' || :OLD.department_id || 
                      ', DEPT_NAME=' || :OLD.department_name;
    END IF;

    INSERT INTO dml_audit_log (
        operation_type, object_name, operation_user, 
        operation_timestamp, old_data, new_data
    ) VALUES (
        v_op_type, 'DEPARTMENTS', USER, 
        SYSTIMESTAMP, v_old_data, v_new_data
    );
END;
/

-- 5. Audit Trigger for EMPLOYEES
CREATE OR REPLACE TRIGGER trg_audit_employees
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
DECLARE
    v_op_type  VARCHAR2(10);
    v_old_data CLOB;
    v_new_data CLOB;
BEGIN
    IF INSERTING THEN
        v_op_type  := 'INSERT';
        v_new_data := 'EMP_ID=' || :NEW.employee_id || 
                      ', NAME=' || :NEW.first_name || ' ' || :NEW.last_name;
    ELSIF UPDATING THEN
        v_op_type  := 'UPDATE';
        v_old_data := 'EMP_ID=' || :OLD.employee_id || 
                      ', NAME=' || :OLD.first_name || ' ' || :OLD.last_name;
        v_new_data := 'EMP_ID=' || :NEW.employee_id || 
                      ', NAME=' || :NEW.first_name || ' ' || :NEW.last_name;
    ELSIF DELETING THEN
        v_op_type  := 'DELETE';
        v_old_data := 'EMP_ID=' || :OLD.employee_id || 
                      ', NAME=' || :OLD.first_name || ' ' || :OLD.last_name;
    END IF;

    INSERT INTO dml_audit_log (
        operation_type, object_name, operation_user, 
        operation_timestamp, old_data, new_data
    ) VALUES (
        v_op_type, 'EMPLOYEES', USER, 
        SYSTIMESTAMP, v_old_data, v_new_data
    );
END;
/

-- 6. Audit Trigger for ROLES
CREATE OR REPLACE TRIGGER trg_audit_roles
AFTER INSERT OR UPDATE OR DELETE ON roles
FOR EACH ROW
DECLARE
    v_op_type  VARCHAR2(10);
    v_old_data CLOB;
    v_new_data CLOB;
BEGIN
    IF INSERTING THEN
        v_op_type  := 'INSERT';
        v_new_data := 'ROLE_ID=' || :NEW.role_id || 
                      ', ROLE_NAME=' || :NEW.role_name;
    ELSIF UPDATING THEN
        v_op_type  := 'UPDATE';
        v_old_data := 'ROLE_ID=' || :OLD.role_id || 
                      ', ROLE_NAME=' || :OLD.role_name;
        v_new_data := 'ROLE_ID=' || :NEW.role_id || 
                      ', ROLE_NAME=' || :NEW.role_name;
    ELSIF DELETING THEN
        v_op_type  := 'DELETE';
        v_old_data := 'ROLE_ID=' || :OLD.role_id || 
                      ', ROLE_NAME=' || :OLD.role_name;
    END IF;

    INSERT INTO dml_audit_log (
        operation_type, object_name, operation_user, 
        operation_timestamp, old_data, new_data
    ) VALUES (
        v_op_type, 'ROLES', USER, 
        SYSTIMESTAMP, v_old_data, v_new_data
    );
END;
/


-- =============================================================================
-- TASK 3: STORED PROCEDURES WITH EXCEPTION HANDLING
-- =============================================================================

-- Procedure 1: Update Allowance
CREATE OR REPLACE PROCEDURE sp_update_allowance (
    p_allowance_id IN allowances.allowance_id%TYPE,
    p_new_amount   IN allowances.amount%TYPE
) AS
    e_no_rows_updated EXCEPTION;
BEGIN
    UPDATE allowances
    SET amount = p_new_amount
    WHERE allowance_id = p_allowance_id;

    IF SQL%NOTFOUND THEN
        RAISE e_no_rows_updated;
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN e_no_rows_updated THEN
        INSERT INTO error_log (procedure_name, error_message, error_code)
        VALUES ('sp_update_allowance', 'No record found with Allowance ID: ' || p_allowance_id, -20001);
        ROLLBACK;
    WHEN OTHERS THEN
        INSERT INTO error_log (procedure_name, error_message, error_code)
        VALUES ('sp_update_allowance', SQLERRM, SQLCODE);
        ROLLBACK;
END;
/

-- Procedure 2: Delete Allowance
CREATE OR REPLACE PROCEDURE sp_delete_allowance (
    p_allowance_id IN allowances.allowance_id%TYPE
) AS
    e_no_rows_deleted EXCEPTION;
BEGIN
    DELETE FROM allowances
    WHERE allowance_id = p_allowance_id;

    IF SQL%NOTFOUND THEN
        RAISE e_no_rows_deleted;
    END IF;

    COMMIT;
EXCEPTION
    WHEN e_no_rows_deleted THEN
        INSERT INTO error_log (procedure_name, error_message, error_code)
        VALUES ('sp_delete_allowance', 'No record found to delete with Allowance ID: ' || p_allowance_id, -20002);
        ROLLBACK;
    WHEN OTHERS THEN
        INSERT INTO error_log (procedure_name, error_message, error_code)
        VALUES ('sp_delete_allowance', SQLERRM, SQLCODE);
        ROLLBACK;
END;
/


-- =============================================================================
-- TASK 4: TESTING & VALIDATION
-- =============================================================================

-- Test 1: INSERT Operation
INSERT INTO allowances (allowance_id, employee_id, amount) 
VALUES (101, 5001, 1500.00);
COMMIT;

-- Test 2: UPDATE Operation via Stored Procedure
EXEC sp_update_allowance(101, 1800.00);

-- Test 3: DELETE Operation via Stored Procedure
EXEC sp_delete_allowance(101);

-- Test 4: ERROR HANDLING (Updating non-existent record)
EXEC sp_update_allowance(9999, 2000.00);


-- =============================================================================
-- VALIDATION QUERIES
-- =============================================================================

-- Query the Audit Log Table
SELECT audit_id, operation_type, object_name, operation_user, 
       TO_CHAR(operation_timestamp, 'YYYY-MM-DD HH24:MI:SS') AS timestamp,
       old_data, new_data 
FROM dml_audit_log 
ORDER BY audit_id ASC;

-- Query the Error Log Table
SELECT error_id, procedure_name, error_code, error_message, 
       TO_CHAR(error_timestamp, 'YYYY-MM-DD HH24:MI:SS') AS timestamp 
FROM error_log 
ORDER BY error_id ASC;