import blinkt
import sys
from sys import argv

if len(sys.argv) < 3:
    print("Please provide a number as an argument.")
    sys.exit(1)

low = int(argv[1])
high = int(argv[2])

blinkt.set_clear_on_exit(False)
for i in range(low, high+1):
  blinkt.set_pixel(i, 255, 0, 0, 0.5)
blinkt.show()
