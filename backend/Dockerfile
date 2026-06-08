# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY nest-cli.json tsconfig.json ./
COPY src ./src
RUN npm run build

# Stage 2: Production (distroless)
FROM gcr.io/distroless/nodejs20-debian12 AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
ENV DB_HOST=postgres
ENV DB_PORT=5432
ENV DB_NAME=company-database
ENV DB_USER=admin
ENV DB_PASSWORD=admin1234
ENV PORT=3000
ENV NODE_ENV=development
EXPOSE 3000
CMD ["dist/main.js"]