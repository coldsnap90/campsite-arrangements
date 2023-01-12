from importlib.metadata import metadata
from importlib.util import source_from_cache
from flask import render_template,request,redirect,url_for,jsonify,make_response,session,flash,Blueprint,abort,Response,current_app
from sniffio import current_async_library
from park.extensions import bcrypt,db,mail,Message,scheduler
from flask_login import login_user, current_user, logout_user, login_required
from flask_security import login_required,login_user
from park.booking import *
from park.auth.forms import ChoiceForm,signupForm,updateForm,passwordResetForm,LoginForm,productForm,redirectForm,testForm,cancelForm,adminForm,requestResetForm
from park.auth import auth
from dateutil.relativedelta import relativedelta
from datetime import datetime
from pathlib import Path
import os
from dotenv import load_dotenv
load_dotenv()
from park.config import Config
import stripe
from stripe import error
from park.static.products.services import service
from park.models import *
from datetime import datetime
from park.booked import *
from selenium import webdriver


from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
import selenium.common.exceptions as webdriverexception
from datetime import datetime
import time
import random



stripe.api_key = Config.STRIPE_SECRET_KEY

#login route
@auth.route('/login',methods =['GET','POST'])
def login():
    error = None
    request = None
    if current_user.is_authenticated and current_user.confirmed:
        print('logged')
        return redirect(url_for('auth.book'))
    form = LoginForm()
    if form.validate_on_submit():
        flash(f'validating.')
        print('Email')
        email_found = User.query.filter_by(email=form.email.data).first()
        
        if email_found and bcrypt.check_password_hash(email_found.password,form.email_password.data):
            print('found')
            login_user(email_found,remember=form.remember_me.data)
            return redirect(url_for('auth.book'))
        else:
            error = True
            print(form.email.data)
            print('Email doesnt exist')
    requestForm = requestResetForm()
    
    if requestForm.is_submitted() and requestForm.reset_email.data == None:
        request = True
        return render_template('login_user.html',login_form=form,resetForm=requestForm,error=error,request=request)
    elif requestForm.validate_on_submit():
        user_email = requestForm.reset_email.data
        if requestForm.validate_email(user_email) == True:
            user = User.query.filter_by(email=user_email).first()
            send_link(user,1)
            return render_template('login_user.html',login_form=form,resetForm=requestForm,error=error,request=request)
    return render_template('login_user.html',login_form=form,resetForm=requestForm,error=error,request=request)

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
    signUpForm = signupForm()
    if signUpForm.validate_on_submit():
        salted_password = bcrypt.generate_password_hash(signUpForm.email_password.data).decode('utf-8')
        new_user = User(email = signUpForm.user_email.data,password = salted_password,
                        firstName=signUpForm.first_name.data,lastName=signUpForm.last_name.data,confirmed=False,billingAddress=None,
                        postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)   
        db.session.add(new_user)
        db.session.commit()
        send_link(new_user)
        return redirect(url_for('auth.login'))   
    return render_template('newUser.html',signUpForm=signUpForm)

