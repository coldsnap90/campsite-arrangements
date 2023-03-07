from ctypes.wintypes import SIZE
from html import entities
from typing import NoReturn
import time
from datetime import datetime, timedelta
from time import sleep
from park.booking import *
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


#bot program

#delete reservation when an error occurs to far into the process
def delete_reservation(browser,waits,Action):
    '''deletes reservation'''
    flag = True
    while flag:
        try:
            waits.until(EC.presence_of_element_located((By.ID,'viewShoppingCartButton')))
            element = browser.find_element(By.ID,'viewShoppingCartButton')
            Action.move_to_element(element).click().perform()
            flag = False
            break
        except:
            pass
      
    while flag == False:
        try:
            waits.until(EC.presence_of_element_located((By.ID,'btn-remove')))
            element = browser.find_element(By.ID,'btn-remove')
            Action.move_to_element(element).click().perform()
            flag = True
            break
        except:
            pass
'''
    flag = False
    while flag == False:
        flag = removed(browser,waits)
        if flag == True:
            print('browser closing')
            browser.close()
        else:
            flag = advisory(browser,waits)
'''

def occupant(browser,waits,Action,b_info):
    '''navigates occupant page and enters in extra occupant info'''
    occupant_Fname = waits.until(EC.presence_of_element_located((By.XPATH,"//input[contains(@id,'first-name-field-')]")))
    type_speed(occupant_Fname,b_info.occupant_first_name)
    occupant_Lname = waits.until(EC.presence_of_element_located(( By.XPATH,"//input[contains(@id,'last-name-field-')]")))
    type_speed(occupant_Lname,b_info.occupant_last_name)
    occupant_phone = waits.until(EC.presence_of_element_located(( By.XPATH,"//input[contains(@id,'primary-phone-')]")))
    type_speed(occupant_phone,b_info.occupant_phone_num)
    counter = 0
    while counter < 10:
        try:
            occupant_address = waits.until(EC.presence_of_element_located(( By.XPATH,"//input[contains(@id,'street-field-')]")))

            type_speed(occupant_address,b_info.occupant_address)
            counter = 0
            break
        except:
            counter+=1

    while counter < 10:
        try:
            occupant_postal = waits.until(EC.presence_of_element_located(( By.XPATH,"//input[contains(@id,'postal-code-field-')]"))) 
            type_speed(occupant_postal,b_info.occupant_postal_code) 
            break 
        except:
             counter+=1
  
    sleep(3)
    try:
        element = browser.find_element(By.ID,'confirmOccupant')
        Action.move_to_element(element).click().perform()
        sleep(1)
        try:
            print('return true occu')
            browser.find_element(By.ID,'ConfirmOccupant').click()
            return True
        except:
             print('return False')
             return False
    
    except:
         return False
    

def proceed_to_checkout(browser,waits,Action,b_info):
    '''navigates checkpout page and logs into account'''
    n = 5
    while n > 0:
                n-=1
                try:
                    waits.until(EC.presence_of_element_located((By.ID,'proceedToCheckout'))).click()
                    sleep(2)
                    break
                except:
                 pass
    if n == 0:
                return False       
    try:
        login(browser,waits,b_info)
        waits.until(EC.presence_of_element_located((By.TAG_NAME, 'body')))
        return True
    
    except:
        return False

