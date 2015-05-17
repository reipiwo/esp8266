pin=3
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, gpio.LOW)
dofile("AP.lua")
