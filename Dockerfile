FROM node:alpine AS build

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

FROM node:alpine AS deploy

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json .

RUN npm install --only=prod

COPY . .

COPY --from=build /usr/src/app/dist ./dist

CMD ["node", "dist/main"]