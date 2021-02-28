config:
  # limits.memory: 16384MB
  environment.DISPLAY: :0
  nvidia.driver.capabilities: all
  nvidia.runtime: "true"
  raw.idmap: "both 1000 1000"
  user.user-data: |
    #cloud-config
    package_update: yes
    package_upgrade: yes
    packages:
      - net-tools
      - bridge-utils
      - x11-apps
      - mesa-utils
      - libnss-mdns
      - gnuplot-nox
      - ffmpeg
      - xvfb
    runcmd:
      - [sh, '-c', 'rm -rf /var/lib/apt/lists/*']
      # gazebo 11
      - [sh, '-c', 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable focal main" > /etc/apt/sources.list.d/gazebo-stable.list']
      - [sh, '-c', 'wget https://packages.osrfoundation.org/gazebo.key -O - | apt-key add -']
      - [sh, '-c', 'apt update -y']
      - [sh, '-c', 'apt install gazebo11 -y']
      - [sh, '-c', 'apt install libgazebo11-dev -y']
      # ros noetic
      - [sh, '-c', 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list']
      - [sh, '-c', 'apt-key adv --keyserver "hkp://keyserver.ubuntu.com:80" --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654']
      - [sh, '-c', 'apt update -y']
      - [sh, '-c', 'apt install ros-noetic-desktop -y']
      - [sh, '-c', 'apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y']
      - [sh, '-c', 'apt install python-is-python3 python3-osrf-pycommon python3-catkin-tools -y']
      - [rosdep, 'init']
      # setup
      - [sh, '-c', 'echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc']
      - [sh, '-c', 'sudo -u ubuntu echo "source /opt/ros/noetic/setup.bash" >> /home/ubuntu/.bashrc']
      - [sh, '-c', 'sudo -u ubuntu rosdep update']
description: gazebo-noetic
devices:
  X0:
    bind: container
    connect: unix:@/tmp/.X11-unix/X1
    listen: unix:@/tmp/.X11-unix/X0
    security.gid: "1000"
    security.uid: "1000"
    type: proxy
  mygpu:
    type: gpu
  eth0:
    name: eth0
    network: lxdbr0
    type: nic
  eth1:
    nictype: macvlan
    parent: enp63s0
    type: nic
  root:
    path: /
    pool: default
    type: disk
name: gazebo-noetic
used_by: []
