# Use Node.js v22.13.1 as the build environment
FROM node:22.13.1 as build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files to the working directory
COPY . .

# Build the React app for production
RUN npm run build

# Use a lightweight nginx image to serve the built app
FROM nginx:alpine

# Copy the build output from the previous stage to nginx's html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to allow external access
EXPOSE 80

# Start nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
