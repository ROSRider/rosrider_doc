ROSRider creates the following subscribers and publishers on the system:

### Subscribers

| Subscriber | Description | Data Type | Range |
| ---------- | ----------- |-----------|-------|
|`/left_wheel/control_effort`| Left Motor PWM Control| Float32 | 0-1023 |
|`/right_wheel/control_effort`| Right Motor PWM Control | Float32 | 0-1023|

>Notice: These subscriber have timeouts, generally twice the update period. For publishing to these subscribers, use `-r 20` option, to repetitively publish command at the subscriber. It is build this way, so if your program crashes, the robot stops.


**deadzone compensation**

[TODO: TBD]
[TODO: show formula]

**example pub**

[TODO: TBD]

>`rostopic info /topic_name` will return data type of topic, and publisher and subscriber info

### Publishers

| Publisher  | Description | Unit |
| ---------- | ----------- |------|
|`/left_wheel/state`| Velocity of Left Wheel|RPM|
|`/left_wheel/position`|Position of Left Wheel|Ticks|
|`/right_wheel/state`|Velocity of Right Wheel|RPM|
|`/right_wheel/position`|Position of Right Wheel|Ticks|
|`/rosrider/diagnostics`|System Diagnostics Message|rosrider/diagnostics|

See [Diagnostics](DIAGS.md) for more information about system diagnostics message.

>`rostopic hz /topic_name` will measure the frequency of which the topic is published

**example echo state**  
[TODO: TBD]  

**example echo position**  
[TODO: TBD] 




