from enum import unique
from anyio import CapacityLimiter
from flask import redirect,url_for,abort,render_template
from .extensions import login_manager,mail,db,admin,Message
#from .extensions import ma
from flask_login import UserMixin,login_user,current_user,login_required,logout_user
#from marshmallow_sqlalchemy import SQLAlchemySchema, auto_field
from flask_admin.contrib.sqla import ModelView
from flask_admin import AdminIndexView,BaseView,expose
from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from flask import current_app
import jwt
from datetime import datetime

from datetime import datetime, timezone, timedelta

roles_users = db.Table('roles_users',db.Column('user_id',db.Integer,db.ForeignKey('users.id')),db.Column('role_id',db.Integer,db.ForeignKey('role.id')))
class Role(db.Model):
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(50),unique= True)

class Park(db.Model):
    __tablename__ = 'parks'
    id = db.Column(db.Integer,primary_key = True)
    park_site = db.Column(db.String(50),unique = True)
    sites = db.relationship('Site',backref='parks')
    
    def __init__(self,park_site):
        self.park_site = park_site
    def __repr__(self):
        return f"park({self.park_site})"
    

class Site(db.Model):

    __tablename__ = 'sites'
    id = db.Column(db.Integer,primary_key = True)
    campground = db.Column(db.String(50))
    inner_campground = db.Column(db.String(50))
    names = db.Column(db.String(50))
    park_id =db.Column(db.Integer,db.ForeignKey('parks.id'))

    def __repr__(self):
        return f"{self.names}, {self.campground},{self.inner_campground}"
    def set_names(self,names):
        if names != None:
            self.names = names
            db.session.merge(self)
    def set_campground(self,campground):
        
            self.inner_Campground = campground
            db.session.merge(self)

    def set_campground(self,inner_campground):
        if inner_campground == None:
            self.inner_campground = inner_campground


    

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

class BookingData(db.Model):
    tablename = 'bookingdatas'
    id = db.Column(db.Integer,primary_key= True)
    park = db.Column(db.String(50))
    site = db.Column(db.String(50))
    site_type = db.Column(db.String(50))
    campground = db.Column(db.String(50))
    inner_campground = db.Column(db.String(50))
    arrival_month = db.Column(db.String(10))
    arrival_day = db.Column(db.String(5))
    arrival_date = db.Column(db.String(20))
    nights = db.Column(db.String(5))
    equiptment = db.Column(db.String(50))
    email = db.Column(db.String(50))
    password = db.Column(db.String(50))
    party_size = db.Column(db.String(50))
    contact_num = db.Column(db.String(11))
    logged = db.Column(db.Boolean,default = False)
    booked = db.Column(db.Boolean,default = False)
    occupant = db.Column(db.Boolean,default = False)
    occupant_first_name = db.Column(db.String(50))
    occupant_last_name = db.Column(db.String(50))
    occupant_address = db.Column(db.String(50))
    occupant_postal_code= db.Column(db.String(50))
    occupant_phone_num = db.Column(db.String(50))
    user_id = db.Column(db.Integer,db.ForeignKey('users.id'))


    def __repr__(self):
        return f"User({self.park},{self.site},{self.site_type},{self.campground},{self.inner_campground},{self.arrival_date},{self.arrival_month},{self.arrival_day},{self.party_size},{self.nights},{self.equiptment},{self.email},{self.password},{self.contact_num},{self.logged},{self.booked},{self.occupant}\
        ,{self.occupant_first_name},{self.occupant_last_name},{self.occupant_address},{self.occupant_postal_code},{self.occupant_phone_num}"
        
    def set_site(self,site):
        self.site = site 
    def set_day(self,day):
        self.arrival_day = day
    def set_mon(self,month):
        self.arrival_month = month
    def set_num(self,contact_num):
        self.contact_num = contact_num
        db.session.merge(self)

    def send_link(self,user):
        token = self.generate_confirmation_token()
        print('GEN TOKEN ', token)
       

        msg = Message('Campsite booking Notifier',
                    recipients=[user.email])
        confirmation_link = url_for('auth.booking_info',token=token,_external=True)
        msg.body = f'''Your site has been booked, follow the link for details:
    {confirmation_link}
    If you did not make this request then simply ignore this email and no changes will be made.
    PS MY SCHMEXY LIL CHEEMO's :) this was booked online through BWC industries <|(=8^p) .
     '''
       
        mail.send(msg)

    def generate_confirmation_token(self,expiration=1000000):

        print('\n\n')
        data = {'confirm': self.id,'exp': datetime.now(timezone.utc) + timedelta(seconds=expiration)}
        return jwt.encode(data, current_app.config['SECRET_KEY'], algorithm="HS256")
   
    
    def token_confirm(self, token, leeway=10):
        print(' \n\n Decoding TOKEN \n\n ')
        try:
            data = jwt.decode(token, current_app.config['SECRET_KEY'], leeway=leeway, algorithms=["HS256"])
        except:
            print('decode false', print(data.get('confirm')))
            return False
        if data.get('confirm') != self.id:
            print(data.get('confirm'), ' == ',self.id)
            print('False')
            return False
        print('/n/n DATA : ',data, data.get('confirm'))
        return True
    
    @staticmethod
    def verify_auth_token(token, leeway=10):
        try:
            data = jwt.decode(token, current_app.config['SECRET_KEY'], leeway=leeway, algorithms=["HS256"])
        except:
            return None
        return User.query.get(data['user_id'])
    

    
