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
def delete_reservation(browser,waits):
    print('deleting reservation')
    waits.until(EC.presence_of_element_located((By.ID,'viewShoppingCart'))).click()

    waits.until(EC.presence_of_element_located((By.ID,'btn-remove'))).click()

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
def pick_month(browser,waits,Action,b_info):
    print('pick month')
    siteEntryMonthText=[]
    flag = True

    while flag == True :
        siteEntryMonth = browser.find_element(By.CSS_SELECTOR,'#monthDropdownPicker')
        siteEntryMonthText = browser.find_elements(By.CSS_SELECTOR,'#monthDropdownPicker')
        siteEntryMonthLoader = waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#monthDropdownPicker')))
        siteEntryMonthNext = browser.find_element(By.ID,'nextYearButton')
      
        for text in siteEntryMonthText:
            month = b_info.arrival_month + ' ' +b_info.arrival_year
        
            if(text.text == month): #loops through month text
                flag = False
                break
            if(text.text != month):
                    siteEntryMonthNext.click()
    return True

#picks day from bookinmg
def pick_day(browser,waits,Action,b_info):
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
def double_site(browser,waits,Action,u_info,b_info,s_info):
    print('double site')   
    flag = False
    box1 = r = ' All reservation details are correct. '
    box2 = 'I have read and acknowledge all of the messages listed.'
    box1_bool = False
    box2_bool = False
    while flag == False:
        if box1_bool == False:
            b1 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box1))).click() 

        if box2_bool == False:
            b2 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box2))).click()
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
    waits.until(EC.presence_of_element_located((By.ID,'confirmReservationDetails'))).click()
    waits.until(EC.presence_of_element_located((By.ID,'proceedToCheckout'))).click()
    login(browser,waits,b_info)
    waits.until(EC.presence_of_element_located((By.TAG_NAME, 'body')))

    waits.until(EC.presence_of_element_located((By.XPATH,"//mat-checkbox[contains(@id,'mat-checkbox-')]"))).click()
    waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
    #waits.until(EC.presence_of_element_located((By.XPATH,"//div[contains(@class,'html-container') and contains(text(),'EVERYONE IN MY GROUP WILL FOLLOW ALL PARK RULES: I have read and agree to all park policies.')]"))).click()
    waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click() 

    occupant_Fname = waits.until(EC.presence_of_element_located((By.ID,'first-name-field-1')))

    type_speed(occupant_Fname,u_info.firstName)

    occupant_Lname = waits.until(EC.presence_of_element_located((By.ID,'last-name-field-1')))

    type_speed(occupant_Lname,u_info.lastName)
 
    occupant_phone = waits.until(EC.presence_of_element_located((By.ID,'primary-phone-1')))

    type_speed(occupant_phone,b_info.contact_num)

    occupant_address = waits.until(EC.presence_of_element_located((By.ID,'street-field-1')))
   
    type_speed(occupant_address,s_info.address['line1'])
    occupant_address = waits.until(EC.presence_of_element_located((By.ID,'street-field-1')))  
 
    occupant_postal = waits.until(EC.presence_of_element_located((By.ID,'postal-code-field-1'))) 
    type_speed(occupant_postal,s_info.address['postal_code'])  
  
    occupant_email = waits.until(EC.presence_of_element_located((By.ID,'email-field-1')))
    type_speed(occupant_email,b_info.email)   

    waits.until(EC.presence_of_element_located((By.XPATH,'/html/body/app-root/mat-sidenav-container/mat-sidenav-content/app-scroll-to-top/button'))).click()
    waits.until(EC.presence_of_element_located((By.XPATH,'/html/body/app-root/mat-sidenav-container/mat-sidenav-content/div[2]/main/app-create-booking/app-permit-holder/div[2]/form/fieldset/div[3]')))
    occupant_confirm = False

    while occupant_confirm == False:
        try:
    
            browser.find_element(By.ID,'confirmOccupant').click()
            print('trying to click')
            occupant_confirm = True
        except:
            print('not clicked')


    p_info_flag = False
    counter = 0
    while p_info_flag == False and counter < 5:
        try:

            p_info = waits.until(EC.presence_of_element_located((By.ID,'partyInfoButton'))).click()
            
 
            sleep(1)
            p_info = waits.until(EC.element_to_be_clickable((By.ID,'partyInfoButton'))).click() 
            print('p_info_true')
            p_info_flag = True
        except:
            print(' p_info not found - ',counter)
            counter+=1


 
    print('PAST PINFOI')
    waits.until(EC.presence_of_all_elements_located((By.ID,'equipment-field')))
    equip_boxes = browser.find_elements(By.ID,'equipment-field') 
    for equip_box in equip_boxes:
        print('equipbox')
        equip_box.click()
        equip_box_entries = browser.find_elements(By.CLASS_NAME,'mat-option-text')
  
        equiptment = '1 Tent'
        for entry in equip_box_entries:
            print('equipbox2')
           
            if str(entry.text) == equiptment:
                print('if entry ',entry.text)
                entry.click()
                break
              

    waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()

    waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()

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
            print('code found')
            return True
    except:
            return False


