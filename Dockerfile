##### Stage 1
FROM node:14.17.0 AS node
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build


##### Stage 2
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /app/dist/angular-test /usr/share/nginx/html

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf


# export port and run app
EXPOSE 8080/tcp

# Start
ENTRYPOINT ["nginx", "-g", "daemon off;"]

# docker build -t test .
# docker run -p 8080:80 test
