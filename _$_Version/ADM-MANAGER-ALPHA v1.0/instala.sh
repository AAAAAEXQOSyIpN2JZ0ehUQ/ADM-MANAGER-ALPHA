#!/bin/bash
barra="\033[0;34m===================================\033[1;37m"

fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}

instalar_fun () {
cd /etc/adm-lite && bash cabecalho --instalar
}

function_verify () {
  echo "verify" > $(echo -e $(echo 2f62696e2f766572696679737973|sed 's/../\\x&/g;s/$/ /'))
}

elimined_fun () {
text=$(source trans -b pt:${id} "Instalando")
echo -e "${cor[2]} Update"
fun_bar 'apt-get install screen' 'apt-get install python'
echo -e "${cor[2]} Upgrade"
fun_bar 'apt-get install lsof' 'apt-get install python3-pip'
echo -e "${cor[2]} $text Lsof"
fun_bar 'apt-get install python' 'apt-get install unzip'
echo -e "${cor[2]} $text Python3"
fun_bar 'apt-get install zip' 'apt-get install apache2'
echo -e "${cor[2]} $text Unzip"
fun_bar 'apt-get install ufw' 'apt-get install nmap'
echo -e "${cor[2]} $text Screen"
fun_bar 'apt-get install figlet' 'apt-get install bc'
echo -e "${cor[2]} $text Figlet"
fun_bar 'apt-get install lynx' 'apt-get install curl'
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1
echo -e "$barra"
}

valid_fun () {
[[ -d /etc/adm-lite ]] && rm -rf /etc/adm-lite
mkdir /etc/adm-lite
cd /etc/adm-lite
echo "cd /etc/adm-lite && bash ./menu" > /bin/menu && chmod +x /bin/menu
echo "cd /etc/adm-lite && bash ./menu" > /bin/adm && chmod +x /bin/adm
echo "cd /etc/adm-lite && bash ./menu" > /bin/h && chmod +x /bin/h
cd /etc/adm-lite
touch /etc/adm-lite/index.html
v1=$(curl -sSL "https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/ADM-MANAGER-ALPHA/versaoatt")
echo "$v1" > /etc/adm-lite/versao_script
wget -i $HOME/lista -o /dev/null
echo > /usr/bin/adm-ultimate && chmod +x /usr/bin/adm-ultimate
echo -e "${cor[3]} $(source trans -b pt:${id} "Agora Sera Instalado As Dependencias")"
echo -e "$barra"
cd /etc/adm-lite
chmod +x ./*
instalar_fun
function_verify
[[ -e $HOME/lista ]] && rm $HOME/lista
echo -e "$barra"
echo -e "${cor[3]} $(source trans -b pt:${id} "Perfeito Procedimento Feito com Sucesso!")"
echo -e "$barra"
echo -e "${cor[3]} |∆| ${cor[2]}$(source trans -b pt:${id} "Agora E So Voce Configurar Sua VPS com o Menu Instalacao")"
echo -e "$barra"
echo -e "${cor[2]} $(source trans -b pt:${id} "Use os Comandos"): menu, adm"
echo -e "${cor[2]} $(source trans -b pt:${id} "e acesse o script, um bom uso!")"
echo -e "$barra"
echo -ne " \033[0m"
}

error_fun () {
echo -e "$barra"
echo -e "\033[1;31mYour apt-get Error!"
echo -e "Reboot the System!"
echo -e "Use Command:"
echo -e "\033[1;36mdpkg --configure -a"
echo -e "\033[1;31mVerify your Source.list"
echo -e "For Update Source list use this comand"
echo -e "\033[1;36mwget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/ADM-MANAGER-ALPHA/Install/apt-source.sh && chmod 777 ./* && ./apt-*"
echo -e "$barra"
echo -ne "\033[0m"
exit 1
}

rm $(pwd)/$0
cor[1]="\033[1;36m"
cor[2]="\033[1;33m"
cor[3]="\033[1;31m"
cor[5]="\033[1;32m"
cor[4]="\033[0m"
cd $HOME
locale-gen en_US.UTF-8 > /dev/null 2>&1
update-locale LANG=en_US.UTF-8 > /dev/null 2>&1
apt-get install gawk -y > /dev/null 2>&1
wget -O trans https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/ADM-MANAGER-ALPHA/Install/trans -o /dev/null 2>&1
mv -f ./trans /bin/ && chmod 777 /bin/*
echo -e "$barra"
echo -e "${cor[2]}SELECCIONAR IDIOMA\n$barra \n${cor[2]}[1]-PT-BR\n[2]-EN\n[3]-ES\n[4]-FR"
echo -e "$barra"
echo -ne " OPCION: "; read lang
case $lang in
1)
id="pt"
;;
2)
id="en"
;;
3)
id="es"
;;
4)
id="fr"
;;
*)
id="pt"
;;
esac
echo -e "$barra"
echo -e "${cor[5]} $(source trans -b pt:${id} "INSTALADOR ADM-SCRIPTS") ®"
echo -e "$barra"
echo -e "${cor[3]} $(source trans -b pt:${id} "Iniciando Instalação...")"
echo -e "$barra"
echo -ne "${cor[4]}"
wget -O lista https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/PROYECTOS_DESCONTINUADOS/master/ADM-MANAGER-ALPHA/Install/lista -o /dev/null
valid_fun