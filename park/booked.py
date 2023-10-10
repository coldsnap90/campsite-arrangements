import time
from datetime import datetime
from time import sleep
from park.booking import *
from selenium.webdriver.common.actions.interaction import KEY
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait as wait
import time
import threading

##frequently updating



def advisory(browser,waits):
    '''checks to see if the site is a double site or not'''
    try:
         browser.find_element(By.ID,'message')
         waits.until(EC.presence_of_element_located((By.ID,'message')))
         t= 'This is part of a Double Site'
         waits.until(EC.presence_of_element_located\
                     ((By.XPATH,"//h2[contains(@id,'mat-dialog-title-') and contains(text(),'%s')]" % t)))
         element = browser.find_element(By.ID,'confirmButton')
         waits.until(EC.presence_of_element_located((By.ID,'confirmButton')))
         element.click()
         return True
    except:
          return False


def confirm_reservation(browser,waits,Action):
    '''navigates initial reservation page'''
    flag1 = True
    while flag1 == True:
            try:
                waits.until(lambda browser: browser.execute_script\
                            ('return document.readyState') == 'complete')
                flag1 = False
                print('break')
                break
            except:
                browser.refresh()

    flag = False
    while flag == False:
            try:
                box1  = 'All reservation details are correct.'
                box1_bool = False
                counter = 0
                while flag == False:

                        counter+=1
                        b1 = waits.until(EC.presence_of_element_located\
                                         ((By.XPATH,"//span[contains(text(),'%s')]" % box1))).click() 
                        flag = True

                        if counter > 5:
                            browser.refresh()

                        if counter > 10:
                            browser.quit()
            except:
                return False
               
            try:
                    c = 'Close'
                    waits.until(EC.presence_of_element_located\
                                ((By.XPATH,"//span[contains(text(),'%s')]" % c))).click()
    
            except:
                    pass
            
            try:
                waits.until(EC.presence_of_element_located\
                            ((By.ID,'confirmReservationDetails'))).click()
                sleep(2)
                return True
            
            except:
                return False
            

def proceed_to_checkout(browser,waits,Action,b_info):
    '''navigates checkpout page and logs into account'''
    counter = 10
    while counter > 0:
                
                try:
                    waits.until(EC.presence_of_element_located((By.ID,'proceedToCheckout'))).click()
                    sleep(2)
                    break
                except:
                     counter-=1
    if counter == 0:
                return False       

    flag = login(browser,waits,b_info)
    sleep(1)

    if flag == True:
        return True


