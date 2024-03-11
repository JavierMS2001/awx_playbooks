#!/bin/bash

# Ejecutar el comando df -h y almacenar la salida en una variable
df_output=$(df -h)

# Imprimir encabezado
echo "Filesystem      Size  Used Avail Use% Mounted on"

# Iterar sobre cada línea de la salida del comando df -h
# La salida se divide en columnas y se imprime de forma estética
echo "$df_output" | while IFS= read -r line; do
    # Saltar la primera línea (encabezado)
    if [[ $line == Filesystem* ]]; then
        continue
    fi
    
    # Dividir la línea en columnas
    filesystem=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2}')
    used=$(echo "$line" | awk '{print $3}')
    avail=$(echo "$line" | awk '{print $4}')
    use_percent=$(echo "$line" | awk '{print $5}')
    mounted_on=$(echo "$line" | awk '{print $6}')

    # Imprimir las columnas formateadas
    printf "%-15s %-5s %-5s %-5s %-5s %-s\n" "$filesystem" "$size" "$used" "$avail" "$use_percent" "$mounted_on"
done
