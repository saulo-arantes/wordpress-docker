#!/bin/bash

clone() {
    echo "\n"
    echo "---------------- 🗂 Clonando repositório 🗂 ----------------"
    mkdir wp-app
    mkdir wp-data
    cd wp-app/

    echo -n "Url do repositório GIT"
    read gitRepoUrl

    git clone "$gitRepoUrl" ./
    git config core.filemode false
    cd ..
}

echo "\n"
echo "---------------- 🔨 Atualizando o sistema 🔨 ----------------"
sudo apt update
sudo apt dist-upgrade -y

echo "\n"
echo "---------------- 🧪 Instalando docker 🧪 ----------------"
sudo apt install apt-transport-https ca-certificates curl software-properties-common git
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
# sudo usermod -aG docker ${USER}

echo -n "O que deseja fazer? (N)ovo projeto Wordpress / (C)lonar projeto existente / (S)air? [N] "
read response

case "$response" in
    n|N|"")
        echo "---------------- 🗂 Criando projeto Wordpress 🗂 ----------------"
    ;;
    c|C)
        clone
    ;;
    s|S)
        echo "Saindo..."
        exit
    ;;
    *)
        echo "Opção inválida"
    ;;
esac

echo "\n"
echo "---------------- 📦 Criando containers 📦 ----------------"
docker-compose up -d

echo "\n"
echo "---------------- ❌ Alterando permissões ❌ ----------------"
sudo chmod 775 -R ./
sudo chown ${USER}:${USER} -R ./

echo "\n"
echo "---------------- 🌐 Abrindo o projeto no VSCode 🌐 ----------------"
cd wp-app/
code .

echo "\n"
echo "---------------- 🎉 Tudo pronto! 🎉 ----------------"
