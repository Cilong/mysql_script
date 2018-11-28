CREATE DEFINER=`root`@`%` PROCEDURE `NewProc`()
BEGIN
  DECLARE s_tablename VARCHAR(100);
 
 /*显示表的数据库中的所有表
 SELECT table_name FROM information_schema.tables WHERE table_schema='databasename' Order by table_name ;
 */

#显示所有
 DECLARE cur_table_structure CURSOR
 FOR 
 SELECT table_name 
 FROM INFORMATION_SCHEMA.TABLES 
 WHERE table_schema = 'wisave_0'
 ORDER BY table_name;

 DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET s_tablename = NULL;

 OPEN cur_table_structure;

 FETCH cur_table_structure INTO s_tablename;
 WHILE ( s_tablename IS NOT NULL) DO
  SET @MyQuery=CONCAT("alter table `",s_tablename,"` change device_id source_id int(11) DEFAULT NULL COMMENT '设备id'");
  PREPARE msql FROM @MyQuery;
  
  EXECUTE msql ;#USING @c; 
   
  FETCH cur_table_structure INTO s_tablename;
  END WHILE;
 CLOSE cur_table_structure;

    END