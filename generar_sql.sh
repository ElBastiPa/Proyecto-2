#!/bin/bash

# Generar archivo SQL para la base de datos
config_dir="config"
output_sql="database.sql"
echo "USE nombre_base_datos;" > "$output_sql"

for tabla_archivo in "$config_dir"/*.conf; do
    tabla_nombre=$(basename "$tabla_archivo" .conf)
    echo "Creando tabla $tabla_nombre en SQL..."

    echo "CREATE TABLE $tabla_nombre (" >> "$output_sql"
    while IFS=":" read -r campo tipo valor nulo; do
        if [[ "$campo" == "PRIMARY_KEY" ]]; then
            echo "PRIMARY KEY ($tipo)," >> "$output_sql"
        elif [[ "$campo" == "FOREIGN_KEY" ]]; then
            echo "FOREIGN KEY ($tipo) REFERENCES $valor($campo)," >> "$output_sql"
        else
            [[ -z "$valor" ]] && valor="" || valor="DEFAULT $valor"
            echo "$campo $tipo $nulo $valor," >> "$output_sql"
        fi
    done < "$tabla_archivo"
    sed -i '$ s/,$//' "$output_sql"  # Eliminar la última coma
    echo ");" >> "$output_sql"
done

echo "Archivo SQL generado en '$output_sql'."