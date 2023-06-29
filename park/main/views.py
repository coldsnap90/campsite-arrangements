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
import logging
import sys


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
        return render_template('/admin/index.html',title = 'Admin Login')

    else:
        return render_template('admin_signup.html')
    
@main.route('/admin/rar',methods =['GET','POST'])
def admin_job_check():
    if current_user.is_admin:
        print(scheduler.get_jobs())
        for job in scheduler.get_jobs():
            print("name: %s, trigger: %s, next run: %s, handler: %s" % (
          job.name, job.trigger, job.next_run_time, job.func))
        return render_template('/data.html',data = scheduler.get_jobs)
    else:
        return render_template('admin_signup.html')
    
    
@main.route('/admin/job-check',methods =['GET','POST'])
def admin_job_remove():
    if current_user.is_admin:
         scheduler.remove_all_jobs()
         logging.basicConfig(stream=sys.stdout) 
         logging.getLogger('apscheduler').setLevel(logging.DEBUG)
         return 'removed'
        
    else:
        return render_template('admin_signup.html')
@main.route('/checkuser',methods=['GET','POST'])
def check_user():
    Account = bookingTimeTest.query.all()
    db.session.delete(Account)
    db.session.commit()

    return render_template('data.html',data = Account)
