FROM osrf/ros:melodic-desktop-full

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

COPY ros_ws/src /home/ros_ws/src
WORKDIR /home/ros_ws

# install ros dependencies

# First get the driver:
RUN apt-get update && rosdep install --from-paths src --ignore-src -r -y \
    && apt-get install -y scons tmux \
    && rm -rf /var/lib/apt/lists/*

# install Warehouse ROS Mongo Interface driver
RUN git clone -b 26compat https://github.com/mongodb/mongo-cxx-driver.git \
# Then compile using scons:
    && apt-get install scons  \
    && cd mongo-cxx-driver \
    && scons --prefix=/usr/local/ --full --use-system-boost --disable-warnings-as-errors \
    && rm -rf mongo-cxx-driver

# You should now be able to compile the packages using catkin

# fixes fatal error error: exploration_msgs/ExploreAction.h: No such file or directory
RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; cd /home/ros_ws; catkin_make --only-pkg-with-deps exploration_msgs && catkin_make -DCATKIN_WHITELIST_PACKAGES=""'

RUN echo "source /home/ros_ws/devel/setup.bash" >> ~/.bashrc
