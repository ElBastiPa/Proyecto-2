#!/bin/bash

# Inicializa la variable de control del menú
m=0

while [ "$m" -eq 0 ]; do
    # Limpiar la pantalla al inicio de cada iteración
    clear

    # Mostrar opciones del menú
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

    # Leer la opción seleccionada por el usuario
    read -p "Seleccione una opción: " option

    # Ejecutar el script correspondiente según la opción
    case $option in
        1) ./crear_tabla.sh ;;
        2) ./definir_campos.sh ;;
        3) ./claves.sh ;;
        4) ./definir_clave_foranea.sh ;;
        5) ./generar_sql.sh ;;
        6) 
            echo "Saliendo del sistema..."
            m=1
            ;;
        *)
            echo "Opción no válida. Intente de nuevo."
            ;;
    esac

    # Pausa para permitir leer la salida del sistema
    read -p "Presione Enter para continuar..."
done
