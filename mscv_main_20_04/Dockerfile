# This is an auto generated Dockerfile for ros:robot
# generated from docker_images/create_ros_image.Dockerfile.em
FROM ros:noetic-ros-base-focal

# install ros packages
RUN apt update && apt install -y --no-install-recommends \
    ros-noetic-desktop=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bash_profile
    
RUN apt update && apt install -y git \
    cmake \
    build-essential \
    python3-pip \
    nano

RUN pip3 install flask

RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash &&\
    mkdir -p ~/catkin_ws/src &&\
    cd ~/catkin_ws/src &&\
    git clone https://github.com/Leonana69/multisemantic_ros_server &&\
    cd ~/catkin_ws &&\
    catkin_make &&\
    source ~/catkin_ws/devel/setup.bash'

RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash &&\
    cd ~/catkin_ws/src &&\
    catkin_create_pkg mscv_service rospy &&\
    cd mscv_service &&\
    mkdir -p src/mscv_service &&\
    cd src/mscv_service &&\
    cp ~/catkin_ws/src/multisemantic_ros_server/examples/run.py ./run.py &&\
    chmod +x run.py &&\
    cd ~/catkin_ws &&\
    catkin_make'

CMD ["bash"]