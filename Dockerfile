FROM node:20.15.0-alpine3.20
EXPOSE 8080
ENV DB_HOST=mysql
#this will reduce the layers and also will create a non root user to run the application
RUN addgroup -S expense && adduser -S expense -G expense \
    && mkdir /app \
    && chown expense:expense /app
WORKDIR /app
COPY package.json .
COPY *.js .
RUN npm install
USER expense
CMD ["node", "index.js"]