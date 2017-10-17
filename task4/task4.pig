REGISTER 'hdfs:///tmp/PigUDF-0.0.1-SNAPSHOT.jar';
DEFINE checkQuality edu.rosehulman.zhaiz.IsGoodQuality();
DEFINE TRIMFUNC edu.rosehulman.zhaiz.Trim();
records = LOAD '$input' using PigStorage('\t') AS (date:chararray, time:chararray, x_edge_location:chararray, sc_bytes:int, c_ip:chararray, cs_method:chararray, cs_Host:chararray, cs_uri_stem:chararray, sc_status:int, cs_Referer:chararray, cs_User_Agent:chararray, cs_uri_query:chararray, cs_Cookie:chararray, x_edge_result_type:chararray, x_edge_request_id:chararray);
frecords = FILTER records by checkQuality(cs_uri_stem);
srecords = foreach frecords generate cs_uri_stem, x_edge_result_type;
grecords = GROUP srecords by cs_uri_stem;
temp = foreach grecords generate group, srecords, COUNT(srecords);
STORE temp into '$output' using PigStorage(',');