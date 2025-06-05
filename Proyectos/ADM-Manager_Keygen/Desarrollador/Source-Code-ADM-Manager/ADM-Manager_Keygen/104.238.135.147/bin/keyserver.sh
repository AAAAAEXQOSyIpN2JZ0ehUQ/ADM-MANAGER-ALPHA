#!/bin/bash
insta_arquivos="/etc/adm-server/adm-ultimate"

start_listen () {
apt-get install netpipes -y > /dev/null 2>&1
screen -dmS server faucet 2000 --fd 3 sh -c "$1"
}

if [[ "$1" = @(-start|-iniciar|-Start|-Iniciar) ]]; then
  [[ ! -e "$2" ]] && exit
  start_listen "$2" && exit
fi

meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

fun_list () {
key_temp="$retrequest"
time_key="2"
#CRIA DIR
[[ ! -e /var/www ]] && mkdir /var/www
[[ ! -e /var/www/html ]] && mkdir /var/www/html
mkdir /var/www/$key_temp
mkdir /var/www/$key_temp/install
mkdir /var/www/html/$key_temp
mkdir /var/www/html/$key_temp/install
#ENVIA ARQS
cp $insta_arquivos/* /var/www/html/$key_temp/install/
touch /var/www/html/$key_temp/install/index.html
cp $insta_arquivos/* /var/www/$key_temp/install/
touch /var/www/$key_temp/install/index.html
echo -e "$credit" > /var/www/$key_temp/install/menu_credito
echo -e "$credit" > /var/www/html/$key_temp/install/menu_credito
#CRIA LISTA
touch /var/www/$key_temp/lista
touch /var/www/$key_temp/index.html
touch /var/www/html/$key_temp/lista
touch /var/www/html/$key_temp/index.html
meu_ip
for lista in `ls /var/www/html/$key_temp/install`; do
echo -e "$IP:81/$key_temp/install/$lista" >> /var/www/html/$key_temp/lista
echo -e "$IP:81/$key_temp/install/$lista" >> /var/www/$key_temp/lista
done
u_dir="$RANDOM"
echo "if [ -d /var/www/html/$key_temp ]; then
rm -rf /var/www/html/$key_temp
fi
if [ -d /var/www/$key_temp ]; then
rm -rf /var/www/$key_temp
fi
rm /bin/KEY-$u_dir" > /bin/KEY-${u_dir}
chmod +x /bin/KEY-${u_dir}
at -f /bin/KEY-${u_dir} now + $time_key min > /dev/null 2>&1
}

(
unset request
keydir="/etc/adm-server/keys"
[[ ! -d $keydir ]] && mkdir $keydir
retrequest=$((RANDOM**4+123456))
status="$retrequest"
request=$(encapsulate --fd 3 -so5i4 sh -c "echo ${status}>&5;exec 5>&-;cat<&4")
 [[ $request = "" ]] && exit || {  
  [[ -e ${keydir}/$request ]] && {
  rm ${keydir}/$request
  credit=$(cat /etc/adm-server/credit)
  fun_list "$retrequest"
  }
 }
) &