def confirm_reservation(browser,waits,Action):
    '''navigates initial reservation page'''
    flag1 = True
    while flag1 == True:
            try:
                waits.until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
                flag1 = False
                break
            except:
                browser.refresh()
    flag = False
    if flag1 == False:
            try:
                box1  = 'All reservation details are correct.'
                box2 = 'I have read and acknowledge all of the messages listed.'
                box1_bool = False
                box2_bool = False
                counter = 0
                while flag == False:
                    counter+=1
                    if box1_bool == False:
                        try:
                            b1 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box1))).click() 
                        except:
                            pass
                   
                    if box2_bool == False:
                        try:
                            b2 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box2))).click()
                        except:
                            pass
                    try:
                        n = browser.find_elements(By.XPATH,"//input[contains(@id,'mat-checkbox-')]")
                        if n[0].get_attribute("aria-checked") == 'true':
                            box1_bool = True
                        if n[1].get_attribute("aria-checked") == 'true':
                            box2_bool = True
                        if box1_bool == True and box2_bool == True:
                            flag = True
                            break
                        else:
                            print('1 or both false')
                    except:
                        if counter > 5:
                            browser.refresh()
                        if counter > 10:
                            browser.quit()
            except:
                return False
               
                
            try:
                    c = 'Close'
                    waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % c))).click()

            except:
                    print('No Sites')

            try:
                waits.until(EC.presence_of_element_located((By.ID,'confirmReservationDetails'))).click()
                sleep(2)
                return True
            except:
                return False

