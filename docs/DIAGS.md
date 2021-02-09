This is the Diagnostics Message, published at `rosrider/diagnostics` each update.

```console
float32 cs_left
float32 cs_right
#
float32 bus_voltage
float32 bus_current
#
uint8 config_flags
#
uint8 power_status
uint8 motor_status
uint8 system_status
#
bool drivers_disabled
float32 dt
```


| Field              | Description         | Unit | Datatype |
| ------------------ | ------------------- | ---- | -------- |
| cs\_left           | Current Sense Left  | Amp  | Float    |
| cs\_right          | Current Sense Right | Amp  | Float    |
| bus\_voltage       | Bus Voltage         | Amp  | Float    |
| bus\_current       | Bus Current         | Amp  | Float    |
| config\_flags      | Config Flag Bits    |      | uint8_t  |
| power\_status      | Power Status Bits   |      | uint8_t  |
| motor\_status      | Motor Status Bits   |      | uint8_t  |
| system\_status     | System Status Bits  |      | uint8_t  |
| drivers\_disabled  | Drivers Disabled    |      | bool     |
| dt                 | Loop Time           | Sec  | Float    |


### current sense 

`cs_left` and `cs_right` returns the current used by each motor in amps. This might be useful to develop an effort controller interface.

Depending on the motor phase, biases might exist for the current sense.

### bus voltage

Returns the System Bus Voltage in Volts. You can plot this variable with rqt_plot, and observe its change when the motors are powered.

>Notice: the bus voltage measurement can be biased.

### bus current

Returns the total current used by the ROSRider board. When the motors, and external leds are off, the system uses around 0.07 amperes of power.

You can plot this variable with rqt_plot, turn on/off external leds, drive the motors, and observe current usage.

### dt

Loop Time. It should equal 1 / update_rate.

### config_flags

| bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | 
| left encoder ab | right encoder ab | right encoder swap | left encoder swap | right motor reversed | left motor reversed |

>Notice: config_flags are applied when configuring hardware initially

### power_status

| bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | 
| right motor amp limit | left motor amp limit | main amp limit | battery high | battery low | aux_ctrl on

>Notice: any bit except bit0 disables motor drivers.

### motor_status

| bit7 | bit6 | bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| right driver fault | left driver fault | right phase forward | left phase forward | right mode2 on | left mode2 on | right mode1 on | left mode1 on |

>Notice: driver fault indicators only work correctly if supply voltage is above 12V

If the below conditions occur in the motor driver, the fault bit is on.

- over temperature warning
- over temperature shutdown
- under voltage lockdown
- over current protection

To reset a shutdown, issue a `soft_reset` using the [SYSCTL](SERVICES.md) service. 

### system_status

| bit7 | bit6 | bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | 
| error while loading parameters | | | | | error while writing default parameters | error while writing default_status | eeprom init error

>Notice: bit7 disables motor drivers.
> 
>If *eeprom_init_error* occurs, system will continue to work requesting parameters. If parameters not found, it will result in a *error while loading parameters* which will disable motor drivers.

---

**Use rqt_plot to plot /rosrider/diagnostics variables**

Open a terminal window and type:

```console
rqt_plot rqt_plot /rosrider/diagnostics/bus_voltage
```

Will plot bus voltage. Use buttons provided by `rqt_plot` to change speed, range, etc.

To plot bus current type:

```console
rqt_plot rqt_plot /rosrider/diagnostics/bus_current
```

To plot execution time per update type:

```console
rqt_plot rqt_plot /rosrider/diagnostics/dt
```

To plot current sense from left and rigt driver type:

```console
rqt_plot /rosrider/diagnostics/cs_left /rosrider/diagnostics/cs_right
```

[![rqt_plot](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/rqt_plot.png)](https://www.youtube.com/watch?v=kgWcXQgxFSU "rqt_plot demo")