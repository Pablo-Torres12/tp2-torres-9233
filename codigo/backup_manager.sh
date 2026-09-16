#!/bin/bash

LEGAJO="9233"
LOCK_DIR="/var/lock/backup_${LEGAJO}.lock"
TEMP_DIR="/tmp/backup_${LEGAJO}"
LOGS_DIR="logs"
FECHA=$(date +"%Y%m%d_%H%M%S")
BACKUP_TAR="${LOGS_DIR}/backup_${LEGAJO}_${FECHA}.tar.gz"

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
        echo "Error: Ya hay un respaldo en ejecución (bloqueo detectado)."
        exit 9
fi

trap 'rmdir "$LOCK_DIR"' EXIT


echo "Iniciando el proceso de respaldo..."

rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
mkdir -p "$LOGS_DIR"

echo "Buscando archivos modificados en las últimas 24 horas..."

find . -mtime -1 -type f -exec cp {} "$TEMP_DIR/" \; 2>/dev/null

echo "Empaquetando y comprimiendo el directorio..."

tar -czf "$BACKUP_TAR" -C "/tmp" "backup_${LEGAJO}"

rm -rf "$TEMP_DIR"

echo "Respaldo completado con éxito. Archivo generado en: $BACKUP_TAR"
