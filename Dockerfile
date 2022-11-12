FROM node:16-alpine as builder
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
COPY --chown=node:node package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
RUN mkdir -p /home/node/app
COPY --from=builder --chown=nginx:nginx /home/node/app/build /usr/share/nginx/html