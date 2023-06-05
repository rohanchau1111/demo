#Stage 1

FROM node:14-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY artifacts/final-build.tar.gz .
RUN tar -xzf final-build.tar.gz
RUN npm run build


#Stage 2
FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 8080
ENTRYPOINT [ "nginx","-g","daemon off;"]
