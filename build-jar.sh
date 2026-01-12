#!/bin/bash

# Build the Docker image
echo "Building Docker image..."
docker build -t emr-advisor-builder .

# Run container in background
echo "Starting container..."
CONTAINER_ID=$(docker run -d emr-advisor-builder)

# Wait for build to complete (if needed)
echo "Waiting for build to complete..."
sleep 10

# Find the JAR file and copy it
echo "Copying JAR file..."
docker exec $CONTAINER_ID find /build/aws-emr-advisor -name "*.jar" -path "*/target/*" | head -1 | while read jar_path; do
    if [ -n "$jar_path" ]; then
        docker cp $CONTAINER_ID:$jar_path ./jar/
        echo "JAR copied to ./jar/"
    else
        echo "JAR file not found"
    fi
done

# Clean up
echo "Cleaning up..."
docker stop $CONTAINER_ID
docker rm $CONTAINER_ID

echo "Done!"
