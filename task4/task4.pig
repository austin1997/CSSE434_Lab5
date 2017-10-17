REGISTER 'hdfs:///tmp/PigUDF-0.0.1-SNAPSHOT.jar';
DEFINE checkQuality edu.rosehulman.zhaiz.IsGoodQuality();
DEFINE TRIMFUNC edu.rosehulman.zhaiz.Trim();
records = LOAD '$input' using PigStorage('\t') AS (date:chararray, time:chararray, x_edge_location:chararray, sc_bytes:int, c_ip:chararray, cs_method:chararray, cs_Host:chararray, cs_uri_stem:chararray, sc_status:int, cs_Referer:chararray, cs_User_Agent:chararray, cs_uri_query:chararray, cs_Cookie:chararray, x_edge_result_type:chararray, x_edge_request_id:chararray);
frecords = FILTER records by checkQuality(cs_uri_stem);
srecords = foreach frecords generate TRIMFUNC(cs_uri_stem) as name, x_edge_result_type;
grecords = GROUP srecords by name;
totalRecords = foreach grecords generate group as name, srecords as content, COUNT(srecords) as total;
hits = FILTER srecords by x_edge_result_type=='Hit';
ghits = GROUP hits by name;
hitRecords = foreach ghits generate group as name, hits as content, COUNT(hits) as hits;
TotalWithHits = JOIN totalRecords by name LEFT OUTER, hitRecords by name;
errors = FILTER srecords by x_edge_result_type=='Error';
gerrors = GROUP errors by name;
errorRecords = foreach gerrors generate group as name, errors as content, COUNT(errors) as errors;
temp = JOIN TotalWithHits by name LEFT OUTER, errorRecords by totalRecords.name;
STORE temp into '$output' using PigStorage(',');