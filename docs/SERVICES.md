### SysCtl Service

The ROSRider board provides a `/rosrider/sysctl` service. Using this service you can send commands, to set different configuration options for the motor drivers and system.

| CMD  | Description            | Notes   |
| ---- | ---------------------- |-------- |
| 0    | soft reset             | turns aux ctl off and resets the `power_status` to `0x00`, this is used to reset software fuses for main supply, and motors|
| 1    | request hard reset     | resets system after 1.6 seonds |
| 2    | encoder reset          | resets the encoder positions to 0 |
| 3    | request hibernate      | hibernates system after 1.6 seconds |
| 20   | left mode2 on          | turn left driver mode2 on |
| 21   | left mode2 off         | turn left driver mode2 off | 
| 22   | right mode2 on         | turn right driver mode2 on |
| 23   | right mode2 off        | turn right driver mode2 off |
| 24   | left mode1 on          | turn left driver mode1 on |
| 25   | left mode1 off         | turn left driver mode1 on |
| 26   | right mode1 on         | turn right driver mode1 on |
| 27   | right mode1 off        | turn right driver mode1 off |
| 30   | left phase forward     | left driver forward |
| 31   | left phase reverse     | left driver reverse |
| 32   | right phase forward    | right driver forward |
| 33   | right phase reverse    | right driver reverse |
| 40   | both mode1 on          | both drivers mode1 on (brakes on) |
| 41   | both mode1 off         | both drivers mode1 off (brakes off) |
| 42   | both mode2 on          | both drivers mode2 on |
| 43   | both mode2 off         | both drivers mode2 off |
| 44   | both forward           | both drivers forward |
| 45   | both reverse           | both drivers reverse |
| 50   | aux ctrl on            | aux ctrl output on (5.0V) |
| 51   | aux ctrl off           | aux ctrl output off |
| 80   | set default_status 0   | sets default status to 0, return to factory settings |
| 81   | write parameters to eeprom, set default_status 1 | device will not request parameters, but will load from eeprom|
| 82   | print system state     | default_status, parameters, config_flags, power_status, motor_status, system_status |


Commands between 20 and 45 are for testing only. The motor control bits should always be set by the `control_effort` subscriber. However, these commands could be useful in debugging the system.

>Remote resets, and hibernate commands could cause problems on the host, and might require rosserial to be restarted, depending on your configuration.

When `MODE1` is on for a driver, the driver shorts the motor terminals, that effects as a brake.

When `MODE2` is on for a driver, `when the pwm is at low cycle`, the driver shorts the motor terminals. This might seem more constrained, but could be useful when making a servo controller, in which precision is preferred over speed.

The ROSRider board has an `AUXCTRL` power port supplying 5.0V upto 500mA. The output is protected by a 500mA polyfuse and a transient voltage suppressor.Command `50` turns it on, command `51` turns it off.

`EEPROM` can be utilized with sysctl service. Command `81` writes current parameters into eeprom. Command `82` prints all the state on the console. Command `80` returns the `default_status = 0`, causing device to return initial settings.

You can call this service by invoking the following command:

    rosservice call /rosrider/sysctl "command: 82"

Command `82` will print  `default_status`, `config_flags`,`power_status`, `motor_status, and `system_status` and parameters.

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

For explanation of power_status, motor_status, system_status bits, look at [DIAGNOSTICS](DIAG.md)

For explanation of config bits, look at [PARAMETERS](PARAMS.md)

### Led Emitter Service

This service controls the external serial LEDS. Each LED can be programmed to blink or state steady at a given color, for a given frequency.

For the ROSRider board, we are using a LED board, that consists of APA106 8mm 3-color serial LEDS. The ROSRider board upon receiving the service call, generates
a timer interrupt that writes the led buffer according to their states to serial led bus. This method consumes less resources than individually addressing leds.

| LED Name | Description  |
| -------- | ------------ |
| fl       | Front Left   |
| top      | Front Middle |
| fr       | Front Right  |
| br       | Back Right   |
| bl       | Back Left    |

Each LEDs color is determined by a 4byte word.

| byte3 | byte2 | byte1 | byte0 |
| ----- | ----- | ----- | ----- |
| RED   | GREEN | BLUE  | MASK  |

MASK can either be 0 or 1. The LSB on byte0 determines whether that led will blink with the given frequency, or stay at a steady color.

To send a LED command, open a terminal and execute the following command: 

    rosservice call /rosrider/led_emitter { fr: 0xFF000000, top: 0x88888801, fr: 0xFF000000, br: 0x0, bl: 0x0, frequency: 2.0 }


And you should see the front right and left lamps are blinking at 2hz, and the middle lamp is steady white.

With this service you can set any led to any color, also have them blink at a given frequency or stay steady, ROSRider board uses timer interrupts to talk to the serial led drivers.
