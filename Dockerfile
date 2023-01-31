FROM frolvlad/alpine-miniconda3:latest

ENV PYTHON_VERSION 2.7.13

RUN apk add --update nodejs npm

RUN apk add --update \
    build-base \
    nodejs \
    npm \
    yarn \
    git \
  && rm -rf /var/cache/apk/*

WORKDIR /home

COPY . .

RUN cd /home/src \
	&& pip install --target . flask

RUN cd /home/src/static \
	&& yarn install
RUN cd /home/src \
	&& pip install --target . flask

RUN chmod +x start.sh

EXPOSE 5000

CMD ["/bin/sh","./start.sh"]
