#!/bin/bash

for archivo in $(find . -name "*.pdf"); do

        if [[ "$archivo" == *"excluir"* ]] || [[ "$archivo" == *"pt"* ]]; then
                continue
        fi

    nombre_archivo=$(basename "$archivo")
    version=$(head -n 1 "$archivo")
    echo "Archivo: [$nombre_archivo] - Versión PDF: [$version]"
done


