Upon launching `robot.launch` a number of subscribers and publishers are created. Some of those are created natively by the ROSRider board, and some are created by other ROS software, such as the `rosrider_diff_drive` package.

ROSRider board creates the following subscribers and publishers on the system:

### Subscribers

| Subscriber | Description | Data Type | Range |
| ---------- | ----------- |-----------|-------|
|`/left_wheel/control_effort`| Left Motor PWM Control| Float32 | 0-1023 |
|`/right_wheel/control_effort`| Right Motor PWM Control | Float32 | 0-1023|

>Notice: These subscriber have timeouts, generally twice the update period. For publishing to these subscribers, use `-r 20` option, to repetitively publish command at the subscriber. It is build this way, so if your program crashes, the robot stops.

**Publishing data to subscriber using rostopic:**

Execute the following command:

```console
rostopic pub /left_wheel/control_effort std_msgs/Float64 "data: 200.0" -r 20
```

This command will turn the left wheel.


>Tip: Use TAB Key: After typing `rostopic pub /left_wheel/cont`, hit TAB, it will auto complete the topic part. Press space, hit TAB again, it will autocomplete the message type Press space, hit TAB again, it will autocomplete the data part. Do not forget to add the `-r 20` part.

**Deadzone Compensation:**

Each motor has a deadzone, when the applied PWM is below a certain limit, the motor will not turn. So, given a `PWM` value between 0 and 1023, `DEADZONE` value is added to `PWM`, after `PWM` is scaled down. Below is the formula used:

```
if(pwm > 0) { pwm = DEADZONE + (pwm * ((1023.0f - DEADZONE) / 1023.0f)); }
```

### Publishers

>Tip: `rostopic info /topic_name` will return data type of topic, and publisher and subscriber info


| Publisher  | Description | Unit |
| ---------- | ----------- |------|
|`/left_wheel/state`| Velocity of Left Wheel|RPM|
|`/left_wheel/position`|Position of Left Wheel|Ticks|
|`/right_wheel/state`|Velocity of Right Wheel|RPM|
|`/right_wheel/position`|Position of Right Wheel|Ticks|
|`/rosrider/diagnostics`|System Diagnostics Message|rosrider/diagnostics|

See [Diagnostics](DIAGS.md) for more information about system diagnostics message.

>Tip: `rostopic hz /topic_name` will measure the frequency of which the topic is published

**Echoing data using rostopic:** 

```console
rostopic echo /left_wheel/state
```

You will see a stream of data depicting RPM for the wheel such as:

```console
data: 0.0
---
data: 0.0
---
data: 0.0
---
data: 0.0
---
data: 0.0
---
data: 0.0
```

