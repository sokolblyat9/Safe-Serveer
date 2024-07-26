#!/bin/bash

# Определение цветов текста и фона
RED='\033[0;31m'
BLUE='\033[0;34m'
WHITE='\033[0;37m'
RESET='\033[0m' # Сброс всех атрибутов


# Примеры использования цветов
echo -e "================================================================================================================================================"
echo -e "||" "${WHITE}ooooooooo.     .oooooo.   oooooo   oooooo     oooo oooooooooooo ooooooooo.   oooooooooooo oooooooooo.         oooooooooo.  oooooo   oooo  " "||"
echo -e "||" "${WHITE}\`888   \`Y88.  d8P'  \`Y8b   \`888.    \`888.     .8'  \`888'     \`8 \`888   \`Y88. \`888'     \`8 \`888'   \`Y8b        \`888'   \`Y8b  \`888.   .8'" "   ||"
echo -e "||" "${BLUE} 888   .d88' 888      888   \`888.   .8888.   .8'    888          888   .d88'  888          888      888        888     888   \`888. .8'    " "||"
echo -e "||" "${BLUE} 888ooo88P'  888      888    \`888  .8'\`888. .8'     888oooo8     888ooo88P'   888oooo8     888      888        888oooo888'    \`888.8'    " " ||"
echo -e "||" "${RES} 888         888      888     \`888.8'  \`888.8'      888    \"     888\`88b.     888    \"     888      888        888    \`88b     \`888'  " "    ||"
echo -e "||" "${RED} 888         \`88b    d88'      \`888'    \`888'       888       o  888  \`88b.   888       o  888     d88'        888    .88P      888      " " ||"
echo -e "||" "${RED}o888o         \`Y8bood8P'        \`8'      \`8'       o888ooooood8 o888o  o888o o888ooooood8 o888bood8P'         o888bood8P'      o888o      " "||"
echo "||" "                                                                                                                                           ||"
echo -e "||" "${WHITE} .oooooo..o   .oooooo.   oooo    oooo   .oooooo.   ooooo             oooooooooo.  ooooo        oooooo   oooo       .o.       oooooooooo. " " ||"
echo -e "||" "${WHITE}d8P'    \`Y8  d8P'  \`Y8b  \`888   .8P'   d8P'  \`Y8b  \`888'             \`888'   \`Y8b \`888'         \`888.   .8'       .888.      \`888'   \`Y8b" " ||"
echo -e "||" "${BLUE}Y88bo.      888      888  888  d8'    888      888  888               888     888  888           \`888. .8'       .8\"888.      888      888" "||"
echo -e "||" "${BLUE} \`\"Y8888o.  888      888  88888[      888      888  888               888oooo888'  888            \`888.8'       .8' \`888.     888      888" "||"
echo -e "||" "${BLUE}     \`\"Y88b 888      888  888\`88b.    888      888  888               888    \`88b  888             \`888'       .88ooo8888.    888      888" "||"
echo -e "||" "${RED}oo     .d8P \`88b    d88'  888  \`88b.  \`88b    d88'  888       o       888    .88P  888       o      888       .8'     \`888.   888     d88'" "||"
echo -e "||" "${RED}8\"\"88888P'   \`Y8bood8P'  o888o  o888o  \`Y8bood8P'  o888ooooood8      o888bood8P'  o888ooooood8     o888o     o88o     o8888o o888bood8P'" "  ||"
echo -e "================================================================================================================================================"
echo -e "${RESET}"







function Ystanovka_Expect {
echo "Проверим, установлена ли у тебя утилита expect"
#eval "expetc -v"
command1=eval expect -v
echo "$command1"
if [[ $command1=="*команда не найдена*" ]]; then
    echo "Установим утилиту, так как она нам будет нужна для автоматизации подстановки пароля"
    os_info=$(lsb_release -a)
        if [[ $os_info == *"CentOS"* || $os_info == *"Fedora"* ]]; then
            yum update
            yum install expect
        elif
            [[ $os_info == *"Debian"* || $os_info == *"Ubuntu"* ]]; then
            sudo apt update && sudo apt upgrade -y
            sudo apt install expect
        else
            echo "Вы пользуетесь MacOS"
        fi
else
    echo "expect установлена"
fi
}
Ystanovka_Expect



function SSH_KEYGEN {
echo "Введем путь для хранения ключей (или нажмите Enter для использования дефолтного пути): "
read path_to_keys_server
path_to_keys_server_per="$path_to_keys_server"

if [[ -z "$path_to_keys_server_per" ]]; then
    path_to_keys_server_per="$HOME/.ssh/id_rsa"
fi
echo "Создадим пару ключей"
ssh-keygen -f "$path_to_keys_server_per" -b 4096
}
SSH_KEYGEN




function login_server {
echo "Напишите какой логин у сервера"
read login_key
login_key_server="$login_key"
}
login_server


function password_server {
echo "Напишите какой пароль у сервера"
read password_key
password_key_server="$password_key"
}
password_server


function ip_address {
echo "Напишите какой ip адрес сервера"
read ip_address
ip_address_server="$ip_address"
}
ip_address


function Port_Server {
PS3="Какой порт у твоего сервера? :"
local port_s
select port_s in 22 Кастомный
do
                case $port_s in
                22)
                    port_server_key="22"
                        echo "Вы выбрали порт сервера - $port_server_key"
                        break
                        ;;
                Кастомный)
                    echo "Введите номер порта"
                    read port_klava
                    port_server_key=$port_klava
                        echo "Вы выбрали порт сервера - $port_server_key"
                        break
                        ;;
                *)
                        echo "Недопустимый выбор"
                        ;;
                esac
done
echo "Выбранный порт: $port_server_key"
}
Port_Server


function copy_key_to_server {
echo "Скопируем публичный ключ на сервер"
    if [[ $port_server_key -eq 22 ]]; then
        #ssh-copy-id -i "$path_to_keys_server_per" "$login_key_server@$ip_address_server"
        expect -c "
        spawn ssh-copy-id -i \"$path_to_keys_server_per\" $login_key_server@$ip_address_server
        expect {
            \"*password:\" { send \"$password_key_server\r\" }
        }
        interact
        "
    else
        #ssh-copy-id -i "$path_to_keys_server_per" -P "$port_server_key $login_key_server@$ip_address_server"
        expect -c "
        spawn ssh-copy-id -i \"$path_to_keys_server_per\" -oPort=$port_server_key $login_key_server@$ip_address_server
        expect {
            \"*password:\" { send \"$password_key_server\r\" }
        }
        interact
        "
    fi
}
copy_key_to_server










function automatic_password {
    expect -c "
    spawn ssh -p $port_server_key $login_key_server@$ip_address_server
    expect {
        \"*yes/no\" { send \"yes\r\"; exp_continue }
        \"*password:\" { send \"$password_key_server\r\" }
    }
    interact
    "
}
automatic_password










