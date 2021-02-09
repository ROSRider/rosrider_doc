### Prerequisites

**All the instructions are for Ubuntu 20.04**

You need to install ROS Noetic following instructions at
[http://wiki.ros.org/noetic/Installation/Ubuntu](http://wiki.ros.org/noetic/Installation/Ubuntu)

After ROS is installed successfully, execute the shell script at
[noetic_depend.sh](https://github.com/ROSRider/rosrider_doc/blob/main/scripts/noetic_depend.sh)

### Gazebo

If you you want to run ROSRider software in simulation, you need to install **Gazebo 11**

Follow instructions at [http://gazebosim.org/tutorials?tut=install_ubuntu](http://gazebosim.org/tutorials?tut=install_ubuntu) to install **Gazebo 11** on your system.

After Gazebo is installed successfully, execute shell script at
[noetic\_depend\_gazebo.sh](https://github.com/ROSRider/rosrider_doc/blob/main/scripts/noetic_depend_gazebo.sh)

### LXD

You can run all the ROS client software in your computer using LXD containers.

Here is a [gazebo-noetic.profile](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/scripts/gazebo-noetic.profile), that has **Gazebo 11** and **ROS Noetic** installed.

>Notice: The above profile uses macvlan, so you need to run it on a computer with **ethernet connection**. If you dont change ethernet connection, modify the profile to use lxdbr0 for networking

Provided your LXD is configured and working, and that you have **Ethernet Connection** and that uid is 1000, you can execute the following commands:

```console
wget https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/scripts/gazebo-noetic.profile
lxc create profile gazebo-noetic
cat gazebo-noetic.profile | lxc edit profile gazebo-noetic
lxc launch ubuntu:20.04 --profile gazebo-noetic rosrider
```

After executing these commands, wait until the setup is complete. You can connect to rosrider container, and monitor the `/var/log/cloud-init-output.log` and `/var/log/tail -f cloud-init.log`

You will see a SUCCESS statement at the end of `/var/log/cloud-init.log`

```console
2021-02-09 16:07:50,088 - handlers.py[DEBUG]: finish: modules-final: SUCCESS: running modules for final
```

**IMPORTANT:** After initializing a container with  [gazebo-noetic.profile](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/scripts/gazebo-noetic.profile), you still need to install dependencies [noetic_depend.sh](https://github.com/ROSRider/rosrider_doc/blob/main/scripts/noetic_depend.sh) and [noetic\_depend\_gazebo.sh](https://github.com/ROSRider/rosrider_doc/blob/main/scripts/noetic_depend_gazebo.sh)