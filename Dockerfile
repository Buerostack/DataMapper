ARG NODE_IMAGE=node:20-alpine
FROM ${NODE_IMAGE}

WORKDIR /workspace/app

COPY package.json .
RUN npm ci --omit=dev || npm install --omit=dev

COPY lib ./lib
COPY server.js ./server.js
COPY DSL ./DSL

EXPOSE 3000
CMD ["npm","start"]
