#!/bin/bash

docker build . -t project-env


docker run -v $(pwd):/home/rstudio/project \
                  -p 8787:8787 \
                  -e PASSWORD=hello123 \
                  -t project-env
