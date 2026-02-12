# ---- Base ----
FROM node:20-alpine AS base

# Patch OS packages
RUN apk update && apk upgrade

WORKDIR /app
COPY package*.json ./

# ---- Dependencies ----
FROM base AS dependencies
RUN npm ci --omit=dev

# ---- Build ----
FROM base AS build
RUN npm ci
COPY . .
RUN npm run build

# ---- Production ----
FROM node:20-alpine AS production

# Patch OS again (important)
RUN apk update && apk upgrade && \
    addgroup -S appgroup && \
    adduser -S appuser -G appgroup

WORKDIR /app
ENV NODE_ENV=production

# Copy only production deps
COPY --from=dependencies /app/node_modules ./node_modules

# Copy build artifacts
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/package*.json ./
COPY --from=build /app/next.config.js ./next.config.js

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
