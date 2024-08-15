#!/bin/bash

# Mendapatkan informasi memori
MEM_INFO=$(vm_stat | grep -E "Pages (free|active|inactive|speculative|wired down|occupied by compressor)")

# Mengekstrak nilai-nilai yang diperlukan
PAGES_FREE=$(echo "$MEM_INFO" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
PAGES_ACTIVE=$(echo "$MEM_INFO" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_INACTIVE=$(echo "$MEM_INFO" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
PAGES_SPECULATIVE=$(echo "$MEM_INFO" | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$MEM_INFO" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
PAGES_COMPRESSED=$(echo "$MEM_INFO" | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

# Menghitung total dan used pages
TOTAL_PAGES=$((PAGES_FREE + PAGES_ACTIVE + PAGES_INACTIVE + PAGES_SPECULATIVE + PAGES_WIRED + PAGES_COMPRESSED))
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED + PAGES_COMPRESSED))

# Menghitung persentase penggunaan RAM
RAM_PERCENT=$(echo "scale=2; $USED_PAGES * 100 / $TOTAL_PAGES" | bc | awk '{printf "%.0f", $0}')

# Memperbarui sketchybar
sketchybar --set $NAME label="  ${RAM_PERCENT}%"