#book campsite route
@auth.route('/book',methods=['GET','POST'])
@login_required
def book():
    
    form = ChoiceForm()
    form.sites.choices = [site.sites for site in Park.query.filter_by(park_site = form.park.data).all()]

    if current_user:
        data = User.get_id(current_user)
        Account = User.query.filter_by(id = data).first()
        newz = Park.query.all()
      
        n_u = Park.query.filter_by(park_site='Alice Lake').first()

        if form.is_submitted() and Account.subscription != None:
    
            if request.method == 'POST':
                salted_code = bcrypt.generate_password_hash(form.code.data)
                salted_code = bcrypt.generate_password_hash(form.code.data).decode('utf-8')
                try:
                    print(stripe.Customer.retrieve(f'{User.get_id(current_user)}'))
                    #stripe.Customer.delete(f'{User.get_id(current_user)}')
                except:
                    print('DNE')
                
                customer = stripe.Customer.modify(f'{Account.cId}',email = f'{form.email.data}',address= {'city':f'{form.city.data}','country':f'{form.country.data}','line1':f'{form.billing_address.data}',
                'postal_code':f'{form.postal_code.data}','state':f'{form.province.data}'},metadata ={'metaNa':f'{form.card_name.data}','metaNu':f'{form.card.data}','metaM':f'{form.mm.data}','metaY':f'{form.yy.data}',
                'metaC':f'{form.code.data}'})  
                months = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06','Jul':'07','Aug':'08','Sept':'09','Oct':'10','Nov':'11','Dec':'12'} 
                arr_month=months[f'{form.arrival_month.data}']
                print('arrival month : ',arr_month, ' - formdata : ',form.arrival_month.data, ' Type : - ',type(form.arrival_month.data))
                newB = BookingData(park =form.park.data,site=form.sites.data,site_type=form.site_type.data,campground = form.campground.data,inner_campground=form.inner_campground.data,arrival_month=form.arrival_month.data,arrival_day=form.arrival_day.data,
                arrival_year = form.arrival_year.data,nights = form.nights.data,equiptment = form.equiptment.data,email = form.email.data,password = form.password.data,
                party_size=form.party_size.data,contact_num=form.contact_num.data,logged=False,booked=False,user_id=data)
                db.session.add(newB)
                db.session.commit()
                return redirect(url_for('auth.tempTasks'))
             
        else:
            print(form.errors)              
    else:
        return redirect(url_for('auth.login'))
    form.sites.data = None      
    return render_template('booking.html',form = form)

#route to dynamically load selectfield on book page
@auth.route('/sited/<park>',methods=['GET'])
def sited(park):
    campSites = Park.query.filter_by(park_site=park).first()
    campArray = []
    camp_temp = ''
    inner_temp =''
    sitesObj = {}
    sitesObj['names'] = ''
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
    data = User.get_id(current_user)
    Account = User.query.filter_by(id = data).first()
    booking = BookingData.query.filter_by(id=data).all()
    return render_template('accountDetails.html',data = Account,booking = booking)

#cancel subscription route
@auth.route('/cancelSubscription',methods=['GET','POST'])
@login_required
def cancel_subscription():
    date = datetime.now()
    data = User.get_id(current_user)
    account = User.query.get_or_404(data)
    date = datetime.now()
    date_delta = date + relativedelta(months=2)
    scheduler.add_job(jobstore='default',func=cancel_sub,args=[account], id=f'{account.scan}',start_date=date_delta,min =f'{time}')

#edit your account details
@auth.route('/editAccountDetails',methods=['GET','POST'])
@login_required
def edit_account_details():
    data = User.get_id(current_user)
    account = User.query.get_or_404(data)
    form = updateForm()
    cancel_form = cancelForm()
    if form.is_submitted() and form.update_account.data:
        if request.form['email'] != '':
            account.email = request.form['email']
        else:
            account.email = account.email
        if request.form['password'] != '':
            salted_password = bcrypt.generate_password_hash(request.form['password']).decode('utf-8')
            account.password = salted_password
        else:
            account.password = account.password

        if request.form['firstName'] != '':
            account.firstName = request.form['firstName']
        else:
            account.firstName = account.firstName
        if request.form['lastName'] != '':
            account.lastName = request.form['lastName']
        else:
            account.lastName = account.lastName 
        if request.form['address'] != '':
            account.billingAddress = request.form['address']
        
        if request.form['city'] != '':
            account.city = request.form['city']
       
        if request.form['province'] != '':
            account.province  = request.form['province']
       
        if request.form['country'] != '':
            account.country = request.form['country']
        
        if request.form['postal_code'] != '':
            account.postalCode = request.form['postal_code']
        else:
        
            form.email.data = account.email
            form.firstName.data = account.firstName
            form.lastName.data = account.lastName
            form.address.data = account.billingAddress
            form.city.data = account.city
            form.province.data = account.province
            form.country.data = account.country
            form.postal_code.data = account.postalCode
            form.password.data = '********'
        
        db.session.commit()
        d = User.get_id(current_user)
        acc = User.query.get_or_404(d)
        return render_template('accountDetails.html',data=acc)
    
    if cancel_form.validate_on_submit():
        return redirect(url_for('auth.cancelAccount'))

    return render_template('editAccountDetails.html',form = form,account=account,cForm=cancel_form)

