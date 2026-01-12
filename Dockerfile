FROM amazonlinux:2

# Install Java 17 and dependencies
RUN yum update -y && \
    yum install -y java-17-amazon-corretto-devel wget git && \
    yum clean all

# Set Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install SBT
RUN wget https://www.scala-sbt.org/sbt-rpm.repo -O /etc/yum.repos.d/sbt-rpm.repo && \
    yum install -y sbt

# Set working directory
WORKDIR /build

# Clone and build the project
RUN git clone https://github.com/aws-samples/aws-emr-advisor && \
    cd aws-emr-advisor && \
    sbt clean compile assembly

# Keep container running
CMD ["tail", "-f", "/dev/null"]
