#!/bin/bash
insta_arquivos="/etc/adm-server/adm-ultimate"

start_listen () {
  apt-get install netpipes -y > /dev/null 2>&1
  screen -dmS server faucet 2000 --fd 3 sh -c "$1"
}

if [[ "$1" =~ ^-start$|^-iniciar$|^-Start$|^-Iniciar$ ]]; then
  [[ ! -e "$2" ]] && exit
  start_listen "$2"
  exit
fi

meu_ip () {
  MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.' | grep -o -E '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
  MIP2=$(wget -qO- ipv4.icanhazip.com)
  [[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

fun_list () {
  key_temp="$retrequest"
  time_key="2"
  mkdir -p /var/www/html/$key_temp/install
  mkdir -p /var/www/$key_temp/install
  cp $insta_arquivos/* /var/www/html/$key_temp/install/
  cp $insta_arquivos/* /var/www/$key_temp/install/
  touch /var/www/html/$key_temp/install/index.html
  touch /var/www/$key_temp/install/index.html
  echo -e "$credit" > /var/www/html/$key_temp/install/menu_credito
  echo -e "$credit" > /var/www/$key_temp/install/menu_credito
  touch /var/www/$key_temp/lista
  touch /var/www/html/$key_temp/lista
  meu_ip
  for lista in $(ls /var/www/html/$key_temp/install); do
    echo "$IP:81/$key_temp/install/$lista" >> /var/www/html/$key_temp/lista
    echo "$IP:81/$key_temp/install/$lista" >> /var/www/$key_temp/lista
  done
  u_dir="$RANDOM"
  echo "rm -rf /var/www/html/$key_temp /var/www/$key_temp /bin/KEY-$u_dir" > /bin/KEY-${u_dir}
  chmod +x /bin/KEY-${u_dir}
  at -f /bin/KEY-${u_dir} now + $time_key min > /dev/null 2>&1
}

(
keydir="/etc/adm-server/keys"
mkdir -p $keydir
retrequest=$((RANDOM**4+123456))
status="$retrequest"

# SALTAR VERIFICACIÓN — FORZAR FUN_LIST
request="key-$retrequest"
credit=$(cat /etc/adm-server/credit 2>/dev/null || echo "KEY SERVER")
fun_list "$retrequest"
) &
