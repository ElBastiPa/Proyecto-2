#!/bin/bash

# Solicita el nombre de la tabla para definir campos
read -p "Ingrese el nombre de la tabla: " table_name

# Verifica si existe un archivo de configuración para la tabla
config_file="config/${table_name}.conf"
if [ ! -f "$config_file" ]; then
    echo "Error: La tabla '${table_name}' no existe."
    exit 1
fi

# Solicita los detalles del campo
read -p "Ingrese el nombre del campo: " field_name
echo "Seleccione el tipo de dato para el campo:"
echo "1. INT"
echo "2. VARCHAR"
echo "3. DATE"
# Agrega otros tipos según sea necesario
read -p "Seleccione una opción (1-3): " field_type_option

case $field_type_option in
    1) field_type="INT" ;;
    2) field_type="VARCHAR(255)" ;;
    3) field_type="DATE" ;;
    *) echo "Opción no válida."; exit 1 ;;
esac

# Pregunta si el campo será la clave primaria en el futuro
read -p "¿Este campo será clave primaria en el futuro? (s/n): " is_primary_key

# Si será clave primaria y es de tipo INT, pregunta por autoincremento
if [ "$is_primary_key" == "s" ] && [ "$field_type" == "INT" ]; then
    read -p "¿Desea que este campo sea AUTOINCREMENT? (s/n): " is_autoincrement
    if [ "$is_autoincrement" == "s" ]; then
        field_definition="${field_name} ${field_type} AUTO_INCREMENT"
    else
        field_definition="${field_name} ${field_type}"
    fi
else
    field_definition="${field_name} ${field_type}"
fi

# Agrega la definición del campo al archivo de configuración de la tabla
echo "$field_definition" >> "$config_file"

echo "Campo '${field_name}' añadido a la tabla '${table_name}'."
