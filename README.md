# EMR Advisor - Spark Event Log Analyzer

This guide shows how to run the AWS EMR Advisor tool locally to analyze Spark event logs.

## Prerequisites Installation

### Install Java 17

```bash
# Install Java 17 via Homebrew
brew install openjdk@17

# Verify installation
java -version  # Should show version 17
```

### Install Spark 3.5.3

```bash
# Download Spark 3.5.3
cd /tmp
wget https://archive.apache.org/dist/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz

# Extract Spark
tar -xzf spark-3.5.3-bin-hadoop3.tgz

# Verify installation
/tmp/spark-3.5.3-bin-hadoop3/bin/spark-submit --version
```

## Example: Analyze Sample Job

To analyze a sample Spark event log:

```bash
# Set Java 17 environment
export JAVA_HOME=/opt/homebrew/opt/openjdk@17
export PATH=$JAVA_HOME/bin:$PATH

# Navigate to sample-run-commands directory
cd /Users/sshah/IdeaProjects/study-learn/sample-run-commands

export JAVA_HOME="/opt/homebrew/Cellar/openjdk@17/17.0.14/libexec/openjdk.jdk/Contents/Home"


export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=$JAVA_HOME/bin:$PATH && cd /Users/soumilshah/IdeaProjects/Experiment/sample-run-commands && /tmp/spark-3.5.3-bin-hadoop3/bin/spark-submit --class com.amazonaws.emr.SparkLogsAnalyzer jar/aws-emr-advisor-assembly-0.3.1.jar logs/eventlog_v2_spark-110be3a8424d4a2789cb88134418217b/events_1_spark-110be3a8424d4a2789cb88134418217b                                                                 


```

## View Report

The report will be saved to `/tmp/emr-advisor.spark.*.html`. To view it:

```bash
# Find and copy the report
mkdir -p reports
REPORT_FILE=$(ls -t /tmp/emr-advisor.spark.*.html 2>/dev/null | head -1)
if [ -n "$REPORT_FILE" ] && [ -s "$REPORT_FILE" ]; then
  cp "$REPORT_FILE" reports/emr-advisor-spark-110be3a8424d4a2789cb88134418217b.html
  open reports/emr-advisor-spark-110be3a8424d4a2789cb88134418217b.html
else
  echo "Report not found or empty. Check spark-submit output for errors."
fi
```

## One-Liner Command

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@17 && export PATH=$JAVA_HOME/bin:$PATH && cd /Users/sshah/IdeaProjects/study-learn/sample-run-commands && /tmp/spark-3.5.3-bin-hadoop3/bin/spark-submit --class com.amazonaws.emr.SparkLogsAnalyzer jar/aws-emr-advisor-assembly-0.3.1.jar logs/eventlog_v2_spark-110be3a8424d4a2789cb88134418217b/events_1_spark-110be3a8424d4a2789cb88134418217b
```

## Available Sample Jobs

- `logs/eventlog_v2_spark-110be3a8424d4a2789cb88134418217b/events_1_spark-110be3a8424d4a2789cb88134418217b`
- `logs/eventlog_v2_spark-bcec39f6201b42b9925124595baad260/events_1_spark-bcec39f6201b42b9925124595baad260`
- `logs/eventlog_v2_spark-cc4d115f011443d787f03a71a476a745/events_1_spark-cc4d115f011443d787f03a71a476a745`

## Notes

- **AWS Credential Errors:** Expected when running locally. The report may be empty (0 bytes) if the JAR doesn't handle AWS API failures gracefully.
- **Report Location:** Generated reports are saved to `/tmp/emr-advisor.spark.*.html`
- **Java Version:** Must be Java 17 (not Java 11 or Java 21)
