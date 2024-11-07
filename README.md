# Crime Analysis and Predictive Modeling with GIS Integration
### The Stranger Dangers
CODY KURPANEK, ckurp001@ucr.edu
DEMETREOUS STILLMAN, dstil005@ucr.edu
BENJAMIN BRAVO, bbrav013@ucr.edu
GABRIEL RUELAS, gruel007@ucr.edu
ADHIKAR CHHIBBER, achhi002@ucr.edu
TANEESHA SHARMA, tshar015@ucr.edu
### BACKGROUND AND MOTIVATION
Knowing about crime rates in certain areas is important. Personally, one of our group members has had their car stolen
multiple times. It is helpful to know the crime rates in an area where you live so you can plan ahead accordingly. With
the knowledge of the car theft rate in Riverside, they could have taken precautions like finding a safe space to park,
planning to get a more secure car, or taking more precautions to secure the car. When planning an area to move to,
being able to know beforehand about the crime rates in a certain area is helpful.
We want to allow people to see the crime rates in different areas, and in different metrics since the worries and
spatial scope that people have differ. Someone who walks home from work alone may be interested in the street thefts
and assaults of a very specific area. Someone who drives an old usecure car, may be more interested in car thefts and of
a slightly larger area. Someone planning on where to move may look at a very large area, and will want to see the rate
of crime in general.
With such a vast amount of data, we want our users to be able to find metrics that are meaningful to them, and to
also be able to predict what the crime rates may be in the future in the area they are planning to live in. We can use
machine learning to make some more meaningful metrics for users and to make predictions about the future.
### THE DATASET THAT YOU WILL USE
**Police Report Data** We will be using datasets from multiple police departments from California. These police reports
have features for the type of crime as well as the time the crime occurred and the location of the crime. We can use the
location and type of crime to map the data out onto a map. The time, location, and type of the crime can be used with
Machine Learning to predict future trends in crime
**Census Data** We will also be using California census data to properly evaluate the dangerousness of an area by the
density of the population.
### MAIN OUTCOME
1. Map out incident report data for users to see. This would require putting past incidents onto a map and allowing
users to select types of incidents to report.
2. Use machine learning to predict future trends in incidents that occur, as well as determining advanced metrics
for the general dangerousness of a location.
3. Use Census data to create a picture of the dangerousness in respect to population within the visualizations and
machine learning predictions.
4. Visualize the location along with the accompanying statistics as well as any other highly correlated features to
the dangerousness of an area

## Docker Setup and Tutorial
Docker allows all of our team members can use the same runtime environment across different operating systems, with reduced dependency issues. \
Download docker desktop from [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
### Setting up the Environment (Container)
A Docker Image defines the necessary dependencies, configurations, and environment for running or developing applications. A docker image is instantiated into a docker container, which is a  lightweight and isolated environment that runs on your host system. \
**Create the image from the Dockerfile:**\
``` git clone https://github.com/CodyKurpanek/CrimeAnalysis.git ```\
``` cd CrimeAnalysis ```\
```  docker build -t CrimeImage .```\
**Instantiate the Image**\
``` docker run -it CrimeImage /bin/bash ```\
You should see something like  ``` root@c4dc06a9c310:/# ``` showing that you have instantiated and accessed the container.
### What's in the environment (Container)?
The container is based on the latest Ubuntu (Linux) environment. If you type ls, you’ll see the standard Ubuntu file system structure.\
Within the container, Apache Spark, Apache Hadoop, and Arcgis API for Python are all installed and ready to be used. You can verify the installations with:
``` pip3 lists | grep arcgis ```\
``` hdfs --version ```\
``` /opt/spark/bin/spark-submit --version ```\
### Using the Container
Once inside the container, you can develop as if you're in a standard Ubuntu shell, with all dependencies ready to use. However, **containers are not persistent**, meaning any changes you make inside the container are lost once it stops.\
Mounts allow you to save to persistent data in a location outside of the container. Docker allows you to bind mount a directory within the container to a directory on your host machine or to a Docker volume, which stores data independently of any container, can be easily shared across containers, and retains data even after containers are stopped or removed.
### Creating Persistent data with Volumes
**Create Container with Mounted Volume and Add Data**\
First, exit the current container.\
``` exit ```\
Now, you can start the container again, but with a volume named CrimeVolume, which is mounted to the \mnt directory within the container.\
``` docker run -it -v CrimeVolume:/mnt CrimeImage /bin/bash ```\
Lets try downloading our Riverside crime data to the volume.\
``` cd /mnt ```\
``` curl -o Riverside_Crime_Reports.csv https://riversideca.gov/transparency/data/dataset/csv/27/Crime_Reports ```\
``` ls ```\
Lets also, for demonstration sake, download this same dataset within the root directory, which is not mounted to persistent storage.\
``` cd .. ```\
``` curl -o Riverside_Crime_Reports.csv https://riversideca.gov/transparency/data/dataset/csv/27/Crime_Reports ```\
``` ls ```\
**Verify Data Persistence by Creating a New Container**\
Now, if you exit and re-instantiate the container, you will see that Riverside_Crime_Reports.csv does not exist within the root directory, but you can still see it within /mnt which is once again mounted to our CrimeVolume Volume. The volume holds the data, and can be remounted to our new container or any other container.\
Stop current container, then create a new container from the same image.\
``` exit ```\
``` docker run -it -v CrimeVolume:/mnt CrimeImage /bin/bash ```\
Check to see if  Riverside_Crime_Reports.csv remains in root and within the mount.
``` ls ```\
``` cd /mnt ```\
``` ls ```\




