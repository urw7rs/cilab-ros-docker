# cilab-ros-docker
Repository for running cilab's ros_ws for the X1 on docker.

## steps for building & running container

Place ros_ws in the root of this repository. It will be copied to the image.

run `docker build -t cilab-ros .` to build the image

run `docker run --rm -it cilab-ros` to start container

## running container with display

run `xhost +local:docker` or `xhost +` to connect to display from container

### docker arguments for connecting to display from host

**ubuntu**

run `docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix cilab-ros` to start container with display support

**macos**

run `docker run -it --rm -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix cilab-ros` to start container with display support

**windows**

TODO

run `xhost -` if you ran `xhost +` before

add `-v my_package:/home/ros_ws/src/my_package` to bind mount my_package directory to develop packages

run `catkin_create_pkg my_package` at /home/ros_ws/src inside the container
