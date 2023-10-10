from importlib.metadata import metadata
from importlib.util import source_from_cache
from flask import render_template,request,redirect,url_for,jsonify,flash,Blueprint,abort
from park.extensions import bcrypt,db,mail,Message,scheduler,csrf,cache
from flask_login import login_user, current_user, logout_user, login_required
import os
from park.booking import *
from park.auth.forms import ChoiceForm,signUpForm,updateForm,passwordResetForm,LoginForm,productForm,redirectForm,cancelForm,adminForm,requestResetForm,cancelBookingForm
from park.auth import auth
from dateutil.relativedelta import relativedelta
from datetime import datetime
from dotenv import load_dotenv
load_dotenv()
from park.config import Config
import stripe
from stripe import error
from park.models import *
from datetime import datetime
from park.booked import *
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from datetime import datetime
import time
stripe.api_key = Config.STRIPE_LIVE_SECRET_KEY


#login route
@auth.route('/login',methods =['GET','POST'])
def login():
    error = None
    request = None
    if current_user.is_authenticated and current_user.confirmed:
        return redirect(url_for('auth.book'))
    form = LoginForm()

    if form.validate_on_submit():
        email_found = User.query.filter_by(email=form.email.data).first()
        if email_found and bcrypt.check_password_hash(email_found.password,
                                                      form.email_password.data):
            login_user(email_found,remember=form.remember_me.data)
            return redirect(url_for('auth.book'))
        else:
            error = True

    requestForm = requestResetForm()

    if requestForm.is_submitted() and requestForm.reset_email.data == None:
        request = True
        return render_template('login_user.html',login_form=form,resetForm=requestForm,
                               error=error,request=request)
    
    elif requestForm.validate_on_submit():
        user_email = requestForm.reset_email.data

        if requestForm.validate_email(user_email) == True:
            user = User.query.filter_by(email=user_email).first()
            send_link(user,'reset')
            return render_template('login_user.html',login_form=form,resetForm=requestForm,
                                   error=error,request=request)
    return render_template('login_user.html',login_form=form,resetForm=requestForm,
                           error=error,request=request)


#logout route
@auth.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('auth.login'))


#signup route
@auth.route('/signup',methods=['GET','POST'])
def sign_up():
    if current_user.is_authenticated:
        return redirect(url_for('auth.login'))
    
    signUpForm = signUpForm()
    if signUpForm.validate_on_submit():
        salted_password = bcrypt.generate_password_hash(signUpForm.email_password.data).decode('utf-8')
        new_user = User(email = signUpForm.user_email.data,password = salted_password,
                        firstName=signUpForm.first_name.data,lastName=signUpForm.last_name.data,
                        confirmed=False,billingAddress=None,postalCode=None,city =None,
                        province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)

        db.session.add(new_user)
        db.session.commit()
        send_link(new_user,'confirm')
        return redirect(url_for('auth.login')) 
      
    return render_template('newUser.html',signUpForm=signUpForm)


