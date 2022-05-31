import time
from RPi import GPIO
from helpers.klasseknop import Button
from helpers.LCD import LCD
import threading

from flask_cors import CORS
from flask_socketio import SocketIO, emit, send
from flask import Flask, jsonify, request
from repositories.DataRepository import DataRepository
from subprocess import check_output

from selenium import webdriver
from mfrc522 import SimpleMFRC522
# from selenium import webdriver
# from selenium.webdriver.chrome.options import Options

#  HARDWARE

counter = 0
sensor = 16


def setup_gpio():
    global reader
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(sensor, GPIO.IN, pull_up_down=GPIO.PUD_UP)
    GPIO.add_event_detect(sensor, GPIO.FALLING,
                          callback=active, bouncetime=1000)
    reader = SimpleMFRC522()


# FLASK
app = Flask(__name__)
app.config['SECRET_KEY'] = 'geheim!'
socketio = SocketIO(app, cors_allowed_origins="*", logger=False,
                    engineio_logger=False, ping_timeout=1)

CORS(app)


# API ENDPOINTS
endpoint = '/api/v1'


@app.route('/')
def hallo():
    return "Server is running."


@app.route(endpoint + '/historiek/', methods=['GET'])
def sensors():
    if request.method == 'GET':
        data = DataRepository.read_status_device()
        if data is not None:
            return jsonify(sensors=data), 200
        else:
            return jsonify(data="ERROR"), 404

# SOCKET


@socketio.on_error()
def error_handler(e):
    print(e)


def active(null):
    global counter
    counter += 1
    socketio.emit("B2F_connect", {'aantal': counter}, broadcast=False)
    print(counter)


@socketio.on('connect')
def initial_connection():
    print('A new client connect')


# ------- LCD DISPLAY -------
def show_ip():
    DB = [26, 19, 13, 6, 5, 17, 18, 21]
    E = 24
    RS = 4
    display = LCD(E, RS, DB)

    while True:
        display.clear()
        try:
            ips = str(check_output(['hostname', '--all-ip-addresses']))
            # Haal b' en \\n eruit en splits in een array op een spatie
            ips = ips.strip("b'").strip(" \\n").split(" ")
            # Wifi IP = index 1 bij mij
            ip = ips[1]
        except Exception as e:
            ip = "Not found..."

        display.send_message(f"IP:")
        display.second_row()
        display.send_message(ip)
        display.cursor_off()
        time.sleep(30)


#-------------RFID------------------#

def read_rfid():
    print("**** Starting RFID ****")
    id, text = reader.read()
    if id != " ":
        print("ID: %s\nText: %s" % (id, text))
        naam = text
        answer = DataRepository.read_rfid(id, naam)
        socketio.emit('B2F_refresh_history', broadcast=True)


def start_thread_rfid():
    thread2 = threading.Thread(target=read_rfid, args=(), daemon=True)
    thread2.start()


def start_chrome_kiosk():
    import os

    os.environ['DISPLAY'] = ':0.0'
    options = webdriver.ChromeOptions()
    # options.headless = True
    # options.add_argument("--window-size=1920,1080")
    options.add_argument(
        "user-agent=Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36")
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--allow-running-insecure-content')
    options.add_argument("--disable-extensions")
    # options.add_argument("--proxy-server='direct://'")
    options.add_argument("--proxy-bypass-list=*")
    options.add_argument("--start-maximized")
    options.add_argument('--disable-gpu')
    # options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--no-sandbox')
    options.add_argument('--kiosk')
    # chrome_options.add_argument('--no-sandbox')
    # options.add_argument("disable-infobars")
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    options.add_experimental_option('useAutomationExtension', False)

    driver = webdriver.Chrome(options=options)
    driver.get("http://localhost")
    while True:
        pass


def start_chrome_thread():
    print("**** Starting CHROME ****")
    chromeThread = threading.Thread(
        target=start_chrome_kiosk, args=(), daemon=True)
    chromeThread.start()


# ANDERE FUNCTIES

if __name__ == '__main__':
    try:
        setup_gpio()
        start_thread_rfid()
        # thread_show_ip = threading.Thread(target=show_ip)
        # thread_show_ip.start()
        # start_thread()
        start_chrome_thread()
        print("**** Starting APP ****")
        socketio.run(app, debug=False, host='0.0.0.0')
    except KeyboardInterrupt:
        print('KeyboardInterrupt exception is caught')
    finally:
        GPIO.cleanup()
