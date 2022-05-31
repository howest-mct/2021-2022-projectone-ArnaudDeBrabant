from asyncore import read
from smbus import SMBus
from RPi import GPIO
import time 
import math


################
i2c = SMBus()
i2c.open(1)
addr = 0x68



def setup(adrr):
    print('starting setup')
    # write to department to turn on
    # 0x01 --> Seriele clock aanzetten
    i2c.write_byte_data(addr,0x6B,0x01)
    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)



def temp(addr):
    tempratuur = 0
    #read the value in temp, 2 values
    # Aantal registeres inlezen 
    res = i2c.read_i2c_block_data(0x68,addr,2) 

    # #write in one byte
    #print(f"\n============================\nResultaat van inlezeing: {res}")
    x1 = res[0]
    x2 = res[1]

    #print(f"X1 --> {x1}")
    #print(f"X2 --> {x2}")

    res = x1 << 8 | x2
    #print(res)
    #print(bin(res))
      
    #check MSB
    time.sleep(0.5)

    # 8 Bits --> 128
    if x1 > 128:

        getal = res - 2 ** 16
        tempratuur = getal / 340 +36.52
    
    return tempratuur

def accelero(addr):

    #read the value in temp, 2 values
    # Aantal registeres inlezen 
    res_list = i2c.read_i2c_block_data(0x68,addr,2) 

    # #write in one byte
    #print(f"\n============================\nResultaat van inlezeing: {res_list}")

    # Eerste twee items er uit halen
    x1 = res_list[0]
    x2 = res_list[1]

    # Omezetten
    res = x1 << 8 | x2

    # Graden berekenen
    graden = (res/16384.0-0)

    return graden

def versnelling():
    x = accelero(0x3B)
    y = accelero(0x3D)
    z = accelero(0x3F)

    accel = math.sqrt(x** 2+y** 2+z** 2)
    return accel

try:
    setup(addr)
    while True:
        time.sleep(1)

        tet = temp(0x41)
        x = accelero(0x3B)
        y = accelero(0x3D)
        z = accelero(0x3F)


        print(f"==================\ntemp: {tet}°C\nx accelereo: {x}\ny accelereo: {y}\nz accelereo: {z}\n==================")
        print (f"Versnelling: {versnelling()}")


        
except KeyboardInterrupt as e:
    print(e)
finally:
    GPIO.cleanup()
    print("Script has stoped!")
 

