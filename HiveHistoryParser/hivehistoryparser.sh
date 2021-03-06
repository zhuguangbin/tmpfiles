#!/bin/bash

cd `dirname "$0"`

host=`hostname`
source /etc/profile

# start parsing
java -Dhostip=$host -DdatePattern=$1 -jar HiveHistoryParser.jar /data/hive-query-log $1

# put result to HDFS
sh /home/hadoop/getticket.sh
hadoop fs -put out/sessionLog* /user/hive/warehouse/hive_session_log/
hadoop fs -put out/queryLog*   /user/hive/warehouse/hive_query_log/
hadoop fs -put out/taskLog*    /user/hive/warehouse/hive_task_log/
