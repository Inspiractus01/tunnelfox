GOOS=darwin GOARCH=arm64 go build -o tunnelfox-macos-arm64 ./cmd/tunnelfox
GOOS=linux GOARCH=amd64 go build -o tunnelfox-linux-amd64 ./cmd/tunnelfox
GOOS=linux GOARCH=arm64 go build -o tunnelfox-linux-arm64 ./cmd/tunnelfox
