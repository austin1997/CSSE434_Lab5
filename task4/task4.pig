REGISTER 'hdfs:///tmp/PigUDF-0.0.1-SNAPSHOT.jar';
DEFINE checkQuality edu.rosehulman.zhaiz.IsGoodQuality();
DEFINE TRIMFUNC edu.rosehulman.zhaiz.Trim();
records = LOAD '$input' using PigStorage('\t') AS (date:chararray, time:chararray, x-edge-location:chararray, sc-bytes:int, c-ip:chararray, cs-method:chararray, cs-Host:chararray, cs-uri-stem:chararray, sc-status:int, cs-Referer:chararray, cs-User-Agent:chararray, cs-uri-query:chararray, cs-Cookie:chararray, x-edge-result-type:chararray, x-edge-request-id:chararray);
frecords = FILTER records by checkQuality(cs-uri-stem);
srecords = select cs-uri-stem, x-edge-result-type from frecords;
grecords = GROUP srecords by cs-uri-stem;
STORE grecords into '$output' using PigStorage(',');