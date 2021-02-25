### Prerequisites

Assuming, gazebo 11 and the dependencies are [installed](https://rosrider.readthedocs.io/en/latest/PRE/#gazebo), install `rosrider_gazebo` package:

	cd ~/catkin_ws/src
	git clone https://gitlab.com/ROSRider/rosrider_gazebo

The `rosrider_gazebo` package contains different worlds, and their launch files. To launch a gazebo world, execute the following command:

	roscd rosrider_gazebo
	source setup.sh
	cd launch
	roslaunch duckie.launch

You will see the gazebo simulator open, with duckietown tiles, and the rosrider robot spawned, along with goal controller, and joystick node. We will break down a launch file, and see how it works later on in this document.

**Duckie World**

![gazebo_duckie](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/gazebo_duckie.png)

**Line World**

Line world is used for odometry experiments. `line.launch` launches a world with a 2m line, yellow on black, and the ROSRider robot spawned on the origin.

![gazebo_line](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/gazebo_line.png)


**Racetrack World**

For trying simple line following algoritms, use this world.

![gazebo_racetrack](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/gazebo_racetrack.png)


**Ground Calibration World**

Ground calibration should be done on the actual robot, but to see how `birds_eye_filter` works, you can use this world.

![gazebo_ground_cal](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/gazebo_ground_cal.png)

**Lens Calibration World**

Again, the lens calibration should be done on the actual robot, but you can use this world, to calibrate your simulated fisheye lens. There are 10 calibration patterns positioned at 4 sides of a square. While running the calibration  software, drive the robot around as if it is visiting an exhibition, as the calibration happens.

![gazebo_lens_cal](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/gazebo_lens_cal.png)

After obtaining the distortion matrix from the calibration program, you need to set the camera\_info. Use the `rosrider_image/scripts/set_camera_info_fisheye.sh`, after modifiying it with your distortion matrix.


### Running Examples

**move_tf**

**loop_tf**

**loop_goal**

**pace**

**visual_pace**

**line_follower**


### LaunchFile Breakdown

Lets break down a launch file and explain it:

```
  <arg name="x_pos" default="0.11"/>
  <arg name="y_pos" default="0.0"/>
  <arg name="z_pos" default="-0.0015"/>
  <arg name="yaw" default="1.570796"/>
```

These arguments you can specify which coordinates, and orientation the robot will be launched into simulation.

```
  <include file="$(find gazebo_ros)/launch/empty_world.launch">
    <arg name="world_name" value="$(find rosrider_gazebo)/worlds/duckie.world" />
    <arg name="paused" value="false"/>
    <arg name="use_sim_time" value="true"/>
    <arg name="gui" value="true"/>
    <arg name="headless" value="false"/>
    <arg name="debug" value="false"/>
  </include>  
```

This is where we launch the world. In this case it launches the duckie.world file. You can compose your own worlds with gazebo, and you specify it here. 

```
  <param name="robot_description" command="$(find xacro)/xacro $(find rosrider_description)/urdf/rosrider.urdf.xacro" />
  <node pkg="gazebo_ros" type="spawn_model" name="spawn_urdf" args="-urdf -model robot1 -x $(arg x_pos) -y $(arg y_pos) -z $(arg z_pos) -Y $(arg yaw) -param robot_description" />
```

This statement above spawns the robot from its urdf file into simulation. Notice arguments for positioning the robot on the simulation.

```
  <node pkg="joy" type="joy_node" name="joy_node">
      <param name="dev" value="$(arg joy_dev_robot1)" />
      <param name="deadzone" value="0.2" />
      <param name="autorepeat_rate" value="20" />
  </node>
```

This statement above launches the joystick node. This node will measure joystick data, and publish it on `/joy` topic. In case your robot does not respond to joystick commands, this is the first place to check.

```
  <node pkg="teleop_twist_joy" name="teleop_twist_joy" type="teleop_node">
      <rosparam command="load" file="$(arg config_filepath)" />
  </node>

```

This statement above launches `teleop_twist_joy`, which basically listens to joystick on `/joy` and publishes `/cmd_vel`

```
  <node name="diff_drive_go_to_goal" pkg="rosrider_diff_drive" type="diff_drive_go_to_goal" output="screen">
      <param name="~rate" value="20" />
      <param name="~kP" value="0.5" />
      <param name="~kA" value="1.0" />
      <param name="~kB" value="-0.8" />
      <param name="~max_linear_speed" value="0.25" />
      <param name="~min_linear_speed" value="0.1" />
      <param name="~max_angular_speed" value="3.14" />
      <param name="~min_angular_speed" value="1.57" />
      <param name="~linear_tolerance" value="0.1" />
      <param name="~angular_tolerance" value="0.1" />
      <param name="~forwardMovementOnly" value="false" />
      <param name="~odom_topic" value="$(arg goal_controller_odom_topic)" />
  </node>
```

The statement above launches the goal controller. When running the simulation, we dont need to launch the `rosrider_diff_drive` because gazebo has a `diff_drive` plugin. However the `goal_controller` is required for the simulations.


### Gazebo and RVIZ

make gazebo, and rviz run side by side 


### Utilities

Sometimes the gazebo simulator does not quit, or takes a long time to shutdown when using with ROS. Put the following bash script under your `~/bin`, and execute it to kill the server and the client, when required.

**degas.sh**

```
#!/bin/bash
server=`pidof gzserver`
client=`pidof gzclient`
if [[ $server ]]; then
  kill -9 $server
fi
if [[ $server ]]; then
  kill -9 $client
fi
```


### Troubleshooting

**Notice:** always source your `~/catkin_ws/src/rosrider_gazebo/setup.bash` before working with gazebo
