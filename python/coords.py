#!/usr/bin/env python

# "bounds": {
#     "width": "0.48583333333333334",
#     "height": "0.009784244856999497",
#     "x": "0.2683333333333333",
#     "y": "0.2168840943301555",

width = 0.48583333333333334
height = 0.009784244856999497
x = 0.2683333333333333
y = 0.2168840943301555

dimx = 1300
dimy = 1993

x1 = int(x * dimx)
x2 = int(x1 + width * dimx)

y1 = int(y * dimy)
y2 = int(y1 + height * dimy)

print "X coords:", x1, x2 # 348, 979
print "Y coords:", y1, y2 # 432, 451
