#!/usr/bin/env python3

import blinkt
import time

if __name__ == "__main__":
    blinkt.set_clear_on_exit(True)
    blinkt.set_brightness(0.5)

    i = 0

    print("Start")
    while True:
        print("Running")
        blinkt.clear()
        blinkt.show()

