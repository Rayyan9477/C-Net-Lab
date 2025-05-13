FROM node:20-alpine

WORKDIR /usr/src/app

# Define build arguments for configuration
ARG MONGODB_URI
ARG AUTH_SERVICE_URL

# Set environment variables
ENV PORT=3002
ENV MONGODB_URI=${MONGODB_URI}
ENV AUTH_SERVICE_URL=${AUTH_SERVICE_URL}

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3002

CMD ["npm", "start"]
