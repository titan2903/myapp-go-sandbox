# Stage 1: Build stage using the official Golang Alpine image
FROM golang:1.18-alpine as build

# Set the working directory inside the container
WORKDIR /app

# Install required dependencies for building the Go application
RUN apk add --no-cache bash make gcc libc-dev

# Cache and install dependencies
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy the current directory contents into the container at /app
COPY . .

# Build the Go application and name the output binary as 'myapp-go'
RUN go build -o myapp-go

# Stage 2: Create a lightweight container with the final executable
FROM alpine:latest

# Install necessary packages for building and compatibility
RUN apk add bash build-base gcompat

# Copy the 'myapp-go' binary from the build stage to the current directory
COPY --from=build /app/myapp-go .

# Expose port 8000 to the outside world
EXPOSE 8000

# Specify the command to run on container startup
CMD [ "./myapp-go" ]
