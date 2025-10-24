# syntax=docker/dockerfile:1
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production || npm ci
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]
