# Build Vue Project
FROM node:20-alpine3.17 AS build
RUN apk add --no-cache git
RUN apk add --no-cache openssh
WORKDIR /app
RUN git clone https://github.com/HeAmongUs/toDoTestCase.git project
WORKDIR /app/project
RUN npm i
RUN npm run build


# Nginx
FROM nginx:1.25.2 AS prod-stage
COPY --from=build /app/dist /usr/shar/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]