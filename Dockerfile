# Step 1: Build stage
FROM node:16-slim AS build
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Runtime stage
FROM node:16-slim
WORKDIR /app

RUN npm install -g serve
COPY --from=build /app/build ./build

EXPOSE 80
CMD ["serve", "-s", "build", "-l", "80"]
