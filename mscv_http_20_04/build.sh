docker stop mscv_http
docker image rm -f mscv_http:20.04
docker rm -f mscv_http &>/dev/null
docker build -t mscv_http:20.04 .
# Create a new container
docker run -td --privileged --net=host --ipc=host \
    --name="mscv_http" \
    --gpus=all \
    -e "DISPLAY=$DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e "XAUTHORITY=$XAUTH" \
    -e ROS_IP=127.0.0.1 \
    --cap-add=SYS_PTRACE \
    -v /etc/group:/etc/group:ro \
    -p 50001:50001 \
    mscv_http:20.04 \
    bash -it -c "cd ~/catkin_ws && roslaunch mscv_http_service run.launch"
