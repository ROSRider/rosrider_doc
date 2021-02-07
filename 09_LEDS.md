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

    rosservice call /rosrider/led_emitter { fr: 0x88888801, top: 0x0, fr: 0x88888801, br:0xFF000000 bl:0xFF000000, frequency: 2.0 }

[TODO: verify this]

And you should see the front right and left lamps are constantly on, as white. The back right, and left lamps are blinking red, at a frequency of 2 hz. With this interface,
you can set any led to any color, also have them blink or stay steady.


