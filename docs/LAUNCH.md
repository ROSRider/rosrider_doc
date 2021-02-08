`robot.launch` launches the ROSRider board, differential drive controller, goal controller, odometry node, and is the basic robot bringup file.

`robot_cam.launch` is robot.launch, but with camera. You have to have a camera attached to your robot and configured.

`robot_ekf.launch` is robot.launch, but with fximu, and robot localization package configured. You need an IMU for this to work. Current configuration is for FXIMU.

`robot_ekf_cam_launch` is robot_ekf.launch, but with camera configured.

### robot.launch

Execute the following commands:

    roscd rosrider/launch
    roslaunch/robot.launch

Will output:

```console
CAPTURE output here
```

List topics by typing the following command:

    rostopic list

```console
CAPTURE list of topics
```

List services by typing the following command:

    rosservice list

```console
CAPTURE list of services
```

### robot_cam.launch

### robot_ekf.launch

### remote.launch



