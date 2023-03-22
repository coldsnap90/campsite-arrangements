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
    
@main.route('/admin/',methods =['GET','POST'])
def admin():
    if current_user.is_admin:
        return render_template('admin_signup.html')
    else:
        return render_template('/admin/index.html',title = 'Admin Login')


#ignore these functions below,they were all used in pseudo-testing the app and database querying

