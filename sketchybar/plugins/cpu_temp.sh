#!/bin/bash

# Pastikan osx-cpu-temp terinstal
if ! command -v osx-cpu-temp &> /dev/null; then
    echo "osx-cpu-temp tidak ditemukan. Silakan install dengan 'brew install osx-cpu-temp'"
    sketchybar --set $NAME label="Error"
    exit 1
fi

# Mendapatkan suhu CPU
TEMP=$(osx-cpu-temp -C)

# Membulatkan suhu ke bilangan bulat terdekat
TEMP_ROUNDED=$(printf "%.0f" "$TEMP")

# Menentukan warna berdasarkan suhu
if [ "$TEMP_ROUNDED" -lt 50 ]; then
    COLOR="0xFF00FF00"  # Hijau
elif [ "$TEMP_ROUNDED" -lt 70 ]; then
    COLOR="0xFFFFFF00"  # Kuning
else
    COLOR="0xFFFF0000"  # Merah
fi

# Memperbarui sketchybar
sketchybar --set $NAME label="${TEMP_ROUNDED}°C" icon.color="$COLOR"
