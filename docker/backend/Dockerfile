FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY server.js ./

EXPOSE 5000

ENV PORT=5000
ENV APP_ENV=production
ENV LOG_LEVEL=info

CMD ["node", "server.js"]