def confirm_acknowledgements(waits):
    '''navigfates acknowledgements page'''
    try:
        waits.until(lambda browser: browser.execute_script\
                    ('return document.readyState') == 'complete')
    except:
         pass
    
    counter = 10
    while counter > 0:
        try:
            sleep(1)
            waits.until(EC.presence_of_element_located\
                        ((By.XPATH,"//mat-checkbox[contains(@id,'mat-checkbox-')]"))).click()
            break   
        except:
            counter-=1

    if counter == 0:
        return False
        
    sleep(1) 
    counter = 10
    while counter > 0:    
        try:
            waits.until(EC.element_to_be_clickable\
                        ((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
            return True
        except:
            counter-=1

    if counter == 0:
         return False
            

def confirm_details(waits):
    '''navigates the details page'''
    try:
        waits.until(EC.element_to_be_clickable\
                    ((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click()
        return True
    except:
        return False


def occupant(browser,waits,Action,b_info,field):
    '''navigates occupant page and enters in extra occupant info'''

    occupant_Fname = waits.until(EC.presence_of_element_located\
                                 ((By.XPATH,f"//input[@id='first-name-field-{field}']")))
    type_speed(occupant_Fname,b_info.occupant_first_name)
    occupant_Lname = waits.until(EC.presence_of_element_located\
                                 (( By.XPATH,f"//input[@id='last-name-field-{field}']")))
    type_speed(occupant_Lname,b_info.occupant_last_name)
    occupant_phone = waits.until(EC.presence_of_element_located\
                                 (( By.XPATH,f"//input[@id='primary-phone-{field}']")))
    type_speed(occupant_phone,b_info.occupant_phone_num)

    occupant_address = waits.until(EC.presence_of_element_located\
                                           (( By.XPATH,f"//input[@id='street-field-{field}']")))    
    type_speed(occupant_address,b_info.occupant_address)
        
    occupant_postal = waits.until(EC.presence_of_element_located\
                                          (( By.XPATH,f"//input[@id='postal-code-field-{field}']"))) 
    type_speed(occupant_postal,b_info.occupant_postal_code) 
    waits.until(EC.presence_of_element_located((By.ID,'confirmOccupant')))

    sleep(2)
    counter = 10
    while counter > 0:
        sleep(0.5)
        try:
            element = browser.find_element(By.ID,'confirmOccupant').click()
            next_page = browser.find_element(By.ID,'partyInfoButton').is_displayed()

            if next_page == True:
                return True
        
        except:
                counter-=1
               
    if counter == 0:
         return False

    
def confirm_reservation(browser,waits,Action):
    '''navigates initial reservation page'''
    flag1 = True
    while flag1 == True:
            
            try:
                waits.until(lambda browser: browser.execute_script('return document.readyState') == 'complete')
                break
            except:
                browser.refresh()

    flag = False
    while flag == False:
            
            try:
                box1  = 'All reservation details are correct.'
                box1_bool = False
                counter = 0

                while flag == False:
                        counter+=1
                        b1 = waits.until(EC.presence_of_element_located\
                                         ((By.XPATH,"//span[contains(text(),'%s')]" % box1))).click() 
                        flag = True

               
                        if counter > 5:
                            browser.refresh()
                        if counter > 10:
                            browser.quit()
            except:
                return False
               
                
            try:
                    c = 'Close'
                    waits.until(EC.presence_of_element_located\
                                ((By.XPATH,"//span[contains(text(),'%s')]" % c))).click()
            except:
                    pass

            try:
                waits.until(EC.presence_of_element_located((By.ID,'confirmReservationDetails'))).click()
                sleep(2)
                return True
            except:
                return False
            

def review_double_policy(browser,waits):
    sleep(0.5)
    counter = 15
    while counter > 0:
        counter-=1
        mat_checkbox = browser.find_elements(By.XPATH,"//mat-checkbox[starts-with(@id, 'mat-checkbox-')]")
        flag = False
        for element in mat_checkbox:
            if flag == False:

                try:
                    element.click()
                    counter = 0
                    break
                except:
                    pass
    
    try:
        waits.until(EC.element_to_be_clickable\
                    ((By.XPATH,"//button[contains(@id,'confirmAcknowledgements')]"))).click()
      
        return True
    except:
        x = browser.find_element(By.ID,'confirmAcknowledgements').click()
        if x :
             return True
   
        return False


def confirm_double_information(browser,waits,action,b_info):
    elements = browser.find_elements(By.ID,'equipment-field')
    elements[1].click()
    found = waits.until(EC.presence_of_all_elements_located\
                                    ((By.CLASS_NAME,'mat-option-text')))
    flag = False
    list_box=[]
    list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
    for text in list_box:
        if str(text.text) == b_info.equiptment:
            text.click()
            flag = True 
            break

    if flag == True:       
        return True
    
    else:
        return False
        

def confirm_details(waits):
    '''navigates the details page'''
    try:
        waits.until(EC.element_to_be_clickable\
                    ((By.XPATH,"//button[contains(@id,'confirmAccountDetails')]"))).click()
        return True
    except:
        return False
    

def confirm_occupant(browser,waits,Action,u_info,b_info,field):
    '''navigates the occupants page'''
    Occupant ='Someone else will be the occupant.'
    counter = 10

    if field == '0':
        while counter > 0:
            try:
                waits.until(EC.presence_of_element_located\
                                    ((By.XPATH,"//span[contains(text(),'%s')]" % Occupant))).click()
                break
            except:
                 counter-=1
         

    counter = 10
    if b_info.occupant == True:
       flag = occupant(browser,waits,Action,b_info,field)

    sleep(2)

    if flag == False:
        element = browser.find_element(By.ID,'confirmOccupant').click()
        return True
    
    else:
        print('return true from occuapnt')
        return True         
        
                            

def confirm_party_info(browser,waits,Action,double):
    '''navigates the party info page'''
    counter = 10
    if double == False:
    
        while counter > 0:
            try:
                browser.find_element(By.XPATH,"//input[contains(@id,'subCat-0')]").click()
                backspace(Action)
                sleep(0.05)
                browser.find_element(By.XPATH,"//input[contains(@id,'subCat-0')]").send_keys('2')
                escape(Action)
                break

            except:
                counter -=1
    else:

        while counter > 0:
            try:
                browser.find_element(By.XPATH,"//input[contains(@id,'partySize-field-0-subCat-0')]").click()
                backspace(Action)
                sleep(0.05)
                browser.find_element(By.XPATH,"//input[contains(@id,'partySize-field-0-subCat-0')]").send_keys('2')
                escape(Action)
                break

            except:
                counter -=1

        sleep(1)
        while counter > 0:
            try:
                browser.find_element(By.XPATH,"//input[contains(@id,'partySize-field-1-subCat-0')]").click()
                backspace(Action)
                sleep(0.05)
                browser.find_element(By.XPATH,"//input[contains(@id,'partySize-field-1-subCat-0')]").send_keys('2')
                escape(Action)
                break
            except:
                counter -=1
         
    sleep(1)
    counter = 10
    while counter > 0:
        try:
            waits.until(EC.presence_of_element_located((By.ID,'partyInfoButton')))
            element = browser.find_element(By.ID,'partyInfoButton').click()
            sleep(2)
            return True
        except:
            counter-=1

    return False


def confirm_double_addons(waits):
    counter = 10
    while counter > 0:
        try:
            waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()
            break
        except:
            counter-=1

    counter = 10
    sleep(0.5)
    while counter > 0:
        try:
            waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()
            break
        except:
            counter-=1

    if counter > 0:
          return True
    else:
        return False
          
          
#@profile(stream=fp)
def confirm_addons(waits):
    '''navigates the confirm addons page'''
    counter = 10
    while counter > 0: 
        try:
            waits.until(EC.presence_of_element_located((By.ID,'confirmAdditionalInformation'))).click()
            sleep(1)
            break
        except:
            counter-=1

    if counter == 0:
         return False
    
    sleep(1)
    counter = 10
    while counter > 0:
        try:
             waits.until(EC.presence_of_element_located((By.ID,'addOnsOptions'))).click()
             sleep(1)
             return True
        except:
            sleep(1)
            counter -=1
            
    if counter == 0:
         return False
    

def confirm_purchases(browser,waits,Action,s_info):
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
                    card_code = waits.until(EC.presence_of_element_located\
                                            ((By.ID,'applyPaymentButton')))
                    browser.quit()
                    card_codes = True
                    if card_codes:
                        return True
                 
                    else:
                        browser.quit()
                        return False
                except:
                    print('Not found')


def double_site(browser,waits,Action,u_info,b_info):
    '''books double campsites'''
    b =confirm_reservation(browser,waits,Action)
    if b == False:
        end = time.time()
        s1 = False
        x='confirm rez'
        return False,end,s1,x
    else:
        sleep(1)

    b = proceed_to_checkout(browser,waits,Action,b_info)
    if b == False:
        end = time.time()
        s1 = False
        x='proceed to checkout'
        return False,end,s1,x
    else:
        sleep(1)
 
    b = review_double_policy(browser,waits)
    if b == False:
        print('PTC FALSE')
        end = time.time()
        s1 = False
        x='review-double-policy'
        return b,end,s1,x
    else:
        sleep(1)

    b = confirm_details(waits)
    if b == False:
        print('cd False')
        end = time.time()
        s1 = False
        x = 'confirmAccountDetails'
        return b,end,s1,x
    else:
        sleep(1)


    b = confirm_occupant(browser,waits,Action,u_info,b_info,'1')
    if b == False:
        end = time.time()
        s1 = False
        x = 'confirmOccupant'
        return b,end,s1,x    
    else:
        sleep(1)

    b = confirm_party_info(browser,waits,Action,True)
    if b == False:
        end = time.time()
        s1 = False
        x='partyinfobutton'
        return b,end,s1,x    
    else:
        sleep(1)

    #confirm add ons func
    b = confirm_double_information(browser,waits,Action,b_info)
    if b == False:
        end = time.time()
        s1 = False
        x = 'confirm double information'
        return b,end,s1,x
    else:
        sleep(1)

    b = confirm_double_addons(waits)
    if b == False:
        end = time.time()
        s1 = False
        x = 'confirm and addons'
        return b,end,s1,x
    else:
        sleep(1)


def removed(browser,waits):
    try:
         browser.find_element(By.ID,'message')
         waits.until(EC.presence_of_element_located((By.ID,'message')))
         t= 'Remove from cart?'
         waits.until(EC.presence_of_element_located\
                     ((By.XPATH,"//h2[contains(@id,'mat-dialog-title-0') and contains(text(),'%s')]" % t)))
         element = browser.find_element(By.ID,'confirmButton')
         waits.until(EC.presence_of_element_located((By.ID,'confirmButton')))
         element.click()
         return True
    except:
         return False
    
#@profile(stream=fp)
def no_sites(browser,waits):
    '''checks to see if site is missing'''
    flag = False

    try:
        if waits.until(EC.presence_of_element_located\
                       ((By.CSS_SELECTOR,'.expansion-details > h2:nth-child(1)'))):

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
    '''deletes some inputs'''
    Action.key_down(Keys.BACKSPACE).perform()
    Action.key_up(Keys.BACKSPACE).perform()

def pick_month(browser,waits,month):
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
            print('finding')
            x = browser.find_element(By.CLASS_NAME,'mat-calendar-body-label').text
            if x != date_list[1]:
                 siteEntryMonthNext.click()
            elif x == date_list[1]:
                flag = True
                r=date_list[0].upper()
                waits.until(EC.presence_of_element_located\
                            ((By.XPATH,"//div[contains(text(),'%s')]" % r))).click()
                break
        except:
            pass
    return True


def pick_day(browser,waits,Action,day):
    '''checks for day of request bookinf and clicks it'''
    flag = True
    siteEntryDateText=[]
    while flag == True :
        siteEntryDateText = browser.find_elements\
            (By.CSS_SELECTOR,'.mat-calendar-body > tr > td')
        waits.until(EC.presence_of_element_located\
                    ((By.CSS_SELECTOR,'.mat-calendar-body > tr > td')))
        counter = 0

        for date in siteEntryDateText:
            counter+=1
            if counter > 31:
                flag = False
                return False
            
            if(date.text == day):
                date.click()
                flag = False
                break
            
    escape(Action)
    sleep(0.5)
    return True


def login(browser,waits,b_info):
    '''logs in BC parks account'''
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
    b = 'Sign In'
    waits.until(EC.presence_of_element_located\
                ((By.XPATH,"//div[contains(@class,'button-contents') and contains(text(),'%s')]" % b))).click() 
    return True  
 


def reservation(browser,waits,Action,u_info,b_info,s_info):

        def mytimer():
            '''threading func to close down browser after timeout'''
            sleep(600)
            try:
                browser.close()
            except:
    
                browser.quit()
        try:
            T = threading.Thread(target=mytimer)
            T.start()
        except:
             print('could not thread')

        browser.implicitly_wait(10)
        doc_ready =wait(browser, 20).until(lambda browser: browser.execute_script\
                                           ('return document.readyState') == 'complete')
        
        browser.get('https://camping.bcparks.ca/')
        flag = True
        sleep(1)
        month = str(b_info.arrival_date)
        date_list = month.split('-')
        day = str(int(date_list[2]))
        arr_mon = str(date_list[1])
        months = {'01':'JAN','02':'FEB','03':'MAR','04':'APR','05':'May',\
                  '06':'JUN','07':'JUL','08':'AUG','09':'SEP','10':'Oct','11':'Nov','12':'Dec'} 
        if arr_mon in months:
            month = months[arr_mon]
            month = month + ' '+date_list[0]

        d2 = datetime(int(date_list[0]),int(date_list[1]),int(date_list[2]),6,59,59,59)
  
        try:
            waits.until(EC.visibility_of_element_located((By.ID,'consentButton')))
            waits.until(EC.element_to_be_clickable((By.ID,'consentButton'))).click()
        except:
            print('skipped consent')
        counter = 0        

        try:
                list_box=[]
                idbox = browser.find_element(By.XPATH,"//input[contains(@id,'park-autocomplete')]").click()
                try:
                    found = browser.find_element(By.ID,'park-field').click()
                    list_box=[]
                    list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                    for text in list_box:
                     
                        if str(text.text) == b_info.park:
                            text.click()
                            break
                except:
                    list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                    for text in list_box:
                 
                        if str(text.text) == b_info.park:
                            text.click()
                        break
   
        except:
                counter+=1
                if counter > 5:
                    end = time.time()
                    s1 = False
                    x = 'located park'
                    return False,end,s1,x

        waits.until(EC.presence_of_element_located((By.ID,'mat-date-range-input-0')))
        element = waits.until(EC.presence_of_element_located\
                              ((By.CSS_SELECTOR,'.mat-date-range-input-start-wrapper'))).click()

        try:
                month_picked = pick_month(browser,waits,month)
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
                day_picked = pick_day(browser,waits,Action,day)
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
    
        try:
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
 
        try:
                waits.until(EC.presence_of_element_located((By.ID,'equipment-field'))).click()
        except:
                end = time.time()
                s1 = False
                x = 'camp equiptment field'
                return False,end,s1,x
            
        try:
                found = waits.until(EC.presence_of_all_elements_located\
                                    ((By.CLASS_NAME,'mat-option-text')))
                list_box=[]
                list_box = browser.find_elements(By.CLASS_NAME,'mat-option-text')
                for text in list_box:
                    if str(text.text) == b_info.equiptment:
                        text.click() 
                        break
                
                sleep(1)
                counter = 10
                while counter > 0:
                    print(counter)
                    
                    try:
                        browser.find_element(By.ID,'actionSearch').click()
                        break
                    except:
                        counter-=1
     
        except:
                end = time.time()
                s1 = False
                x= 'action search'
                return False,end,s1,x

        try:
                waits.until(EC.presence_of_element_located\
                            ((By.CSS_SELECTOR,'#list-view-button-button > span:nth-child(1)')))
                waits.until(EC.presence_of_element_located((By.ID,'mat-tab-label-1-1')))
        except:
                end = time.time()
                s1 = False
                x ='list view pre-spin'
                return False,end,s1,x
      

        try:
            waits.until(EC.invisibility_of_element\
                        ((By.CLASS_NAME,'loading-spinner overlay ng-star-inserted')))
        except:
            if waits.until(EC.visibility_of_element_located((By.ID,'mat-tab-label-1-1'))):
                 pass
            else:
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

        try:
            b = str(b_info.campground)
            b = b.lstrip().rstrip()
            waits.until(EC.presence_of_element_located\
                        ((By.XPATH,"//h3[contains(text(),'%s')]" % b))).click()   
        except:
            pass

        try:
             b = str(b_info.inner_campground)
             b = b.lstrip().rstrip()
             x = browser.find_element(By.XPATH,"//h3[contains(text(),'%s')]" % b)
             x.click()
        except Exception:
             pass


        waits.until(EC.presence_of_all_elements_located\
                    ((By.CSS_SELECTOR,'.mat-accordion')))
        site_found = False
        found_counter = 0
        while site_found == False:
                try:
                    found_counter+=1
                    sites = browser.find_elements(By.XPATH,"//h3[contains(@id,'resource-name-')]")

                    for i in sites:
                            
                            if b_info.site in i.text:
                                i.click()
                                r = 'Reserve'
                                sleep(2)
                                site_found = True
                                break

                            if b_info.site == 'any site':
                                i.click()
                                r = 'Reserve'
                                sleep(2)
                                site_found = True
                                break
                                      
                except:                        
                    waits.until(EC.presence_of_element_located\
                                ((By.ID,"loadMoreButton"))).click()
                    sleep(1)
          
                if found_counter > 5:
                        browser.close()
                        end = time.time()
                        s1 = False
                        x = 'site search'
                        return False,end,s1,x

        bool_flag = True 
        count = 0
        while bool_flag == True:
                                    if datetime.now().time() >= b_info.arrival_date:
                                        try:
                                            r = 'Reserve'
                                            waits.until(EC.presence_of_element_located\
                                                        ((By.XPATH,"//span[contains(text(),'%s')]" % r))).click()
                                            bool_flag = False
                                            
                                        except:
                                             count+=1

                                    if count == 5:
                                            end = time.time()
                                            s1 = False
                                            x='greater then 4 months booking time'
                                            return False,end,s1,x                                             
                                             

                #check for double
        flag = advisory(browser,waits)
        if flag == False:
                b =confirm_reservation(browser,waits,Action)
                if b == False:
                    end = time.time()
                    s1 = False
                    x='confirm rez'
                    return False,end,s1,x
                else:
                            sleep(1)

                b = proceed_to_checkout(browser,waits,Action,b_info)
                if b == False:
                            print('PTC FALSE')
                            end = time.time()
                            s1 = False
                            x='proceedtocheckout'
                            return b,end,s1,x
                else:
                            sleep(1)


                b = confirm_acknowledgements(waits)
                if b == False:
                            print('ca FAlse')
                            end = time.time()
                            s1 = False
                            x = 'confirmAcknowledgenments'
                            return b,end,s1,x
                else:
                            sleep(1)


                b = confirm_details(waits)
                if b == False:
                            print('cd False')
                            end = time.time()
                            s1 = False
                            x = 'confirmAccountDetails'
                            return b,end,s1,x
                else:
                            sleep(1)


                b = confirm_occupant(browser,waits,Action,u_info,b_info,'0')
                if b == False:
                            end = time.time()
                            s1 = False
                            x = 'confirmOccupant'
                            return b,end,s1,x    
                else:
                            sleep(1)


                b = confirm_party_info(browser,waits,Action,False)
                if b == False:
                            end = time.time()
                            s1 = False
                            x='partyinfobutton'
                            return b,end,s1,x    
                else:
                            sleep(1)

                b = confirm_addons(waits)
                if b == False:
                            end = time.time()
                            s1 = False
                            x = 'confirm and addons'
                            return b,end,s1,x
                else:
                            sleep(1)

                #make payment func
                #confirm_purchase(browser,waits,Action) for tim
              
        else:
            sleep(0.5) #s_info
            b,x,y,z = double_site(browser,waits,Action,u_info,b_info)
            if b == False:
                 return b,x,y,z
            else:
                 return b,x,y,z
            

