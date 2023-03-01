docker stop mscv_http_ros
docker image rm -f mscv_http_ros:20.04
docker rm -f mscv_http_ros &>/dev/null
docker build -t mscv_http_ros:20.04 .
# Create a new container
docker run -td --privileged --net=host --ipc=host \
    --name="mscv_http_ros" \
    --gpus=all \
    -e ROS_IP=127.0.0.1 \
    --cap-add=SYS_PTRACE \
    -p 50001:50001 \
    mscv_http_ros:20.04 \
    bash -it -c "cd /root/catkin_ws && roslaunch mscv_http_service run.launch"
