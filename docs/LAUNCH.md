`robot.launch` launches the ROSRider board, differential drive controller, goal controller, odometry node, and is the basic robot bringup file.

`robot_cam.launch` is robot.launch, but with camera. You have to have a camera attached to your robot and configured.

`robot_ekf.launch` is robot.launch, but with fximu, and robot localization package configured. You need an IMU for this to work. Current configuration is for FXIMU.

`robot_ekf_cam_launch` is robot_ekf.launch, but with camera configured.

### robot.launch

Execute the following commands:

    roscd rosrider/launch
    roslaunch/robot.launch

To see output, click [here](robot_launch.txt)

In another window, list topics by typing the following command:

    rostopic list

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

### robot_ekf.launch

### remote.launch



