username="$USER"
user="$(id -u)"
home="${1:-$HOME}"
version="${2:-105}"

imageName=${2:-"feelpp/feelpp-toolboxes"}
containerName="feelpp-v$version"
displayVar="$DISPLAY"
FEELPP_GITHUB_TOKEN="$FEELPP_GITHUB_TOKEN" 

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
    --volume="/etc/group:/etc/group:ro"                     \
    --volume="/etc/passwd:/etc/passwd:ro"                   \
    --volume="/etc/shadow:/etc/shadow:ro"                   \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro"             \
    -v=/tmp/.X11-unix:/tmp/.X11-unix ${imageName}          \
    /bin/bash --rcfile /usr/local/etc/bashrc.feelpp


#--volume="/private/etc/shadow:/etc/shadow:ro"                   \


echo "Container ${containerName} was created."

echo "*******************************************************"
echo "Run the ./startFeelpp script to launch container"
echo "*******************************************************"
