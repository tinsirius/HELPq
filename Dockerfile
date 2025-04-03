FROM ubuntu:22.04

RUN apt update && apt install -y curl && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=0.10.40

RUN mkdir -p $NVM_DIR && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash \
	&& . $NVM_DIR/nvm.sh \
	&& nvm install $NODE_VERSION

RUN curl -o- 'https://install.meteor.com/?release=2.7.2' | sh

COPY . /src

WORKDIR /src

RUN NODE_TLS_REJECT_UNAUTHORIZED=0 meteor build --directory build --allow-superuser

WORKDIR /src/build/bundle/programs/server

RUN . $NVM_DIR/nvm.sh && npm install

WORKDIR /src/build/bundle

CMD ["bash", "-c", ". $NVM_DIR/nvm.sh && node main.js"]