#send email helpert function
def send_link(*args):
    new_user = args[0]
    token = new_user.generate_confirmation_token()
    if args[1]:
        msg = Message('Account confirmation link',
                    recipients=[new_user.email])
        confirmation_link = url_for('auth.reset_password',token=token,_external=True)
        msg.body = f'''To confirm your password reset, visit the following link:
    {confirmation_link}
    If you did not make this request then simply ignore this email and no changes will be made.'''

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
def confirm(token):
    data = User.get_id(current_user)
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
def help(): 
    return render_template('help.html')

#payment route,when a sub is purchaserd it redirects you to stripe
@auth.route('/payment',methods=['GET','POST'])
@login_required
def payment():
    errorr = None
    product = productForm()
    confirmForm = redirectForm()
    data = User.get_id(current_user)
    account = User.query.filter_by(id=data).first()
    accounts = account.confirmed
    #will be conditioon here based on subscription purchased or not
    x = 1
    if x==1:
        print('1=1')
        productKey = {'iann_mem_bronze':'price_1LulFpH3k8WZ4arfpPVjdNaq','jann_mem_silver':'price_1LulFpH3k8WZ4arfK3inXJDT',
    'kann_mem_gold':'price_1LulFpH3k8WZ4arfMXYgKtLI','lann_mem_plat':'price_1LulFpH3k8WZ4arfR98vyl3X','emon_mem_bronze':'price_1LkfreH3k8WZ4arfdAjDipjW',
    'fmon_mem_silver':'price_1LkfreH3k8WZ4arfskkvQ0xe','gmon_mem_gold':'price_1LkfreH3k8WZ4arfNXltBLeu','hmon_mem_plat':'price_1LkfreH3k8WZ4arfSBQ2CsXG','asingle_bronze':'price_1LkfvaH3k8WZ4arfyrGerqcx',
    'bsingle_silver':'price_1LkfvaH3k8WZ4arf4RGgHGHy','csingle_gold':'price_1LkfvaH3k8WZ4arfzmDwmYAD','dsingle_plat':'price_1LkfvaH3k8WZ4arfDyC5s06D'}
        realproductKey = {'iann_mem_bronze':'price_1LmSeeH3k8WZ4arfFSxheyTG','jann_mem_silver':'price_1LmSefH3k8WZ4arfZUxMjyKe',
    'kann_mem_gold':'price_1LmSefH3k8WZ4arf8YLs693X','lann_mem_plat':'price_1LmSefH3k8WZ4arfidVgDZiG','emon_mem_bronze':'price_1MGwSjH3k8WZ4arftdFl1zKT',
    'fmon_mem_silver':'price_1MGwSjH3k8WZ4arff5xCQvYI','gmon_mem_gold':'price_1MGwSjH3k8WZ4arf3oUu6qgB','hmon_mem_plat':'price_1MGwSjH3k8WZ4arfSoVH91jP','asingle_bronze':'price_1MGwVSH3k8WZ4arfypWmp1tR',
    'bsingle_silver':'price_1MGwVSH3k8WZ4arfLkXcMkzY','csingle_gold':'price_1MGwVSH3k8WZ4arfQ8OzBIfb','dsingle_plat':'price_1MGwVSH3k8WZ4arfXwO7cLbt'}
        
        new_subscription = None
        id = None
        print(product.validate_on_submit(),product.is_submitted())
        if product.is_submitted():
            new_subscription = product.data
            for i in product.data.keys():
                if product.data[i] == True:
                    new_subscription = i
            else:
                print(new_subscription)
            if new_subscription in productKey:
                p_id = productKey[new_subscription]
    
            data = User.get_id(current_user)

            Account = User.query.filter_by(id = data).first()
            if p_id[0] > Account.subscription[0]:
                if new_subscription[1] == 's':
                    checkout_session = stripe.checkout.Session.create(line_items =[
                    {'price':p_id,'quantity':1}
                ],
                metadata={'user_id':data},
                mode ='payment',
                success_url = url_for('auth.success',_external=True)+ '?session_id={CHECKOUT_SESSION_ID}',
                cancel_url = url_for('auth.cancel',_external=True),
                automatic_tax = {'enabled':True}
                )
                    return redirect(checkout_session['url'])
                else:
                    print('New Sub 2 ',new_subscription)
                    checkout_session = stripe.checkout.Session.create(line_items =[
                        {'price':p_id,'quantity':1}
                        
                    ],
                    metadata={'user_id':data},
                    mode ='subscription',
                    success_url = url_for('auth.success',_external=True)+ '?session_id={CHECKOUT_SESSION_ID}',
                    cancel_url = url_for('auth.cancel',_external=True),
                    automatic_tax = {'enabled':True}
                    )
                    return redirect(checkout_session['url'])
            else:
                errorr = True
                return render_template('payment.html',form=product, errorr = errorr) 
    return render_template('payment.html',form=product,errorr = errorr,sub = accounts,confirmForm=confirmForm)

