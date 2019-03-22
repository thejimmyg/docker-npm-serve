FROM node:alpine as base

FROM base as builder
RUN mkdir /app
WORKDIR /app
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install --only=prod

FROM base

COPY --from=builder /app /app
COPY public /app/public
WORKDIR /app
EXPOSE 80
ENV NODE_PATH=/app/node_modules
ENV NODE_ENV=production
ENV PORT=80
ENV PATH="${PATH}:/app/node_modules/.bin"
CMD ["serve", "public"]
