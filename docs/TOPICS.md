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

[TODO: detailed explanations]

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

[TODO: detailed explanation for each]

[TODO: rosnode list tip here]




