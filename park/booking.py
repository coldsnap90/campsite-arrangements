from time import sleep
from selenium.webdriver.remote.webelement import WebElement
#helper functions for bot
#error message  
def exceptPrint():
    print('could not be located')
 
#auto enter text you want at a speed a human could
def type_speed(element: WebElement,text:str):

    delay = 0.03
    for char in text:
        element.send_keys(char)
        sleep(delay)
   
def no_delay_type(element: WebElement,text:str):
    for char in text:
        element.send_keys(char)