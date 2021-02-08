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

``rosrider_examples` contains example programs, that use odometry.

- move_tf : moves the robot to point x, y
- loop_tf : loops the robot following a trajectory
- pace.py : pace robot between two points

`pid` external pid controller, required by rosrider\_diff\_drive

To continue, click [PARAMETERS](PARAMS.md)

### Installing Gazebo Related Software

You can use Gazebo to run ROSRider on your computer. 

### Installing IMAGE Package

### Installing FXIMU


### TODO: examples, should be on different package, linked rosrider_description, can have its own readme





