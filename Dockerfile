FROM golang:alpine3.16 AS build
WORKDIR /app
COPY . .
# Install necessary packages for the final image
RUN apk add --no-cache bash
RUN go build -o myapp



FROM alpine:latest
COPY --from=build /app/myapp .
EXPOSE 8000
CMD [ "./myapp" ]