def confirm_acknowledgements(waits):
    '''navigfates acknowledgements page'''
    try:
        waits.until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
    except:
         pass
    counter = 0
    while counter < 10:
        try:
            sleep(1)
            waits.until(EC.presence_of_element_located((By.XPATH,"//mat-checkbox[contains(@id,'mat-checkbox-')]"))).click()
            break   
        except:
            print('counter ',counter)
            counter+=1
    if counter == 10:
        return False
        
    sleep(1)  
    while counter < 10:    
        try:
            waits.until(EC.element_to_be_clickable((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
            return True
        except:
            print('counter ',counter)
            counter+=1

    if counter == 10:
         return False

def confirm_details(waits):
    '''navigates the details page'''
    try:
        waits.until(EC.element_to_be_clickable((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click()
        return True
    except:
        return False

def confirm_occupant(browser,waits,Action,u_info,b_info):
    '''navigates the occupants page'''
    if b_info.occupant == True:
                try:   
                        O='Someone else will be the occupant.'
                        try:
                            checkbox = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % O))).click()
                            bool_flag = occupant(browser,waits,Action,b_info)
                            sleep(2)
                            if bool_flag == False:
                                print('occupant flag false')
                                element = browser.find_element(By.ID,'confirmOccupant')
                                Action.move_to_element(element).click().perform()
                                return True
                         
                        except:
                            checkbox =  waits.until(EC.presence_of_element_located(By.XPATH,"//mat-radio-button[contains(@id,'mat-radio-3')]")).click()
                            bool_flag = occupant(browser,waits,Action,b_info)
                            sleep(2)
                            if bool_flag == False:
                                print('occupant flag false')
                                element = browser.find_element(By.ID,'confirmOccupant')
                                Action.move_to_element(element).click().perform()
                                return True
                         
                          
                        sleep(2)

                except:
                        print('no occupant')
                        n = 5
                        while n > 0:
                            try:
                                waits.until(EC.element_to_be_clickable((By.ID,'confirmOccupant'))).click()
                                sleep(2)
                                return True
                                
                            except:
                                 n-=1
                  
    else:
                try:
                    n = 5
                    while n > 0:
                        n-=1
                        try:
                            waits.until(EC.element_to_be_clickable((By.ID,'confirmOccupant'))).click()
                            sleep(2)
                            return True
        
                        except:
                            print('except occupant')
                            waits.until(EC.presence_of_element_located((By.ID,'confirmOccupant'))).click()
                            return True
                except:
                   return False

def confirm_party_info(browser,waits,Action):
    '''navigates the party info page'''
    counter = 0
    while counter < 10:
        try:
            browser.find_element(By.XPATH,"//input[contains(@id,'subCat-0')]").click()
            backspace(Action)
            sleep(0.05)
            browser.find_element(By.XPATH,"//input[contains(@id,'subCat-0')]").send_keys('4')
            escape(Action)
            break

        except:
            counter +=1
    counter = 0
    sleep(1)

    try:
        waits.until(EC.presence_of_element_located((By.ID,'partyInfoButton')))
        element = browser.find_element(By.ID,'partyInfoButton')
        Action.move_to_element(element).click().perform()
        sleep(2)
        print('party info return')
        return True

    except:
        return False

def confirm_addons(browser,waits,Action):
    '''navigates the confirm addons page'''
    flag = True
    while flag:
        try:
              element = browser.find_element(By.ID,'partyInfoButton').click()
              print('party info clicked')
              sleep(2)
              flag = False

        except:
             waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()
             sleep(2)
             print('confirm clicked')
             flag = False
             break

    while flag == False:
          
        print('confirming')
        try:
            waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()
            print('additional clicked')
            sleep(2)
            break
        except:
            waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()
            sleep(2) 
            print('add ons clicked')
            return True 
    counter = 0
    while counter < 10:
        try:
             waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()
             sleep(2)
             return True
        except:
            sleep(1)
            counter +=1
            print('add ons failed')
            
    if counter == 10:
         return False

def confirm_purchases(browser,waits,Action):
    '''using the stripe api it makes a request for credit card details and pays for the campsite'''
    card = waits.until(EC.presence_of_element_located((By.ID,'cardNumber')))
    type_speed(card,s_info.metadata['metaNu'])
    card_name = waits.until(EC.presence_of_element_located((By.ID,'cardHolderName')))     
    type_speed(card_name,s_info.metadata['metaNa'])
    exp_month = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryMonth'))) 
    type_speed(exp_month,s_info.metadata['metaM'])    
    exp_year = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryYear')))
    type_speed(exp_year,s_info.metadata['metaY'])   
    card_code = waits.until(EC.presence_of_element_located((By.ID,'cardCvv')))    
    type_speed(card_code,s_info.metadata['metaC'])

    sleep(5)
    flag = False
    while flag == False:
                try:
                    card_code = waits.until(EC.presence_of_element_located((By.ID,'applyPaymentButton')))
                    card_codes = True
                    if card_codes:
                        return True
                 
                    else:
                        browser.quit()
                        return False
                except:
                    print('Not found')

def confirm_purchase(browser,waits,Action):

    card = waits.until(EC.presence_of_element_located((By.ID,'cardNumber')))
    cards = '5524903605801563'
    type_speed(card,cards)
    card_name = waits.until(EC.presence_of_element_located((By.ID,'cardHolderName')))
    type_speed(card_name,'Colton Farbatuk')
    exp_month = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryMonth')))
    type_speed(exp_month,'03')   
    exp_year = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryYear')))
    type_speed(exp_year,'2026')   
    card_code = waits.until(EC.presence_of_element_located((By.ID,'cardCvv')))   
    type_speed(card_code,'359')
    sleep(5)
    flag = False
    while flag == False:
                try:
                    card_code = waits.until(EC.presence_of_element_located((By.ID,'applyPaymentButton'))).click()
                    card_codes = True
                    if card_codes:
                        return True
                    else:
                        browser.quit()
                        return False
                except:
                    print('Not found')
   
def advisory(browser,waits):
    '''checks to see if the site is a double site or not'''
    try:
         browser.find_element(By.ID,'message')
         waits.until(EC.presence_of_element_located((By.ID,'message')))
         t= 'This is part of a Double Site'
         waits.until(EC.presence_of_element_located((By.XPATH,"//h2[contains(@id,'mat-dialog-title-0') and contains(text(),'%s')]" % t)))
         element = browser.find_element(By.ID,'confirmButton')
         waits.until(EC.presence_of_element_located((By.ID,'confirmButton')))
         element.click()
         return True
    except:
         return False

def removed(browser,waits):
    try:
         browser.find_element(By.ID,'message')
         waits.until(EC.presence_of_element_located((By.ID,'message')))
         t= 'Remove from cart?'
         waits.until(EC.presence_of_element_located((By.XPATH,"//h2[contains(@id,'mat-dialog-title-0') and contains(text(),'%s')]" % t)))
         element = browser.find_element(By.ID,'confirmButton')
         waits.until(EC.presence_of_element_located((By.ID,'confirmButton')))
         element.click()
         return True
    except:
         return False

def no_sites(browser,waits):
    '''checks to see if site is missing'''
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

def escape(Action):
    '''escapes some click function'''
    Action.key_down(Keys.ESCAPE).perform()
    Action.key_up(Keys.ESCAPE).perform()

def backspace(Action):
    '''deletes some inpits'''
    Action.key_down(Keys.BACKSPACE).perform()
    Action.key_up(Keys.BACKSPACE).perform()

def pick_month(browser,waits,Action,month):
    '''checks for month of request booking and clicks it'''
    siteEntryMonthText=[]
    flag = True
    date_list = month.split(' ')
    year = date_list[1]
    flag = False
    siteEntryMonthNext = browser.find_element(By.ID,'nextYearButton')
    siteEntryMonth = browser.find_element(By.CSS_SELECTOR,'#monthDropdownPicker').click()
    while flag == False:
        try:
            x = browser.find_element(By.CLASS_NAME,'mat-calendar-body-label').text
            if x != date_list[1]:
                 siteEntryMonthNext.click()
            elif x == date_list[1]:
                flag = True
                r=date_list[0]
                waits.until(EC.presence_of_element_located((By.XPATH,"//div[contains(text(),'%s')]" % r))).click()
                break
        except:
            pass
    return True

def pick_day(browser,waits,Action,b_info):
    '''checks for day of request bookinf and clicks it'''
    flag = True
    siteEntryDateText=[]
    #scans the days until it finds the day enteredn much like the month
    while flag == True :
        siteEntryDateText = browser.find_elements(By.CSS_SELECTOR,'.mat-calendar-body > tr > td')
        waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'.mat-calendar-body > tr > td')))
        counter = 0
        for date in siteEntryDateText:
            counter+=1
            if counter > 31:
                flag = False
                return False
            if(date.text == b_info.arrival_day):
                date.click()
                flag = False
                break
            
    escape(Action)
    sleep(0.5)
    return True

