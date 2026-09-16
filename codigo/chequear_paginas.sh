#!/bin/bash

VERDE="\e[32m"
AMARILLO="\e[33m"
ROJO="\e[31m"
FIN="\e[0m"

ARCHIVO="sitios_9233.txt"
LOG="logs/chequeo_9233.log"

mkdir -p logs
echo "=== Reporte de Verificación de Sitios ===" > "$LOG"


if [ $# -eq 0 ]; then
        echo "No se ingresaron argumentos. Leyendo desde $ARCHIVO..."
        if [ ! -f "$ARCHIVO" ]; then
                echo "Error: No se encontró el archivo $ARCHIVO."
                exit 1
        fi
        LISTA_URLS=$(cat "$ARCHIVO")
else
        echo "Leyendo URLs ingresadas por consola..."
        LISTA_URLS="$@"
fi


echo "Iniciando chequeo de sitios..."

for url in $LISTA_URLS; do

        codigo=$(curl -s -o /dev/null -w "%{http_code}" "$url")


        case $codigo in
                200)
                        color=$VERDE
                        ;;
                3*)
                        color=$AMARILLO
                        ;;
                4*|5*)
                        color=$ROJO
                        ;;
                *)
                        color=$FIN
                        ;;
        esac


        echo -e "Sitio: $url -> Estado: ${color}${codigo}${FIN}"

        echo "Sitio: $url -> Estado: $codigo" >> "$LOG"
done

echo "Chequeo finalizado. Reporte guardado en $LOG"
