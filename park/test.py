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


def occupant(browser,waits,Action):
    print('occll')
    occupant_Fname = waits.until(EC.presence_of_element_located((By.ID,'first-name-field-0')))

    type_speed(occupant_Fname,'Navdeep')

    occupant_Lname = waits.until(EC.presence_of_element_located((By.ID,'last-name-field-0')))

    type_speed(occupant_Lname,'cheema')
 
    occupant_phone = waits.until(EC.presence_of_element_located((By.ID,'primary-phone-0')))

    type_speed(occupant_phone,'6042179026')

    occupant_address = waits.until(EC.presence_of_element_located((By.ID,'street-field-0')))
   
    type_speed(occupant_address,'7532 lark st')
 
    occupant_postal = waits.until(EC.presence_of_element_located((By.ID,'postal-code-field-0'))) 
    type_speed(occupant_postal,'v2s0j6')  
  

    sleep(3)
    element = browser.find_element(By.ID,'confirmOccupant')
    Action.move_to_element(element).click().perform()
    return



#delete reservation when an error occurs to far into the process
def delete_reservation(browser,waits):
    print('deleting reservation')
    
    waits.until(EC.element_to_be_clickable((By.ID,'viewShoppingCartButton'))).click()
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
            if(date.text == '19'):
                date.click()
                flag = False
                break
            
    escape(Action)
    sleep(0.5)
    browser.implicitly_wait(5)
    return True
def login(browser,waits):
 
    found = waits.until(EC.presence_of_element_located((By.ID,'email')))
    email = browser.find_element(By.ID,"email")
    if bool(found) == True:
        type_speed(email,'cheema_mandy@hotmail.com')
    else:
        login(browser,waits)

    found = waits.until(EC.presence_of_element_located((By.ID,'password')))
    password = browser.find_element(By.ID,"password")
    if bool(found) == True:
        type_speed(password,'Apple9314!!')
    else:
        login(browser,waits)

    waits.until(EC.presence_of_element_located((By.ID,'loginButton'))).click()
 
