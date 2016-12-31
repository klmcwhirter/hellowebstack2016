#!/bin/bash
#*---------------------------------------------------------------------------*
#* Name: build.sh
#*
#* Description: Build the docker images for the hello solution.
#*
#*---------------------------------------------------------------------------*
function build_image
{
    dir=$1
    image_name=$2
    dockerfile=${image_name}.dockerfile

    # Make sure that the Dockerfile is in the workspace dir
    cp ${dir}/${dockerfile} Dockerfile

    docker build -t klmcwhirter/${image_name} .

    rm -f Dockerfile
}
#*---------------------------------------------------------------------------*
function log
{
  timestamp=$(date "+%Y/%m/%d %H:%M:%S")
  echo ">>> ${timestamp}: $*"
}
#*---------------------------------------------------------------------------*
#* M A I N  P R O G R A M
#*---------------------------------------------------------------------------*
if [ "$(basename $PWD)" != "docker" ]
then
  cd docker
fi

if [ "$(basename $PWD)" != "docker" ]
then
  echo "Execute script in the directory containing the docker dir"
  exit 2
fi

log Get the current versions of the images
docker pull microsoft/dotnet
docker pull microsoft/aspnetcore
docker pull nginx

log Clean the workspace dir
cd ../hello
rm -fr bin obj
cd ..

log Build the wepapi image
./docker/hellowebapi.build.sh

log Create the hellowebapi image
build_image ./docker hellowebapi

log Build the app
rm -fr dist
mkdir -p dist
ng build

log Create the hellonginx image
cd ./dist
build_image ../docker hellonginx

#*---------------------------------------------------------------------------*
