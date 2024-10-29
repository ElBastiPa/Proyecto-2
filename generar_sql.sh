#!/bin/bash

# Solicita el nombre de la base de datos
while true; do
    read -p "Ingrese el nombre de la base de datos para el archivo SQL: " db_name

    # Verifica que el nombre no esté vacío
    if [ -z "$db_name" ]; then
        echo "Error: El nombre de la base de datos no puede estar vacío."
        continue
    fi

    # Verifica si ya existe un archivo SQL con ese nombre
    if [ -f "${db_name}.sql" ]; then
        echo "Error: Ya existe un archivo con el nombre '${db_name}.sql'."
        read -p "¿Desea ingresar un nuevo nombre? (s/n): " respuesta
        if [ "$respuesta" == "n" ]; then
            echo "Cancelando operación."
            exit 1
        fi
    else
        break
    fi
done

# Define el nombre del archivo SQL
sql_file="${db_name}.sql"

# Comienza el archivo SQL con las declaraciones CREATE DATABASE y USE
echo "CREATE DATABASE IF NOT EXISTS \`${db_name}\`;" > "$sql_file"
echo "USE \`${db_name}\`;" >> "$sql_file"
echo "" >> "$sql_file"  # Agrega una línea en blanco para separación

# Agrega todas las definiciones de tablas y claves al archivo SQL
for table_conf in config/*.conf; do
    if [ -f "$table_conf" ]; then
        echo "---- Definiendo tabla desde: ${table_conf} ----" >> "$sql_file"
        echo "" >> "$sql_file"  # Línea en blanco antes de cada tabla
        # Lee el contenido del archivo de configuración
        while IFS= read -r line; do
            echo "$line" >> "$sql_file"
        done < "$table_conf"
        echo "" >> "$sql_file"  # Línea en blanco después de cada tabla
    fi
done

echo "Archivo SQL '${sql_file}' generado con éxito y listo para usar en MySQL."

# Opcional: Prueba la creación de la base de datos en MySQL
read -p "¿Desea probar la creación de la base de datos en MySQL? (s/n): " test_response
if [ "$test_response" == "s" ]; then
    mysql -u root -p -e "SOURCE ${sql_file};"
    if [ $? -eq 0 ]; then
        echo "Base de datos y tablas creadas exitosamente."
    else
        echo "Error al crear la base de datos o tablas. Revise el archivo SQL."
    fi
fi
