# AWS EMR Advisor Docker Build

Build the AWS EMR Advisor JAR using Docker and copy it to your local machine.

## Quick Start

```bash
# Make sure jar directory exists
mkdir -p jar

# Run the build script
./build-jar.sh
```

## Manual Steps (Alternative)

If you prefer to run manually:

```bash
# Build Docker image
docker build -t emr-advisor-builder .

# Run container
docker run -d --name emr-builder emr-advisor-builder

# Copy JAR file
docker cp emr-builder:/build/aws-emr-advisor/target/scala-2.12/aws-emr-advisor-assembly-*.jar ./jar/

# Clean up
docker stop emr-builder
docker rm emr-builder
```

## Exec into Container (for debugging)

```bash
# Start container
docker run -it --name emr-builder emr-advisor-builder bash

# Inside container, build manually:
cd /build/aws-emr-advisor
sbt clean compile assembly

# Exit and copy JAR
exit
docker cp emr-builder:/build/aws-emr-advisor/target/scala-2.12/aws-emr-advisor-assembly-*.jar ./jar/
```
