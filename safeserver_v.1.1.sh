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






function Update_and_Upgarde_Remote_Server {
echo "Обновим пакеты на сервере, но сначала узнаем какую операционную систему ты используешь"
os_info=$(lsb_release -a)
    if [[ $os_info == *"CentOS"* || $os_info == *"Fedora"* ]]; then
        yum update
    elif
        [[ $os_info == *"Debian"* || $os_info == *"Ubuntu"* ]]; then
        sudo apt update && sudo apt upgrade -y
    else
        echo "Вы пользуетесь MacOS"
    fi
}
Update_and_Upgarde_Remote_Server


#function Add_New_User {
#PS3="Добавим нового пользователя? :"
#local polzovatel
#    select polzovatel in Да Нет
#    do
#                case $polzovatel in
#                Да)
#                   echo -e "Напиши название пользователя: \n"
#                    read polzovatel
#                    new_polzovatel="$polzovatel"
#                    eval sudo adduser "$new_polzovatel"
#                    Add_New_User
#                    ;;
#                Нет)
#                    echo "Новый пользователь не будет добавлен"
#                    break
#                    ;;
#                *)
#                    echo "Повтори еще раз"
#                    ;;
#                esac
#done
#echo "Добавлен новый пользователь: $new_polzovatel"
#}
#Add_New_User

function Add_New_User {
    PS3="Добавим нового пользователя? :"
    local users=()  # Массив для хранения имен пользователей
    while true; do
        select choice in Да Нет; do
            case $choice in
                Да)
                    echo -e "Напиши название пользователя: \n"
                    read user
                    users+=("$user")  # Добавляем пользователя в массив
                    eval sudo adduser "$user"
                    break
                    ;;
                Нет)
                    echo "Новый пользователь не будет добавлен"
                    # Выводим всех добавленных пользователей
                    echo "Добавленные пользователи: ${users[@]}"
                    return
                    ;;
                *)
                    echo "Повтори еще раз"
                    ;;
            esac
        done
    done
}

Add_New_User


#function Add_Sudo_Privileges {
    # Получаем список всех пользователей
#    users=($(getent passwd | cut -d: -f1))
#
#    PS3="Выберите пользователя, которому нужно дать права sudo: "
#
#    select user in "${users[@]}"; do
#        if [[ -n "$user" ]]; then
#            # Добавляем пользователя в группу sudo
#            sudo usermod -aG sudo "$user"
#            echo "Пользователь $user добавлен в группу sudo."
#            break
#        else
#            echo "Неправильный выбор. Попробуйте еще раз."
#        fi
#    done
#}

#Add_Sudo_Privileges

function Add_Sudo_Privileges {
    while true; do
        # Получаем список всех пользователей
        users=($(getent passwd | cut -d: -f1))
        users+=("Выход")  # Добавляем опцию "Выход" в конец списка



#Объяснение изменений:
#shopt -s nocasematch и shopt -u nocasematch: Включение и отключение опции #nocasematch, чтобы сделать проверку в case нечувствительной к регистру.
#Упрощенная проверка case: Упрощение проверки case, чтобы учитывать только #"да" и "yes" в любом регистре.
#Теперь, независимо от того, вводите ли вы "Да", "да", "Yes" или "yes", скрипт #должен продолжать работу. В любом другом случае он завершит выполнение.


        PS3="Выберите пользователя, которому нужно дать права sudo: "

        select user in "${users[@]}"; do
            if [[ "$user" == "Выход" ]]; then
                echo "Вы вышли и не хотите добавить пользователя в sudo"
                return  # Завершение функции
            elif [[ -n "$user" ]]; then
                # Добавляем пользователя в группу sudo
                sudo usermod -aG sudo "$user"
                echo "Пользователь $user добавлен в группу sudo."
                break
            else
                echo "Неправильный выбор. Попробуйте еще раз."
            fi

        done

        # Спрашиваем, нужно ли добавить еще одного пользователя
        read -p "Хотите добавить еще одного пользователя в группу sudo? (Да/Нет): " answer
        shopt -s nocasematch
        case $answer in
            да|yes)
                continue
                ;;
            *)
                echo "Выход из скрипта."
                break
                ;;
        esac
        shopt -u nocasematch
    done
}

Add_Sudo_Privileges


