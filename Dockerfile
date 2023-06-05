#Stage 1

FROM node:14-alpine as builder
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn install 
COPY artifact /app/
RUN  yarn build

#Stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
EXPOSE 8080
ENTRYPOINT [ "nginx","-g","daemon off;"]
