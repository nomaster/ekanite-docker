FROM golang as builder
ENV CGO_ENABLED=0
RUN go get github.com/ekanite/ekanite/cmd/ekanited

FROM scratch
COPY --from=builder /go/bin/ekanited /go/bin/
VOLUME /data
EXPOSE 5514
EXPOSE 8080
EXPOSE 9950
CMD [ "/go/bin/ekanited", "--datadir=/data", "--query=0.0.0.0:9950", "--queryhttp=0.0.0.0:8080", "--tcp=0.0.0.0:5514", "--udp=0.0.0.0:5514" ]
