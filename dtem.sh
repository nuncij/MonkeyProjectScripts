#/bin/bash
         
CONF_FILE="dystem.conf"
CONF_DIR=".dystem"
PORT=65443
RPC_PORT=17100
VERSION=V1.0.5

if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e "The operating system is not Ubuntu 16.04. You must be running on ubuntu 16.04."
  exit 1
fi

printf '\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;146m▄\e[48;5;0m\e[38;5;146m▄\e[48;5;0m\e[38;5;146m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;7m\e[38;5;146m▄\e[48;5;152m\e[38;5;146m▄\e[48;5;0m\e[38;5;146m▄\e[48;5;0m\e[38;5;251m▄\e[48;5;0m\e[38;5;250m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;7m\e[38;5;146m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;251m\e[38;5;146m▄\e[48;5;251m\e[38;5;146m▄\e[48;5;7m\e[38;5;251m▄\e[48;5;0m\e[38;5;7m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m\e[38;5;0m▄\e[48;5;146m\e[38;5;15m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;251m\e[38;5;146m▄\e[48;5;251m\e[38;5;152m▄\e[48;5;0m\e[38;5;251m▄\e[48;5;0m\e[38;5;248m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;251m\e[38;5;146m▄\e[48;5;252m\e[38;5;146m▄\e[48;5;0m\e[38;5;152m▄\e[48;5;0m\e[38;5;152m▄\e[48;5;0m \e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;152m\e[38;5;146m▄\e[48;5;251m\e[38;5;146m▄\e[48;5;0m\e[38;5;251m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;152m\e[38;5;146m▄\e[48;5;251m\e[38;5;146m▄\e[48;5;7m\e[38;5;251m▄\e[48;5;0m\e[38;5;7m▄\e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;152m\e[38;5;146m▄\e[48;5;0m\e[38;5;159m▄\e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;248m\e[38;5;0m▄\e[48;5;146m\e[38;5;0m▄\e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;152m\e[38;5;7m▄\e[48;5;0m\e[38;5;147m▄\e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m\e[38;5;146m▄\e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;251m\e[38;5;146m▄\e[48;5;0m\e[38;5;251m▄\e[48;5;0m\e[38;5;251m▄\e[48;5;0m \e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m\e[38;5;146m▄\e[48;5;0m \e[48;5;7m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[0m
\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;251m\e[38;5;146m▄\e[48;5;0m\e[38;5;7m▄\e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m\e[38;5;105m▄\e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;146m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m\e[38;5;146m▄\e[48;5;0m \e[48;5;147m\e[38;5;0m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[0m
\e[48;5;110m\e[38;5;68m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;152m\e[38;5;146m▄\e[48;5;0m\e[38;5;146m▄\e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[0m
\e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;110m\e[38;5;68m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[48;5;0m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m\e[38;5;147m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;146m \e[48;5;0m \e[48;5;0m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m \e[48;5;146m \e[48;5;146m \e[0m
\e[48;5;68m\e[38;5;67m▄\e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;110m\e[38;5;104m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m\e[38;5;110m▄\e[48;5;147m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;146m\e[38;5;110m▄\e[48;5;146m\e[38;5;110m▄\e[0m
\e[48;5;0m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;110m\e[38;5;68m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;0m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m\e[38;5;109m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;103m▄\e[48;5;0m\e[38;5;110m▄\e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;147m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;109m\e[38;5;0m▄\e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;74m\e[38;5;68m▄\e[48;5;110m\e[38;5;68m▄\e[48;5;110m\e[38;5;104m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;147m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m\e[38;5;104m▄\e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;73m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;68m\e[38;5;0m▄\e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;110m\e[38;5;68m▄\e[48;5;110m\e[38;5;104m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;109m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;0m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m\e[38;5;110m▄\e[48;5;0m\e[38;5;110m▄\e[48;5;105m\e[38;5;110m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;0m▄\e[48;5;103m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;68m\e[38;5;67m▄\e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;74m\e[38;5;68m▄\e[48;5;74m\e[38;5;68m▄\e[48;5;74m\e[38;5;68m▄\e[48;5;74m\e[38;5;68m▄\e[48;5;74m\e[38;5;68m▄\e[48;5;110m\e[38;5;68m▄\e[48;5;110m\e[38;5;68m▄\e[48;5;110m\e[38;5;68m▄\e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m \e[48;5;110m\e[38;5;103m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;74m\e[38;5;0m▄\e[48;5;68m\e[38;5;0m▄\e[48;5;68m\e[38;5;0m▄\e[48;5;68m\e[38;5;67m▄\e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;68m \e[48;5;104m\e[38;5;68m▄\e[48;5;110m\e[38;5;104m▄\e[48;5;110m\e[38;5;104m▄\e[48;5;110m\e[38;5;67m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;110m\e[38;5;0m▄\e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[48;5;0m \e[0m
';
echo 
echo "DYSTEM - Masternode installer ${VERSION}"
echo 
echo "Welcome to the dystem MN installer."
echo
echo "Please follow the instructions when asked and press [ENTER] when asked too do so."
echo
echo "Are you sure you want to install a dystem masternode? type y/n followed by [ENTER]:"
read AGREE

if [[ $AGREE =~ "y" ]] ; then

	echo "Enter PORT? type y/n followed by [ENTER]:"
	read PORT
	
	if [ -z "$PORT" ]; then
	   PORT=65443
	fi

	#Install required dependancies
	#sudo apt-get -y update
	#sudo apt-get -y upgrade
	#sudo apt-get -y dist-upgrade
	#sudo apt-get -y autoremove
	#sudo apt-get -y autoclean
	#sudo apt-get -y install software-properties-common
	#sudo add-apt-repository ppa:bitcoin/bitcoin
	#sudo apt-get update
	#sudo apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libssl-dev libgmp3-dev libevent-dev bsdmainutils libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libzmq5 libboost-system1.58-dev libboost-system1.58.0 libboost-filesystem1.58-dev libboost-filesystem1.58.0 libboost-program-options-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libevent-pthreads-2.0-5


	#Increase swap memory
	#cd /var
	#sudo touch swap.img
	#sudo chmod 600 swap.img
	#sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
	#sudo mkswap /var/swap.img
	#sudo swapon /var/swap.img
	#sudo free
	#sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
	#cd

	#Pull down and unpack binaries
	wget https://github.com/Dystem/dystem-core/releases/download/$VERSION/mnbin.tar.gz
	tar -xzf mnbin.tar.gz
	sudo mv bin/* /usr/bin
	sed -i -e '13i/usr/bin/dystemd || exit 1\' /etc/rc.local
	mkdir -p ~/bin
	echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
	source ~/.bashrc

	#Get users to input required details
	echo "We are now going to setup the masternode"
	echo
  	echo "Please type the 'masternode private key' for this $ALIAS followed by [ENTER]:"
  	read MN_PRIVATE_KEY

  	#Write config to config file
  	mkdir -p $CONF_DIR
  	cd $CONF_DIR
  	touch $CONF_FILE 

  	touch dystem.conf_TEMP
  	echo "rpcuser=dtem"`shuf -i 100000-10000000 -n 1` >> dystem.conf_TEMP 
  	echo "rpcpassword="`shuf -i 100000-10000000 -n 1` >> dystem.conf_TEMP 
  	echo "rpcallowip=127.0.0.1" >> dystem.conf_TEMP 
  	echo "rpcport=17100" >> dystem.conf_TEMP 
  	echo "listen=1" >> dystem.conf_TEMP 
  	echo "server=1" >> dystem.conf_TEMP 
  	echo "daemon=1" >> dystem.conf_TEMP 
  	echo "masternode=1" >> dystem.conf_TEMP 
  	echo "masternodeaddr=$(hostname  -I | cut -f1 -d' '):$PORT" >> dystem.conf_TEMP 
	echo "bind=$(hostname  -I | cut -f1 -d' '):$PORT" >> dystem.conf_TEMP 
  	echo "masternodeprivkey=$MN_PRIVATE_KEY" >> dystem.conf_TEMP 
  	echo "maxconnections=256" >> dystem.conf_TEMP 
  	echo "port=$PORT" >> dystem.conf_TEMP 
    echo "addnode=45.32.236.168" >> dystem.conf_TEMP 
    echo "addnode=45.76.251.25" >> dystem.conf_TEMP 
    echo "addnode=149.28.146.122" >> dystem.conf_TEMP 
    echo "addnode=80.240.31.71" >> dystem.conf_TEMP 
    echo "addnode=104.238.189.152" >> dystem.conf_TEMP 
    echo "addnode=149.28.232.166" >> dystem.conf_TEMP 
    echo "addnode=45.63.54.162" >> dystem.conf_TEMP 
    echo "addnode=108.61.215.68" >> dystem.conf_TEMP 
    echo "addnode=207.148.121.118" >> dystem.conf_TEMP 
    echo "addnode=207.148.80.150" >> dystem.conf_TEMP 
    echo "addnode=202.182.125.85" >> dystem.conf_TEMP 
    echo "addnode=217.163.29.93" >> dystem.conf_TEMP 

  	mv dystem.conf_TEMP dystem.conf
  	sudo rm -rdf "/root/bin"
  	sudo rm -f "/root/mnbin.tar.gz"
  	sudo rm -f "/root/mn_install.sh"

  	echo "Enjoy your masternode rewards! Now if you could get the developers a nice cup of coffee..."
fi 