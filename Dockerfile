FROM node:16-alpine AS builder

WORKDIR /app

COPY package.json package.json

RUN npm install

COPY . /app/
RUN REACT_APP_MEILI_SERVER_ADDRESS=https://search.data.ganjaran.app npm run build


FROM node:16-alpine

COPY --from=builder /app/build /app/build

WORKDIR /app

RUN npm install -g serve

CMD ["npx", "--yes", "serve", "--no-clipboard", "--no-compression", "--no-port-switching", "build" ]
