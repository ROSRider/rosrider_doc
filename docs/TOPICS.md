When `robot.launch` is launched, the following happens:

- connect to ROSRider for topics provided natively by ROSRider
- launch `pid_controller`
- launch `diff_drive_controller`
- launch `diff_drive_go_to_goal`
- launch `odometry_publisher`
- launch `teleop_twist_joy`
- urdf model loaded


Besides topics provided natively by the ROSRider board, `robot.launch` brings up the following subscribers and publishers:

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

Move the sticks around to see axes change in stream. `joy` is published by `teleop_twist_joy` node.

**/odom**

`/odom` publishes `Odometry` messages which contains robots position, orientation, and measured linear, angular speeds as well as covariances.

Lets see an actual `Odometry` message

```console
rostopic echo /odom
```

You will see a strean of:

```console
header: 
  seq: 85438
  stamp: 
    secs: 1612868315
    nsecs: 616346359
  frame_id: "odom"
child_frame_id: "base_footprint"
pose: 
  pose: 
    position: 
      x: -0.1385688848064156
      y: 0.03605075816714569
      z: 0.0
    orientation: 
      x: -0.0
      y: 0.0
      z: 0.2938340462238658
      w: -0.9558564501428607
  covariance: [0.02, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.02, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1000000000000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1000000000000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1000000000000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.05]
twist: 
  twist: 
    linear: 
      x: 0.0
      y: 0.0
      z: 0.0
    angular: 
      x: 0.0
      y: 0.0
      z: 0.0
  covariance: [0.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1000000000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1000000000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1000000000.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.02]
```

`pose` part contains `position` and the `orientation` of the robot. In a planar robot, we only have `x`, `y` and `z` is always zero.

the type of `orientation` is a `quarternion` which denote the yaw or theta of the robot for our application.

`twist` contains a `twist` object, just like we send to `/cmd_vel` to make the robot move. But this time, in the odometry message, it is the measured linear and angular speed from encoders. 

If you were to send a linear speed of 0.1m/s to the `/cmd_vel`, the `diff_drive_controller` would try to match the rpms for the required linear speed, `odometry_publisher` would publish the actual measured speed in its `Twist`. You would observe the measured speed.

For other ROS packages such as `robot-localization` to work, your measured linear and angular speeds must be matching with real measured units in `m/s` and `rad/s`, and your `covariances` must be calculated correctly. The above covariances work with the ROSRider system.

**/joint\_states, /wheel\_states**

These to topics depict wheel position in PI, generally used for visualization with `RVIZ`

Execute the following command:

```console
rostopic echo /wheel_states
```

And you will see:

```console
header: 
  seq: 92460
  stamp: 
    secs: 1612869020
    nsecs: 916299104
  frame_id: ''
name: 
  - wheel_left_joint
  - wheel_right_joint
position: [5.5708153940629535, 4.925962165168206]
velocity: []
effort: []
```

As seen, it contains the positions of each axes, in normalized PI

`/wheel_states` is published by `odometry_controller` and `/joint_states` is republished by `joint_state_publisher`

**/diff\_drive\_go\_to\_goal/distance\_to\_goal**

While the `diff_drive_go_to_goal` is executing a goal, it will publish distance to goal in meters, in this topic. It is useful for debugging, also developing your own programs.

**/diff\_drive\_go\_to\_goal/result**

After the `diff_drive_go_to_goal` is executes a goal, it will publish result in this topic. 

**/diff\_drive\_go\_to\_goal/status**

While the `diff_drive_go_to_goal` is executing a goal, it will publish status here.

**/goal_achieved**

This is the simpler version to use with `/move_base_simple/goal`

Returns `True` once the goal is executed.

**Example Python Code**

```console
# send goal, and wait
self.action_client.send_goal(self.action_goal)

wait = self.action_client.wait_for_result()

if not wait:
    rospy.signal_shutdown('action server not available!')

if self.action_client.get_result().success:
    self.recovery_mode = False
```

The above code is an excerpt from `visual_pace.py` illustrating submitting goals to controller, and waiting for execution.

>TIP: use `rosnode list` to list nodes running, and `rosnode info /controller` to get information about a node.




