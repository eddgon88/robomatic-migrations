FROM vutreras/dbmate

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p /migrations

# copia todo a la imagen
COPY . /migrations/

# borra archivos innecesarios
RUN rm -rf /migrations/docker*
RUN rm -rf /migrations/.git*
RUN rm /migrations/.drone.yml

WORKDIR /migrations

RUN sh config_docker
