
from flask import render_template,redirect,url_for
from park.extensions import scheduler,cache
from flask_login import current_user
from park.booking import *
from park.main.forms import *
from park.auth.forms import adminForm
from park.main import main
import logging
import sys




@main.route('/',methods =['GET','POST'])
@cache.cached(timeout=200)
def index():
    return render_template('base.html')


@main.route('main/tos',methods=['POST'])
@cache.cached(timeout = 200)
def tos():
    tosForm = TosForm()
    if tosForm.is_submitted():
            return redirect(url_for('/'))
    return render_template('tos.html',tosForm=tosForm)
    

@main.route('/admin/',methods =['GET','POST'])
def admin():
    form = adminForm()
 
    if current_user.is_admin:
        return render_template('/admin/index.html',title = 'Admin Login')
    
    else:
        return render_template('admin_signup.html',adminForm = form)
    

@main.route('/admin/jobCheck',methods =['GET','POST'])
def admin_job_check():
    form = adminForm()

    if current_user.is_admin:
        return render_template('data.html',data = scheduler.get_jobs())
    
    else:
        return render_template('admin_signup.html',adminForm = form)
     

@main.route('/admin/removeJobs',methods =['GET','POST'])
def admin_job_remove():
    form = adminForm()

    if current_user.is_admin:
         scheduler.remove_all_jobs()
         logging.basicConfig(stream=sys.stdout) 
         logging.getLogger('apscheduler').setLevel(logging.DEBUG)
         return 'removed' 
    
    else:
        return redirect(url_for('auth.create_admin'))
    


