username="$USER"
user="$(id -u)"
home="${1:-$HOME}"

imageName=${2:-"feelpp/feelpp-toolboxes"}
containerName="feelpp-v104"
displayVar="$DISPLAY"

# List container name :
echo "*******************************************************"
echo "Following Docker containers are present on your system:"
echo "*******************************************************"
docker ps -a


# Create docker container for Feel++ operation
echo "*******************************************************"
echo ""
echo "Creating Docker Feel++ container ${containerName} for user ${username}:${user}"

docker run  -it -d --name ${containerName} --user=${user}:$(id -g)  -h "feelpp" \
       -e USER=${username} \
    -e QT_X11_NO_MITSHM=1                                   \
    -e DISPLAY=${displayVar}                                \
    -e QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb                \
    --workdir="${home}"                                     \
    --volume="${home}:${home}"                              \
    --volume="${home}/feel:/feel"                           \
    -v=/tmp/.X11-unix:/tmp/.X11-unix ${imageName}          \
     /usr/sbin/gosu /bin/bash

#--volume="/private/etc/shadow:/etc/shadow:ro"                   \


echo "Container ${containerName} was created."

echo "*******************************************************"
echo "Run the ./startFeelpp script to launch container"
echo "*******************************************************"
