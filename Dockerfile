# Étape 1 : Build
FROM node:18-slim AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

# Étape 2 : Production (Image finale légère)
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
