FROM node:16-alpine AS builder

WORKDIR /app

COPY package.json package.json

RUN npm install

COPY . /app/
RUN npm run build


FROM node:16-alpine

COPY --from=builder /app/build /app/build

WORKDIR /app

RUN npm install -g serve

CMD ["REACT_APP_MEILI_SERVER_ADDRESS=https://search-engine.ganjaran.app", "npx", "--yes", "serve", "--no-clipboard", "--no-compression", "--no-port-switching", "build" ]
