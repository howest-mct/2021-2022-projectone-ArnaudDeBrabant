from RPi import GPIO
import time
  
GPIO.setmode(GPIO.BCM)

counter =0
sensor = 16

GPIO.setup(sensor, GPIO.IN, pull_up_down = GPIO.PUD_UP)

#Function executed on signal detection
def active(null):
    global counter
    counter+=1
    print(counter)

#On detecting signal (falling edge), active function will be activated.
GPIO.add_event_detect(sensor, GPIO.FALLING, callback=active, bouncetime=1000) 
  
# main program loop
try:
    while True:
        time.sleep(1)
  
# Scavenging work after the end of the program
except KeyboardInterrupt:
        GPIO.cleanup()