#!/bin/bash

# Ejecutar el comando df -h y almacenar la salida en una variable
df_output=$(df -hm)

# Imprimir encabezado
echo "|Filesystem		       Size	Used	 Avail	  Use%	   Mounted on   |"
echo "+-------------------------------------------------------------------------------+"

# Iterar sobre cada línea de la salida del comando df -h
# La salida se divide en columnas y se imprime de forma estética
echo "$df_output" | while IFS= read -r line; do
    # Saltar la primera línea (encabezado)
    if [[ $line == Filesystem* ]]; then
        continue
    fi

    # Dividir la línea en columnas
    filesystem=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2"M"}')
    used=$(echo "$line" | awk '{print $3"M"}')
    avail=$(echo "$line" | awk '{printf "%.2fG\n", $4/1024}')
    use_percent=$(echo "$line" | awk '{print $5}')
    mounted_on=$(echo "$line" | awk '{print $6}')

    # Imprimir las columnas formateadas
    printf "%-30s %-8s %-8s %-8s %-8s %-s\n" "$filesystem" "$size" "$used" "$avail" "$use_percent" "$mounted_on"
done
