# Crime Analysis with GIS Integration
### Visualize Crime data from Riverside and LA County Police Report Datasets using ArcGIS API for Python.
![Visualization Functionality](https://docs.google.com/drawings/d/e/2PACX-1vTQP7qDxjqADd2iIDB51Pi00OQzgY_W8I3K5_5Fv0LX_pBPw6bBBNEbOs8stZRlI2xXDGCgZ26i37fr/pub?w=1387&h=901)
### Project Structure 

![Project Structure](https://docs.google.com/drawings/d/e/2PACX-1vQUAYEuavaQjrS3K8dHD4wYC9c9LBSC9kVm74lU1fRALdMTjXTTsxG1DJT-cJqv1RqtrXGCuhMHr3f0/pub?w=987&h=881)

# Getting Started
## Docker Setup and Tutorial
Docker allows all of our team members can use the same runtime environment across different operating systems, with reduced dependency issues. \
Download docker desktop from [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
### Setting up the Environment (Container)
A Docker Image defines the necessary dependencies, configurations, and environment for running or developing applications. A docker image is instantiated into a docker container, which is a  lightweight and isolated environment that runs on your host system. \
**Create the image from the Dockerfile:**\
``` git clone https://github.com/CodyKurpanek/CrimeAnalysis.git ```\
``` cd CrimeAnalysis ```\
```docker build -t crimeimage .```\
**Instantiate the Image**\
``` docker run -it crimeimage /bin/bash ```\
You should see something like  ``` root@c4dc06a9c310:/# ``` showing that you have instantiated and accessed the container.
### What's in the environment (Container)?
The container is based on the latest Ubuntu (Linux) environment. If you type ls, you’ll see the standard Ubuntu file system structure.\
Within the container, Apache Spark, and Arcgis API for Python are installed and ready to be used. You can verify the installations with:\
``` pip3 list | grep arcgis ```\
``` spark-submit --version ```
### Using the Container
Once inside the container, you can develop as if you're in a standard Ubuntu shell, with all dependencies ready to use. However, **containers are not persistent**, meaning any changes you make inside the container are lost once it stops.\
Mounts allow you to save to persistent data in a location outside of the container. Docker allows you to bind mount a directory within the container to a directory on your host machine or to a Docker volume, which stores data independently of any container, can be easily shared across containers, and retains data even after containers are stopped or removed.
### Creating Persistent data with Volumes
**Create Container with Mounted Volume and Add Data**\
First, exit the current container.\
``` exit ```\
Now, you can start the container again, but with a volume named CrimeVolume, which is mounted to the \mnt directory within the container.\
``` docker run -it -v CrimeVolume:/mnt crimeimage /bin/bash ```\
Lets now download our crime data to the volume.\
``` cd /mnt ```\
``` curl -o Riverside_Crime_Reports.csv https://riversideca.gov/transparency/data/dataset/csv/27/Crime_Reports ```\
``` curl -o SF_PD_Incident_Reports.csv https://data.sfgov.org/api/views/wg3w-h783/rows.csv?fourfour=wg3w-h783&cacheBust=1731346267&date=20241111&accessType=DOWNLOAD ```\
``` curl -o LA_Crime_Data.csv https://data.lacity.org/api/views/2nrs-mtv8/rows.csv?fourfour=2nrs-mtv8&cacheBust=1730298060&date=20241111&accessType=DOWNLOAD ```\
``` ls ```\
Lets also, for demonstration sake, download the riverside dataset within the root directory, which is not mounted to persistent storage.\
``` cd .. ```\
``` curl -o Riverside_Crime_Reports.csv https://riversideca.gov/transparency/data/dataset/csv/27/Crime_Reports ```\
``` ls ```\
**Verify Data Persistence by Creating a New Container**\
Now, if you exit and re-instantiate the container, you will see that Riverside_Crime_Reports.csv does not exist within the root directory, but you can still see it within /mnt which is once again mounted to our CrimeVolume Volume. The volume holds the data, and can be remounted to our new container or any other container.\
Stop current container, then create a new container from the same image.\
``` exit ```\
``` docker run -it -v CrimeVolume:/mnt crimeimage /bin/bash ```\
Check to see if  Riverside_Crime_Reports.csv remains in root and within the mount.\
``` ls ```\
``` cd /mnt ```\
``` ls ```

### Opening the container in the vscode environment.
Download the dev containers extension in vscode\
After starting your container, you can go to the docker desktop to see your container ids or use docker ps -a in the command line\
then inside of vscode, use cmd/ctrl + shift + p, then type in `dev containers: attach to running container`, and select your container's id. It will open the container in a vscode environment.

### Running the Jupyter Notebook using the container's environment as the kernel, and allowing pyspark in the container.
To run Jupyter using the environment within our container, we need to install a new jupyter kernel with wour environment.\
```python -m ipykernel install --user --name container_env --display-name container_env```\
Now, we want to use pyspark within a jupyter notebook rather than in the shell, so lets set some environment variables to use pyspark in jupyter.\
```export PYSPARK_PYTHON=python3```\
```export PYSPARK_DRIVER_PYTHON=jupyter```\
```export PYSPARK_DRIVER_PYTHON_OPTS="notebook --allow-root" ```\
Finally, we can run pyspark which will automatically open in jupyter notebook. You can now open and run any notebook, but make sure to select the kernel we just installed (the option is in the top right corner by default).\
```pyspark```\
Now, run any notebook!

## ArcGIS API Key Setup:
Use https://ucr.maps.arcgis.com/ to sign in with ucr credentials so you have access to arcgis pro and api development permissions.\
Then go to content > new item > developer credential > continue > then type in redirect url = urn:ietf:wg:oauth:2.0:oob and url you can use https://localhost. This will create your API key and give its client_id.\
When running the notebook, if it uses Arcgis, there will be an Authentication section. You should paste your own client id into that cell before running it. There will also be instructions in the markdown above that cell.
