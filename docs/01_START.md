### Getting Started with the ROSRider Board

---

### Installing the ROSRider package

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

If no errors from *catkin_make*, and if the command above changes directory to *~/catkin_ws/src/rosrider* directory, the setup is completed successfully.

### Testing

Get the ROSRider Board Ready to connect

1. Insert coin battery
2. Connect LED Board with JST cable (optional)
3. Connect Battery with XT30 connector
4. Connect ROSRider board to a host computer with a USB connector

Upon connecting the battery, the red led on the board will go on, flickering but steady.

If the LED is flashing 1 sec, this means the battery is under or overvoltage, and the board is refusing to start. It will go to hibernate mode in 30 sec.  
The hard limits on the suplly voltage are 6.0V minimum and 14.4V maximum.


| LED blink Style   | indicates |
|-------------------|-----------|
| Steady flickering | Ready to connect |
| Flashing 1 sec    | Power failure, device will go to sleep mode in 30 sec |
| Flipping on-off   | Connected to ROS |

>Notice: if the devices goes in sleep mode, you have to press *WAKE* button.

Open A Terminal Window, and execute the following command:

    roscore

On Another Terminal Window, and execute the following commands:

    roscd rosrider/config
    rosparam load rosrider.yaml

These commands will load default parameters from [rosrider.yaml](03_PARAMS.md) file.

To connect to ROSRider board, execute the following command:

    rosrun rosserial_python serial_node.py _port:=/dev/ttyACM0 _baud:=230400

You will see an output similar to below upon successfull connect.

```console
[INFO] [1611423598.123713]: ROS Serial Python Node
[INFO] [1611423598.137211]: Connecting to /dev/ttyACM0 at 230400 baud
[INFO] [1611423600.246322]: Requesting topics...
[INFO] [1611423600.258677]: Note: publish buffer size is 512 bytes
[INFO] [1611423600.260958]: Setup service server on rosrider/sysctl [rosrider/SysCtrlService]
[INFO] [1611423600.267216]: Setup service server on rosrider/led_emitter [rosrider/LedService]
[INFO] [1611423600.276191]: Setup publisher on left_wheel/state [std_msgs/Float64]
[INFO] [1611423600.284655]: Setup publisher on right_wheel/state [std_msgs/Float64]
[INFO] [1611423600.292984]: Setup publisher on left_wheel/position [std_msgs/Int32]
[INFO] [1611423600.301249]: Setup publisher on right_wheel/position [std_msgs/Int32]
[INFO] [1611423600.310946]: Setup publisher on /rosrider/diagnostics [rosrider/Diagnostics]
[INFO] [1611423600.316371]: Note: subscribe buffer size is 512 bytes
[INFO] [1611423600.328566]: Setup subscriber on left_wheel/control_effort [std_msgs/Float64]
[INFO] [1611423600.341352]: Setup subscriber on right_wheel/control_effort [std_msgs/Float64]
[INFO] [1611423600.346675]: default_status: 0
[INFO] [1611423600.357331]: update_rate: 10
[INFO] [1611423600.377670]: encoder_ppr: 12
[INFO] [1611423600.399141]: gear_ratio: 380
[INFO] [1611423600.418785]: wheel_dia: 0.060
[INFO] [1611423600.439189]: base_width: 0.100
[INFO] [1611423600.460559]: main_amp_limit: 3.60
[INFO] [1611423600.480709]: mt_amp_limit: 1.20
[INFO] [1611423600.502383]: bat_volts_high: 14.4
[INFO] [1611423600.523017]: bat_volts_low: 6.0
[INFO] [1611423600.543203]: max_rpm: 90.0
[INFO] [1611423600.563336]: left_swap: false
[INFO] [1611423600.583929]: right_swap: false
[INFO] [1611423600.605330]: left_reverse: false
[INFO] [1611423600.625641]: right_reverse: false
[INFO] [1611423600.646198]: max_idle_seconds: 1800
[INFO] [1611423600.656378]: power_status: 0
[INFO] [1611423600.666385]: motor_status: 48
[INFO] [1611423600.677633]: system_status: 0
```

On Another Terminal Window, List ROS topics by executing the following command:

    rostopic list

It will list topics provided by ROSRider board. Topics are explained [here](05_TOPICS.md) in detail.

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

It will list services provided by ROSRider board, which are explained [here](07_SERVICES.md) in detail.

```console
/rosrider/sysctl
/rosrider/led_emitter
```

To proceed with the rest of the setup, click [here](02_SOFTWARE.md).