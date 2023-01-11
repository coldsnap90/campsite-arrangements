from datetime import datetime
from selenium import webdriver
from selenium.webdriver import firefox
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from ctypes.wintypes import SIZE
from html import entities
from typing import NoReturn
import time
from datetime import datetime, timedelta
from time import sleep
from booking import *
from xml.dom.minidom import Element
from selenium.webdriver.common import action_chains
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.actions.interaction import KEY
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait as wait
from selenium.webdriver.support.ui import Select as select
import speech_recognition as SR
import urllib
import urllib.request
import pydub
#import ffmpy
import os
import selectors
import time






#delete reservation when an error occurs to far into the process
def delete_reservation(browser,waits):
    print('deleting reservation')
    waits.until(EC.presence_of_element_located((By.ID,'viewShoppingCartButton'))).click()
    browser.implicitly_wait(10)
    waits.until(EC.presence_of_element_located((By.ID,'btn-remove'))).click()
    browser.implicitly_wait(10)
    flag = False
    while flag == False:
        flag = removed(browser,waits)
        if flag == True:
            print('browser closing')
            browser.close()
        else:
            flag = advisory(browser,waits)

#checks if a warning message pops up
def advisory(browser,waits):

    try:
        browser.find_element(By.ID,'message')
        waits.until(EC.presence_of_element_located((By.ID,'message')))
        browser.implicitly_wait(10)
        t= 'This is part of a Double Site'
        waits.until(EC.presence_of_element_located((By.XPATH,"//h2[contains(@id,'mat-dialog-title-0') and contains(text(),'%s')]" % t)))
        element = browser.find_element(By.ID,'confirmButton')
        waits.until(EC.presence_of_element_located((By.ID,'confirmButton')))
        element.click()
        return True
    except:
        return False

#delete booking from cart
def removed(browser,waits):
    try:
        browser.find_element(By.ID,'message')
        waits.until(EC.presence_of_element_located((By.ID,'message')))
        browser.implicitly_wait(10)
        t= 'Remove from cart?'
        waits.until(EC.presence_of_element_located((By.XPATH,"//h2[contains(@id,'mat-dialog-title-0') and contains(text(),'%s')]" % t)))
        print('found')
        element = browser.find_element(By.ID,'confirmButton')
        waits.until(EC.presence_of_element_located((By.ID,'confirmButton')))
        element.click()
        return True
    except:
        print('return removed false')
        return False

#checks if no sites are listed
def no_sites(browser,waits):
    browser.implicitly_wait(5)
    flag = False
    try:
        if waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'.expansion-details > h2:nth-child(1)'))):
                print("True")
                listbox = browser.find_element(By.CSS_SELECTOR,'.expansion-details > h2:nth-child(1)')
                for i in listbox.text:
                    if 'No' in listbox.text:
                        flag = True
                        break
    except:
        pass
    return flag

#escape func
def escape(Action):
    Action.key_down(Keys.ESCAPE).perform()
    Action.key_up(Keys.ESCAPE).perform()
#delete inputs func
def backspace(Action):
    Action.key_down(Keys.BACKSPACE).perform()
    Action.key_up(Keys.BACKSPACE).perform()

#selects month for booking
def pick_month(browser,waits,Action):
    print('pick month')
    siteEntryMonthText=[]
    flag = True
    browser.implicitly_wait(5)
    while flag == True :
        siteEntryMonth = browser.find_element(By.CSS_SELECTOR,'#monthDropdownPicker')
        siteEntryMonthText = browser.find_elements(By.CSS_SELECTOR,'#monthDropdownPicker')
        siteEntryMonthLoader = waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#monthDropdownPicker')))
        siteEntryMonthNext = browser.find_element(By.ID,'nextYearButton')
        browser.implicitly_wait(5)
        for text in siteEntryMonthText:

        
            if(text.text == 'Jan 2023'): #loops through month text
                flag = False
                break
            if(text.text != 'Jan 2023'):
                    siteEntryMonthNext.click()
    return True

#picks day from bookinmg
def pick_day(browser,waits,Action):
    print('pick day')
    flag = True
    siteEntryDateText=[]
    #scans the days until it finds the day enteredn much like the month
    while flag == True :
        siteEntryDateText = browser.find_elements(By.CSS_SELECTOR,'.mat-calendar-body > tr > td')
        waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'.mat-calendar-body > tr > td')))
        counter = 0
        print('day')
        for date in siteEntryDateText:
            counter+=1
            if counter > 31:
                flag = False
                return False
            if(date.text == '5'):
                date.click()
                flag = False
                break
            
    escape(Action)
    sleep(0.5)
    browser.implicitly_wait(5)
    return True

