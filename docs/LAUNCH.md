`robot.launch` launches the ROSRider board, differential drive controller, goal controller, odometry node, and is the basic robot bringup file.

`robot_cam.launch` is robot.launch, but with camera. You have to have a camera attached to your robot and configured.

`robot_ekf.launch` is robot.launch, but with fximu, and robot localization package configured. You need an IMU for this to work. Current configuration is for FXIMU.

`robot_ekf_cam_launch` is robot_ekf.launch, but with camera configured.

`remote.launch` launches rviz with everything configured for ROSRider.

### robot.launch

Execute the following commands:

    roscd rosrider/launch
    roslaunch/robot.launch

To see output, click [here](robot_launch.txt)

In another window, list topics by typing `rostopic list`, you should see:

```console
/cmd_vel
/diff_drive_go_to_goal/cancel
/diff_drive_go_to_goal/distance_to_goal
/diff_drive_go_to_goal/feedback
/diff_drive_go_to_goal/goal
/diff_drive_go_to_goal/result
/diff_drive_go_to_goal/status
/goal_achieved
/initialpose
/joint_states
/joy
/left_wheel/control_effort
/left_wheel/pid_debug
/left_wheel/pid_enable
/left_wheel/position
/left_wheel/setpoint
/left_wheel/state
/move_base_simple/goal
/odom
/right_wheel/control_effort
/right_wheel/pid_debug
/right_wheel/pid_enable
/right_wheel/position
/right_wheel/setpoint
/right_wheel/state
/rosrider/diagnostics
/tf
/tf_static
/wheel_states
```

List services by typing the following command:

    rosservice list

You should see the list of services, which includes the services below:

```console
/rosrider/led_emitter
/rosrider/sysctl
```

### robot_cam.launch

>Notice: In order to launch the `robot_cam.launch` you need a camera attached and configured to your robot.

Execute the following commands:

    roscd rosrider/launch
    roslaunch/robot_cam.launch

To see output, click [here](robot_cam_launch.txt)

In another window, list topics by typing `rostopic list`, you should see:

### robot_ekf.launch

>Notice: In order to launch the `robot_ekf.launch` you need imu sensor attached and configured to your robot.

Execute the following commands:

    roscd rosrider/launch
    roslaunch/robot_ekf.launch

To see output, click [here](robot_ekf_launch.txt)

In another window, list topics by typing `rostopic list`, you should see:

### remote.launch

This file launches `rviz` with a configuration file for ROSRider. This is usually done in a remote computer, connected to `roscore` running at your robot. To accomplish this first set `ROS_MASTER_URI` and `ROS_HOST` environment variables.

On your laptop type:

```
export ROS_MASTER_URI=http://robot.local:11311
export ROS_HOSTNAME=laptop.local
```

`robot` is the hostname of the robot, and `laptop` is the hostname of the client that you are connecting from. Both robot and client must be able to resolve and contact each other on the network.

Consult to [NETWORKING](NETWORK.md) for detailed explanation, testing and troubleshooting.

Once networking is in order, type the following commands:

```
roscd rosrider/launch
roslaunch/remote.launch
```

RVIZ program should pop up, showing a model of a ROSRider robot, along with the TF, etc

[TODO: screen cap]