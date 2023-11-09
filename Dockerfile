FROM golang:alpine3.16 AS build
WORKDIR /app
COPY . .
RUN go build -o myapp



FROM alpine:latest
COPY --from=build /app/myapp .
EXPOSE 8000
CMD [ "./myapp" ]