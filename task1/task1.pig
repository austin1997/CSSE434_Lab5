records = LOAD '$input' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
frecords = FILTER records by temperature!=9999 and (quality == 0 OR quality == 1);
grecords = GROUP frecords by year;
temp = FOREACH grecords GENERATE group, MAX(frecords.temperature) as MaxTemp, MIN(frecords.temperature) as MinTemp, AVG(frecords.temperature) as AvgTemp;
STORE temp into '$output' using PigStorage(',');
