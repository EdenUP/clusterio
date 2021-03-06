FROM node:latest
RUN apt-get update && apt install git -y

RUN mkdir factorioClusterio
RUN git clone -b dev https://github.com/Danielv123/factorioClusterio.git && cd factorioClusterio && npm install && curl -o factorio.tar.gz -L https://www.factorio.com/get-download/latest/headless/linux64 && tar -xvzf factorio.tar.gz

WORKDIR factorioClusterio
RUN mkdir instances sharedMods sharedPlugins

RUN node client.js download

LABEL maintainer "danielv@live.no"

EXPOSE 8080 34167
VOLUME /factorioClusterio/instances
VOLUME /factorioClusterio/sharedMods
VOLUME /factorioClusterio/sharedPlugins

CMD RCONPORT="$RCONPORT" FACTORIOPORT="$FACTORIOPORT" MODE="$MODE" node $MODE\.js start $INSTANCE