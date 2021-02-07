### ROSRider launch scripts

```robot.launch``` launches the ROSRider board, differential drive controller, goal controller, odometry node, and is the basic robot bringup file.

```robot_cam.launch``` is robot.launch, but with camera.

```robot_ekf.launch``` is robot.launch, but with fximu, and robot localization package configured. You need an IMU for this to work. Current configuration is for FXIMU.

```robot_ekf_cam_launch``` is robot_ekf.launch, but with camera configured.

For camera to work, complete instructions on [IMAGE](IMAGE.md) first.

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

---
### robot_cam.launch

### robot_ekf.launch

### robot_ekf_cam.launch

### Other Topics and Services

[TODO: list and explain any other topics and services provided by the system]

[TODO: Odometry explained, using RVIZ, make a chapter on that]

[TODO: delete 05_TOPICS and explain it here]

[TODO: make services single file]