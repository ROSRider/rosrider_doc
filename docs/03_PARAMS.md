### rosrider.yaml

>Notice: You have to finish [Getting Started](01_START.md) and [Installing the ROSRider Software](02_SOFTWARE.md) before following instructions on this document.

Here is the ROSRider parameter file: [rosrider.yaml](https://gitlab.com/ROSRider/rosrider/-/blob/master/config/rosrider.yaml)

```console
rosrider/params: {
config_flags: 48,
update_rate: 10,
encoder_ppr: 12,
gear_ratio: 380,
wheel_dia: 0.06,
base_width: 0.1,
main_amp_limit: 3.6,
mt_amp_limit: 1.2,
bat_volts_high: 14.4,
bat_volts_low: 6.0,
max_rpm: 90.0,
left_deadzone: 64,
right_deadzone: 64,
max_idle_seconds: 1800,
/left_wheel/controller/Kp: 4.8,
/left_wheel/controller/Ki: 3.2,
/left_wheel/controller/Kd: 0.02,
/right_wheel/controller/Kp: 4.8,
/right_wheel/controller/Ki: 3.2,
/right_wheel/controller/Kd: 0.02
}

```

Compose the configuration file correctly, and ROSRider will provide a differential drive controller, odomety, goal controller, ekf based localization based on your parameters.
Instructions for setting / verifying / tuning all parameters given below.

### Parameter Table


| Parameter          | Description | Unit |
|--------------------|-------------|------|
| config_flags       | Set 48 for Default | uint8\_t |
| update_rate        | Acceptable values are 10, 20, 50 | Hz |
| encoder_ppr        | Pulse per revolution of the encoder used | Pulse per Revolution |
| gear_ratio         | Gear ratio of motor | |
| wheel_dia          | Wheel diameter | Meter |
| base_width         | Base width | Meter |
| main\_amp_limit    | Main current limit | Amp |
| mt\_amp_limit      | Motor current limit | Amp |
| bat\_volts_high    | Battery volts maximum limit | Volts |
| bat\_volts_low     | Battery volts minimum limit | Volts |
| left\_deadzone     | Deadzone compensation for left motor, set 0 to disable | uint8_t |
| right\_deadzone    | Deadzone compensation for right motor, set 0 to disable | uint8_t |
| max_rpm            | Max rpm of the motor/gear setup. Use 90% of motor max rpm | Rounds per Minute |
| max\_idle_seconds  | Max seconds without connection before hibernating, set 0 to disable | Seconds |

### config_flags

>Notice: If you are building your own robot, you may need to change config_flags according to your configuration. Otherwise, you can skip this section.

`config_flags` are applied when configuring hardware initially. It configures motor polarity, encoder direction, and encoder type.

Consult to [PROCEDURES](100_PROCEDURES.md) section, to verify that the `config_flags` are set correctly.

To reverse a motor direction, set the corresponding reverse bit. Given positive input, motor should roll robot forward.

To reverse an encoder direction, set the corresponding swap bit. Given positive input, encoder should read positive values.

Some low cost encoder motors have single phase encoder. If using such equipment, set the corresponding enc ab bit to false. Encoder QEI will work single phase, only reading A. Notice you will have to set the correct PPR for the single phase encoder.


| bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | 
| left enc ab | right enc ab | right enc swap | left enc swap | right motor reversed | left motor reversed |


### default_status 

If `default_status = 0`, ROSRider board will request parameters over rosserial, and if one or more of the parameters fail to load, motor drivers will be disabled.

If `default_status = 1`, ROSRider board will load parameters from eeprom, and not request parameters from rosparam.

To Write Current Parameters to EEPROM, execute the following command:

    rosservice call /rosrider/sysctl "data: 81"

It will return `True` if succeeded.

To see recorded parameters, execute the following command:

    rosservice call /rosrider/sysctl "data: 82"

On the console it should print parameters and default status:

```console
[INFO] [1612796409.481000]: default_status: 1
[INFO] [1612796409.512673]: update_rate: 10
[INFO] [1612796409.576012]: encoder_ppr: 12
[INFO] [1612796409.628091]: gear_ratio: 380
[INFO] [1612796409.712123]: wheel_dia: 0.060
[INFO] [1612796409.764570]: base_width: 0.100
[INFO] [1612796409.846464]: main_amp_limit: 3.60
[INFO] [1612796409.914010]: mt_amp_limit: 1.20
[INFO] [1612796409.983063]: bat_volts_high: 14.4
[INFO] [1612796410.070903]: bat_volts_low: 6.0
[INFO] [1612796410.133378]: max_rpm: 90.0
[INFO] [1612796410.190756]: left_swap: false
[INFO] [1612796410.263288]: right_swap: false
[INFO] [1612796410.332181]: left_reverse: false
[INFO] [1612796410.375143]: right_reverse: false
[INFO] [1612796410.478587]: left_enc_ab: true
[INFO] [1612796410.561397]: right_enc_ab: true
[INFO] [1612796410.636514]: left_deadzone: 64
[INFO] [1612796410.719486]: right_deadzone: 64
[INFO] [1612796410.792127]: max_idle_seconds: 1800
[INFO] [1612796410.891169]: config_flags: 48
[INFO] [1612796410.999265]: power_status: 0
[INFO] [1612796411.108948]: motor_status: 240
[INFO] [1612796411.162348]: system_status: 0
```