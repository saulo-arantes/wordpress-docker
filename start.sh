#!/bin/bash

# Clonigng repository
clone() {
    mkdir wp-app
    mkdir wp-data
    cd wp-app/

    echo -n "GIT repository web url: "
    read gitRepoUrl

    git clone "$gitRepoUrl" ./
    git config core.filemode false
    cd ..
}

# Updating system
sudo apt update
sudo apt dist-upgrade -y

# Installing docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common git
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker ${USER}

echo -n "What to do next? (N)ew Wordpress project / (C)lone existing project / (Q)uit? [N] "
read response

case "$response" in
    n|N|"")
        echo ""
    ;;
    c|C)
        clone
    ;;
    q|Q)
        echo "Quitting..."
        exit
    ;;
    *)
        echo "Invalid option, quitting..."
        exit
    ;;
esac

# Creating containers
docker-compose up -d

# Changin project permissions
sudo chmod 775 -R ./
sudo chown ${USER}:${USER} -R ./

case "$response" in
    c|C)
        echo -n "Now, it's time to import your project's databse. Be sure that a \"dump.sql\" file exist on \"wp-data\" directory. Type \"ok\" to continue... "
        read importDatabaseResponse

        case "$importDatabaseResponse" in
            ok|Ok|oK|OK)
                file="./wp-data/dump.sql"
                if [ -f "$file" ]
                then
                    ./import.sh
                else
                    echo "The \"wp-data/dump.sql\" does not exists, skiping..."
                fi
            ;;
            *)
                echo "Invalid option, quitting..."
                exit
            ;;
        esac
    ;;
    *)
        echo "Invalid option, quitting..."
        exit
    ;;
esac

# Opening project
cd wp-app/
code .

exit
