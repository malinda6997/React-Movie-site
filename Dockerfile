# Stage 1: Build the React app using Node.js
FROM node:18-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) and install dependencies
COPY package*.json ./
RUN npm install

# Copy all the application files into the container
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Set up Nginx to serve the build files
FROM nginx:latest

# Copy the build output from the build stage to Nginx's public directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to access the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
