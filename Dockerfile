FROM golang:1.21.0

WORKDIR /usr/src/app/

COPY . /usr/src/app/
RUN go mod download

RUN VOSK_PATH=`pwd`/vosk-linux-x86_64-0.3.45 \ 
    LD_LIBRARY_PATH=$VOSK_PATH CGO_CPPFLAGS="-I \
    $VOSK_PATH" CGO_LDFLAGS="-L $VOSK_PATH" \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o test

CMD {"./test"}