
FROM node:alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .


FROM gcr.io/distroless/nodejs18-debian11
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app .
EXPOSE 3000
CMD ["index.js"]