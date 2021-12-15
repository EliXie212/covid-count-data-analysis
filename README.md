Covid Data Analysis with Time Series
===================

-----------------------------

### Introduction
This project seeks to analyze and model the total detected COVID-19 counts of
Timeseria (fake name but realy data)from the first day of the first diagnosis
until present.



Using This Project
------------------
You will need Docker. You will need to be able to run docker as your current user.

Instructions on installation of docker can be found here:

Windows: https://docs.docker.com/desktop/windows/install/

Ubuntu: https://docs.docker.com/engine/install/ubuntu/


To initiate the docker environment, run:

		> ./start-env.sh

Then open an Rstudio instance on port 8787. You can access the instance by going
to your browser and type:

		> localhost:8787

When prompted by Rstudio to enter username and password, enter Rstudio and "hello123".

You can also modified the username and password in the start-env.sh.

The working directory of the project is located at home/rstudio/project. Make sure
you are in the working directory before proceeding by using:

	> cd /home/rstudio/project



Please download the dataset from the kaggle and move the csv file under source_data directory.


Makefile
--------
The Makefile included in this repository will help build different components
 of the project.

You will need to go the terminal of the rstudio instance to run the following commands
to build different components

To build the report, use the following:

	> make pdflatex covid_data_analysis_report.tex

When prompted to asked for file name, hit enter to skip.