#success route if your purchase is successful
@auth.route('/success/<book>',methods=['GET'])
@login_required
def success(book):
    session = stripe.checkout.Session.retrieve(request.args.get('session_id'))
    customer = stripe.Customer.retrieve(session.customer)
    print(current_user)
    return render_template('success.html',book = book)

#cancel route if your purchase failed
@auth.route('/cancel/<book>',methods=['GET','POST'])
@login_required
def cancel(book):
    return render_template('cancel.html',book=book)



#cancel subscription route
@auth.route('/cancelAccount',methods=['GET','POST'])
@login_required
def cancelAccount():
    cancel = True
    uncancelled =None
    user = User.get_id(current_user)
    sub_check = User.query.filter_by(id = user).first()
    sub_id = sub_check.sId
    cancelled = sub_check.cancel_sub()
    if cancelled == True:
        stripe.Subscription.modify(
    f'{sub_id}',
    cancel_at_period_end=True
        )
    else:
        uncancelled = True
        
    return render_template('cancel.html',cancel = cancel,uncancelled = uncancelled)


#webhook from stripe when a purchase is made
@auth.route('/webhook', methods=['POST'])
def webhook():
    print('WEBHOOK CALLED')
    if request.content_length > 1024 * 1024:
        print('REQUEST TOO BIG')
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
        cust = session.customer
        sub = session.subscription

        try:
            MD = stripe.checkout.session.metadata(session['id'],limit=1)
            print('MD TRY : ',MD)
        except:
            print('fail')
        line_items = stripe.checkout.Session.list_line_items(session['id'], limit=1)
        valued = str(line_items['data'][0].amount_subtotal)
   
        valu = session.metadata['user_id']
        print(valu)
        custy = User.query.filter_by(id=valu).first()
        id_update = custy.id_check(cust)
        sub_update = custy.subscription_check(valued)
        subId = custy.sId_check(sub)
        if sub_update == True or id_update == True or subId ==True:
            time = custy.sub_date()
            db.session.commit()  
    return{}
        

#sched.add_job(my_job, 'date', run_date=datetime(2009, 11, 6, 16, 30, 5), args=['text'])
#,trigger ='interval',hours=1, start_date='2022-11-11 22::30'

