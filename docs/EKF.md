### EKF

This section deals with configuring the ROS [robot_localization](http://wiki.ros.org/robot_localization) package.

In order to navigate a 2D space, the robot needs to know its location. While we get odometry data from the encoders, and that the encoder data is precise in the short term, it is not precise on the long term, because errors accumulate over time.

The IMU has the orientation, and linear and angular acceleration data.

By fusing the odometry with the imu data using extended kalman kiltering, we obtain a more robust odometry, published at `/odometry/filtered`

`robot_localization` is the ROS package, that contains a generalized form of EKF, that can be used for any number of sensors, and inputs.


In order for `robot_localization` to work:

1. **FXIMU** has to be operational, publishing at `/imu/data`
2. Input data must adhere to https://www.ros.org/reps/rep-0103.html
3. Covariances must be setup correctly

If you are using `ROSRider` with `FXIMU` the configuration files work by default.

To launch `EKF`:

```console
roscd rosrider/launch
roslaunch robot_ekf.launch
```

Upon successful launch, you should see the `/odometry/filtered` topic. Use `rostopic echo /odometry/filtered` to see if odometry messages are being published.

While running the goal controller with the EKF, the goal controller must listen to `/odometry/filtered` topic instead of `/odom`, which is the default configuration.

When you launch `robot_ekf.launch` it starts the goal controller node with the argument:

```console
<arg name="goal_controller_odom_topic" value="/odometry/filtered" />
````

So it should be listening on `/odometry/filtered`. To test execute:

```console
rostopic info /odometry/filtered
```

and see if goal controller has subscribed to it.

[TODO: CAPTURE rostopic info]

### configuration file

[TODO: explain switching to gazebo]

### Using RVIZ

To plot odometry messages use:

```console

```

### References

Most of these instructions were made possible by: [ros-sensor-fusion-tutorial](https://github.com/methylDragon/ros-sensor-fusion-tutorial/blob/master/01%20-%20ROS%20and%20Sensor%20Fusion%20Tutorial.md)