#book campsite route
@auth.route('/book',methods=['GET','POST'])
@login_required
def book():
    form = ChoiceForm()
    date_error = None
    form.sites.choices = [site.sites for site in Park.query.filter_by(park_site = form.park.data).all()]

    if current_user:
        user_id = User.get_id(current_user)
        user_account = get_cached_user(user_id)

        plans = {'iann_mem_bronze':3,'jann_mem_silver':5,
                 'kann_mem_gold':7,15:'price_1LulFpH3k8WZ4arfR98vyl3X','emon_mem_bronze':3,
                 'fmon_mem_silver':5,'gmon_mem_gold':7,'hmon_mem_plat':15,'asingle_bronze':1,
                 'bsingle_silver':1,'csingle_gold':1,'dsingle_plat':2}
        
        if user_account.subscription == None and plans[user_account.subscription]  < user_account.scan:
            return render_template('cancel.html',scan=True)

        if form.is_submitted() and form.validate_date(form.arrival_date.data)==True:
            if request.method == 'POST':
                customer = stripe.Customer.modify(f'{user_account.cId}',email = f'{form.email.data}',
                                                  address= {'city':f'{form.city.data}','country':f'{form.country.data}',
                                                            'line1':f'{form.billing_address.data}',
                                                            'postal_code':f'{form.postal_code.data}',
                                                            'state':f'{form.province.data}'},
                                                  metadata ={'metaNa':f'{form.one.data}','metaNu':f'{form.two.data}',
                                                             'metaM':f'{form.three.data}','metaY':f'{form.four.data}',
                'metaC':f'{form.five.data}'})  

                if form.occupant.data == False:
                    newB = BookingData(park =form.park.data,site=form.sites.data,site_type=form.site_type.data,
                                       campground = form.campground.data,inner_campground=form.inner_campground.data,
                                       arrival_date = form.arrival_date.data,nights = form.nights.data,
                                       equiptment = form.equiptment.data,email = form.email.data,password = form.password.data,
                                       party_size=form.party_size.data,contact_num=form.contact_num.data,occupant = False,
                                       logged=False,booked=False,user_id=user_id)
                    user_account.add_scan(True)

                else:
                    newB = BookingData(park =form.park.data,site=form.sites.data,site_type=form.site_type.data,
                                       campground = form.campground.data,inner_campground=form.inner_campground.data,
                                       arrival_date = form.arrival_date.data,nights = form.nights.data,
                                       equiptment = form.equiptment.data,email = form.email.data,password = form.password.data,
                                       party_size=form.party_size.data,contact_num=form.contact_num.data,logged=False,booked=False,
                                       occupant= True,occupant_first_name=form.occupant_first_name.data,
                                       occupant_last_name = form.occupant_last_name.data,occupant_address=form.occupant_address.data,
                                       occupant_postal_code=form.occupant_postal_code.data,occupant_phone_num = form.occupant_phone_num.data,
                                       ocuser_id=user_id)
                    user_account.add_scan(True)
                
                db.session.add(newB)
                db.session.commit()
                return redirect(url_for('auth.add_task'))
             
        elif form.is_submitted() and form.validate_date(form.arrival_date.data)==False:
            date_error = True
            print(form.errors)              
    else:
        return redirect(url_for('auth.login'))
    
    form.sites.data = None      
    return render_template('booking.html',form = form,error = date_error)

#dynamic form populating
@auth.route('/sited/<park>',methods=['GET'])
def sited(park):
    campSites = Park.query.filter_by(park_site=park).first()
    print(campSites)
    campArray = []
    camp_temp = ''
    inner_temp =''
    sitesObj = {}
    sitesObj['names'] = 'any site'
    sitesObj['campground'] = camp_temp
    sitesObj['inner_campground'] = inner_temp
    campArray.append(sitesObj)
    for sites in campSites.sites:
            sitesObj = {}
            sitesObj['names'] = sites.names

            if camp_temp != sites.campground:
                camp_temp = sites.campground
                sitesObj['campground'] = camp_temp

            if inner_temp != sites.inner_campground:
                inner_temp = sites.inner_campground
                sitesObj['inner_campground'] = inner_temp
            campArray.append(sitesObj)

    return jsonify({'sites' : campArray})


#account information route
@auth.route('/accountDetails',methods=['GET'])
@login_required
def account_details():
    
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    booking = BookingData.query.filter_by(user_id=user_account.id).all()
    print(cache.get('user_id'),cache.get('user'),cache.get(user_id))
    return render_template('accountDetails.html',data = user_account,booking = booking)


#cancel subscription route
@auth.route('/cancelSubscription',methods=['GET','POST'])
@login_required
def cancel_subscription():
    date = datetime.now()
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    date_delta = date + relativedelta(months=2)
    scheduler.add_job(jobstore='default',func=cancel_sub,args=[user_account], 
                      id=f'{user_account.scan}',start_date=date_delta,min =f'{time}')
    return redirect(url_for('auth.account_details'))



