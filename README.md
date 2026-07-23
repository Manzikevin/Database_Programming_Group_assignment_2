## 👨‍💻 My Contribution

As a member of this project, I contributed by:

- Creating the `AUDIT` table to store database audit logs.
- Creating the `ERROR_LOG` table for exception logging.
- Developing PL/SQL triggers for INSERT, UPDATE, and DELETE operations.
- Writing stored procedures to update and delete allowance records.
- Implementing exception handling and automatic error logging.
- Testing all database operations to verify the auditing system.
- Writing clean, well-commented Oracle SQL/PLSQL code.

### Technologies Used
- Oracle SQL
- Oracle PL/SQL
- Database Triggers
- Stored Procedures
- Exception Handling
- Git & GitHub

| No. | Full Name | Registration Number | Role / Contribution |
|:---:|:---|:---:|:---|
| 1 | **Manzi Irakoze Kevin** | `33205/2025` | Audit & Error Log Schema Design |
| 2 | **[Kipling Bowier]** | `[30713/2025]` | DML Audit Triggers (`ALLOWANCES`, `ATTENDANCE`, `COUNTRIES`) |
| 3 | **Kula C.Y Massally** | `30884/2025` | DML Audit Triggers (`DEPARTMENTS`, `EMPLOYEES`, `ROLES`) |
| 4 | **[John Bondo]** | `[33365/2025]` | Stored Procedures (`sp_update_allowance`, `sp_delete_allowance`) & Error Handling |
| 5 | **[Joshua s Karbar]** | `[31386/2025]` | Test Suite Execution, Validation & Query Verification |

---

## System Architecture & Technical Tasks

### Task 1: Audit Table & Error Log Table
* **`dml_audit_log`**: Unified audit table tracking the operation type (`INSERT`, `UPDATE`, `DELETE`), target object (`object_name`), connected database user (`operation_user`), execution timestamp, and snapshots of pre/post-operation record data (`old_data`, `new_data`) stored as `CLOB`.
* **`error_log`**: Dedicated repository for runtime exceptions capturing the procedure name, Oracle error message (`SQLERRM`), SQL error code (`SQLCODE`), and error timestamp.

### Task 2: DML Audit Triggers
[Row-level `AFTER INSERT OR UPDATE OR DELETE` triggers configured across 6 audited banking entities:
* `trg_audit_allowances` (`ALLOWANCES`) 
* `trg_audit_attendance` (`ATTENDANCE`) 
* `trg_audit_countries` (`COUNTRIES`) 
* `trg_audit_departments` (`DEPARTMENTS`) 
* `trg_audit_employees` (`EMPLOYEES`) 
* `trg_audit_roles` (`ROLES`) 

### Task 3: Stored Procedures & Exception Handling
* **`sp_update_allowance`**: Updates record values, checks row modification via `SQL%NOTFOUND`, handles non-existent IDs with custom exceptions, and logs errors into `error_log` without crashing the application.
* **`sp_delete_allowance`**: Performs safe record deletion with explicit transaction control (`COMMIT` / `ROLLBACK`) and automatic error logging.

### Task 4: Testing & Verification Suite
Comprehensive test script running automated `INSERT`, `UPDATE`, and `DELETE` operations alongside intentionally failing transactions (e.g., updating non-existent records) to prove exception capture and log generation.

---

## Infrastructure & Connection Setup

* **Database Container**: Oracle Database 21c Express Edition (`gvenzl/oracle-xe:21-slim`)
* **Container Database (CDB)**: `XE` 
* **Pluggable Database (PDB)**: `XEPDB1`
* **IDE**: VS Code with **Oracle SQL Developer for VSCode** extension 

### Docker Setup Command
```bash
docker run -d --name oracle21c \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PASSWORD=admin \
  gvenzl/oracle-xe:21-slim

***
