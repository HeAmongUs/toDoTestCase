# Build Vue Project
FROM node:20-alpine3.17 AS build
RUN apk add --no-cache git
RUN apk add --no-cache openssh
WORKDIR /app
RUN git clone https://github.com/HeAmongUs/toDoTestCase.git ./project
WORKDIR /app/project
RUN npm i
RUN npm run build


# Nginx
FROM nginx:1.19.0-alpine AS prod-stage
COPY --from=build /app/project/dist /usr/share/nginx/html
RUN rm /usr/share/nginx/html/50x.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]