function Edit_SSH_Config_Port {
    PS3="Какой порт предпочитаете использовать? :"
    select port_server_number in 'Стандартный - 22' Кастомный; do
        case $port_server_number in
            'Стандартный - 22')
                port_server_number_ok="22"
                echo "Вы выбрали 22 порт"
                break
                ;;
            Кастомный)
                echo "Введите номер порта:"
                read port_server_number_ok
                if ! [[ $port_server_number_ok =~ ^[0-9]+$ ]] || (( $port_server_number_ok < 1 || $port_server_number_ok > 65535 )); then
                    echo "Недопустимый порт. Попробуйте еще раз."
                    continue
                fi

                # Замена строки с новым номером порта
                #sudo sed -i "s/^#Port [0-9]*/Port $port_server_number_ok/" /etc/ssh/sshd_config
                #sudo sed -i "s/^Port [0-9]*/Port $port_server_number_ok/" /etc/ssh/sshd_config
                #Можно сделать как выше, так тоже будет работать
                sudo sed -i "/^#Port [0-9]*/c\Port $port_server_number_ok" /etc/ssh/sshd_config

                echo "Порт изменен на $port_server_number_ok"
                while true; do
                    read -p "Сохранить данный порт?: (да/нет)" answer_port_1
                    shopt -s nocasematch




                        #Другой вариант реализации:
                        #if [[ $answer_port_1 =~ ^(да|yes|нуа|lf)$ ]]; then
                            #echo "Порт не изменится: $port_server_number_ok"
                            #shopt -u nocasematch
                            #break 2 # Выходим из обоих циклов
                        #elif [[ $answer_port_1 =~ ^(нет|no|тщ|ytn)$ ]]; then
                            #read -p "Напишите, какой порт хотите использовать: " answer_port_2
                            #if ! [[ $answer_port_2 =~ ^[0-9]+$ ]] || (( $answer_port_2 < 1 || $answer_port_2 > 65535 )); then
                                #echo "Недопустимый порт. Попробуйте еще раз."
                                #continue
                            #fi

                            #sudo sed -i "/^Port [0-9]*/c\Port $answer_port_2" /etc/ssh/sshd_config
                            #echo "Вы выбрали порт: $answer_port_2"
                            #shopt -u nocasematch
                            #break 2 # Выходим из обоих циклов
                        #else
                            #echo "Недопустимый выбор. Повторите еще раз."
                        #fi
                    #done
                    #;;




                    case $answer_port_1 in
                        да|yes|нуа|lf)
                            echo "Порт не изменится - $port_server_number_ok"
                            shopt -u nocasematch
                            return
                            ;;
                        нет|no|тщ|ytn)
                            read -p "Напишите какой порт хочешь использовать: " answer_port_2
                            if ! [[ $answer_port_2 =~ ^[0-9]+$ ]] || (( $port_server_number_ok < 1 || $port_server_number_ok > 65535 )); then
                                echo "Недопустимый порт. Попробуйте еще раз."
                                continue
                            fi
                            sudo sed -i "/^Port [0-9]*/c\Port $answer_port_2" /etc/ssh/sshd_config
                            echo "Вы выбрали порт: $answer_port_2"
                            shopt -u nocasematch
                            return
                            ;;
                        *)
                            echo "Повтори еще раз"
                            ;;

                    esac
                    shopt -u nocasematch
                done
                ;;
            *)
                echo "Недопустимый выбор. Повтори еще раз"
                ;;
        esac
        echo "Вы выбрали порт: $port_server_number_ok"
    done
}

Edit_SSH_Config_Port



#forward=$(sudo sed -i '/^#LoginGraceTime /c\LoginGraceTime ' /etc/ssh/sshd_config)
#forward=$(sudo sed -i '/^#PermitRootLogin prohibit-password /c\PermitRootLogin prohibit-password ' /etc/ssh/sshd_config)
#forward=$(sudo sed -i '/^#MaxAuthTries /c\MaxAuthTries ' /etc/ssh/sshd_config)
#forward=$(sudo sed -i '/^#MaxSessions /c\MaxSessions ' /etc/ssh/sshd_config)
#forward=$(sudo sed -i '/^#PubkeyAuthentication /c\PubkeyAuthentication ' /etc/ssh/sshd_config)
#forward=$(sudo sed -i '/^#PasswordAuthentication /c\PasswordAuthentication ' /etc/ssh/sshd_config)
#forward=$(sudo sed -i '/^#PermitEmptyPasswords /c\PermitEmptyPasswords ' /etc/ssh/sshd_config)
#echo "AllowUsers " > /etc/ssh/sshd_config