#apscheduler route that activates a job function
@auth.route('/tempTasks',methods =['GET','POST'])
@login_required
def tempTasks():
    print('scheduling')
    data = User.get_id(current_user)
    productScan = {'iann_mem_bronze': 3,'jann_mem_silver':7,
    'kann_mem_gold':10,'lann_mem_plat':15,'emon_mem_bronze':3,
    'fmon_mem_silver':7,'gmon_mem_gold':10,'hmon_mem_plat':15,'asingle_bronze':3,
    'bsingle_silver':7,'csingle_gold':10,'dsingle_plat':15}
    productKey = {'iann_mem_bronze':15,'jann_mem_silver':10,
    'kann_mem_gold':5,'lann_mem_plat':5,'emon_mem_bronze':15,
    'fmon_mem_silver':10,'gmon_mem_gold':5,'hmon_mem_plat':5,'asingle_bronze':60,
    'bsingle_silver':30,'csingle_gold':15,'dsingle_plat':5}
    
    months = {'Jan':'1','Feb':'2','Mar':'3','Apr':'4','May':'5','Jun':'6','Jul':'7','Aug':'8','Sept':'9',
                 'Oct':'10','Nov':'11','Dec':'12'}
    account = User.query.get_or_404(data)
    sub = str(account.subscription)
    acc_scan_num = account.scan
    account_booking = BookingData.query.filter_by(user_id = data).first()
    temp = None
    if sub in productKey:
        time = productKey[sub]
        scan_num = productScan[sub]
    else:
        return render_template('cancel.html',scan = False)
    if acc_scan_num == None or scan_num >= acc_scan_num and account_booking.logged == False:
        print('adding Job')
        account_booking = BookingData.query.filter_by(user_id = data).filter(BookingData.logged == False).first()
        month = months[account_booking.arrival_month]
        date_booking = datetime(int(account_booking.arrival_year),int(month),int(account_booking.arrival_day),6,59,59,59)
      

        if date_booking.month > ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:
            print('start 1')
            date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{date_booked} 19:59:00'
        elif date_booking.month < ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:
            print('start 3')
            print(datetime.now())
            date_booked = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day+1} 19:59:00'
        elif date_booking.year < datetime.now().year:
            print('start 2')
            date = f'{date_booking.year+1}-{date_booking.month-4}-{date_booking.day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{date_booked} 19:59:00'

        scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[data,account_booking], id=f'{account.id}-{account_booking.park}-{account_booking.site}',start_date=start_day,end_date=end_day,minutes =2,max_instances =1)
        account_booking.logged = True
        db.session.merge(account_booking)
        db.session.commit()
        print('scheduled')
    else:
        return render_template('cancel.html',scan = False)

    #error testing check for
    print('checking jobs')
    for job in scheduler.get_jobs():
        print("name: %s, trigger: %s, next run: %s, handler: %s" % (
          job.name, job.trigger, job.next_run_time, job.func))
        #app.apscheduler.add_job(func=blah, trigger='date', args=[i], id='j'+str(i)
    return 'Scheduled several long running tasks.', 200

#cancel subscription route
def cancel_sub(*args):
    account_id = args[0]
    with scheduler.app.app_context():
        u_info = User.query.filter_by(id=account_id).first()
        s_info   = stripe.Subscription.delete(f'{u_info.SId}')
        u_info.cancel_subscription()
        u_info.delete_scans()

#job check helper will be deleted later
@auth.route('/job-check',methods = ['GET','POST'])
def job_check():

    print(scheduler.get_jobs())
    for job in scheduler.get_jobs():
        print("name: %s, trigger: %s, next run: %s, handler: %s" % (
          job.name, job.trigger, job.next_run_time, job.func))
        #app.apscheduler.add_job(func=blah, trigger='date', args=[i], id='j'+str(i)
    return render_template('data.html',data = scheduler.get_jobs)

#create admin
@auth.route('create_admin',methods=['GET','POST'])
def create_admin():
    aForm = adminForm()
    print(aForm.validate_on_submit(), ' = ', Config.ADMIN_PASS)
    if aForm.validate_on_submit() and aForm.email_password.data == Config.ADMIN_PASS:
        if current_user:
            aUser = User.query.get_or_404(User.get_id(current_user))
            aUser.set_admin()
        else:
            salted_password = bcrypt.generate_password_hash(aForm.email_password.data).decode('utf-8')
            new_user = User(email = aForm.user_email.data,password = salted_password,
                            firstName=None,lastName=None,confirmed=False,billingAddress=None,
                            postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                            sub_day = None,phone_num = None,confirmed_at = datetime.now,is_admin = True)
            db.session.add(new_user)
            db.session.commit()
    else:
        flag = True
        return render_template('admin_signup.html',adminForm=aForm,flag = flag)
    return render_template('admin_signup.html',adminForm=aForm)


#ignore functions below like the main routes these were used in pseudo-testing and will be deleted later 
@auth.route("/sub")
@login_required  # force the user to log in/sign up
def sub():
   
    form = ChoiceForm()
    for i in form.park.choices:
        print(i)

    # if record exists, add the subscription info to the render_template method
    context =  User.query.get_or_404(User.get_id(current_user))
    return render_template("data.html", data = context)

