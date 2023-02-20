# UI permisions
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker

docker stop mscv_slam
docker image rm -f mscv_slam:20.04
docker rm -f mscv_slam &>/dev/null
docker build -t mscv_slam:20.04 .
# Create a new container
docker run -td --privileged --net=host --ipc=host \
    --name="mscv_slam" \
    --gpus=all \
    -e "DISPLAY=$DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e "XAUTHORITY=$XAUTH" \
    --cap-add=SYS_PTRACE \
    -v /etc/group:/etc/group:ro \
    mscv_slam:20.04 bash