class User(db.Model,UserMixin):
    __tablename__ = 'users'
    id = db.Column(db.Integer,primary_key = True)
    email = db.Column(db.String(100),unique=True)
    password = db.Column(db.String(20))
    firstName = db.Column(db.String(20))
    lastName = db.Column(db.String(20))
    confirmed = db.Column(db.Boolean,default = False)
    billingAddress = db.Column(db.String(50))
    postalCode = db.Column(db.String(50))
    city = db.Column(db.String(50))
    province = db.Column(db.String(50))
    country = db.Column(db.String(50))
    subscription = db.Column(db.String(50))
    cId = db.Column(db.String(50))
    sId = db.Column(db.String(50))
    scan = db.Column(db.Integer)
    sub_day = db.Column(db.String(50))
    active = db.Column(db.Boolean)
    phone_num = db.Column(db.String(11))
    is_admin = db.Column(db.Boolean,default=False)
   
    bookingDatas = db.relationship('BookingData',backref='users')
    roles = db.relationship('Role',secondary = 'roles_users',backref='users',lazy='dynamic')
   
    def __init__(self,email,password,firstName,lastName,confirmed,billingAddress,postalCode,city,province,country,subscription,cId,sId,scan,sub_day,phone_num):
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.confirmed = confirmed
        self.billingAddress = billingAddress
        self.postalCode = postalCode
        self.city = city
        self.province = province
        self.country = country
        self.subscription = subscription
        self.cId = cId
        self.sId = sId
        self.scan = scan
        self.sub_day = sub_day
        self.phone_num = phone_num


        
    def __repr__(self):
        return f"User('{self.email}','{self.password}','{self.firstName}','{self.lastName}','{self.confirmed}','{self.billingAddress}','{self.postalCode}','{self.city}','{self.province}','{self.country}','{self.subscription}','{self.cId}','{self.sId}','{self.scan}','{ self.sub_day}','{self.phone_num}','{self.is_admin}')"
    
    
    def is_admins(self):
        print(self.is_admin)
        return

    def temp_sub(self,boole):
        if boole == True:
            self.subscription = 'iann_mem_bronze'
            db.session.merge(self)
        else:
            self.subscription = None
            db.session.merge(self)
        db.session.commit()
        return boole

    def subscription_check(self,value):
        print('/n/n SUB CHECK /n/n')
        productKey = {'iann_mem_bronze':'8000','jann_mem_silver':'16000',
                    'kann_mem_gold':'24000','lanne_mem_plat':'40000','emon_mem_bronze':'800',
                    'fmon_mem_silver':'1600','gmon_mem_gold':'2400','hmon_mem_plat':'4000','asingle_bronze':'600',
                    'bsingle_silver':'1200','csingle_gold':'1800','dsingle_plat':'2400'}
        for i in productKey:
            if productKey[i] == value:
                self.subscription = i
                print(' s = ',self.subscription)
                db.session.merge(self)
                
                print(self.subscription)

                return True
        else:
            return False
    def set_admin(self):
        print('setting admin')
        self.is_admin = True
        db.session.merge(self)
        db.session.commit()
        print(self.is_admin)
        return
    def id_check(self,id):
        if self.cId == None:
            self.cId = id
            db.session.merge(self)
            return True
        else:
            print('ID exists')
            return False
    def id_change(self,id):
            self.cId = id
            db.session.merge(self)
            return True
      

    def sId_check(self,id):
        if self.sId == None:
            self.sId = id
            db.session.merge(self)
            return True
        else:
            print('ID exists')
            return False
  

    def cancel_subscription(self):
        if self.sId != None:
            self.sId = None
            db.session.merge(self)
            return True
        else:
            return False

    def generate_confirmation_token(self, expiration=3600):
        data = {'confirm': self.id, 'exp': datetime.now(timezone.utc) + timedelta(seconds=expiration)}
        return jwt.encode(data, current_app.config['SECRET_KEY'], algorithm="HS256")
        
    def password_reset_mail(user):
        token = user.generate_confirmation_token()
        print('user : ',user.email)
        msg = Message('Account confirmation link',
                    recipients=[user.email])
        confirmation_link = url_for('auth.reset_token',token=token,_external=True)
        msg.body = f'''To confirm your password recovery, visit the following link:
    {confirmation_link}
    If you did not make this request then simply ignore this email and no changes will be made.
    '''
        mail.send(msg)
        return
    
    def confirm(self, token, leeway=10):
        try:
            data = jwt.decode(token, current_app.config['SECRET_KEY'], leeway=leeway, algorithms=["HS256"])
        except:
            return False
        if data.get('confirm') != self.id:
            return False
        self.confirmed = True
        db.session.add(self)
        return True
    
    @staticmethod
    def verify_auth_token(token, leeway=10):
        try:
            data = jwt.decode(token, current_app.config['SECRET_KEY'], leeway=leeway, algorithms=["HS256"])
        except:
            return None
        id = data.get('confirm')
        
        return User.query.get(id)
    
    def add_scan(self,add):
        print('SCAN CHECK : ',self.scan,add)
        if self.scan == None:
            self.scan = 1
            
        elif add == True:
            self.scan = (int(self.scan)+1)
        else:
            self.scan = (int(self.scan)-1)
        db.session.merge(self)
        db.session.commit()

    def delete_scan(self):
        if self.scan != None:
            self.scan = None
            db.session.merge(self)
            db.session.commit()
            
    def sub_date(self):
        if self.sub_day == None:
            now = datetime.now()
            sub_day = now.strftime("%m/%d/%Y %H:%M:%S")
            db.session.merge(self)