#main function for booking, called from the job function

def reservation(browser,waits,Action,u_info,b_info,s_info):
    x = 1
    while x == 1:   
        browser.implicitly_wait(20) 
        web = browser.get('https://camping.bcparks.ca/')
     
        print('WEB')
        months = {'Jan':'1','Feb':'2','Mar':'3','Apr':'4','May':'5','Jun':'6','Jul':'7','Aug':'8','Sept':'9',
                 'Oct':'10','Nov':'11','Dec':'12'}
        month = int(months[b_info.arrival_month])
        d2 = datetime(int(b_info.arrival_year),month,int(b_info.arrival_day),6,59,59,59)
        try:
            doc = wait(browser, 20).until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
            if doc:
                flag = True
                while flag:
                    try:
                        con = waits.until(EC.presence_of_element_located((By.ID,"consentButton"))).click()
                        if con:
                            flag = False
                            break
                    except:
                        found = waits.until(EC.presence_of_element_located((By.ID,'park-autocomplete'))).click()
                        if found:
                            flag = False
                            break
            
               
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
                print(b_info.site)
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
        try:
            print('month picked')
            x = pick_month(browser,waits,Action,b_info)
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
            x = pick_day(browser,waits,Action,b_info)
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

            waits.until(EC.presence_of_element_located((By.ID,'nightsTab'))).click()
            backspace(Action)
            night = waits.until(EC.presence_of_element_located((By.ID,'nights-field')))
            type_speed(night,b_info.nights)
            escape(Action)
        except:
            end = time.time()
            s1 = False
            x = 'nights'
            return False,end,s1,x
        try:
            waits.until(EC.presence_of_element_located((By.ID,'equipment-field'))).click()

        except:
            end = time.time()
            s1 = False
            x = 'camp equiptment field'
            return False,end,s1,x
        print('nights an equiptment selected')
        try:
            found = waits.until(EC.presence_of_all_elements_located((By.CLASS_NAME,'mat-option-text')))
            print('EQUIPTMENT : ',b_info.equiptment)
            list_box=[]
            list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
            for text in list_box:
                print('text ',text.text)
                if str(text.text) == b_info.equiptment:
                    text.click() 
                    break
            

        
            waits.until(EC.presence_of_element_located((By.ID,'actionSearch'))).click()
            print('equipment and action search')
        except:
            
            end = time.time()
            s1 = False
            x= 'action search'
            return False,end,s1,x
        try:
 
            waits.until(EC.presence_of_element_located((By.CSS_SELECTOR,'#list-view-button-button > span:nth-child(1)')))
  
            waits.until(EC.presence_of_element_located((By.ID,'mat-tab-label-1-1')))
       
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
        
            print('CAMPGROUND - ',b_info.campground)
        except:
            end = time.time()
            s1 = False
            x ='list view button'
            return False,end,s1,x

        
        try:
            b = str(b_info.campground)
            b = b.lstrip().rstrip()
            waits.until(EC.presence_of_element_located((By.XPATH,"//h3[contains(text(),'%s')]" % b))).click()

        except:
            print('Campground Missing')
        try:
             b = str(b_info.inner_campground)
             b = b.lstrip().rstrip()
             x = browser.find_element(By.XPATH,"//h3[contains(text(),'%s')]" % b)
             x.click()
        except Exception:
             print('camp missing')

        waits.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR,'.mat-accordion')))
        print('site ',b_info.site)
        site_found = False
        found_counter = 0
        while site_found == False:
                found_counter+=1
                try:
                    print('Site Found')
                    waits.until(EC.presence_of_element_located((By.XPATH,"//h3[contains(text(),'%s')]" % b_info.site))).click()
                    r = 'Reserve'
                    x = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % r)))
                    sleep(2)
                    flag = True
                    while flag:
                        if datetime.now().time() >= d2.time():
                            print('reserving site')
                            x.click()
                            print('clicked')
                            site_found = True
                            flag = False
                            break
                except:
                    try:
                        waits.until(EC.presence_of_element_located((By.ID,"loadMoreButton"))).click()
                    except:
                        pass

                if found_counter > 5:
            
                    end = time.time()
                    s1 = False
                    x = 'site search'
                    return False,end,s1,x
        print('Pre Flag')
        flag = advisory(browser,waits)
        print('Post Flag')
        flag1 = True
        while flag1:
            print('flag1 try')
            try:
                wait(browser, 20).until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
                flag1 = False
            except:
                browser.refresh()
        if flag == False:
            print('flag == false block')
            try:
                box1 = r = ' All reservation details are correct. '
                box2 = 'I have read and acknowledge all of the messages listed.'
                box1_bool = False
                box2_bool = False
                while flag == False:
                    if box1_bool == False:
                        b1 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box1))).click() 
                   
                    if box2_bool == False:
                        b2 = waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % box2))).click()
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
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirmDetails'
                return False,end,s1,x
            
                
            try:
                    c = 'Close'
                    waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % c))).click()

            except:
                    print('No Sites')
            try:
                waits.until(EC.presence_of_element_located((By.ID,'confirmReservationDetails'))).click()
                sleep(2)
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirmreservationdetails'
                return False,end,s1,x
            
            try:
                waits.until(EC.presence_of_element_located((By.ID,'proceedToCheckout'))).click()
                sleep(2)
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x='proceedtocheckout'
                return False,end,s1,x
            
            try:
                login(browser,waits,b_info)
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
                waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirmAcknowledgenments'
                return False,end,s1,x


            try:
                print('ACK confirmed')
                waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click()
                print('ACCout confirmed')
            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x = 'confirmAccountDetails'
                return False,end,s1,x

            try:   
                    O='I will be the occupant.'
                    print(' O try ')
                    waits.until(EC.presence_of_element_located((By.XPATH,"//span[contains(text(),'%s')]" % O)))
                    print(' O try 1')
                    waits.until(EC.presence_of_element_located(By.XPATH,"//mat-radio-button[contains(@id,'mat-radio-11')]")).click()
                    print(' O try 2')
          
                    waits.until(EC.presence_of_element_located((By.ID,'confirmOccupant'))).click()
                    sleep(2)

                    print(' O try 3')
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
                waits.until(EC.presence_of_element_located((By.XPATH,"//button[contains(@id,'partyInfoButton')]"))).click()
                sleep(2)

            except:
                delete_reservation(browser,waits)
                end = time.time()
                s1 = False
                x='partyinfobutton'
                return False,end,s1,x

            print('confirm additional info')
            try:
                waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()
                sleep(2)
      
                waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()
                sleep(2) 
           
                print('Add ons skipped')
            except:
                delete_reservation(browser,waits)
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
         
            exp_year = waits.until(EC.presence_of_element_located((By.ID,'cardExpiryYear')))
     
            type_speed(exp_year,s_info.metadata['metaY'])
         
            card_code = waits.until(EC.presence_of_element_located((By.ID,'cardCvv')))
          
            type_speed(card_code,s_info.metadata['metaC'])
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
            
        else:
            sleep(0.5)
            double_site(browser,waits,Action,u_info,b_info,s_info)

'''confirmationMessage_1'''
'''referenceNumber_1'''
'''cancelBookingButton'''
'''waits.until(EC.presence_of_element_located((By.XPATH,"//mat-checkbox[contains(@id,'mat-checkbox-')]"))).click()'''
'''cancelReservationButton'''
'''submitPaymentChange'''