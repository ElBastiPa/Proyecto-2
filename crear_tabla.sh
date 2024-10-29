#!/bin/bash

# Crear una nueva tabla
read -p "Ingrese el nombre de la nueva tabla: " tabla_nombre

# Crea un archivo para la tabla en el directorio de configuración
config_dir="config"
mkdir -p "$config_dir"
tabla_archivo="$config_dir/$tabla_nombre.conf"

if [[ -e "$tabla_archivo" ]]; then
    echo "La tabla ya existe. Intente con otro nombre."
else
    touch "$tabla_archivo"
    echo "Tabla '$tabla_nombre' creada con éxito."
fi