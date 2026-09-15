#!/bin/bash

PS3="Ingrese el número de la opción deseada: "

# Armamos una lista con los nombres exactos de nuestras opciones
opciones=("Monitorear memoria RAM" "Buscar archivos grandes" "Espacio en particiones" "Salir")

echo "=== Panel de Monitoreo Interactivo ==="

# select dibuja el menú automáticamente
select opcion in "${opciones[@]}"; do

        # case evalúa qué opción eligió el usuario
        case $opcion in
                "Monitorear memoria RAM")
                        echo "Iniciando monitoreo en tiempo real. Presione Ctrl+C para salir y volver al menú."
                        watch -n 1 free -m
                        ;;
                "Buscar archivos grandes")
                        echo "Buscando los 5 archivos más grandes (>10MB) en $HOME..."
                        find "$HOME" -type f -size +10M -exec du -h {} + 2>/dev/null | sort -rh | head -n 5
                        ;;
                "Espacio en particiones")
                        echo "Uso de espacio de las particiones físicas montadas:"
                        df -h | grep '^/dev/'
                        ;;
                "Salir")
                        echo "¡Panel cerrado con éxito! Alumno Pablo Torres - Legajo: 9233."
                        break 
                        ;;
                *)
                        echo "Opción inválida. Por favor, seleccione un número del 1 al 4."
                        ;;
        esac
done