def main():
    x= 1
    if x == 1:
        chrome_options = webdriver.ChromeOptions()
        #chrome_options.binary_location = os.environ.get('GOOGLE_CHROME_BIN')
        #caps["pageLoadStrategy"] = "eager"  #  complete
        #chrome_options.add_argument("--headless") # Runs Chrome in headless mode.
        chrome_options.add_argument('--disable-infobars')
        chrome_options.add_argument("--disable-extensions")
        browser = webdriver.Chrome( options=chrome_options)
   
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
            web = browser.get('https://camping.bcparks.ca/')
     
            print('WEB')
            months = {'Jan':'1','Feb':'2','Mar':'3','Apr':'4','May':'5','Jun':'6','Jul':'7','Aug':'8','Sept':'9',
                    'Oct':'10','Nov':'11','Dec':'12'}
            month = int(months['Jan'])
            d2 = datetime(int('2023'),month,int('13'),6,59,59,59)
            x = browser.find_element(By.ID,'park-field').click()
            if x:
                print('x : ',x)
            try:
                
                list_box=[]
                list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                for text in list_box:
                    print(text.text)
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
                sleep(1)
                n= 5
                try:
                    browser.find_element(By.ID,'consentButton').click()
                except:
                    print('not found')
                while n > 0:
                    print(n)
                    n-=1
                    try:
                        browser.find_element(By.ID,'actionSearch').click()
                    except:
                        pass
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
                pass
            '''
                end = time.time()
                s1 = False
                x ='loading spinner post spin'
                return False,end,s1,x
            '''
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

            while site_found == False:
                    found_counter+=1
                    try:
                        print('Site Found')
                        b='4'
                        waits.until(EC.presence_of_element_located((By.XPATH,"//h3[contains(text(),'%s')]" % b))).click()
                        r = 'Reserve'
                        x = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % r)))
                        flag = True
                 
                        while flag:
                            print(datetime.now().time())
                            if datetime.now():
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
                    print('refreshing')
                    browser.refresh()
            while flag == False:
                print('flag loop2')
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
            z = waits.until(EC.element_to_be_clickable((By.ID,'confirmReservationDetails'))).click()
            try:
                waits.until(EC.element_to_be_clickable((By.ID,'proceedToCheckout'))).click()
                sleep(2)
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x='proceedtocheckout'
                return False,end,s1,x
            
            try:
                login(browser,waits)
                print('Login completed')
                waits.until(EC.presence_of_element_located((By.TAG_NAME, 'body')))
            except:
                    delete_reservation(browser,waits)
                    end = time.time()
                    s1 = False
                    x = 'mat-checkbox-before-logibn'
                    return False,end,s1,x
            sleep(1)
            try:

                waits.until(EC.presence_of_element_located((By.XPATH,"//mat-checkbox[contains(@id,'mat-checkbox-')]"))).click()
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'mat-checkbox-after-logibn'
                return False,end,s1,x

            sleep(1)
            try:
                waits.until(EC.element_to_be_clickable((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirmAcknowledgenments'
                return False,end,s1,x


            try:
                print('ACK confirmed')
                waits.until(EC.element_to_be_clickable((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click()
                print('ACCout confirmed')
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirmAccountDetails'
                return False,end,s1,x

            try:   
                    O='Someone else will be the occupant.'
                    print(' O try ')
                    try:
                       z= waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % O))).click()
                       occupant(browser,waits,Action)
                  
                    except:
                        z =  waits.until(EC.presence_of_element_located(By.XPATH,"//mat-radio-button[contains(@id,'mat-radio-3')]")).click()
                    
                       
                    print(' O try 2')
                    waits.until(EC.presence_of_element_located((By.ID,'confirmOccupant'))).click()
                    sleep(2)
                    print(' O try 3')
                    element = browser.find_element(By.ID,'confirmOccupant')
                    Action.move_to_element(element).click().perform()
            except:
                    print('EXCEPT - i will be occupant')
                    try:
                        print('?')
                        waits.until(EC.element_to_be_clickable((By.ID,'confirmOccupant'))).click()
                        sleep(2)
                        print(':)')
                    except:
                        delete_reservation(browser,waits)
                        end = time.time()
                        s1 = False
                        x = 'confirmOccupant'
                        return False,end,s1,x
            print('Waiting')
    
            print('PARTY INFO CLiICK')
            try:
                waits.until(EC.element_to_be_clickable((By.XPATH,"//button[contains(@id,'partyInfoButton')]"))).click()
                sleep(2)

            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x='partyinfobutton'
                return False,end,s1,x

            print('confirm additional info')
            try:
                waits.until(EC.element_to_be_clickable((By.ID,'confirmAdditionalInformation'))).click()
                sleep(2)
      
                waits.until(EC.element_to_be_clickable((By.ID,'addOnsOptions'))).click()
                sleep(2) 
           
                print('Add ons skipped')
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirm and addons'
                return False,end,s1,x

            card = waits.until(EC.presence_of_element_located((By.ID,'cardNumber')))
    
            type_speed(card,'4242424242424242')
  
            card_name = waits.until(EC.presence_of_element_located((By.ID,'cardHolderName')))
          
            type_speed(card_name,' M C')
    
            exp_month = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryMonth')))
          
            type_speed(exp_month,'11')
         
            exp_year = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryYear')))
     
            type_speed(exp_year,'2025')
         
            card_code = waits.until(EC.presence_of_element_located((By.ID,'cardCvv')))
          
            type_speed(card_code,'123')
            sleep(5)
            flag = False
            while flag == False:
                try:
                    card_code = waits.until(EC.presence_of_element_located((By.ID,'applyPaymentButton')))
                    if card_code:
                        print('code found')
                        
                        end = time.time()
                        s1 = True
                        return True,end,s1,None
                    else:
                        s2 = False
                        return False,end,s2,'CARD CODE'
                except:
                    print('Not found')
            x = input('waiting')
            if x == '1':
                delete_reservation(browser,waits)

#x,y,z,e = main()
#print(' X : ',x, ' Y : ',y, ' Z : ',z,' E : ',e)
flag = True

date_list = ['2023','07','01']
d2 = datetime(int(date_list[0]),int(date_list[1]),int(date_list[2]),21,39,59,59)
print(datetime.now())
x=''
while datetime.now().time() < d2.time():
    print(d2, ' ',datetime.now())
    x = datetime.now().time()

x = datetime.now().time() - d2.time()
print('Time : ',x)
    