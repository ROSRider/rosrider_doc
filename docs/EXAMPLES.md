>Notice: You have to finish [Getting Started](START.md) and [Installing the ROSRider Software](SOFTWARE.md) before following instructions on this document.

You have to have `robot.launch` file launched, before using any of these programs.

To run these examples in simulation, consult to [GAZEBO](GAZEBO.md)

### move_tf.py

Moves robot to point x,y using odometry. Robot calculates trajectory to point x,y without using goal controller. Arguments are:
 
> x  
> y  
> speed  
> kp  
> angular\_tolerance  
> distance\_tolerance


To run the program, with default `speed`, `kp`, and `tolerances`, execute the following commands:

    roscd rosrider_examples/nodes
    ./move_tf.py _x:=1.0 _y:=0.0

And the robot will go to point (1,0)

### loop_tf.py

Reads a file, consisting of waypoints, and follows the trajectory of these waypoints in infinite loop. Arguments are:

>speed  
>kp  
>file  
>rate  
>base_frame  
>odom_frame  
>angular_tolerance  
>distance_tolerance  

`file` consists of a file path that has x, y coordinates of points, terminated by new line. Example file:


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

Paces the robot between two points, using goal controller. The goal controller has to be on for this program to work, which usually happens when you launch `robot.launch`

Arguments are:

>ax  
>ay  
>bx  
>by  
>az  
>aw  
>bz  
>bw  

`ax`, `ay` denote `x,y` of `point a`  
`az`, `aw` denote orientation of robot at `point a`  
`bx`, `by` denote `x,y` of `point b`  
`bz`, `bw` denote orientation of robot at `point b`  

To run the program, using default parameters execute the following commands:

    roscd rosrider_examples/nodes
    ./pace.py

With default parameters, the pace.py progrma will make the robot go between `point(0,0)` and `point(2,0)`

This example uses `odometry` only. If you are using `EKF` please adjust goal controller to use `/odometry/filtered`instead of `/odom`

### loop_goal.py

[TODO]

### visual_pace.py

Follows a yellow line on background. When there is no more yellow line, the robot executes a 180 degree turn, using goal controller.

>Notice: In order to launch the `robot_cam.launch` you need a camera attached and configured to your robot.

[TODO: explanation launch node parametrize node]

To see a video of robot in operation, click the image below:

[![Visual Pace](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/visual_pace_mov.png)](https://www.youtube.com/watch?v=i8jRJzGPu2k "Visual Pace")

To see the ROS Console, while the robot is in operation, click the image below:

[![Visual Pace Console](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/visual_pace_console.png)](https://www.youtube.com/watch?v=MUS3nrNKr90 "Visual Pace Console")

Click [here](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/webm/visual_pace.webm) for screencast.

### line_follower.py

[TODO explain line_detector]