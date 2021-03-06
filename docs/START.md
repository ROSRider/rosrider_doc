### Prerequisites

**All the instructions are for Ubuntu 20.04**

You need to install ROS Noetic following instructions at
[http://wiki.ros.org/noetic/Installation/Ubuntu](http://wiki.ros.org/noetic/Installation/Ubuntu)

After ROS is installed successfully, execute the shell script at
[noetic_depend.sh](https://github.com/ROSRider/rosrider_doc/blob/main/scripts/noetic_depend.sh)

### Gazebo

>Notice: You can skip this part, if you will not be using Gazebo

If you you want to run ROSRider software in simulation, you need to install **Gazebo 11**

Follow instructions at [http://gazebosim.org/tutorials?tut=install_ubuntu](http://gazebosim.org/tutorials?tut=install_ubuntu) to install **Gazebo 11** on your system.

After Gazebo is installed successfully, execute shell script at
[noetic\_depend\_gazebo.sh](https://github.com/ROSRider/rosrider_doc/blob/main/scripts/noetic_depend_gazebo.sh)

### LXD

>Notice: This part is not required unless you want to run ROS in a container.

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


### Install ROSRider Package

>Make sure you have successfully installed ROS Noetic, and the required dependencies before executing the instructions below.

Open A Terminal Window, and execute the following commands:

    mkdir -p catkin_ws/src
    cd catkin_ws/src
    git clone https://gitlab.com/ROSRider/rosrider.git
    cd ..
    catkin_make rosrider_generate_messages
    source devel/setup.bash
    catkin_make

You have to have ROSRider message types in your path, otherwise you will get errors while connecting. Add this at the bottom of your ~/.bashrc file:

    source ~/catkin_ws/devel/setup.bash

And then execute the following command:

    source ~/.bashrc

To test that everything is setup correctly, execute:

    roscd rosrider

If the above command changes directory to `~/catkin_ws/src/rosrider` and if you received no errors in the previous `catkin_make` command, the ROSRider package is setup correctly.  


### Testing

Get the ROSRider Board Ready to connect

1. Insert coin battery
2. Connect LED Board with JST cable (optional)
3. Connect Battery with XT30 connector
4. Connect ROSRider board to a host computer with a USB connector

Upon connecting the battery, the red led on the board will go on, flickering but steady.

If the LED is flashing 1 sec, this means the battery is under or overvoltage, and the board is refusing to start. It will go to hibernate mode in 30 sec.

The hard limits on the suply voltage at startup are 6.0V minimum and 14.4V maximum. These values can not be overridden.


| LED blink Style   | indicates |
|-------------------|-----------|
| Steady flickering | Ready to connect |
| Flashing 1 sec    | Power failure, device will go to sleep mode in 30 sec |
| Flipping on-off   | Connected to ROS |

>Notice: if the devices goes in sleep mode, you have to press `WAKE` button.

Open A Terminal Window, and execute the following command:

    roscore

On Another Terminal Window, and execute the following commands:

    roscd rosrider/config
    rosparam load rosrider.yaml

These commands will load default parameters from [rosrider.yaml](PARAMS.md) file.

To connect to ROSRider board, execute the following command:

    rosrun rosserial_python serial_node.py _port:=/dev/ttyACM0 _baud:=230400

You will see an output similar to below upon successfull connect.

```console
[INFO] [1612790844.703436]: ROS Serial Python Node
[INFO] [1612790844.717859]: Connecting to /dev/ttyACM0 at 230400 baud
[INFO] [1612790846.829189]: Requesting topics...
[INFO] [1612790846.833376]: Note: publish buffer size is 512 bytes
[INFO] [1612790846.836264]: Setup service server on rosrider/sysctl [rosrider/SysCtrlService]
[INFO] [1612790846.839602]: Setup service server on rosrider/led_emitter [rosrider/LedService]
[INFO] [1612790846.843117]: Setup publisher on left_wheel/state [std_msgs/Float64]
[INFO] [1612790846.846694]: Setup publisher on right_wheel/state [std_msgs/Float64]
[INFO] [1612790846.849855]: Setup publisher on left_wheel/position [std_msgs/Int32]
[INFO] [1612790846.852699]: Setup publisher on right_wheel/position [std_msgs/Int32]
[INFO] [1612790846.855704]: Setup publisher on /rosrider/diagnostics [rosrider/Diagnostics]
[INFO] [1612790846.857871]: Note: subscribe buffer size is 512 bytes
[INFO] [1612790846.862581]: Setup subscriber on left_wheel/control_effort [std_msgs/Float64]
[INFO] [1612790846.867138]: Setup subscriber on right_wheel/control_effort [std_msgs/Float64]
[INFO] [1612790846.869244]: default_status: 0
[INFO] [1612790847.162944]: update_rate: 10
[INFO] [1612790847.172187]: encoder_ppr: 12
[INFO] [1612790847.182271]: gear_ratio: 380
[INFO] [1612790847.192537]: wheel_dia: 0.060
[INFO] [1612790847.202517]: base_width: 0.100
[INFO] [1612790847.212537]: main_amp_limit: 3.60
[INFO] [1612790847.222696]: mt_amp_limit: 1.20
[INFO] [1612790847.233334]: bat_volts_high: 14.4
[INFO] [1612790847.243479]: bat_volts_low: 6.0
[INFO] [1612790847.253543]: max_rpm: 90.0
[INFO] [1612790847.263967]: left_swap: false
[INFO] [1612790847.274171]: right_swap: false
[INFO] [1612790847.284146]: left_reverse: false
[INFO] [1612790847.294196]: right_reverse: false
[INFO] [1612790847.304335]: left_enc_ab: true
[INFO] [1612790847.314304]: right_enc_ab: true
[INFO] [1612790847.325102]: left_deadzone: 64
[INFO] [1612790847.334513]: right_deadzone: 64
[INFO] [1612790847.344739]: max_idle_seconds: 1800
[INFO] [1612790847.355036]: config_flags: 48
[INFO] [1612790847.365300]: power_status: 0
[INFO] [1612790847.374551]: motor_status: 48
[INFO] [1612790847.384761]: system_status: 0
```

On Another Terminal Window, List ROS topics by executing the following command:

    rostopic list

It will list of subscribers and publishers provided by ROSRider board.

```console
/left_wheel/control_effort
/left_wheel/position
/left_wheel/state
/right_wheel/control_effort
/right_wheel/position
/right_wheel/state
/rosrider/diagnostics
```

List ROS services by executing the following command:

    rosservice list

It will list services provided by ROSRider board, which are explained [here](SERVICES.md) in detail.

```console
/rosrider/sysctl
/rosrider/led_emitter
```


### Troubleshooting

If you see errors like below, your message types are not in path. 

```console
[ERROR] [1612790996.405765]: Creation of service server failed: rosrider
[ERROR] [1612790996.408441]: Creation of service server failed: rosrider
[ERROR] [1612790996.422431]: Creation of publisher failed: rosrider
[ERROR] [1612790996.425850]: Creation of service server failed: rosrider
[ERROR] [1612790998.128954]: Tried to publish before configured, topic id 131
```

Solution is:

	source ~/catkin_ws/devel/setup.bash

Put the above statement at the end of `~/.bashrc` file

If you see errors like below, you dont have access to the serial port, or device is in hibernate mode

```console
[INFO] [1612791320.206436]: ROS Serial Python Node
[INFO] [1612791320.219816]: Connecting to /dev/ttyACM0 at 230400 baud
[ERROR] [1612791320.223259]: Error opening serial: [Errno 2] could not open port /dev/ttyACM0: [Errno 2] No such file or directory: '/dev/ttyACM0'

```

Execute the following command:

	ls -al /dev/ttyACM*

It should return:

```console
crw-rw-rw- 1 root root 166, 0 Feb  8 13:41 /dev/ttyACM0
```

You have to make sure that your user has the correct privileges to access the serial port. Here above the serial port is set 666, so each user can access it.

The device could be in sleeping mode. Press wake button, if the led does not indicate startup, press reset. `/dev/ttyACM0` should appear.

If the led on the board is blinking, then going to hibernate, your battery voltages are low, and you need to recharge.





