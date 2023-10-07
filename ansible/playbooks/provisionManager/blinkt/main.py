
#!/usr/bin/env python3

import blinkt
import time

if __name__ == "__main__":
    blinkt.set_clear_on_exit(True)
    blinkt.set_brightness(0.2)

    i = 0

    while True:
        blinkt.clear()
        blinkt.set_pixel(i % 8, 0, 255, 0)
        blinkt.show()

        time.sleep(0.2)
        i += 1

