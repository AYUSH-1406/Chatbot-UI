FROM node:20-alpine AS production

RUN apk update && apk upgrade && \
    addgroup -S appgroup && \
    adduser -S appuser -G appgroup

WORKDIR /app
ENV NODE_ENV=production

COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=build /app ./

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
