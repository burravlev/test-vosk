FROM ubuntu

RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
        ca-certificates \
        git \
        g++ \
        unzip \
        wget
RUN 
CMD ["gcc --version"]