FROM node:latest
WORKDIR /usr/src/app/savics/omrsToDhis2Mediator

COPY ./server/ .

RUN npm install

EXPOSE 3000

CMD ["node", "./lib/index.js" ]