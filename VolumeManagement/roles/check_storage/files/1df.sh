#!/bin/bash

# Definir la entrada como variable
threshold_gb=$1

# Convertir el umbral de GB a bytes
threshold_bytes=$1

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

    # Convertir el espacio disponible a gigabytes
    avail_gb=$(echo "$avail" | sed 's/G//')
    avail_mb=$(echo "$avail" | sed 's/M//')
    if [[ $avail_gb == 0 ]]; then
	avail_bytes=0
    elif [[ "$avail" == *G ]]; then
        avail_bytes=$((avail_gb * 1024 * 1024 * 1024))
    elif [[ "$avail" == *M ]]; then
        avail_bytes=$((avail_mb * 1024 * 1024))
    fi

    # Imprimir las columnas formateadas
    printf "%-15s %-5s %-5s %-5s %-5s %-s\n" "$filesystem" "$size" "$used" "$avail" "$use_percent" "$mounted_on"

    # Verificar si el espacio disponible es inferior al umbral
    if [[ $avail_bytes -lt $threshold_bytes ]]; then
        echo "¡Advertencia! El espacio disponible en $filesystem es inferior a $threshold_gb GB."
    fi

done