class Control(ModelView):
    def is_accessible(self):
        if current_user.is_admin == True:
            return current_user.is_authenticated
        else:
            return abort(404)
    def inaccessible_callback(self, name, **kwargs):
        return redirect(url_for('auth.login'))
class AdminPermission(AdminIndexView):
    def is_accessible(self):
        if current_user.is_admin == True:
            return current_user.is_authenticated
        else:
            return abort(404)
    def inaccessible_callback(self, name, **kwargs):
        return redirect(url_for('auth.login'))
class MyView(BaseView):
    def is_accessible(self):
        if current_user.is_admin == True:
            return True
        else:
            return abort(404)
   
    def inaccessible_callback(self, name, **kwargs):
        return redirect(url_for('auth.login'))
class MyHomeView(AdminIndexView):
    @expose('/')
    def index(self):
        arg1 = 'Hello'
        return self.render('admin/myhome.html', arg1=arg1)

admin.add_view(Control(User,db.session))
admin.add_view(ModelView(BookingData,db.session))


class bookingTimeTest(db.Model):
    id = db.Column(db.Integer,primary_key= True)
    site = db.Column(db.String(50))
    time_delta = db.Column(db.String(20))
    date_delta = db.Column(db.String(20))
    success = db.Column(db.Boolean,default=False)
    failed_at = db.Column(db.String(20))
    failed_number = db.Column(db.Integer)
    def __repr__(self):
        return f"Time (' time delta '{self.time_delta}', - date delta : '{self.date_delta}', - Success : '{self.success}', - Fail : '{self.failed_at}', - Site : '{self.site}', - failed numbers : '{self.failed_number}'"
    def __init__(self,time_delta,date_delta,success,failed_at,site,failed_number):
        self.date_delta = date_delta
        self.time_delta = time_delta
        self.success=success
        self.failed_at = failed_at
        self.site = site
        self.failed_number = failed_number

    def successful_booking(self,time_delta_X1,time_delta_X2,success,site):
        if self.time_delta == None:
            time_delta = time_delta_X2 - time_delta_X1
            self.time_delta = f'{time_delta} seconds'   
        if success == True:
            self.success = True
        self.site = site
     
        return
    def failed_booking(self,time_delta_X1,time_delta_X2,failed_at,site,failed_number):
            time_delta = time_delta_X2 - time_delta_X1
            self.time_delta = f'{time_delta} seconds'
            self.failed_at = failed_at
            self.success = False
            self.site = site
            if self.failed_number == None:
                self.failed_number = 1
            else:
                self.failed_number = int(self.failed_number + failed_number)
            db.session.merge(self)
            db.session.commit()
       
            
            return
admin.add_view(ModelView(bookingTimeTest,db.session))
'''
class UserSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
       model = User
       load_instance = True
class ParkSchema(ma.SQLAlchemySchema):
    class Meta:
        model = Park 
        load_instance = True
    id = auto_field()
    park_site = auto_field()
  
class SiteSchema(ma.SQLAlchemySchema):
    class Meta:
        model = Site
        load_instance = True
    id = auto_field()
    campground = auto_field()
    inner_campground = auto_field()
    names = auto_field()
    park_id = auto_field()

'''
        
