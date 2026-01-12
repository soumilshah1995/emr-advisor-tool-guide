# Spark History Server Sample Jobs

This directory contains sample Spark event logs from the [kubeflow/mcp-apache-spark-history-server](https://github.com/kubeflow/mcp-apache-spark-history-server) repository.

## Sample Applications

1. **`spark-bcec39f6201b42b9925124595baad260`**
   - Status: ✅ Completed Successfully
   - Event log: `eventlog_v2_spark-bcec39f6201b42b9925124595baad260/events_1_spark-bcec39f6201b42b9925124595baad260`
   - Use Case: Basic functionality testing

2. **`spark-110be3a8424d4a2789cb88134418217b`**
   - Status: ✅ Completed Successfully
   - Event log: `eventlog_v2_spark-110be3a8424d4a2789cb88134418217b/events_1_spark-110be3a8424d4a2789cb88134418217b`
   - Use Case: Job comparison testing

3. **`spark-cc4d115f011443d787f03a71a476a745`**
   - Status: ✅ Completed Successfully
   - Event log: `eventlog_v2_spark-cc4d115f011443d787f03a71a476a745/events_1_spark-cc4d115f011443d787f03a71a476a745`
   - Use Case: Performance analysis

## Option 1: Analyze Directly with EMR Advisor

You can analyze these event logs directly using the EMR Advisor tool:

```bash
# Set Java environment
export JAVA_HOME=/opt/homebrew/opt/openjdk@17
export PATH=$JAVA_HOME/bin:$PATH

# Analyze a sample job
cd /Users/sshah/IdeaProjects/study-learn
/tmp/spark-3.5.3-bin-hadoop3/bin/spark-submit \
  --class com.amazonaws.emr.SparkLogsAnalyzer \
  sample-run-commands/aws-emr-advisor-assembly-0.3.1.jar \
  sample-run-commands/logs/eventlog_v2_spark-bcec39f6201b42b9925124595baad260/events_1_spark-bcec39f6201b42b9925124595baad260
```

## Option 2: Start Local Spark History Server

Start a local Spark History Server to view these jobs in a web UI:

```bash
# Using Docker/Podman
cd /Users/sshah/IdeaProjects/study-learn/sample-run-commands
docker run -it -v $(pwd)/logs:/mnt/data -p 18080:18080 \
  apache/spark:3.5.5 \
  /opt/java/openjdk/bin/java -cp '/opt/spark/conf:/opt/spark/jars/*' -Xmx1g \
  org.apache.spark.deploy.history.HistoryServer \
  --properties-file /mnt/data/history-server.conf
```

Then access:
- Web UI: http://localhost:18080
- REST API: http://localhost:18080/api/v1/applications

## Option 3: Use with analyze-spark-log.sh Script

You can also use these with the analyze script by pointing to localhost:

```bash
export SPARK_HISTORY_SERVER_HOST="localhost"
export APPLICATION_ID="spark-bcec39f6201b42b9925124595baad260"
cd /Users/sshah/IdeaProjects/study-learn/sample-run-commands
./analyze-spark-log.sh
```

## Application IDs

- `spark-bcec39f6201b42b9925124595baad260`
- `spark-110be3a8424d4a2789cb88134418217b`
- `spark-cc4d115f011443d787f03a71a476a745`