def main():
    x= 1
    if x == 1:
        chrome_options = webdriver.ChromeOptions()
        chrome_options.binary_location = os.environ.get('GOOGLE_CHROME_BIN')
        #caps["pageLoadStrategy"] = "eager"  #  complete
        chrome_options.add_argument("--headless") # Runs Chrome in headless mode.
        chrome_options.add_argument('--disable-infobars')
        chrome_options.add_argument("--disable-extensions")
        browser = webdriver.Chrome(os.environ.get("CHROMEDRIVER_PATH"), options=chrome_options)
   
        waits = wait(browser,10)
        Action = ActionChains(browser)
        browser.command_executor.set_timeout(10)
        

        web = browser.get('https://camping.bcparks.ca/')
        if 1 == 1:
            browser.implicitly_wait(5)
            z =wait(browser, 20).until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
            print(z)
            months = {'01':'Jan','02':'Feb','03':'Mar','04':'Apr','05':'May','06':'Jun','07':'Jul','08':'Aug','09':'Sept',
                    '10':'Oct','11':'Nov','12':'Dec'}
            try:
                browser.implicitly_wait(5)
                found = waits.until(EC.presence_of_element_located((By.ID,"consentButton"))).click()
                browser.implicitly_wait(5)
                found = waits.until(EC.presence_of_element_located((By.ID,'park-autocomplete'))).click()
                browser.implicitly_wait(5)
            except:
                end = time.time()
                s1 = False
                x = 'first popup'
                return False,end,s1, x

            try:
                found = waits.until(EC.presence_of_all_elements_located((By.CLASS_NAME,'mat-option-text')))
                if found:
                    print('located parks')
                list_box=[]
                list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                for text in list_box:
                    if str(text.text) == 'Porteau Cove':
                        text.click()
                        break
                browser.implicitly_wait(5)
            except:
                end = time.time()
                s1 = False
                x = 'located park'
                return False,end,s1,x

            waits.until(EC.presence_of_element_located((By.ID,'mat-date-range-input-0')))
            element = waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'.mat-date-range-input-start-wrapper'))).click()
            try:
                print('month picked')
                x = pick_month(browser,waits,Action)
                if x == False:
                    end = time.time()
                    s1 = False
                    x = 'pick month'
                    return False,end,s1,x

            except:
                end = time.time()
                s1 = False
                return False,end,s1,'pick month'
            print('Month picked')
            try:
                print('day picked')
                x = pick_day(browser,waits,Action)
                if x == False:
                    end = time.time()
                    s1 = False
                    x = 'pick day'
                    return False,end,s1,x
            except:
                print('day fail')
                end = time.time()
                s1 = False
                x = 'pick day'
                return False,end,s1,x
            print('day picked')
            try:
                browser.implicitly_wait(5)
                waits.until(EC.presence_of_element_located((By.ID,'nightsTab'))).click()
                backspace(Action)
                night = waits.until(EC.presence_of_element_located((By.ID,'nights-field')))
                type_speed(night,'1')
                print('Fail night')
                sleep(2)
                escape(Action)
            except:
                end = time.time()
                s1 = False
                x = 'nights'
                return False,end,s1,x
            try:
                waits.until(EC.presence_of_element_located((By.ID,'equipment-field'))).click()
                browser.implicitly_wait(5)
            except:
                end = time.time()
                s1 = False
                x = 'camp equiptment field'
                return False,end,s1,x
            print('nights an equiptment selected')
            try:
                found = waits.until(EC.presence_of_all_elements_located((By.CLASS_NAME,'mat-option-text')))
            
                list_box=[]
                list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                for text in list_box:
                    print('text ',text.text)
                    if str(text.text) == '1 Tent':
                        text.click() 
                        break
                
                browser.implicitly_wait(5)
            
                waits.until(EC.presence_of_element_located((By.ID,'actionSearch'))).click()
                print('equipment and action search')
            except:
                
                end = time.time()
                s1 = False
                x= 'action search'
                return False,end,s1,x
            try:
                browser.implicitly_wait(5)
                waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#list-view-button-button > span:nth-child(1)')))
                browser.implicitly_wait(5)
                waits.until(EC.presence_of_element_located((By.ID,'mat-tab-label-1-1')))
                browser.implicitly_wait(5)
            except:
                end = time.time()
                s1 = False
                x ='list view pre-spin'
                return False,end,s1,x
            try:
                waits.until(EC.invisibility_of_element((By.CLASS_NAME,'loading-spinner overlay ng-star-inserted')))
            except:
                end = time.time()
                s1 = False
                x ='loading spinner post spin'
                return False,end,s1,x
            try:
                waits.until(EC.visibility_of_element_located((By.ID,'mat-tab-label-1-1')))
                browser.implicitly_wait(5)
                waits.until(EC.element_to_be_clickable((By.ID,'list-view-button'))).click()
            
        
            except:
                end = time.time()
                s1 = False
                x ='list view button'
                return False,end,s1,x

      
            try:
                b = 'A (Sites 1-37)'
                waits.until(EC.presence_of_element_located((By.XPATH,"//h3[contains(text(),'%s')]" % b))).click()
            except:
                print('inner Campground Missing')
                waits.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR,'.mat-accordion')))
            
            site_found = False
            found_counter = 0
            b = '8'
            arr_day = 4
            arr_month = 1
            arr_year = 2023
            
            while site_found == False:
                    found_counter+=1
                    try:
                        print('Site Found')
                        waits.until(EC.presence_of_element_located((By.XPATH,"//h3[contains(text(),'%s')]" % b))).click()
                        r = 'Reserve'
                        x = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % r)))
                        flag = True
                        d2 = datetime(arr_year,arr_month,arr_day,20,55,30)
                        while flag:
                            print(datetime.now().time())
                            if datetime.now().time() <= d2.time() :
                                s = time.time() 
                                waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % r))).click()
                                sleep(2)
                                e = time.time()

                                flag = False
                                site_found = True
                                print('TIME = ',e-s)
                                break
                       
                    except:
                        try:
                            waits.until(EC.presence_of_element_located((By.ID,"loadMoreButton"))).click()
                        except:
                            pass

            browser.implicitly_wait(5)     
            box1 = r = ' All reservation details are correct. '
            box2 = 'I have read and acknowledge all of the messages listed.'
            box1_bool = False
            box2_bool = False
            try:
                print('page froze 1 ')
                x = wait(browser, 20).until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
                print(x)
                if not x:
                    browser.refresh()
            except:
                print('except page')
                browser.refresh()
            flag = False
            print('\n\ SITE BUTTONS')
            sleep(0.5)
     
            while flag:
                print('flag loop')
                try:
                    z = waits.until(EC.visibility_of_element_located((By.ID,'confirmReservationDetails')))
                    flag = False 
                except:
                    browser.refresh()
            while flag == False:
                print('flag loop')
                try:
                    print('try1')
                    print('page froze 1')
                    z =wait(browser, 20).until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
                    print(z)
                    if not z:
                            print('refresh on box')
                            browser.refresh()
                    if box1_bool == False:
                        print('box bool')
                        try:
                         browser.find_element(By.XPATH,"//span[contains(text(),'%s')]" % box1).click()
                        except:
                            browser.refresh() 
                    browser.implicitly_wait(5)
                    if box2_bool == False:
                        try:
                            browser.find_element(By.XPATH,"//span[contains(text(),'%s')]" % box2).click()
                        except:
                            browser.refresh()
                    n = browser.find_elements(By.XPATH,"//input[contains(@id,'mat-checkbox-')]")
                    if n[0].get_attribute("aria-checked") == 'true':
                        box1_bool = True
                    if n[1].get_attribute("aria-checked") == 'true':
                        box2_bool = True
                    if box1_bool == True and box2_bool == True:
                        print('both true')
                        flag = True
                    else:
                        print('one or both false')
                except:
                    print('try 1 except')
             
            x = input('waiting')
            if x == '1':
                delete_reservation(browser,waits)

#x,y,z,e = main()
d1 = datetime.now()
arr_day = 5
arr_month = 7
arr_year = 2023
d2 = datetime(arr_year,arr_month,arr_day,20,42,30)

if d2.month > (datetime.now().month + 4)%12: 
    new_d = datetime(arr_year,d2.month-4,d2.day,6,12,12)
    print(new_d)
else:
    new_d = datetime.now()
    print(new_d)

print( ' > ','a'>'i')
if d2.month > ((datetime.now().month + 4)%12) and d2.year == datetime.now().year:
            date = f'{d2.year}-{d2.month-4}-{d2.day}'
          

elif d2.year < datetime.now().year and (d2.month-4) > datetime.now().month:
     print((datetime.now().month + 4)%12)



months = {'1':'Jan','2':'Feb','3':'Mar','4':'Apr','5':'May','6':'Jun','7':'Jul','8':'Aug','9':'Sept'}
month = months['Jan']
print(month)
main