def schedule_site(*args):
    print('starting Job')
    account_id = args[0]
    b_info = args[1]
    with scheduler.app.app_context():
        u_info = User.query.filter_by(id=account_id).first()
        b_info = BookingData.query.filter_by(user_id = account_id).first()
        s_info = stripe.Customer.retrieve(f'{u_info.cId}')
        CHROMEDRIVER_PATH = os.environ.get('CHROMEDRIVER_PATH', '/usr/local/bin/chromedriver')
        GOOGLE_CHROME_BIN = os.environ.get('GOOGLE_CHROME_BIN', '/usr/bin/google-chrome')
        chrome_options = webdriver.ChromeOptions()
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--headless')
        #chrome_options.add_argument('--proxy-sever=socks5://127.0.0.1:0000')
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument('--disable-gpu')
        chrome_options.binary_location = GOOGLE_CHROME_BIN

       # exception for if chromedriver crashes on launch
        try:
            browser = webdriver.Chrome(CHROMEDRIVER_PATH, chrome_options=chrome_options)
        except:
            print("\nChrome crashed on launch:")
            print("Trying again in 1 second")
            time.sleep(1)
            driver = webdriver.Chrome(executable_path=os.environ.get("CHROMEDRIVER_PATH"), chrome_options=chrome_options)
            print("Success!\n")
        
    #caps["pageLoadStrategy"] = "eager"  #  complete

        
    
        waits = wait(browser,20)
        Action = ActionChains(browser)
        time1 = time.time()
        print('reservation starting')
        book,time2,success,failed_at = reservation(browser,waits,Action,u_info,b_info,s_info)
        btt = bookingTimeTest(None,datetime.now(),success,failed_at,None)
        print('Failed at : ',failed_at)
        if book == True:
            print('Book == True')
            site = f'{b_info.park}-{b_info.site}'
            btt.successful_booking(time1,time2,success,site)
            b_info.booked = True
            db.session.merge(b_info)
            db.session.commit()
            b_info.send_link(u_info,b_info)
            scheduler.remove_job(id=f'{account_id}-{b_info.park}-{b_info.site}')
            for job in scheduler.get_jobs():
                            print("name: %s, trigger: %s, next run: %s, handler: %s" % (
                    job.name, job.trigger, job.next_run_time, job.func))
                        
        else:
            print('Booking Failed')
            site = f'{b_info.park}-{b_info.site}'
            btt.failed_booking(time1,time2,failed_at,site)

def blah3(*args):
    print('Job starting')
    
    b = args[1]
    with scheduler.app.app_context():
        user = User.query.filter_by(id =args[0]).first()
        print('Schedule')
    try:
        print('CURRENT APP CONTEXT')
        with current_app.app_context():
                print('5 redirect')
                send_link(user,b)
    except:
        print('except')
        print(' BOOKED ' ,b.booked)
        with scheduler.app.app_context():
            user = User.query.filter_by(id =args[0]).first()
            if b.booked == False:
                print('USER ',user.email)
                b.send_link(user,b)
                b.booked = True
                db.session.merge(b)
                db.session.commit()
                scheduler.remove_job(id=f'{args[0]}-{b.park}-{b.site}')
#booking info route via link from email helper function
@auth.route('/booking_info/<token>',methods=['GET'])
def booking_info(token):
    print('\n Booking Info Called \n')
    user = User.query.filter_by(id = User.get_id(current_user)).first()
    print('USER : ',user)
    accounts = BookingData.query.filter_by(user_id = current_user.get_id()).first()
    user_bookings = BookingData.query.filter_by(user_id = current_user.get_id()).all()
    if accounts.token_confirm(token) == True:
        bookingBool= True
        
        return render_template('accountDetails.html',bookingBool=bookingBool,data=user,booking=user_bookings)
    else:
        bookingBool = False
        return render_template('accountDetails.html',bookingBool=bookingBool,data=user,booking = user_bookings)
          
