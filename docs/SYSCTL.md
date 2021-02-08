### SysCtl Service

The ROSRider board provides a ```/rosrider/sysctl``` service. 

You can call this service by invoking the following command:

    rosservice call /rosrider/sysctl "command: 82"

Command ```82``` will print all the default_status, parameters, power, motor, config, system status on the console.

# TODO REDO

```console
[INFO] [1611438199.545751]: default_status: 0
[INFO] [1611438199.588866]: update_rate: 10
[INFO] [1611438199.666573]: encoder_ppr: 12
[INFO] [1611438199.703274]: gear_ratio: 380
[INFO] [1611438199.724848]: wheel_dia: 0.060
[INFO] [1611438199.763283]: base_width: 0.100
[INFO] [1611438199.815428]: main_amp_limit: 3.60
[INFO] [1611438199.888972]: mt_amp_limit: 1.20
[INFO] [1611438199.945985]: bat_volts_high: 14.4
[INFO] [1611438199.993021]: bat_volts_low: 6.0
[INFO] [1611438200.055204]: max_rpm: 90.0
[INFO] [1611438200.093292]: left_swap: false
[INFO] [1611438200.131133]: right_swap: false
[INFO] [1611438200.229184]: left_reverse: false
[INFO] [1611438200.250466]: right_reverse: false
[INFO] [1611438200.344514]: max_idle_seconds: 1800
[INFO] [1611438200.723867]: config_flags: 0
[INFO] [1611438200.427031]: power_status: 0
[INFO] [1611438200.521165]: motor_status: 240
[INFO] [1611438200.594941]: system_status: 0
```

For explanation of power_status, motor_status, system_status bits, look at [DIAGNOSTICS](06_DIAGNOSTICS.md)

For explanation of config_flags bits, look at PARAM...

---

| CMD  | Description            | Notes   |
| ---- | ---------------------- |-------- |
| 0    | soft reset             | turns aux ctl off and resets the ```power_status``` to ```0x00```, this is used to reset software fuses for main supply, and motors|
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

### Explanation

>Commands between 20 and 45 are for testing only. The motor control bits should always be set by the ```control_effort``` subscriber. However, these commands could be useful in debugging the system.

>Remote resets, and hibernate commands could cause problems on the host, and might require rosserial to be restarted, depending on your configuration.

>MODE1: when mode1 is open for a driver, the driver shorts the motor terminals, that effects as a brake.

>MODE2: when mode2 is open for a driver, *when the pwm is at low cycle*, the driver shorts the motor terminals. This might seem more constrained, but
> could be useful when making a servo controller, in which precision is preferred over speed.

>AUXCTRL: the ROSRider board has an auxillary power port supplying 5.0V upto 500mA. The output is protected by a 500mA polyfuse and a transient voltage suppressor.
> command 50 turns it on, command 51 turns it off.

>EEPROM: command ```81``` writes current parameters into eeprom. command ```82``` prints all the state on the console. command ```80``` returns the default_status to 0, causing device to return initial settings.



