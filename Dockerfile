#Build this image with: docker build --file Dockerfile_Server -t lmpsrv:latest .
#Delete the image with the command: docker image rm lmpsrv:latest

#Create a container with: docker run -td -p 8800:8800 -p 8900:8900 --name lmpsrv lmpsrv:latest
# the -t (tty) flag is needed so docker can send SIGINT for proper shutdown.
#Attach to a container with: docker exec -it lmpsrv /bin/ash
#When inside a container, you can dettach with: CONTROL+P+Q
#Check logs with: docker logs -f lmpsrv

#Stop a container with: docker stop lmpsrv
#Start a container with: docker start lmpsrv
#Remove a container with: docker container rm lmpsrv

FROM mcr.microsoft.com/dotnet/sdk:5.0.403-bullseye-slim-arm64v8

ADD https://github.com/LunaMultiplayer/LunaMultiplayer/releases/download/0.28.0/LunaMultiplayer-Server-Release.zip LMPServer.zip
RUN apt-get update && apt-get install unzip
RUN unzip LMPServer.zip -d LMPServer
EXPOSE 8800/udp 8900/tcp
VOLUME "/LMPServer/Config" "/LMPServer/Plugins" "/LMPServer/Universe" "/LMPServer/logs"
STOPSIGNAL sigint
WORKDIR /LMPServer
CMD dotnet Server.dll