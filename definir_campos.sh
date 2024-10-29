#!/bin/bash

# Definir campos para una tabla existente
config_dir="config"
read -p "Ingrese el nombre de la tabla para agregar campos: " tabla_nombre
tabla_archivo="$config_dir/$tabla_nombre.conf"

if [[ ! -f "$tabla_archivo" ]]; then
    echo "La tabla no existe. Por favor, cree la tabla primero."
    exit 1
fi

# Recolección de datos para cada campo
while true; do
    read -p "Ingrese el nombre del campo (o 'salir' para terminar): " campo_nombre
    [[ "$campo_nombre" == "salir" ]] && break

    echo "Seleccione el tipo de dato:"
    echo "1. INT"
    echo "2. VARCHAR"
    echo "3. DATE"
    echo "4. FLOAT"
    read -p "Tipo de dato (número): " tipo
    case $tipo in
        1) tipo_dato="INT";;
        2) tipo_dato="VARCHAR"; read -p "Ingrese el tamaño: " tamano; tipo_dato+="($tamano)";;
        3) tipo_dato="DATE";;
        4) tipo_dato="FLOAT";;
        *) echo "Tipo inválido. Intente de nuevo."; continue;;
    esac

    read -p "Valor por defecto (presione Enter para omitir): " valor_defecto
    read -p "¿Permitir valores NULL? (s/n): " es_nulo
    [[ "$es_nulo" == "s" ]] && nulo="NULL" || nulo="NOT NULL"

    # Agrega el campo al archivo de configuración
    echo "$campo_nombre:$tipo_dato:$valor_defecto:$nulo" >> "$tabla_archivo"
    echo "Campo agregado con éxito."
done