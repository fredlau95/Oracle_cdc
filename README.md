# Oracle_cdc
Guide to setup Oraclecdc with streamsets,
Noticed now after trying to set up Oracle than it cant run on the always free option since the memory is to little and sql will crash. 

# some steps to follow, 
1. if you dont have you might want to setup a oracle instance if this is for home use and playing around. You get 30 days for free on the site. 
2. Will provide some commands for you so can paste into your vm

## Follow this guide to install the docker on Oracle. 

Somethings you need to install beforehand is the docker image. Follow this guide to step 5. 
[Docker download](https://geekscircuit.com/how-to-install-docker-on-oracle-linux-8-7/)

Here it will come boxes for easy copy and pasting for the commands needed!

## Follow these steps to connect to the sql, and to send it to snowflake with streamsets.
follow these steps 

Use this command on the ssh key you downloaded

`chmod 400 your key name`

Log in and accept, then run this command

login in here and accept the terms for enterprise in the database section container-registry.oracle.com
[Container-oracle](https://container-registry.oracle.com)

`sudo docker pull container-registry.oracle.com/database/enterprise:latest`

Then run this

`docker run -d --name oraclecdc -p 1521:1521 -e ORACLE_SID="change this" -e ORACLE_PDB=PDB1 -e ORACLE_PWD="change this" -e ENABLE_ARCHIVELOG=true  container-registry.oracle.com/database/enterprise:latest`

Then run: 

`sudo docker exec -it oraclecdc bash`
then run:

`sqlplus sys as sysdba`

Putt in your password that you choose from the docker run command

## Next part is to connect to streamsets:

`select name from V$database;`


`ALTER SESSION SET container=PDB1;`


`create tablespace streamsets_tabspace datafile 'streamsets_tabspace.dat' size 10M autoextend on;` 


`create temporary tablespace streamsets_tabspace1_temp tempfile 'streamsets_tabspace1_temp.dat' size 5M autoextend on;` 


`create user streamsets identified by 123456 default tablespace streamsets_tabspace temporary tablespace streamsets_tabspace1_temp;` 


`grant create session to Streamsets;` 


`grant create table to Streamsets;` 


`grant unlimited tablespace to Streamsets;` 


`select current_scn from v$database;` 


Go back to your desktop move over some files to your vm with sftp.

`sftp -i "your link to your ssh"  opc@"ip address for your instance"`

with the put command, send the ora files to this locaction 

`/opt/oracle/homes/OraDB21Home1/network/admin/`

and send the sql files to correct path, for me it is here 
`sudo docker cp ot_schema.sql oraclecdc:/home/oracle/ot_schema.sql`

and then you will go into the bash script and putt in your password, and then 
`@ot_schema.sql`
`@ot_data.sql`

This will first make the schema for our database and then load the data into our database. 



