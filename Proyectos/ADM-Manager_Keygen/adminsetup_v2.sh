#!/bin/bash

# Variables de instalación
DIR_BASE="/etc/adm-server"
DIR_ULTIMATE="$DIR_BASE/adm-ultimate"
ZIP_URL="https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ALPHA/raw/refs/heads/main/Proyectos/ADM-Manager_Keygen/Desarrollador/server.zip"
ZIP_FILE="$HOME/server.zip"

# Verificación de permisos
if [[ $(id -u) -ne 0 ]]; then
    echo -e "\033[1;31mEste script debe ejecutarse como root.\033[0m"
    exit 1
fi

# Función para instalar paquetes necesarios
instalar_paquetes() {
    echo -e "\033[1;36mInstalando paquetes necesarios...\033[0m"
    apt-get update -y > /dev/null
    apt-get install -y netpipes zip unzip screen net-tools apache2 > /dev/null
}

# Configurar Apache para usar el puerto 81
configurar_apache() {
    echo -e "\033[1;36mConfigurando Apache...\033[0m"
    sed -i 's/^Listen 80/Listen 81/' /etc/apache2/ports.conf
    systemctl restart apache2 > /dev/null
}

# Descargar y preparar recursos
descargar_recursos() {
    echo -e "\033[1;36mDescargando recursos...\033[0m"
    rm -f "$ZIP_FILE"
    wget -q "$ZIP_URL" -O "$ZIP_FILE"
    if [[ ! -f "$ZIP_FILE" ]]; then
        echo -e "\033[1;31mError al descargar los recursos.\033[0m"
        exit 1
    fi
}

# Instalar sistema
instalar_sistema() {
    echo -e "\033[1;36mInstalando sistema...\033[0m"
    rm -rf "$DIR_BASE"
    mkdir -p "$DIR_ULTIMATE"

    unzip -q "$ZIP_FILE" -d "$HOME"
    rm -f "$ZIP_FILE"

    if [[ ! -d "$HOME/etc/adm-server/adm-ultimate" ]]; then
        echo -e "\033[1;31mError: Archivos extraídos no encontrados.\033[0m"
        exit 1
    fi

    mv -f "$HOME/etc/adm-server/adm-ultimate/"* "$DIR_ULTIMATE/"
    rm -rf "$HOME/etc"

    # Copiar scripts al sistema
    mv -f "$DIR_ULTIMATE/autoonline" /bin/
    mv -f "$DIR_ULTIMATE/keyserver.sh" /bin/
    chmod +x /bin/autoonline /bin/keyserver.sh

    # Archivos para Apache
    touch /var/www/html/liberados /var/www/html/serverlibs
    echo "24377" > /var/www/html/versaoatt
}

# Mensaje de bienvenida
echo -e "\n\033[1;34m============================================"
echo -e "\033[1;33mSISTEMA KEY ADM-MANAGER - INSTALADOR"
echo -e "\033[1;34m============================================"
echo ""

# Ejecución de funciones
instalar_paquetes
configurar_apache
descargar_recursos
instalar_sistema

# Finalización
echo ""
echo -e "\033[1;32mInstalación completada con éxito!\033[0m"
[[ ! -e /etc/adm-server/credit ]] && echo "OFICIAL ADM-SERVER" > /etc/adm-server/credit
echo ""
echo -e "\033[1;33mUtilice el comando \033[1;31mautoonline\033[1;33m para administrar las claves."
echo -e "También puede actualizar la base de servidores desde ahí.\033[0m"
echo ""

exit 0
