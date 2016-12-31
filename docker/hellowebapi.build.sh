#!/bin/bash
#*---------------------------------------------------------------------------*
#* Name: hellowebapi.build.sh
#*
#* Description: build the webapi bits using the dotnet sdk supplied as a 
#* Docker image.
#*
#* Note that it uses the latest version which at the time is 1.1.0
#*
#*---------------------------------------------------------------------------*
#* Constants
CONNAME=hellowebapi-build
PROJ=hello
PUBDIR=dotnet-bin
DATADIR=${PUBDIR}/Data

BUILDCMD="cd /app && dotnet restore && dotnet publish ${PROJ} -o /app/${PUBDIR}"

#*---------------------------------------------------------------------------*
#* M A I N  P R O G R A M
#*---------------------------------------------------------------------------*

rm -fr ${PUBDIR}
mkdir -p ${PUBDIR}

docker run --name ${CONNAME} -v $PWD:/app microsoft/dotnet /bin/bash -c "${BUILDCMD}" 

docker rm -v ${CONNAME} 

mkdir -p ${DATADIR}

#*---------------------------------------------------------------------------*
