
FROM ubuntu:latest

# Java installation
RUN apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-arm64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install  minor dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install gcc g++ make -y

RUN apt-get update && apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-aarch64.sh

RUN bash Anaconda3-2024.10-1-Linux-aarch64.sh -b

ENV PATH="/root/anaconda3/bin:$PATH" 


# Arcgis API for Python install
RUN pip3 install arcgis arcgis-mapping



# Spark Installation
RUN curl -L https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz | tar -xz -C /opt \
    && ln -s /opt/spark-3.5.3-bin-hadoop3 /opt/spark
    

ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Expose spark port
EXPOSE 4040

CMD ["/bin/bash", "-c", "spark-submit --version && pip3 lists | grep arcgis"]
