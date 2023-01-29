import pyautogui
from time import sleep

z = False
x, y = 100, 200

while True:
    pyautogui.moveTo(x, y) if z else pyautogui.moveTo(x + 1, y + 1)
    z = !z
    sleep(1)
