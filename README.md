# Oracle_cdc
Guide to setup Oraclecdc with streamsets

# some steps to follow, 
1. if you dont have you might want to setup a oracle instance if this is for home use. 
2. Will provide some commands for you so can paste into your vm


.... Somethings you need to install beforehand is docker, follow this guide.


Here it will come boxes for easy copy and pasting for the commands needed!


Need to install the docker image.

follow these steps 



`ALTER SESSION SET container=PDB1;`

`Alter session set container=PDB1;

create tablespace streamsets_tabspace datafile 'streamsets_tabspace.dat' size 10M autoextend on;

create temporary tablespace streamsets_tabspace1_temp tempfile 'streamsets_tabspace1_temp.dat' size 5M autoextend on;

create user streamsets identified by 123456 default tablespace streamsets_tabspace temporary tablespace streamsets_tabspace1_temp;

grant create session to Streamsets;

grant create table to Streamsets;

grant unlimited tablespace to Streamsets;

select current_scn from v$database; `

