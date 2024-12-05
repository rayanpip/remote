#!/bin/bash

# Versi Android NDK yang akan diunduh
NDK_VERSION=r26b
NDK_ARCHIVE=android-ndk-${NDK_VERSION}-linux.zip
NDK_URL=https://dl.google.com/android/repository/${NDK_ARCHIVE}

# Direktori instalasi NDK
NDK_INSTALL_DIR=/opt/android-ndk-${NDK_VERSION}

# Fungsi untuk menampilkan pesan
function log {
    echo -e "\n[INFO] $1\n"
}

# Update dan install dependensi
log "Memperbarui sistem dan menginstal dependensi..."
sudo apt update
sudo apt install -y build-essential openjdk-11-jdk unzip wget

# Unduh Android NDK
log "Mengunduh Android NDK (${NDK_VERSION})..."
wget -q --show-progress ${NDK_URL} -O /tmp/${NDK_ARCHIVE}

# Ekstrak Android NDK
log "Mengekstrak Android NDK ke ${NDK_INSTALL_DIR}..."
sudo unzip -q /tmp/${NDK_ARCHIVE} -d /opt/

# Bersihkan file unduhan
log "Menghapus file unduhan sementara..."
rm /tmp/${NDK_ARCHIVE}

# Tambahkan NDK ke PATH
log "Menambahkan Android NDK ke PATH..."
echo "export PATH=\$PATH:${NDK_INSTALL_DIR}" >> ~/.bashrc
source ~/.bashrc

# Verifikasi instalasi
log "Memeriksa instalasi Android NDK..."
if command -v ndk-build &> /dev/null; then
    log "Android NDK berhasil diinstal. Versi:"
    ndk-build --version
else
    log "Gagal menginstal Android NDK. Periksa log untuk kesalahan."
    exit 1
fi

log "Instalasi selesai. Android NDK siap digunakan!"
