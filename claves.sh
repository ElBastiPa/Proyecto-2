#!/bin/bash

# Establecer claves primarias y foráneas
config_dir="config"
read -p "Ingrese el nombre de la tabla: " tabla_nombre
tabla_archivo="$config_dir/$tabla_nombre.conf"

if [[ ! -f "$tabla_archivo" ]]; then
    echo "La tabla no existe. Cree la tabla primero."
    exit 1
fi

echo "1. Establecer clave primaria"
echo "2. Establecer clave foránea"
read -p "Seleccione una opción: " opcion

if [[ $opcion -eq 1 ]]; then
    # Clave primaria
    read -p "Ingrese el nombre del campo a establecer como clave primaria: " clave_primaria
    echo "PRIMARY_KEY:$clave_primaria" >> "$tabla_archivo"
    echo "Clave primaria '$clave_primaria' agregada."
elif [[ $opcion -eq 2 ]]; then
    # Clave foránea
    read -p "Tabla relacionada: " tabla_relacionada
    read -p "Campo relacionado: " campo_relacionado
    echo "FOREIGN_KEY:$campo_relacionado:$tabla_relacionada" >> "$tabla_archivo"
    echo "Clave foránea añadida entre '$tabla_nombre' y '$tabla_relacionada'."
else
    echo "Opción no válida."
fi