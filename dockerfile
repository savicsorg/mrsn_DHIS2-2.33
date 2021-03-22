FROM node:latest
WORKDIR /usr/src/app/savics/omrsToCRMediator

COPY ./server/ .

RUN npm install

EXPOSE 3000

CMD ["node", "./lib/index.js" ]