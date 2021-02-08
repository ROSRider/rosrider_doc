### Diagnostics System

This is the Diagnostics Message, published at ```rosrider/diagnostics``` each update.

```console
float32 cs_left
float32 cs_right

float32 bus_voltage
float32 bus_current

uint8 config_flags

uint8 power_status
uint8 motor_status
uint8 system_status

bool drivers_disabled
float32 dt
```

---

| Field             | Description         | Unit | Datatype |
| ----------------- | ------------------- | ---- | -------- |
| cs_left           | Current Sense Left  | Amp  | Float    |
| cs_right          | Current Sense Right | Amp  | Float    |
| bus_voltage       | Bus Voltage         | Amp  | Float    |
| bus_current       | Bus Current         | Amp  | Float    |
| config_flags      | Config Flag Bits    |      | uint8_t  |
| power_status      | Power Status Bits   |      | uint8_t  |
| motor_status      | Motor Status Bits   |      | uint8_t  |
| system_status     | System Status Bits  |      | uint8_t  |
| drivers_disabled  | Drivers Disabled    |      | bool     |
| dt                | Loop Time           | Sec  | Float    |


### Current Sense 

```cs_left``` and ```cs_right``` returns the current used by each motor in amps. This might be useful to develop an effort controller interface.

Depending on the motor phase, biases might exist for the current sense.

### Bus Voltage

Returns the System Bus Voltage in Volts. You can plot this variable with rqt_plot, and observe its change when the motors are powered.

>Notice: the bus voltage measurement can be biased.

### Bus Current

Returns the total current used by the ROSRider board. When the motors, and external leds are off, the system uses around 0.07 amperes of power.

You can plot this variable with rqt_plot, turn on/off external leds, drive the motors, and observe current usage.

### dt

Loop Time. It should equal 1 / update_rate.

### config_flags

| bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | 
| left encoder ab | right encoder ab | right encoder swap | left encoder swap | right motor reversed | left motor reversed |

>Notice: config_flags are applied when configuring hardware initially
> 
# TODO: config_flags is not even diag, needs a new page, explanation on PARAMS.md maybe
# TODO: params.md needs an update as some bools are depreciated

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

### system_status

| bit7 | bit6 | bit5 | bit4 | bit3 | bit2 | bit1 | bit0 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | 
| error while loading parameters | | | | | error while writing default parameters | error while writing default_status | eeprom init error

>Notice: bit7 disables motor drivers.
> 
>If *eeprom_init_error* occurs, system will continue to work requesting parameters. If parameters not found, it will result in a *error while loading parameters* which will disable motor drivers.

[TODO: rqt_plot examples]