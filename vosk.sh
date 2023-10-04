go get "github.com/alphacep/vosk-api/go" && \
wget https://github.com/alphacep/vosk-api/releases/download/v0.3.45/vosk-linux-x86_64-0.3.45.zip && \
unzip vosk-linux-x86_64-0.3.45.zip && \
wget https://alphacephei.com/vosk/models/vosk-model-ru-0.42.zip && \
unzip vosk-model-ru-0.42.zip && \
mv vosk-model-ru-0.42 model && \
rm -rf vosk-model-ru-0.42 && \
VOSK_PATH=`pwd`/vosk-linux-x86_64-0.3.45 LD_LIBRARY_PATH=$VOSK_PATH CGO_CPPFLAGS="-I $VOSK_PATH" CGO_LDFLAGS="-L $VOSK_PATH" go run . -f test.wav