@auth.route('/Tquery',methods = ['GET','POST'])
def Tquery():
    b = User.query.filter_by(email='cfarbatuk@gmail.com').first()
    scheduler.add_job(jobstore='default',func=blah3,trigger = 'interval', args=[b],id=f'{5}',minutes =0.25,max_instances =1)
    print('job created')
    return redirect(url_for('auth.bookings'))

@auth.route('/dquery',methods = ['GET','POST'])
def dquery():
    print('scheduling')
    data = User.get_id(current_user)
    time = bookingTimeTest.query.all()
    productScan = {'iann_mem_bronze': 3,'jann_mem_silver':7,
    'kann_mem_gold':10,'lann_mem_plat':15,'emon_mem_bronze':3,
    'fmon_mem_silver':7,'gmon_mem_gold':10,'hmon_mem_plat':15,'asingle_bronze':3,
    'bsingle_silver':7,'csingle_gold':10,'dsingle_plat':15}
    productKey = {'iann_mem_bronze':15,'jann_mem_silver':10,
    'kann_mem_gold':5,'lann_mem_plat':5,'emon_mem_bronze':15,
    'fmon_mem_silver':10,'gmon_mem_gold':5,'hmon_mem_plat':5,'asingle_bronze':60,
    'bsingle_silver':30,'csingle_gold':15,'dsingle_plat':5}
    account = User.query.get_or_404(data)
    sub = str(account.subscription)
    acc_scan_num = account.scan
    temp = None
    '''
    if sub in productKey:
        time = productKey[sub]
        scan_num = productScan[sub]
    else:
        return render_template('cancel.html',scan = False)
    '''
    #if acc_scan_num == None or scan_num >= acc_scan_num:
    if 1==1:

         account_booking = BookingData.query.filter_by(user_id = data).filter(BookingData.logged == False).all()
         for i in account_booking:
            date_booked = f'{i.arrival_year}-{i.arrival_month}-{i.arrival_day}'
            start_day = f'{date_booked} 06:55:00'
            end_day = f'{date_booked} 23:59:00'
   
            if i.booked == False:
                scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[data,i], id=f'{account.id}-{i.park}-{i.site}',minutes =1,max_instances =1)
                print('scheduled')
    else:
        return render_template('cancel.html',scan = False)

    return render_template('data.html',data = data,campground = account,inner_Campground = time)


@auth.route('/testBook',methods =['GET','POST'])
def testBook():
                '''3 6 12 14'''
                data = User.get_id(current_user)
                '''
                newB = BookingData(park ='Porteau Cove',site='38',site_type='campsite',campground = 'B (Sites 38-44)',inner_campground=None,arrival_month='Jan',arrival_day='6',
                arrival_year = '2023',nights = '1',equiptment = '2 Tents',email = 'cheema_mandy@hotmail.com',password = 'Apple9314!!',
                party_size='1',contact_num=f'6046141826',booked = True,user_id=data)
                db.session.add(newB)
                db.session.commit()

                newB = BookingData(park ='Porteau Cove',site='15',site_type='campsite',campground = 'A (Sites 1-37)',inner_campground=None,arrival_month='Jan',arrival_day='6',
                arrival_year = '2023',nights = '2',equiptment = '1 Tent',email = 'cheema_mandy@hotmail.com',password = 'Apple9314!!',
                party_size='2',contact_num=f'6046141826',booked = False,user_id=data)
                db.session.add(newB)
                db.session.commit()
                
                newB = BookingData(park ='Porteau Cove',site='8',site_type='campsite',campground = 'A (Sites 1-37)',inner_campground=None,arrival_month='Jan',arrival_day='6',
                arrival_year = '2023',nights = '1',equiptment = '3 Tents',email = 'cheema_mandy@hotmail.com',password = 'Apple9314!!',
                party_size='1',contact_num=f'6046141826',booked = False,user_id=data)
                db.session.add(newB)
                db.session.commit()
                '''
                newB = BookingData(park ='Porteau Cove',site='6',site_type='campsite',campground = 'A (Sites 1-37)',inner_campground=None,arrival_month='Jan',arrival_day='6',
                arrival_year = '2023',nights = '1',equiptment = '2 Tents',email = 'cheema_mandy@hotmail.com',password = 'Apple9314!!',
                party_size='2',contact_num=f'6046141826',booked = False,user_id=data)
                db.session.add(newB)
                db.session.commit()
                data = User.get_id(current_user)
                account = User.query.filter_by(id = data).first()
                account_booking = BookingData.query.filter_by(user_id = data).filter(BookingData.logged == False).all()
                for i in account_booking:
                    scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[data,i], id=f'{account.id}-{i.park}-{i.site}',minutes =1,max_instances =1)
                    account.add_scan(True)
                    i.logged = True
                    db.session.merge(i)
                    db.session.commit()
                    print('job added')
                return redirect(url_for('auth.bookings'))


