#!/bin/bash

directorio="$1"

if [[ ! -d "$directorio" ]]; then
        echo "Error: El directorio no existe."
        exit 1
fi

mkdir -p "$directorio/imagenes"
mkdir -p "$directorio/documentos"
mkdir -p "$directorio/comprimidos"
mkdir -p "$directorio/otros"

for archivo in "$directorio"/*; do
        if [[ ! -f "$archivo" ]]; then
                continue
        fi

        if [[ "$archivo" == *".jpg" ]] || [[ "$archivo" == *".png" ]]; then
                mv "$archivo" "$directorio/imagenes/"
                continue
        fi

        if [[ "$archivo" == *".pdf" ]] || [[ "$archivo" == *".txt" ]] || [[ "$archivo" == *".docx" ]]; then
                mv "$archivo" "$directorio/documentos/"
                continue
        fi

        if [[ "$archivo" == *".zip" ]] || [[ "$archivo" == *".tar.gz" ]] || [[ "$archivo" == *".rar" ]]; then
                mv "$archivo" "$directorio/comprimidos/"
                continue
        fi

        if [[ "$archivo" == *".old" ]]; then
                nuevo_nombre="${archivo%.old}.backup"
                mv "$archivo" "$nuevo_nombre"
                mv "$nuevo_nombre" "$directorio/otros/"
                continue
        fi

        mv "$archivo" "$directorio/otros/"
done

echo "¡Organización completada con éxito!"
