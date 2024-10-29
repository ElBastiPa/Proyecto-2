#!/bin/bash

# Directorio donde se almacenan los archivos de configuración de las tablas
dir_config="config"

# Solicitar el nombre de la tabla
read -p "Ingrese el nombre de la tabla para establecer la clave primaria: " tabla

# Construir la ruta del archivo de la tabla con extensión .conf
archivo_tabla="${dir_config}/${tabla}.conf"

# Verificar si el archivo de configuración de la tabla existe
if [ ! -f "$archivo_tabla" ]; then
    echo "Error: La tabla '$tabla' no existe o no se ha creado el archivo de configuración en '$dir_config'."
    exit 1
fi

# Mostrar los campos disponibles en la tabla
echo "Campos disponibles en la tabla '$tabla':"
campos=()
while IFS=: read -r campo tipo extra; do
    campos+=("$campo")
    echo "- $campo"
done < "$archivo_tabla"

# Solicitar al usuario el nombre del campo para la clave primaria
read -p "Ingrese el nombre del campo que desea establecer como clave primaria: " campo_clave

# Verificar si el campo ingresado existe en la lista de campos
if [[ " ${campos[@]} " =~ " $campo_clave " ]]; then
    # Si el campo existe, añadir la clave primaria al archivo de configuración
    echo "PRIMARY KEY ($campo_clave)" >> "$archivo_tabla"
    echo "Clave primaria establecida en el campo '$campo_clave' de la tabla '$tabla'."
else
    # Mostrar un mensaje de error si el campo no existe
    echo "Error: El campo '$campo_clave' no existe en la tabla '$tabla'."
fi
