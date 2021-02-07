## ROSRider Examples

>Notice: You have to finish [Installing the ROSRider Package](01_START.md) and [Installing the ROSRider System](02_SOFTWARE.md) before following instructions on this document.

>Notice: You have to have ```robot.launch``` file launched, before using any of these programs.

### move_tf.py

Moves robot to point x,y using odometry. Robot calculates trajectory to point x,y without using goal controller.

Arguments:
- x
- y
- speed
- kp
- angular_tolerance
- distance_tolerance

To run the program, with default speed, kp, and tolerances, execute the following commands:

    roscd rosrider_examples/nodes
    ./move_tf.py _x:=1.0 _y:=0.0

And the robot will go to point (1,0)

### loop_tf.pg

Reads a file, consisting of waypoints, and follows the trajectory of these waypoints in infinite loop.

Arguments
- speed
- kp
- file
- rate
- base_frame
- odom_frame
- angular_tolerance
- distance_tolerance

>*file* consists of a file that has x, y coordinates of points, terminated by new line.

Example File contains:

```console
0 0.5
-1 0.5
-1 -0.5
0 -0.5
0 0
```

To run the program, execute the following commands:

    roscd rosrider_examples/nodes
    ./loop_tf.py _file:=../data/e0.txt

Will make the robot follow an ellipse trajectory, as given by ```e0.txt``` file.

### pace.py

Paces the robots between two points, using goal controller. The goal controller has to be on for this program to work.

Determine if goal controller is running by executing the following commands:

    [TODO: find those commands]

Arguments
- ax
- ay
- bx
- by
- az
- aw
- bz
- bw

To run the program, using default parameters execute the following commands:

    roscd rosrider_examples/nodes
    ./pace.py

ax, ay indicate x,y of point a
az, aw indicate orientation of robot at point a
bx, by indicate x,y of point b
bz, bw indicate orientation of robot at point b

> With default parameters, the pace.py progrma will make the robot go between point (0,0) and point (2,0)

### How to Run these examples using Gazebo Simulation

- install dependencies
- install required packages, rosrider_gazebo
- environment setup
- execute a test environment with gazebo
  - check if goal controller, and other necessary nodes are running
- execute move.py in gazebo
- execute pace.py in gazebo
- make gazebo, and rviz run side by side [TODO: dont know how without having robot]


