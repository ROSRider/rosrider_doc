### Installing the ROSRider Software

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

### Installing Gazebo Related Software

You can use Gazebo to run ROSRider on your computer. This part is optional.

### Installing IMAGE Package

This part is optional. TBD

### Installing FXIMU

This part is optional. TBD





