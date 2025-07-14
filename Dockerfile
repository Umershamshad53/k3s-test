# Use the official Node.js base image
FROM hashicorp/http-echo

# Set working directory inside the container
WORKDIR /app

# Copy package.json and install dependenciess
COPY . .