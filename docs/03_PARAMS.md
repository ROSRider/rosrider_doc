### Parameters Explained

TODO: section on config flags

TODO: explanation about single phase encoders, and config, and mention you have to * 2 everything, or reduce ppr by half.

>Notice: You have to finish [Getting Started with the ROSRider Board](01_START.md) and [Installing the ROSRider Software](02_SOFTWARE.md) before following instructions on this document.

Here is the ROSRider parameter file [rosrider.yaml](../config/rosrider.yaml)

```console
rosrider/params: {
config_flags: 48,
update_rate: 10,
encoder_ppr: 12,
gear_ratio: 380,
wheel_dia: 0.06,
base_width: 0.1,
main_amp_limit: 3.6,
mt_amp_limit: 1.2,
bat_volts_high: 14.4,
bat_volts_low: 6.0,
max_rpm: 90.0,
left_deadzone: 64,
right_deadzone: 64,
max_idle_seconds: 1800,
/left_wheel/controller/Kp: 4.8,
/left_wheel/controller/Ki: 3.2,
/left_wheel/controller/Kd: 0.02,
/right_wheel/controller/Kp: 4.8,
/right_wheel/controller/Ki: 3.2,
/right_wheel/controller/Kd: 0.02
}
```

### Parameter Description Table

Compose the configuration file correctly, and ROSRider will provide a differential drive controller, odomety, goal controller, ekf based localization based on your parameters.
Instructions for setting / verifying / tuning all parameters given below.

| Parameter         | Description | Unit |
|-------------------|-------------|------|
| update_rate       | Acceptable values are 10, 20, 50 | Hz |
| encoder_ppr       | Pulse per revolution of the encoder used | Pulse Per Revolution |
| gear_ratio        | Gear ratio of motor | |
| wheel_dia         | Wheel diameter | Meter |
| base_width        | Base width | Meter |
| main_amp_limit    | Main current limit | Amp |
| mt_amp_limit      | Motor current limit | Amp |
| max_rpm           | Max rpm of the motor/gear setup. Use 90% of motor max rpm | Rounds per minute |
| left_swap         | Left encoder swap |  True if swapped |
| right_swap        | Right encoder swap | True if swapped |
| left_reverse      | Left motor reverse | True if reversed |
| right_reverse     | Right motor reverse | True if reversed |
| max_idle_seconds  | Maximum seconds without connection before unit goes to sleep 0 to disable | Sec |
| /left_wheel/controller/Kp     | 4.8 |  
| /left_wheel/controller/Ki     | 3.2  |
| /left_wheel/controller/Kd     | 0.02 | |
| /right_wheel/controller/Kp    | 4.8 | |
| /right_wheel/controller/Ki    | 3.2 | |
| /right_wheel/controller/Kd    | 0.02 | |

---

### How to Tune Parameters

After starting roscore on a Terminal, Open Another Terminal Window, and execute the following commands:

    roscd rosrider/config
    rosparam load rosrider.config
    rosrun rosserial_python serial_node.py _port:=/dev/ttyACM0 _baud:=230400

It should generate some output like:

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

>***Make sure your robot / setup is in a jack, i.e. the wheels do not touch the ground.***

### Verification of motor direction

Open a Terminal Window, and execute the following command:

    rostopic pub /left_wheel/control_effort ... -r 20

Publishing positive values to ```/left_wheel/control_effort```, should result in forward motion of the wheel. 
Publishing negative values to ```/left_wheel/control_effort```, should result in reverse motion of the wheel.

If not, change ```left_reverse``` to true, in parameter file, re-load rosparam file by typing ```rosparam load rosrider.yaml``` in the ```rosrider/config``` directory.

Repeat the same procedure for the right wheel.

---

### Verification of encoder direction

Open a Terminal Window, and execute the following command:

    rostopic echo /left_wheel/state

Should show an output such as:

```console
0.0
0.0
0.0
0.0
```

On Another Window, execute the following command:

    rostopic pub /left_wheel/control_effort ... -r 20

Publishing positive values to ```/left_wheel/control_effort```, should result in positive values displayed on the console.
Publishing negative values to ```/left_wheel/control_effort```, should result in negative values displayed on the console.

If not, change ```left_swap``` to true, in parameter file, re-load rosparam file by typing ```rosparam load rosrider.yaml``` in the ```rosrider/config``` directory.

Repeat the same procedure for the right wheel.

---
### Verification of Gear Ratio and Encoder PPR

First setup the wheel with an external optical RPM meter.

Then publish positive values to ```/left_wheel/control_effort``` while plotting rpm values on ```/left_wheel/state``` with rqt_plot.

    rostopic pub /left_wheel/control_effort ... -r 20

From another command window:

    rqt_plot /left_wheel/state

The values read from ```/left_wheel/state``` should match the output of optical RPM meter.

If not change ```gear_ratio``` and ```encoder_ppr``` in parameter file, re-load rosparam file by typing ```rosparam load rosrider.yaml``` in the ```rosrider/config``` directory.

Repeat the procedure until you get it right. Sometimes the documentation for an encoder motor ordered from the internet might not be exact. First determine the ```encoder_ppr``` and then determine ```gear_ratio```

---
### Wheel Diameter Verification

To continue further, close the ```rosserial_python``` and the ```roscore``` by pressing CTRL-C on the console.

Open A Terminal Window, and execute the following commands:

    roscd rosrider/launch
    roslaunch robot.launch

It will launch the serial node, pid, differential drive controller, odometry node, and teleoperation.  
It should generate some output like:

```console
Capture output and put as a file
```

If given a goal that is (wheel_dia * N) away from 0, wheel should turn N time, and robot should move wheel_dia * N meters.

First Set RVIZ

---
### Base Width Verification

Given an angular twist command, turn speed of the robots in Radians / Second should match.

---
### RVIZ Test of goal controller

Robot must go to goal point 1 meter or 2 meter away

---
### Motor Current Limit Determination

Put it on rqt view and show some examples

---
### Main Current Limit Determination

Put it on rqt view, and test stalls.

---

### pid calibration with dynamic reconfigure tutotial, explain pid params dont have to do with board

---

### default_status explained

If ```default_status = 0```, ROSRider board will request parameters over rosserial, and if one or more of the parameters fail to load, motor drivers will be disabled

If ```default_status = 1```, ROSRider board will load parameters from eeprom, and not request paramters from rosserial.

To Write Current Parameters to eeeprom, execute the following command:

    rosservice call /rosrider/sysctl "data: 81"

It will return ```True``` if succeeded.

To see recorded parameters, execute the following command:

    rosservice call /rosrider/sysctl "data: 82"

On the console it should print parameters and default status:

```console
CAPTURE OUTPUT
```