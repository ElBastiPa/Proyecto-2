#!/bin/bash

# Directorio donde se almacenan los archivos de configuración de las tablas
dir_config="config"

# Comprobar si el directorio de configuración existe
if [ ! -d "$dir_config" ]; then
    echo "Error: El directorio de configuración '$dir_config' no existe."
    exit 1
fi

# Listar las tablas disponibles
echo "Tablas disponibles:"
tablas=()
for archivo in "$dir_config"/*.conf; do
    tabla=$(basename "$archivo" .conf)
    tablas+=("$tabla")
    echo "- $tabla"
done

# Solicitar al usuario el nombre de la tabla que contendrá la clave foránea
read -p "Ingrese el nombre de la tabla de origen para definir la clave foránea: " tabla_origen

# Comprobar que el archivo de la tabla de origen exista
archivo_origen="${dir_config}/${tabla_origen}.conf"
if [ ! -f "$archivo_origen" ]; then
    echo "Error: La tabla '$tabla_origen' no existe."
    exit 1
fi

# Mostrar los campos de la tabla de origen
echo "Campos en la tabla '$tabla_origen':"
campos_origen=()
while IFS=: read -r campo tipo extra; do
    campos_origen+=("$campo")
    echo "- $campo"
done < "$archivo_origen"

# Solicitar el campo que actuará como clave foránea
read -p "Ingrese el nombre del campo en '$tabla_origen' que será la clave foránea: " campo_origen

# Verificar si el campo existe en la tabla de origen
if [[ ! " ${campos_origen[@]} " =~ " $campo_origen " ]]; then
    echo "Error: El campo '$campo_origen' no existe en la tabla '$tabla_origen'."
    exit 1
fi

# Solicitar el nombre de la tabla de destino
read -p "Ingrese el nombre de la tabla de destino (referenciada): " tabla_destino

# Verificar que el archivo de la tabla de destino exista
archivo_destino="${dir_config}/${tabla_destino}.conf"
if [ ! -f "$archivo_destino" ]; then
    echo "Error: La tabla '$tabla_destino' no existe."
    exit 1
fi

# Mostrar los campos de la tabla de destino
echo "Campos en la tabla '$tabla_destino':"
campos_destino=()
while IFS=: read -r campo tipo extra; do
    campos_destino+=("$campo")
    echo "- $campo"
done < "$archivo_destino"

# Solicitar el campo de la tabla de destino que se referenciará
read -p "Ingrese el nombre del campo en '$tabla_destino' que será referenciado: " campo_destino

# Verificar si el campo existe en la tabla de destino
if [[ ! " ${campos_destino[@]} " =~ " $campo_destino " ]]; then
    echo "Error: El campo '$campo_destino' no existe en la tabla '$tabla_destino'."
    exit 1
fi

# Añadir la clave foránea en el archivo de configuración de la tabla de origen
echo "FOREIGN KEY ($campo_origen) REFERENCES $tabla_destino($campo_destino)" >> "$archivo_origen"
echo "Clave foránea definida en '$tabla_origen' ($campo_origen) que referencia a '$tabla_destino' ($campo_destino)."
