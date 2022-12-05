# Oracle_cdc
Guide to setup Oraclecdc with streamsets,
Noticed now after trying to set up Oracle than it cant run on the always free option since the memory is to little and sql will crash. 

## some steps to follow
1. if you dont have you might want to setup a oracle instance if this is for home use and playing around. You get 30 days for free on the site. 
2. Will provide some commands for you so can paste into your vm
3. When making the instance remember to save the ssh key from one of the options. This ssh-key should be moved to the same folder where your scripts are for easier use.

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

`sudo docker login container-registry.oracle.com/database/enterprise:latest`

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

## Here you will copy over the files into your vm 


Go back to your desktop move over the files to your vm with sftp.

`sftp -i "your link to your ssh-key"  opc@"ip address for your instance"`

with the put command, send the ora files to this locaction 

`/opt/oracle/homes/OraDB21Home1/network/admin/`

and send the sql files to correct path, for me it is here 
`sudo docker cp ot_schema.sql oraclecdc:/home/oracle/ot_schema.sql`

and then you will go into the bash script and putt in your password, and then 

`@ot_schema.sql` 

`@ot_data.sql`

Here you need to wait intil it is ready, it wont tell you when you can use it, but you can check running the commands bellow

´sudo docker logs oraclecdc´


This will first make the schema for our database and then load the data into our database. 

## The last part is to run the redo log so streamsets can pick it up and send it to Snowflake: 

The redo logs could aslo be run several times, this worked better for me when I made it work the first time. 

`ALTER SESSION SET container=cdb$root;` 

`EXECUTE dbms_logmnr_d.build(options=> dbms_logmnr_d.store_in_redo_logs);`


## Streamsets settings for your pipeline. 

From the picture below you see how the settings you should use. If you are using the schema than I have added in the files setup your streamset pipeline like this.


![Settings for streamsets](https://github.com/fredlau95/Oracle_cdc/blob/main/Pictures_Streamsets/Picture1.png)

Change the warehouse and database option to where you want your pipeline to end up. 

![Settings for streamsets](https://github.com/fredlau95/Oracle_cdc/blob/main/Pictures_Streamsets/Picture2.png)

![Settings for streamsets](https://github.com/fredlau95/Oracle_cdc/blob/main/Pictures_Streamsets/Picture3.png)

