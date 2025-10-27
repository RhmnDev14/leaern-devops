# BUILD STAGE
# Menggunakan golang 1.25-alpine 
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Menyalin go.mod dan go.sum (PENTING: Pastikan kedua file ini ada di root lokal Anda!)
COPY go.mod .
COPY go.sum .

# Download dependencies
RUN go mod download

# Menyalin kode sumber aplikasi
COPY . .

# Gunakan flag -o /myapp dan tambahkan flag -ldflags "-s -w -extldflags '-static'" 
RUN apk add --no-cache tzdata && \
    CGO_ENABLED=0 go build -ldflags "-s -w -extldflags '-static'" -o /myapp .

# FINAL STAGE
FROM scratch

# Menyalin Timezone database. Sekarang file ini ada di builder image.
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
# COPY --from=builder /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1 

# Menyalin binary 'myapp' yang sudah dikompilasi dari build stage ke root container FINAL
COPY --from=builder /myapp /myapp

# Menentukan port yang akan digunakan aplikasi
EXPOSE 8080

# 💡 PERBAIKAN: Perintah untuk menjalankan binary /myapp
ENTRYPOINT ["/myapp"]
