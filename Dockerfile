# -------- Base Image --------
FROM node:20-alpine AS base
WORKDIR /app
ENV NODE_ENV=production

# -------- Dependencies --------
FROM base AS deps
COPY package*.json ./
RUN npm ci

# -------- Build --------
FROM deps AS builder
COPY . .
RUN npm run build

# -------- Production --------
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Create non-root user (security best practice)
RUN addgroup -g 1001 -S nodejs \
    && adduser -S nextjs -u 1001

# Copy only necessary standalone files
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Change ownership
RUN chown -R nextjs:nodejs /app

USER nextjs

EXPOSE 3000

CMD ["node", "server.js"]