#logins in to bc parks account
def login(browser,waits,b_info):
    found = waits.until(EC.presence_of_element_located((By.ID,'email')))
    email = browser.find_element(By.ID,"email")
    if bool(found) == True:
        type_speed(email,b_info.email)
    else:
        login(browser,waits,b_info)

    found = waits.until(EC.presence_of_element_located((By.ID,'password')))
    password = browser.find_element(By.ID,"password")
    if bool(found) == True:
        type_speed(password,b_info.password)
    else:
        login(browser,waits,b_info)
    waits.until(EC.presence_of_element_located((By.ID,'loginButton'))).click()
 
#if booking is a double site,this func executes
def double_site(browser,waits,Action,u_info,b_info):
    flag1 = True
    while flag1 == True:
            try:
                waits.until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
                flag1 = False
                break
            except:
                browser.refresh()
    sleep(1)
    flag = False
    box1  = ' All reservation details are correct. '
    box2 = 'I have read and acknowledge all of the messages listed.'
    box1_bool = False
    box2_bool = False
    counter = 0
    while flag == False:
        try:
            counter+=1
            if box1_bool == False:
                try:
                    b1 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box1))).click()
                except:
                    print('b1 fail') 

            if box2_bool == False:
                try:
                    b2 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box2))).click()
                except:
                     print('b2 fail')
            try:
                n = browser.find_elements(By.XPATH,"//input[contains(@id,'mat-checkbox-')]")
                if n[0].get_attribute("aria-checked") == 'true':
                        box1_bool = True
                if n[1].get_attribute("aria-checked") == 'true':
                        box2_bool = True
                if box1_bool == True and box2_bool == True:
                        waits.until(EC.presence_of_element_located((By.ID,'confirmReservationDetails'))).click()
                        flag = True
                        break
                else:
                        print('one or both false')
            except:
                        if counter > 5:
                            browser.refresh()
                        if counter > 10:
                            browser.quit()
                            end = time.time()
                            s1 = False
                            x = 'confirmDetails'
                            return False,end,s1,x

        except:
           print(counter)

    sleep(1)
    try:
        waits.until(EC.element_to_be_clickable((By.ID,'proceedToCheckout'))).click()
        flag = True
    except:
         waits.until(EC.presence_of_element_located((By.ID,'proceedToCheckout'))).click()
         flag = True

    if flag == True:
         sleep(1)
    else:
        end = time.time()
        s1 = False
        x = 'proceed to checkout'
        return False,end,s1,x
    
    login(browser,waits,b_info)

    sleep(1)
    waits.until(EC.presence_of_element_located((By.TAG_NAME, 'body')))
    waits.until(EC.presence_of_element_located((By.XPATH,"//mat-checkbox[contains(@id,'mat-checkbox-')]"))).click()
    try:
        waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
        sleep(1)
    except:
        end = time.time()
        s1 = False
        x = 'confirm acknowledgements'
        return False,end,s1,x

    sleep(1)
    try:
        waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click()
    except:
        end = time.time()
        s1 = False
        x = 'confirm account'
        return False,end,s1,x
    
    occupant_flag = occupant(browser,waits,Action,b_info)
    sleep(1) 
    p_info_flag = False
    counter = 0

    try:
        if occupant_flag == False:
            element = browser.find_element(By.ID,'confirmOccupant')
            Action.move_to_element(element).click().perform()  
    except:  
        pass

    while p_info_flag == False and counter < 5:
            try:
                p_info = waits.until(EC.presence_of_element_located((By.ID,'partyInfoButton'))).click()
                sleep(1)
                p_info_flag = True
            except:
                counter+=1

    if p_info_flag == True:
        sleep(1)
    else:
        end = time.time()
        s1 = False
        x = 'party info'
        return False,end,s1,x

    flag = False
    waits.until(EC.presence_of_all_elements_located((By.ID,'equipment-field')))
    equip_boxes = browser.find_elements(By.ID,'equipment-field') 
    for equip_box in equip_boxes:
        equip_box.click()
        equip_box_entries = browser.find_elements(By.CLASS_NAME,'mat-option-text')
  
        for entry in equip_box_entries:
            print('equipbox2')
            print(entry.text)
            try:
                if str(entry.text) == b_info.equiptment:
                    print('if entry ',entry.text)
                    entry.click()
                    flag = True
                    break
            except:
                 pass

    x = input('wait')
    if flag == True:
         sleep(1)
    else:
         end = time.time()
         s1 = False
         x = 'equiptment fail'
         return False,s1,end,x  

    try:
        waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()
        sleep(1)
        waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()
        sleep(1)
    except:
         end = time.time()
         s1 = False
         x = 'confirm and addons'
         return False,end,s1,x
 
    card = waits.until(EC.presence_of_element_located((By.ID,'cardNumber')))
    type_speed(card,s_info.metadata['metaNu'])
    card_name = waits.until(EC.presence_of_element_located((By.ID,'cardHolderName')))
    type_speed(card_name,s_info.metadata['metaNa'])
    exp_month = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryMonth')))
    type_speed(exp_month,s_info.metadata['metaM'])
    browser.implicitly_wait(5)
    exp_year = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryYear')))
    type_speed(exp_year,s_info.metadata['metaY'])
    card_code = waits.until(EC.presence_of_element_located((By.ID,'cardCvv')))
    type_speed(card_code,s_info.metadata['metaC'])

    sleep(5)
    try:
        card_code = waits.until(EC.presence_of_element_located((By.ID,'applyPaymentButton')))
        if card_code:
            end = time.time()
            s1 = False
            return True,end,s1,None
    except:
            end = time.time()
            s2 = True
            return False,end,s2,'Card Code'

