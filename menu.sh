#!/bin/bash

m=0

while [ "$m" -eq 0 ]; do
    clear
    echo "====================="
    echo "Sistema de Creación de Bases de Datos MySQL"
    echo "====================="
    echo "1. Crear nueva tabla"
    echo "2. Definir campos en una tabla"
    echo "3. Establecer claves primarias"
    echo "4. Establecer claves foráneas"
    echo "5. Generar archivo SQL"
    echo "6. Salir"
    echo "====================="

    read -p "Seleccione una opción: " option

    case $option in
        1) ./crear_tabla.sh ;;
        2) ./definir_campos.sh ;;
        3) ./claves.sh ;;
        4) ./claves.sh -f ;;
        5) ./generar_sql.sh ;;
        6) 
            echo "Saliendo del sistema..."
            m=1
            ;;
        *)
            echo "Opción no válida. Intente de nuevo."
            ;;
    esac
done