#edit your account details
@auth.route('/editAccountDetails',methods=['GET','POST'])
@login_required
def edit_account_details():
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    form = updateForm()
    cancel_form = cancelForm()

    if form.is_submitted() and form.update_account.data:
        
        if request.form['email'] != '':
            user_account.email = request.form['email']
    
        if request.form['password'] != '':
            salted_password = bcrypt.generate_password_hash(request.form['password']).decode('utf-8')
            user_account.password = salted_password

        if request.form['first_name'] != '':
            user_account.firstName = request.form['first_name']
      
        if request.form['last_name'] != '':
            user_account.lastName = request.form['last_name']

        if request.form['address'] != '':
            user_account.billingAddress = request.form['address']
        
        if request.form['city'] != '':
            user_account.city = request.form['city']
       
        if request.form['province'] != '':
            user_account.province  = request.form['province']
       
        if request.form['country'] != '':
            user_account.country = request.form['country']
        
        if request.form['postal_code'] != '':
            user_account.postalCode = request.form['postal_code']
        db.session.commit()
        return redirect(url_for('auth.account_details'))

    else:
            form.email.data = user_account.email
            form.first_name.data = user_account.firstName
            form.last_name.data = user_account.lastName
            form.address.data = user_account.billingAddress
            form.city.data = user_account.city
            form.province.data = user_account.province
            form.country.data = user_account.country
            form.postal_code.data = user_account.postalCode
            form.password.data = '********'
            form.phone_num.data = user_account.phone_num
            form.country.data = user_account.country
        
   
    if cancel_form.validate_on_submit():
        return redirect(url_for('auth.cancel_account'))

    return render_template('editAccountDetails.html',form = form,
                           account=user_account,cForm=cancel_form)


@auth.route('/cancelBooking',methods=['GET','PUT'])
def cancel_booking():
    form = cancelBookingForm()
    user_id = User.get_id(current_user)
    bookings = BookingData.query.filter_by(id = user_id).filter(BookingData.booked == False).all()

    if form.is_submitted():
        try:
            scheduler.remove_job(id=f'{user_id}-{form.park.data}-{form.camp.data}-{form.site.data}')
        except:
            pass

    return render_template('cancel_booking.html',form=form,bookings=bookings,data=user_id)


#send email helpert function
def send_link(*args):
    new_user = args[0]
    token = new_user.generate_confirmation_token()

    if args[1]=='reset':
        msg = Message('Account password reset link',
                    recipients=[new_user.email])
        confirmation_link = url_for('auth.reset_password',token=token,_external=True)
        msg.body = f'''To confirm your password reset, visit the following link:
    {confirmation_link}
    If you did not make this request then simply ignore this email and no changes will be made.'''
        
    elif args[1] =='book':
        msg = Message('Account booking confirmation',
                    recipients=[new_user.email])
        confirmation_link = url_for('auth.confirm',token=token,_external=True)
        msg.body = f'''To confirm your reservation, visit the following link:
    {confirmation_link}
    If you did not make this request then simply ignore this email and no changes will be made.
    '''
        
    else:
        msg = Message('Account confirmation link',
                    recipients=[new_user.email])
        confirmation_link = url_for('auth.confirm',token=token,_external=True)
        msg.body = f'''To confirm your account registration, visit the following link:
    {confirmation_link}
    If you did not make this request then simply ignore this email and no changes will be made.
    '''
    mail.send(msg)


@auth.route('/confirm/<token>',methods=['GET','POST'])
@cache.cached(timeout = 200)
def confirm(token):
    user_id = User.get_id(current_user)

    if current_user.confirmed:
        return redirect(url_for('auth.login'))
    
    if current_user.confirm(token):
        db.session.commit()

    else:
        flash('link invalid')
        return redirect(url_for('auth.login'))
    return render_template('confirmation.html',token=token)



#reset password route from link send by email helper function 
@auth.route("/reset_password/<token>", methods=['GET','POST'])
def reset_password(token):
    if current_user.is_authenticated:
        return redirect(url_for('/'))
    
    user = User.verify_auth_token(token)

    if user is None:
        flash('That is an invalid or expired token', 'warning')
        return redirect(url_for('send_link'))
    
    resetForm = passwordResetForm()

    if resetForm.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(resetForm.password.data).decode('utf-8')
        user.password = hashed_password
        db.session.commit()
        flash('Your password has been updated! You are now able to log in', 'success')
        return redirect(url_for('auth.login'))
    return render_template('reset_token.html', title='Reset Password', resetForm=resetForm)



#FAQ route
@auth.route('/help')
@login_required
@cache.cached(timeout = 200)
def help(): 
    return render_template('help.html')