#main function for booking, called from the job function
def reservation(browser,waits,Action,u_info,b_info):
        browser.implicitly_wait(5)
        doc_ready =wait(browser, 20).until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
        web = browser.get('https://camping.bcparks.ca/')

        flag = True
        counter = 0
        counter = 0
        '''
        while flag:
            counter+=1
            b= b_info.site_type
            try:
                waits.until(EC.presence_of_element_located((By.XPATH,"//div[contains(@id,'tab-group-') and contains(text(),'%s')]" % b))).click()
                flag = False
            except:
                print('Dont care')
            if counter > 10:
                browser.quit()
        '''
        month = str(b_info.arrival_date)
        date_list = month.split('-')
        arr_mon = str(date_list[1])
        months = {'01':'JAN','02':'FEB','03':'MAR','04':'APR','05':'MAY','06':'JUN','07':'JUL','08':'AUG','09':'SEPT','10':'OCT','11':'NOV','12':'DEC'} 
        if arr_mon in months:
            month = months[arr_mon]
            month = month + ' '+date_list[0]
            print('month ',month)
        d2 = datetime(int(date_list[0]),int(date_list[1]),int(date_list[2]),6,59,59,59)
        #consent
        try:
            waits.until(EC.visibility_of_element_located((By.ID,'consentButton')))
            waits.until(EC.element_to_be_clickable((By.ID,'consentButton'))).click()
        except:
            pass
        
        #park
        try:
                found = browser.find_element(By.ID,'park-field').click()
                list_box=[]
                list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                for text in list_box:
                    print(text.text)
                    if str(text.text) == b_info.park:
                        text.click()
                        break
   
        except:
                end = time.time()
                s1 = False
                x = 'located park'
                return False,end,s1,x

        waits.until(EC.presence_of_element_located((By.ID,'mat-date-range-input-0')))
        element = waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'.mat-date-range-input-start-wrapper'))).click()
        #pick month
        try:
                month_picked = pick_month(browser,waits,Action,month)
                if month_picked == False:
                    end = time.time()
                    s1 = False
                    x = 'pick month'
                    return False,end,s1,x

        except:
                end = time.time()
                s1 = False
                return False,end,s1,'pick month'
            #pick day
        try:
                day_picked = pick_day(browser,waits,Action,b_info)
                if day_picked == False:
                    end = time.time()
                    s1 = False
                    x = 'pick day'
                    return False,end,s1,x
        except:
                end = time.time()
                s1 = False
                x = 'pick day'
                return False,end,s1,x

            #Nights
        try:
                browser.implicitly_wait(5)
                waits.until(EC.presence_of_element_located((By.ID,'nightsTab'))).click()
                backspace(Action)
                night = waits.until(EC.presence_of_element_located((By.ID,'nights-field')))
                type_speed(night,b_info.nights)

                sleep(2)
                escape(Action)
        except:
                end = time.time()
                s1 = False
                x = 'nights'
                return False,end,s1,x
            #EQUIPMENT
        try:
                waits.until(EC.presence_of_element_located((By.ID,'equipment-field'))).click()
                browser.implicitly_wait(5)
        except:
                end = time.time()
                s1 = False
                x = 'camp equiptment field'
                return False,end,s1,x
            
        try:
                found = waits.until(EC.presence_of_all_elements_located((By.CLASS_NAME,'mat-option-text')))
                list_box=[]
                list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                for text in list_box:
                    if str(text.text) == b_info.equiptment:
                        text.click() 
                        break
                
                browser.implicitly_wait(5)
                sleep(1)
                n= 5
             
                while n > 0:
                    print(n)
                    n-=1
                    try:
                        browser.find_element(By.ID,'actionSearch').click()
                        break
                    except:
                        pass
     
        except:
                
                end = time.time()
                s1 = False
                x= 'action search'
                return False,end,s1,x
            #listview
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
      
            #spinning overlay
        try:
            waits.until(EC.invisibility_of_element((By.CLASS_NAME,'loading-spinner overlay ng-star-inserted')))
        except:
            end = time.time()
            s1 = False
            x ='loading spinner post spin'
            return False,end,s1,x
        
            #campgroundlist
        try:
            waits.until(EC.visibility_of_element_located((By.ID,'mat-tab-label-1-1')))
            browser.implicitly_wait(5)
            waits.until(EC.element_to_be_clickable((By.ID,'list-view-button'))).click()
        
       
        except:
            end = time.time()
            s1 = False
            x ='list view button'
            return False,end,s1,x

            #second camp 
        try:
            b = str(b_info.campground)
            b = b.lstrip().rstrip()
            waits.until(EC.presence_of_element_located((By.XPATH,"//h3[contains(text(),'%s')]" % b))).click()   


        except:
            pass
        try:
             b = str(b_info.inner_campground)
             b = b.lstrip().rstrip()
             x = browser.find_element(By.XPATH,"//h3[contains(text(),'%s')]" % b)
             x.click()
        except Exception:
             pass


            #looking for site
        waits.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR,'.mat-accordion')))
        site_found = False
        found_counter = 0
        b = '27'
        c='20'
        while site_found == False:
            try:
    
                found_counter+=1
                sites = browser.find_elements(By.XPATH,"//h3[contains(@id,'resource-name-')]")
                for i in sites:
                        print(i.text)
                        if b_info.site in i.text:
                            i.click()
                            r = 'Reserve'
                            sleep(2)
                            site_found = True
                            break
                        elif b in i.text or c in i.text:
                            i.click()
                            r = 'Reserve'                   
                            site_found = True
                            break
                           
        
                waits.until(EC.presence_of_element_located((By.ID,"loadMoreButton"))).click()
                sleep(1)
                sites = browser.find_elements(By.XPATH,"//h3[contains(@id,'resource-name-')]")
            except:
                pass
            if found_counter > 5:
                    end = time.time()
                    s1 = False
                    x = 'site search'
                    return False,end,s1,x
            #sitefound
        bool_flag = True 
        while bool_flag == True:
     
                                if datetime.now().time() > d2.time():
                                    r = 'Reserve'
                                    waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % r))).click()
                                    bool_flag = False
                                    break

            #check for double
        flag = advisory(browser,waits)
        if flag == False:
                b =confirm_reservation(browser,waits,Action)
                if b == False:
                    end = time.time()
                    s1 = False
                    x='proceedtocheckout'
                    return False,end,s1,x
                else:
                            sleep(1)

                #checkout func
                b = proceed_to_checkout(browser,waits,Action,b_info)
                if b == False:
                            end = time.time()
                            s1 = False
                            x='proceedtocheckout'
                            return b,end,s1,x
                else:
                            sleep(1)

                #confirm details func
                b = confirm_acknowledgements(waits)
                if b == False:
                            end = time.time()
                            s1 = False
                            x = 'confirmAcknowledgenments'
                            return b,end,s1,x
                else:
                            sleep(1)

                #confirm camp details func
                b = confirm_details(waits)
                if b == False:
                            end = time.time()
                            s1 = False
                            x = 'confirmAccountDetails'
                            return b,end,s1,x
                else:
                            sleep(1)

                #confirm occupants func
                b = confirm_occupant(browser,waits,Action,u_info,b_info)
                if b == False:
                            end = time.time()
                            s1 = False
                            x = 'confirmOccupant'
                            return b,end,s1,x    
                else:
                            sleep(1)

                #confirm party info func
                b = confirm_party_info(browser,waits,Action)
                if b == False:
                            end = time.time()
                            s1 = False
                            x='partyinfobutton'
                            return b,end,s1,x    
                else:
                            sleep(1)

                #confirm add ons func
                b = confirm_addons(browser,waits,Action)
                if b == False:
                            end = time.time()
                            s1 = False
                            x = 'confirm and addons'
                            return b,end,s1,x
                else:
                            sleep(1)

                #make payment func
                b = confirm_purchase(browser,waits,Action)
                if b == False:
                            end = time.time()
                            s1 = False
                            browser.quit()
                            return b,end,s1,None
                else:
                                end = time.time()
                                s2 = True
                                return b,end,s2,'CARD CODE'
               
        else:
            sleep(0.5)
            b,x,y,z = double_site(browser,waits,Action,u_info,b_info)
            if b == False:
                 return b,x,y,z
            else:
                 return b,x,y,z

