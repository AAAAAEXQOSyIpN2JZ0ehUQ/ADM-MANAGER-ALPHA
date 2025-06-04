#!/bin/bash

# Directorios de instalación
insta_arquivos1="/etc/adm-server"
insta_arquivos2="/etc/adm-server/adm-ultimate"

# Verificación de permisos
cd
if [ $(id -u) != 0 ]
then
echo "Ejecte este script como root"
exit
fi

# Función para instalar paquetes necesarios
repositorios () {
   apt-get install netpipes -y > /dev/null 2>&1
   apt-get install zip -y > /dev/null
   apt-get install unzip -y > /dev/null
   apt-get install screen -y > /dev/null
   apt-get install net-tools -y > /dev/null
}

# Configurar Apache para usar el puerto 81
config_apache2 () {
   apt-get install apache2 -y > /dev/null 2>&1
   sed -i 's/^Listen 80/Listen 81/' /etc/apache2/ports.conf
    systemctl restart apache2 > /dev/null
}

# Función para instalar recursos
recursos () {
   rm -rf $HOME/server.zip* > /dev/null 2>&1
   wget https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ALPHA/raw/refs/heads/main/Proyectos/ADM-Manager_Keygen/Desarrollador/server.zip > /dev/null 2>&1
}

# Configurar sistema
sistema () {
   [[ -e "$insta_arquivos1" ]] && rm -rf $insta_arquivos1
   mkdir $insta_arquivos1
   mkdir $insta_arquivos2
   unzip $HOME/server.zip
   rm -rf $HOME/server.zip*
   mv -f $HOME/etc/adm-server/adm-ultimate/* $insta_arquivos2/
   rm -rf $HOME/etc
   mv -f $insta_arquivos2/autoonline /bin/
   mv -f $insta_arquivos2/keyserver.sh /bin/
   chmod +x /bin/*
   touch /var/www/html/liberados
   touch /var/www/html/serverlibs
   echo "24377" > /var/www/html/versaoatt

}

# Mensaje de bienvenida
echo -e "\n\033[1;34m============================================"
echo -e "\033[1;33mSISTEMA KEY ADM-MANAGER - INSTALADOR"
echo -e "\033[1;34m============================================"
echo ""
echo -e "\033[1;36mInstalando paquetes necesarios..." 
repositorios
echo -e "\033[1;36mConfigurando Apache...."
config_apache2
echo -e "\033[1;36mDescargando recursos..."
recursos
echo -e "\033[1;36mInstalando sistema...\033[1;32m"
sistema
echo ""
echo -e "\033[1;32mInstalación completada con éxito!\033[0m"
[[ ! -e /etc/adm-server/credit ]] && echo "OFICIAL ADM-SERVER" > /etc/adm-server/credit
echo ""
echo -e "\033[1;33m  Perfecto, Utilice el comando \033[1;31mautoonline \033[0m"
echo -e "\033[1;33m  para administrar sus claves y \033[0m"
echo -e "\033[1;33m  Actualizar la base de servidores \033[0m"
echo ""

exit 0
