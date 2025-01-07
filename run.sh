#!/bin/bash

PROJECT_NAME="chlee"
REPO_NAME="nvim"
TAG="latest"

CONTAINER_NAME="hermai_edit"
ROS_VOLUME="ros-noetic"
DEVEL_VOLUME="hermai_devel"
SRC_PATH="/home/chlee/Projects/Iocrops/rdv_hermai"

IP_ADDR=localhost
HOSTNAME=$(hostname)
USER=$(id -un)
DISP=:9

LOCAL_INC='/usr/local/include'
LOCAL_LIB='/usr/local/lib'

ENVS="--env=QT_X11_NO_MITSHM=1
      --env=XAUTHORITY=/home/rdv/.Xauthority
      --env=DISPLAY=$DISP
      --env=LD_LIBRARY_PATH=$LOCAL_LIB:$LD_LIBRARY_PATH
      --env=ROS_IP=$IP_ADDR
      --env=ROS_HOSTNAME=$IP_ADDR
      --env=ROS_MASTER_URI=http://$IP_ADDR:11311
      --env=TZ=Asia/Seoul
      --device=/dev/dri:/dev/dri"

XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority
VOLUMES="--volume=$ROS_VOLUME:/opt/ros/noetic:rw
         --volume=$DEVEL_VOLUME:/home/rdv/catkin_ws/devel:ro
         --volume=$SRC_PATH:/home/rdv/catkin_ws/src:rw"


docker run \
    -it \
    $ENVS \
    $VOLUMES \
    --privileged \
    --net host \
    --ipc host \
    --workdir /home/rdv/catkin_ws/src \
    --name $CONTAINER_NAME \
    $PROJECT_NAME/$REPO_NAME:$TAG
