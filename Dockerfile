# ===============================
# Base Image
# ===============================
FROM node:20-alpine AS base

RUN apk update && apk upgrade
WORKDIR /app

# ===============================
# Dependencies Stage
# ===============================
FROM base AS dependencies

# Copy package files first for caching
COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# ===============================
# Build Stage
# ===============================
FROM base AS build

# Copy package files
COPY package*.json ./

# Install all dependencies (including dev for build)
RUN npm ci

# Copy full project
COPY . .

# Build Next.js app
RUN npm run build

# ===============================
# Production Stage
# ===============================
FROM node:20-alpine AS production

RUN apk update && apk upgrade && \
    addgroup -S appgroup && \
    adduser -S appuser -G appgroup

WORKDIR /app
ENV NODE_ENV=production

# Copy production dependencies
COPY --from=dependencies /app/node_modules ./node_modules

# Copy entire built application
COPY --from=build /app ./

# Use non-root user
USER appuser

EXPOSE 3000

CMD ["npm", "start"]
