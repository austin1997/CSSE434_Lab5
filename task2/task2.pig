REGISTER 'hdfs:///tmp/PigUDF-0.0.1-SNAPSHOT.jar';
DEFINE TRIMFUNC edu.rosehulman.zhaiz.Trim();
input1 = LOAD '$input' As (word:chararray);
a = foreach input1 generate TOKENIZE(word);
b = foreach a generate flatten($0) as data;
c = group b by data;
result = FOREACH c GENERATE TRIMFUNC(group), COUNT(b);
STORE result into '$output' using PigStorage(',');
