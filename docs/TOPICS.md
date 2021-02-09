Besides subscribers and publishers created natively by the ROSRider board, `robot.launch` brings up the following subscribers and publishers:

[TODO: a little more detail on what robot.launch launches]

### Subscribers

| Subscriber     | Node                      | Type |
| -------------- | ------------------------- |------------ |
|`/cmd_vel`      | `diff_drive_controller`   |`geometry_msgs/Twist`|
|`/left_wheel/setpoint`  | `pid_controller`  |`std_msgs/Float64`|
|`/right_wheel/setpoint` | `pid_controller`  |`std_msgs/Float64`|
|`/initialpose`          |`odom_publisher`   |`geometry_msgs/PoseWithCovarianceStamped`|
|`/diff_drive_go_to_goal/goal`|`diff_drive_go_to_goal`  |`rosrider_diff_drive/GoToPoseActionGoal`|
|`/diff_drive_go_to_goal/cancel`|`diff_drive_go_to_goal`|`actionlib_msgs/GoalID`|
|`/move_base_simple/goal`|`diff_drive_go_to_goal`  |`geometry_msgs/PoseStamped`|

**/cmd_vel**

`/cmd_vel` controls the robots movement. Sending a twist message to this subscriber causes the robot to move. A `Twist` message contains a linear speed in m/s and angular speed in rad/s. For The purposes of a differential drive robot, we only use `linear.x` to denote linear speed and `angular.z` to denote angular speed.

Type the following command: (HINT: Hit TAB to autocomplete, then edit x)

```console
rostopic pub /cmd_vel geometry_msgs/Twist "linear:
  x: 0.1
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.0" -r 20
```

Upon pressing enter the robot will move at 0.1m/s. Upon hitting `CTRL-C` the robot will stop.

**/left\_wheel/setpoint, /right\_wheel/setpoint**

`/left_wheel/setpoint` and `/right_wheel/setpoint` are listened by the `pid_controller`. Sending an RPM value to the setpoint will cause `pid_controller` to generate PWM for the motors, that will turn the wheel exactly by the given RPM, using data from encoders. To try it, execute the following command:

```console
rostopic pub /left_wheel/setpoint std_msgs/Float64 "data: 20.0" -r 20
```

The left wheel will turn at 20 RPM

**/initialpose**

The `odometry_publisher` calculates the position and orientiation of the robot, based on encoder data. But sometimes it needs to be reset, or set to an initial condition.

Publishing a `geometry_msgs/PoseWithCovarianceStamped` to `/initialpose` will reset the `odometry_publisher` to the given position `x`,`y`,`theta`. 

This usually happens when using the `2D Pose Estimate` button in `RVIZ`. 

Click on the `2D Pose Estimate` button on `RVIZ`, select a position and heading on the screen. The robots object in `RVIZ` will move to the given position with the `2D Pose Estimate` arrow.

>Notice: The robot will not actually move.

**/diff\_drive\_go\_to\_goal/goal**

`/diff_drive_go_to_goal/goal` is provided by the goal controller. If you were writing a python program that utilizes the goal controller, you would submit goal to this subscriber, then monitor `result`, `status`, and `distance_to_goal` listening the respective publisher. 

**/diff\_drive\_go\_to\_goal/cancel**

`/diff_drive_go_to_goal/goal`: Send the `Goal_ID` of the currently executing task to cancel.

**/move\_base\_simple/goal**

This is a simplified version. It accepts `geometry_msgs/PoseStamped` and makes the robot move to the given `Pose`

This usually happens when using the `2D Nav Goal` buttin in `RVIZ`.

Click on the `2D Nav Goal` button on `RVIZ`, select a position and heading on the screen. The robot will actually move to that point.



### Publishers


| Publisher                                | Node                      | Type            |
| ---------------------------------------- | ------------------------- |---------------- |
|`/joy`                                    |`teleop_twist_joy`         |`sensor_msgs/Joy`|
|`/odom`                                   |`odom_publisher`           |`nav_msgs/Odometry`|
|`/joint_states`                           |`joint_state_publisher`|`sensor_msgs/JointState`|
|`/wheel_states`                           |`odom_publisher`|`sensor_msgs/JointState`|
|`/diff_drive_go_to_goal/distance_to_goal` |`diff_drive_go_to_goal`|`std_msgs/Float32`|
|`/diff_drive_go_to_goal/result`           |`diff_drive_go_to_goal`|`rosrider_diff_drive/GoToPoseActionResult`|
|`/diff_drive_go_to_goal/status`           |`diff_drive_go_to_goal`|`actionlib_msgs/GoalStatusArray`|
|`/goal_achieved`                          |`diff_drive_go_to_goal`|`std_msgs/Bool`|

`/joy` contains joystick data. You can check by:

```console
rostopic echo /joy
```

Will output a stream containing joystick data:

```console
header: 
  seq: 139723
  stamp: 
    secs: 1612866788
    nsecs: 104403732
  frame_id: "/dev/input/js0"
axes: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
buttons: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

```

Move the sticks around to see axes change in stream.

**/odom**

**/joint_states**

**/wheel_states**

**/diff\_drive\_go\_to\_goal/distance_to_goal**

**/diff\_drive\_go\_to\_goal/result**

**/diff\_drive\_go\_to\_goal/status**

**/goal_achieved**

[TODO: rosnode list tip here]