#payment route,when a sub is purchaserd it redirects you to stripe
@auth.route('/payment',methods=['GET','POST'])
@login_required
def payment():
    errorr = None
    product = productForm()
    confirmForm = redirectForm()
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    confirmed_account = user_account.confirmed
    #will be conditioon here based on subscription purchased or not

    if confirmed_account:
        realproductKey = {'iann_mem_bronze':'price_1LmSeeH3k8WZ4arfFSxheyTG','jann_mem_silver':'price_1LmSefH3k8WZ4arfZUxMjyKe',
                          'kann_mem_gold':'price_1LmSefH3k8WZ4arf8YLs693X','lann_mem_plat':'price_1LmSefH3k8WZ4arfidVgDZiG',
                          'emon_mem_bronze':'price_1MGwSjH3k8WZ4arftdFl1zKT','fmon_mem_silver':'price_1MGwSjH3k8WZ4arff5xCQvYI',
                          'gmon_mem_gold':'price_1MGwSjH3k8WZ4arf3oUu6qgB','hmon_mem_plat':'price_1MGwSjH3k8WZ4arfSoVH91jP',
                          'asingle_bronze':'price_1MGwVSH3k8WZ4arfypWmp1tR','bsingle_silver':'price_1MGwVSH3k8WZ4arfLkXcMkzY',
                          'csingle_gold':'price_1MGwVSH3k8WZ4arfQ8OzBIfb','dsingle_plat':'price_1MGwVSH3k8WZ4arfXwO7cLbt'}
        new_subscription = None
        id = None

        if product.is_submitted():
            new_subscription = product.data
            for key in product.data.keys():

                if product.data[key] == True:
                    new_subscription = key
                
            if new_subscription in realproductKey:
                p_id = realproductKey[new_subscription]
    
            User.get_id(current_user)
            user_account = User.query.filter_by(id = User.get_id(current_user)).first()

            if user_account.subscription == None or new_subscription[0]=='t' or new_subscription[0] > user_account.subscription[0]:
           
                if new_subscription[1] == 's':
                    checkout_session = stripe.checkout.Session.create(line_items =[
                    {'price':p_id,'quantity':1}
                ],
                metadata={'user_id':user_id},
                mode ='payment',
                success_url = url_for('auth.success',_external=True)+ '?session_id={CHECKOUT_SESSION_ID}',
                cancel_url = url_for('auth.cancel',_external=True),
                automatic_tax = {'enabled':True}
                )
                    return redirect(checkout_session['url'])
                
                else:
                    checkout_session = stripe.checkout.Session.create(line_items =[
                        {'price':p_id,'quantity':1}
                        
                    ],
                    metadata={'user_id':user_id},
                    mode ='subscription',
                    success_url = url_for('auth.success',_external=True)+ '?session_id={CHECKOUT_SESSION_ID}',
                    cancel_url = url_for('auth.cancel',_external=True),
                    automatic_tax = {'enabled':True}
                    )
                    return redirect(checkout_session['url'])
                
            else:
                errorr = True
                return render_template('payment.html',form=product, errorr = errorr) 
    return render_template('payment.html',form=product,errorr = errorr,
                           sub = confirmed_account,confirmForm=confirmForm)


#success route if your purchase is successful
@auth.route('/success',methods=['GET'])
@login_required
def success():
    session = stripe.checkout.Session.retrieve(request.args.get('session_id'))

    if session:
        book = True

    else:
        book = False

    customer = stripe.Customer.retrieve(session.customer)
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    return render_template('success.html',book = book)

#cancel route if your purchase failed
@auth.route('/cancel',methods=['GET','POST'])
@login_required
def cancel():
    book = True
    return render_template('cancel.html',book=book)


#cancel subscription route
@auth.route('/cancelAccount',methods=['GET','POST'])
@login_required
def cancel_account():
    cancel = True
    uncancelled =None
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    subscription_id = user_account.sId
    cancelled = user_account.cancel_sub()

    if cancelled == True:
        stripe.Subscription.modify(
    f'{subscription_id}',
    cancel_at_period_end=True
        )

    else:
        uncancelled = True
        
    return render_template('cancel.html',cancel = cancel,uncancelled = uncancelled)


