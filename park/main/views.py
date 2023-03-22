from email.message import Message
from flask import render_template,request,redirect,url_for,jsonify,make_response,session,flash,Blueprint,current_app,app
from park.extensions import bcrypt,db,mail,scheduler
from apscheduler.triggers.combining import OrTrigger,AndTrigger
from apscheduler.triggers.cron import CronTrigger
from apscheduler.triggers.interval import IntervalTrigger
from flask_login import login_user, current_user, logout_user, login_required
from park.booking import *
from park.main.forms import *
from park.models import *
from park.main import main
from park.auth.forms import ChoiceForm


@main.route('/',methods =['GET','POST'])
def index():
    return render_template('base.html')

@main.route('main/tos',methods=['POST'])
def tos():
    tosForm = TosForm()
    if tosForm.is_submitted():
            return redirect(url_for('/'))
    return render_template('tos.html',tosForm=tosForm)

@main.route('/create_admin',methods =['GET','POST'])
def create_admin():
    print('admin')
    add = 'Frank'
    if current_user.is_admin:
        return render_template('admin_signup.html')
    else:
        Accounts = User.query.filter_by(email = 'cfarbatuk@gmail.com').first()
        Accounts.set_admin() 
        return render_template('/admin/index.html',title = 'Admin Login',add =add)
    
@main.route('/admin/',methods =['GET','POST'])
def admin():

    if current_user.is_admin:
        return render_template('admin_signup.html')
    else:
        return render_template('/admin/index.html',title = 'Admin Login')


#ignore these functions below,they were all used in pseudo-testing the app and database querying

@main.route('/deldata',methods=['GET','POST'])
def deldata():
   Accounts = User.query.filter_by(email = 'cfarbatuk@gmail.com').first() 
   Account = BookingData.query.filter_by(id = Accounts.id).first() 
   print(BookingData.query.all())
   db.session.delete(Account)
   db.session.flush()
   db.session.commit()
   return render_template('data.html',data = Accounts)

@main.route('/delbooking',methods=['GET','POST'])
def delbooking():
   Account = User.query.filter_by(email = 'cfarbatuk@gmail.com').first() 
   del Account
   db.session.flush()
   db.session.commit()
   return render_template('data.html',data = Account)

@main.route('/data',methods =['GET','POST'])
def data():
    date = User.query.all()
    B = BookingData.query.filter_by(user_id = User.get_id(current_user)).first()
    db.session.commit()
    Account = User.query.filter_by(email = 'cfarbatuk@gmail.com').first()
    return render_template('data.html',data = B,site=date,campground = Account)


@main.route('/deleteallbookings',methods=['GET','POST'])
def deleteallbookings():
    b4 = BookingData.query.all()
    db.session.delete(b4)
    db.session.commit()
    b5=BookingData.query.all()
    return render_template('data.html',data = b4, site =b5)
@main.route('/checkuser',methods=['GET','POST'])
def check_user():
    b5 = User.query.all()
    b4 = BookingData.query.all()
    Account = bookingTimeTest.query.all()

    return render_template('data.html',data = b4, site =b5,campground = Account)