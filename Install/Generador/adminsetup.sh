#!/bin/bash
insta_arquivos1="/etc/adm-server"
insta_arquivos2="/etc/adm-server/adm-ultimate"
cd
if [ $(id -u) != 0 ]
then
echo "Ejecte este script como root"
exit
fi

repositorios () {
   apt-get install netpipes -y > /dev/null 2>&1
   apt-get install zip -y > /dev/null
   apt-get install unzip -y > /dev/null
   apt-get install screen -y > /dev/null
}

config_apache2 () {
   apt-get install apache2 -y > /dev/null 2>&1
   sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
   service apache2 restart > /dev/null 2>&1
}

recursos () {
   rm -rf $HOME/server.zip* > /dev/null 2>&1
   wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-ALPHA/main/Install/Generador/Install/server.zip > /dev/null 2>&1
}

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
}

echo -e "\033[01;34m         \033[01;33m SISTEMA KEY ADM-MANAGER"
echo ""
echo -e "\033[1;36mATUALIZANDO REPOSITÓRIOS..." 
repositorios
echo -e "\033[1;36mCONFIGURANDO APACHE..."
config_apache2
echo -e "\033[1;36mINSTALANDO RECURSOS..."
recursos
echo -e "\033[1;36mINSTALANDO SISTEMA...\033[1;32m"
echo ""
sistema
echo ""
echo -e "\033[1;36mINSTALAÇÃO CONCLUÍDA!"
rm -rf $HOME/adminsetup.sh* > /dev/null 2>&1
echo ""
echo -e "\033[1;33m  Perfecto, Utilice el comando \033[1;31mautoonline \033[0m"
echo -e "\033[1;33m  para administrar sus claves y \033[0m"
echo -e "\033[1;33m  Actualizar la base de servidores \033[0m"
echo ""
exit