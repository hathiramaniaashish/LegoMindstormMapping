#!/usr/bin/env python3
from ev3dev.ev3 import *
import time

us = UltrasonicSensor()
us.mode = 'US-DIST-CM'

def rotate():
    pass
    
def measure():
    # distance = us.distance_centimeters_ping()
    # time.sleep(0.25)
    distance = us.value()
    return distance


log = open("log.txt", "w")
actualAngle = 0
while (actualAngle < 360):
    line = "Angle: " + str(actualAngle) + "; Distance (cm): " + str(measure())
    log.write(line + "\n")
    rotate()

    # alguna corrección si no rota los ticks indicados
    # ...

    actualAngle += 5    # sumar el ángulo que ha rotado
                        # aquí se está suponiendo que se mide cada 5 grados (cada vez rota 5 grados)