#webhook from stripe when a purchase is made
@auth.route('/webhook', methods=['POST'])
@csrf.exempt
def webhook():
    print('WEBHOOK CALLED')

    if request.content_length > 1024 * 1024:
        abort(400)

    payload = request.get_data()
    sig_header = request.environ.get('HTTP_STRIPE_SIGNATURE')
   
    endpoint_secret ='whsec_fc62491304b1d48910e4ba792e57f0b8747f3e03f738b7f7b51c3794fb215dac'
    event = None

    try:
        event = stripe.Webhook.construct_event(
            payload, sig_header, endpoint_secret
        )
    except ValueError as e:
        # Invalid payload
        print('INVALID PAYLOAD')
        return {}, 400
    
    except stripe.error.SignatureVerificationError as e:
        # Invalid signature
        print('INVALID SIGNATURE')
        return {}, 400
    # Handle the checkout.session.completed event

    if event['type'] == 'checkout.session.completed':
        session = event['data']['object']
        customer = session.customer
        subscription = session.subscription

        try:
            MD = stripe.checkout.session.metadata(session['id'],limit=1)
        except:
            pass

        line_items = stripe.checkout.Session.list_line_items(session['id'], limit=1)
        valued = str(line_items['data'][0].amount_subtotal)
   
        user_id = session.metadata['user_id']

        custy = User.query.filter_by(id=user_id).first()
        id_update = custy.id_check(customer)
        sub_update = custy.subscription_check(valued)
        subId = custy.sId_check(subscription)

        if sub_update == True or id_update == True or subId ==True:
            time = custy.sub_date()
            db.session.commit()  
    return{}
        

def job_date(date_booking):
        if date_booking.month <= 8 and date_booking.month > ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:
            date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day+1}'
            start_day = f'{date_booked} 06:55:00'
            end_day = f'{date_booked} 19:59:00'

        elif date_booking.month > 8 and  date_booking.month > ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:
            start_day = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day} 06:55:00' 
            end_day = f'{date_booking.year}-{date_booking.month}-{date_booking.day-1} 19:59:00'


        elif date_booking.month <= ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:

            if date_booking.day <= datetime.now().day:
                date_booked = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day}'
                start_day = f'{date_booked} 06:53:00'
                end_day = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day} 19:59:00'

            else:
                date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
                start_day = f'{date_booked} 06:53:00'
                end_day = f'{date_booked} 19:59:00'

        elif date_booking.year > datetime.now().year:
            date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{date_booked} 19:59:00'

        return start_day,end_day

#apscheduler route that activates a job function
@auth.route('/addTask',methods =['GET','POST'])
@login_required
def add_task():
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    productScan = {'iann_mem_bronze': 3,'jann_mem_silver':7,
    'kann_mem_gold':10,'lann_mem_plat':15,'emon_mem_bronze':3,
    'fmon_mem_silver':7,'gmon_mem_gold':10,'hmon_mem_plat':15,'asingle_bronze':3,
    'bsingle_silver':7,'csingle_gold':10,'dsingle_plat':15}
    productKey = {'iann_mem_bronze':15,'jann_mem_silver':10,
    'kann_mem_gold':5,'lann_mem_plat':5,'emon_mem_bronze':15,
    'fmon_mem_silver':10,'gmon_mem_gold':5,'hmon_mem_plat':5,'asingle_bronze':60,
    'bsingle_silver':30,'csingle_gold':15,'dsingle_plat':5}

    sub = str(user_account.subscription)
    acc_scan_num = user_account.scan
    scan_num = acc_scan_num + 1
    temp = None

    if sub in productKey:
        time = productKey[sub]
        scan_num = productScan[sub]

    else:
        return render_template('cancel.html',scan = False)
    
    if acc_scan_num == None or scan_num >= acc_scan_num:
        account_booking = BookingData.query.filter_by(user_id = user_id).filter(BookingData.logged == False).all()
        for i in account_booking:
            start_day, end_day = job_date(i.arrival_date)
            scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',
                              args=[user_id,i], id=f'{user_account.id}-{i.park}-{i.campground}-{i.site}-{i.arrival_date}',
                              start_date=start_day,end_date=end_day,minutes =1,max_instances =1)
            i.logged = True
            db.session.merge(i)
            db.session.commit()

    else:
        return render_template('cancel.html',scan = False)
    
    return {}

