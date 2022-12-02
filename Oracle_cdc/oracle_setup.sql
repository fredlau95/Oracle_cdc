select name from V$database;

Alter session set container=PDB1;

create tablespace streamsets_tabspace datafile 'streamsets_tabspace.dat' size 10M autoextend on;

create temporary tablespace streamsets_tabspace1_temp tempfile 'streamsets_tabspace1_temp.dat' size 5M autoextend on;

create user streamsets identified by 123456 default tablespace streamsets_tabspace temporary tablespace streamsets_tabspace1_temp;

grant create session to Streamsets;

grant create table to Streamsets;

grant unlimited tablespace to Streamsets;

select current_scn from v$database;

ALTER SESSION SET container=cdb$root;

CREATE USER c##streamsets IDENTIFIED BY "streamsets" container=ALL;

GRANT CREATE SESSION, ALTER SESSION, SET container, SELECT ANY dictionary, logmining, execute_catalog_role TO c##streamsets container=ALL;

GRANT CREATE SESSION TO c##streamsets CONTAINER=ALL;

GRANT SET CONTAINER TO c##streamsets CONTAINER=ALL;

GRANT SELECT ON V_$DATABASE TO c##streamsets CONTAINER=ALL;

GRANT FLASHBACK ANY TABLE TO c##streamsets CONTAINER=ALL;

GRANT SELECT ANY TABLE TO c##streamsets CONTAINER=ALL;

GRANT SELECT_CATALOG_ROLE TO c##streamsets CONTAINER=ALL;

GRANT EXECUTE_CATALOG_ROLE TO c##streamsets CONTAINER=ALL;

GRANT SELECT ANY TRANSACTION TO c##streamsets CONTAINER=ALL;

GRANT SELECT ANY DICTIONARY TO c##streamsets CONTAINER=ALL;

GRANT LOGMINING TO c##streamsets CONTAINER=ALL;

GRANT CREATE TABLE TO c##streamsets CONTAINER=ALL;

GRANT LOCK ANY TABLE TO c##streamsets CONTAINER=ALL;

GRANT CREATE SEQUENCE TO c##streamsets CONTAINER=ALL;

GRANT EXECUTE ON DBMS_LOGMNR TO c##streamsets CONTAINER=ALL;

GRANT EXECUTE ON DBMS_LOGMNR_D TO c##streamsets CONTAINER=ALL;

GRANT SELECT ON V_$LOGMNR_LOGS TO c##streamsets CONTAINER=ALL;

GRANT SELECT ON V_$LOGMNR_CONTENTS TO c##streamsets CONTAINER=ALL;

GRANT SELECT ON V_$LOGFILE TO c##streamsets CONTAINER=ALL;

GRANT SELECT ON V_$ARCHIVED_LOG TO c##streamsets CONTAINER=ALL;

GRANT SELECT ON V_$ARCHIVE_DEST_STATUS TO c##streamsets CONTAINER=ALL;

ALTER SESSION SET container=cdb$root;

shutdown immediate;

startup mount;

ALTER DATABASE archivelog;

ALTER DATABASE OPEN;

SELECT supplemental_log_data_min, supplemental_log_data_pk, supplemental_log_data_all FROM v$database;

ALTER DATABASE ADD supplemental LOG data;

SELECT supplemental_log_data_min, supplemental_log_data_pk, supplemental_log_data_all FROM v$database;

ALTER SYSTEM switch logfile;

ALTER SESSION SET container=PDB1;

CREATE USER test01 IDENTIFIED BY test01;

GRANT CONNECT,RESOURCE TO test01;

ALTER USER test01 quota unlimited ON users;

CREATE TABLE test01.table01 (column1 varchar2(10),column2 integer);

ALTER TABLE test01.table01 ADD supplemental LOG data (PRIMARY KEY) columns;

INSERT INTO test01.table01 VALUES('One',1);

select value from v$parameter where name='service_names';

SELECT * FROM dba_log_groups WHERE owner='TEST01';

/* to set Redo Logs */

ALTER SESSION SET container=cdb$root;

EXECUTE dbms_logmnr_d.build(options=> dbms_logmnr_d.store_in_redo_logs);