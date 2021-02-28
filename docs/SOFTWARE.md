### Installing ROSRider Software

>Notice: You have to finish [Getting Started](START.md) before following instructions on this document.

Open A Terminal Window, and execute the following commands:

    cd catkin_ws/src
    git clone https://gitlab.com/ROSRider/rosrider_description.git
    git clone https://gitlab.com/ROSRider/rosrider_diff_drive.git
    git clone https://gitlab.com/ROSRider/rosrider_teleop.git
    git clone https://gitlab.com/ROSRider/rosrider_examples.git
    git clone https://bitbucket.org/AndyZe/pid.git
    cd ..
    catkin_make
    source devel/setup.bash

The explanation of the packages are as follows:

`rosrider_description` contains urdf files, rviz profiles, and gazebo launch files.

`rosrider_diff_drive` contains the differential drive controller, and odometry node, and the simple goal controller.

`rosrider_teleop` contains configuration files to use the robot with a gamepad. (Logitech F710)

`rosrider_examples` contains example programs, that use odometry, and camera. For more information click [here](EXAMPLES.md)

`pid` external pid controller, required by rosrider\_diff\_drive

To continue, click [PARAMETERS](PARAMS.md)

### Installing IMAGE Package

>Notice: This part is optional.

The example given is for RaspberryPI. You need your RaspberryPI configured for the camera, and the userland libraries need to be installed and in working condition.

`rosrider_image` package contains the necessary configuration files for image capturing, and rectification.

To get your camera working, execute the following commands.

```console
cd ~/catkin_ws/src  
git clone https://gitlab.com/ROSRider/rosrider_image.git  
git clone https://github.com/UbiquityRobotics/raspicam_node.git
cd ..
catkin_make
source devel/setup.bash
```

`image_proc.launch` launches image processing node, that rectifies the images.

`cam.launch` launches `raspicam_node` and `image_proc_node`, enabling the camera and rectification. For rectification to work camera must be [calibrated](CALIBRATION.md).

After the commands above have completed successfully, lets see how it works.

```console
roscd rosrider/launch
roslaunch robot_cam.launch
```


### Installing Gazebo Related Software

>*This part is optional.*

You can use Gazebo to run ROSRider on your computer. Provided that you have installed gazebo and the dependencies successfully as outlined in [prerequisites](PRE.md#gazebo)

To install the `rosrider_gazebo` package, which contains the worlds and the launch files for simulations:

```console
cd ~/catkin_ws/src
git clone https://gitlab.com/ROSRider/rosrider_gazebo
```

How to use the Gazebo simulations are explained in the [gazebo](GAZEBO.md) section in detail.

### Installing FXIMU

>*This part is optional.*

Both FXIMU and ROSRider are USB serial devices. We want each device to get the same name each time the robot reboots, so the software can work reliably.

First, obtain the usb serial id of your FXIMU by executing the following command:

```
udevadm info -a -n /dev/ttyACM0 | grep '{serial}'
```

It will return:

```
ATTRS{serial}=="0000000A"
ATTRS{serial}=="0000:00:14.0"
```

In this case, the usb serial id is `0000000A`, which is a string.

Create a new rules file by:

```console
sudo nano /etc/udev/rules.d/99-usb-serial.rules
```

Add the following inside the file, after replacing the FXIMU usb serial id:

```console
KERNEL=="ttyACM*", ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="0002", ATTRS{serial}=="0000000A", SYMLINK+="fximu"
```

If you also have the ROSRider board, after replacing the ROSRider board usb serial id:

```
KERNEL=="ttyACM*", ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="0002", ATTRS{serial}=="12345678", SYMLINK+="rosrider"
```


**Reboot System**

This will allow your system to assign symlinks from `/dev/ttyACM*` to `/dev/rosrider` and `/dev/fximu` Each time your system boots, the symlinks will point to the correct `/dev/ttyACM*`

You must modify the `robot.launch` and `fximu.launch` to open the symlinks instead of the hard coded `/dev/ttyACM0`, if you are using both ROSRider and FXIMU together.

There is no special install required for the `FXIMU`

The launch file loads fximu parameters from `rosrider/config/fximu_params_000.yaml`. To test if fximu is connecting:

```console
roscd rosrider/launch
roslaunch fximu.launch
```

After connection, you should see topics `/imu/data` which contains the filtered orientation, and acceleration values and `/imu/mag` which contain magnetometer data.



