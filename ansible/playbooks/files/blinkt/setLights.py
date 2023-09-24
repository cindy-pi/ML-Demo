#!/usr/bin/env python3

import sys
import blinkt

if __name__ == "__main__":
    if len(sys.argv) != 6:
        print("Usage: script.py <number_of_leds> <brightness> <red> <green> <blue>")
        sys.exit(1)

    number_of_leds = int(sys.argv[1])
    brightness = float(sys.argv[2])
    red = int(sys.argv[3])
    green = int(sys.argv[4])
    blue = int(sys.argv[5])

    if not(0 <= brightness <= 1) or not(0 <= red <= 255) or not(0 <= green <= 255) or not(0 <= blue <= 255):
        print("Invalid Input: Brightness should be between 0 and 1 and color values should be between 0 and 255")
        sys.exit(1)

    blinkt.set_clear_on_exit(False)
    blinkt.set_brightness(brightness)
    blinkt.clear()

    for i in range(7, 7 - number_of_leds, -1):
        blinkt.set_pixel(i, red, green, blue)

    blinkt.show()


