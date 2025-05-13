FROM node:20-alpine

WORKDIR /usr/src/app

# Define build arguments for configuration
ARG MONGODB_URI
ARG JWT_SECRET=your_jwt_secret_key
ARG TOKEN_EXPIRY=1d

# Set environment variables
ENV PORT=3001
ENV MONGODB_URI=${MONGODB_URI}
ENV JWT_SECRET=${JWT_SECRET}
ENV TOKEN_EXPIRY=${TOKEN_EXPIRY}

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001

CMD ["npm", "start"]
