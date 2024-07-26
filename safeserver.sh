#!/bin/bash

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










