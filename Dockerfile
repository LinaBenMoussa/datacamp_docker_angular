### STAGE 1: Build ###

FROM node:12.7-alpine AS build
RUN apk add --no-cache python3 make g++
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
RUN npx browserslist@latest --update-db
COPY . .
RUN npm run build -- --prod
### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/aston-villa-app /usr/share/nginx/html