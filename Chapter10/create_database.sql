create database freeswitch;
use freeswitch;
CREATE TABLE `extensions` ( `userid` varchar(5) NOT NULL DEFAULT '', `password` varchar(30) NOT NULL DEFAULT '', `displayname` varchar(14) NOT NULL DEFAULT '', `vmpasswd` varchar(10) DEFAULT NULL, `accountcode` varchar(10) DEFAULT NULL, `outbound_caller_id_name` varchar(14) DEFAULT NULL, `outbound_caller_id_number` varchar(14) DEFAULT NULL );
insert into extensions (userid,password,displayname,vmpasswd,accountcode,outbound_caller_id_name,outbound_caller_id_number) values ("1000","12345","Giovanni Maruzzelli","12345","1000","OpenTelecom.IT","+393472665618"), ("1001","12345","Sara Sissi","12345","1001","OpenAdassi.IR","+12125551212"), ("1002","12345","Francesca Francesca","12345","1002","OpenSantuzza","+4433344422"), ("1003","12345","Tommaso Stella","12345","1003","OpenBoat.LUV","+9188877755");
select * from extensions;
