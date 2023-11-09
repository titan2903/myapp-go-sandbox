FROM golang:1.18-alpine AS build
WORKDIR /app
COPY . .
RUN go build -o myapp



FROM alpine:latest
COPY --from=build /app/myapp .
EXPOSE 8000
CMD [ "./myapp" ]