@auth.route('/tokentest',methods=['GET','POST'])
@login_required
def token_test():
    
    data = current_user.get_id()
    print('DATA : ',data)
    user = User.query.filter_by(id = data).first()
    newB = BookingData(park ='Porteau Cove',site='5',site_type='campsite',campground = 'A (Sites 1-37)',inner_campground=None,arrival_month='Jan',arrival_day='3',
                arrival_year = '2022',nights = '1',equiptment = '2 Tents',email = 'cheema_mandy@hotmail.com',password = 'Apple9314!!',
                party_size='1',contact_num=f'6046141826',booked = False,user_id=data)
    db.session.add(newB)
    db.session.commit()
    newB.send_link(user,newB)


    return redirect(url_for('auth.account_details'))

@auth.route('/addu',methods =['GET','POST'])
def addu():
                salted_password = bcrypt.generate_password_hash('1').decode('utf-8')
                new_user = User(email = 'frankcastle@gmail.com',password = salted_password,
                        firstName='frank',lastName='castle',confirmed=False,billingAddress=None,
                        postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)
                db.session.add(new_user)
                db.session.commit()
                salted_password = bcrypt.generate_password_hash('1').decode('utf-8')
                new_user = User(email = 'cheems@hotmail.com',password = salted_password,
                        firstName='jak',lastName='cheemo',confirmed=False,billingAddress=None,
                        postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)
                db.session.add(new_user)
                db.session.commit()
                return redirect(url_for('auth.dquery'))

@auth.route('/data',methods =['GET','POST'])
@login_required
def data():
    date = BookingData.query.all()
    for i in date:
        db.session.delete(i)
        db.session.commit()
    Account = User.query.filter_by(email = 'cfarbatuk@gmail.com').first()
    time = bookingTimeTest.query.all()
    for i in time:
        db.session.delete(i)
        db.session.commit()
    Account.is_admins()
    return render_template('data.html',site=date,campground = Account)

@auth.route('/bookings',methods=['GET','POST'])
def bookings():
    data = User.get_id(current_user)
    account = User.query.filter_by(id=data).all()
    time = bookingTimeTest.query.all()
    b = BookingData.query.filter_by(user_id =data).all()
    return render_template('data.html',data = data,campground = account,inner_Campground = time,bookings=b)

@auth.route('/adds',methods = ['GET','POST'])
@login_required
def adds():
    data = User.get_id(current_user)
    account_booking = BookingData.query.get_or_404(data)
    user = User.query.filter_by(id = data).first()
    user.add_scan(True)
    db.session.commit()
    return render_template('data.html',data = user)

@auth.route('/dels',methods = ['GET','POST'])
@login_required
def dels():
    data = User.get_id(current_user)
    user = User.query.filter_by(id = data).first()
    user.delete_scan()
    db.session.commit()
    print(user)
    return render_template('data.html',data = user)

@auth.route('/delU',methods = ['GET','POST'])
def delU():
    user = User.query.all()
    for i in User.query.all():
        if i == User.query.filter_by(email = 'cfarbatuk@gmail.com').first():
            print(' USER : ',i)

        elif i == User.query.filter_by(email='admin@admin.ca').first():
            print(i)
        else:
            db.session.delete(i)
            db.session.commit()
    return render_template('data.html',data = user)

@auth.route('/rar',methods=['GET','POST'])
def rar():
    scheduler.remove_all_jobs()
    
    return render_template('data.html')


