#!/bin/bash
# scripts/monitor.sh

echo "=== INFORMACIÓN DEL CONTENEDOR ==="
echo "Hostname: $(hostname)"
echo "IP: $(hostname -i)"
echo "Fecha: $(date)"
echo ""

echo "=== USO DE RECURSOS ==="
echo "CPU:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "  Uso: " 100-$1 "%"}'
echo ""

echo "MEMORIA:"
free -m | awk 'NR==2{printf "  Total: %sMB | Usada: %sMB | Libre: %sMB\n", $2, $3, $4}'
echo ""

echo "=== SERVICIO WEB SIMPLE ==="
echo "Servidor web escuchando en puerto 8080..."
echo "Puedes hacer: curl http://localhost:8080/health"

# Servir contenido simple
while true; do
    echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nContenedor activo - $(date)\nCPU: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100-$1 "%"}')" | nc -l -p 8080 -q 1
    sleep 5
done