# STEP 1: build executable binary

# Use the official Golang image as the build stage
FROM golang:1.18-alpine AS build

# Set a label for the maintainer
LABEL maintainer="Titanio Yudista <titanioyudista98@gmail.com>"

# Set the working directory in the build stage
WORKDIR /app

# Install required dependencies for building the Go application
RUN apk add --no-cache bash make gcc libc-dev

# Copy the source code and any additional files
COPY . .

# Build the Go application
RUN go build -o myapp-go

# Create a vendor directory and copy dependencies
# RUN go mod vendor

# STEP 2: create a smaller image for the final application

# Use a minimal Alpine Linux image as the final stage
FROM alpine:3.16.0

# Install necessary packages for the final image
RUN apk add --no-cache bash

# Expose port if your application listens on a specific port
EXPOSE 8000

# Define the command to run your application
CMD ["./myapp-go"]