
records = LOAD '$input' using PigStorage('\t') AS (date:chararray, time:chararray, x-edge-location:chararray, sc-bytes:int, c-ip:chararray, cs-method:chararray, cs-Host:chararray, cs-uri-stem:chararray, sc-status:int, cs-Referer:chararray, cs-User-Agent:chararray, cs-uri-query:chararray, cs-Cookie:chararray, x-edge-result-type:chararray, x-edge-request-id:chararray);
