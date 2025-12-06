# Dockerfile
FROM alpine:latest

# Instalar herramientas básicas
RUN apk add --no-cache \
    curl \
    htop \
    stress-ng \
    && echo "Contenedor básico listo" > /etc/motd

# Script para monitoreo
COPY scripts/monitor.sh /usr/local/bin/monitor.sh
RUN chmod +x /usr/local/bin/monitor.sh

# Puerto para comunicación
EXPOSE 8080

# Comando por defecto
CMD ["/usr/local/bin/monitor.sh"]