#cancel subscription route
def cancel_sub(*args):
    account_id = args[0]
    with scheduler.app.app_context():
        user_id = User.get_id(current_user)
        user_account = get_cached_user(user_id)
        s_info   = stripe.Subscription.delete(f'{user_account.SId}')
        user_account.cancel_subscription()
        user_account.delete_scans()


def schedule_site(*args):
    account_id = args[0]
    b_info = args[1]
    with scheduler.app.app_context():
        u_info = User.query.filter_by(id=account_id).first()
        s_info = stripe.Customer.retrieve(f'{u_info.cId}')
        
        try:
            browser = webdriver.Firefox()
        except:
            time.sleep(1)
            browser = webdriver.FireFox()


        waits = wait(browser,20)
        Action = ActionChains(browser)
        time1 = time.time()
        book,time2,success,failed_at = reservation(browser,waits,Action,u_info,b_info,s_info)
        #failure data logging system
        btt = bookingTimeTest(None,datetime.now(),success,failed_at,None,0)
        db.session.add(btt)
        db.session.commit()
       
        if book == True:
            site = f'{b_info.park}-{b_info.site}'
            btt.successful_booking(time1,time2,success,site)
            db.session.merge(btt)
            b_info.booked = True
            db.session.merge(b_info)
            db.session.commit()
            send_link(b_info,'book')
    
            scheduler.remove_job(id=f'{u_info.id}-{b_info.park}-{b_info.campground}-{b_info.site}-{b_info.arrival_date}')
            for job in scheduler.get_jobs():
                            print("name: %s, trigger: %s, next run: %s, handler: %s" % (
                    job.name, job.trigger, job.next_run_time, job.func))

                        
        else:
            site = f'{b_info.park}-{b_info.site}'
            btt.failed_booking(time1,time2,failed_at,site,1)
            db.session.merge(btt)
            db.session.commit()
            try:
                browser.close()
            except:
                pass


#booking info route via link from email helper function
@auth.route('/booking_info/<token>',methods=['GET'])
def booking_info(token):
    user_id = User.get_id(current_user)
    user_account = get_cached_user(user_id)
    user_bookings = get_booking_data(user_id)
    accounts = BookingData.query.filter_by(user_id = current_user.get_id()).first()

    if accounts.token_confirm(token) == True:
        bookingBool= True
        return render_template('accountDetails.html',bookingBool=bookingBool,
                                data=user_account,booking=user_bookings)
    
    else:
        bookingBool = False
        return render_template('accountDetails.html',bookingBool=bookingBool,
                               data=user_account,booking = user_bookings)
          

#TESTING & ADMIN ROUTES Ignore
#create admin
@auth.route('create_admin',methods=['GET','POST'])
def create_admin():
    aForm = adminForm()
    if aForm.validate_on_submit() and aForm.email_password.data == os.environ.get('ENV_ADMIN_PASS'):

        if current_user:
            user_id = User.get_id(current_user)
            user_account = get_cached_user(user_id)
            user_account.set_admin()
            db.session.commit()

        else:
            salted_password = bcrypt.generate_password_hash(aForm.email_password.data).decode('utf-8')
            new_user = User(email = aForm.user_email.data,password = salted_password,
                            firstName=None,lastName=None,confirmed=False,billingAddress=None,
                            postalCode=None,city =None,province = None,country = None,
                            subscription = None,cId=None,sId=None,scan=None,
                            sub_day = None,phone_num = None,confirmed_at = datetime.now,
                            is_admin = True)
            db.session.add(new_user)
            db.session.commit()
    else:
        flag = True
        return render_template('admin_signup.html',adminForm=aForm,flag = flag)
    
    return render_template('admin_signup.html',adminForm=aForm)

@cache.cached(timeout = 50,key_prefix='get_cached_user')
def get_cached_user(user_id):
    user = cache.get(user_id)

    if user:
        return user
    
    else:
        user = User.query.get_or_404(user_id)
        cache.set(user_id, user)
        return user
    
@cache.cached(timeout = 50,key_prefix='get_booking_data')
def get_booking_data(userId):
    userBooking = cache.get('userBooking')

    if userBooking:
        return userBooking
    
    else:
        bookingData = BookingData.query.filter_by(user_id=userId).all()
        cache.set('userBooking',bookingData)
        return bookingData
    
