import unittest
from park import create_app,db
from park.models import User,BookingData
from park.config import TestingConfig
from flask import current_app
import os

from flask_login import current_user,login_user
#os.environ['DATABASE_URL']='sqlite://'

class FlaskClientTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['WTF_CSRF_ENABLED'] = False
      
        self.app_context = self.app.app_context()
        self.app_context.push()

        db.create_all()
        self.client = self.app.test_client(use_cookies = True)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        self.app_context.pop()

    def test_app(self):
        assert self.app is not None
        assert current_app == self.app

    def test_home_page(self):
        print('home page test')
        response = self.client.get('/')
        self.assertEqual(response.status_code,200)

    def test_signup_and_login(self):
        print('sign up and login teast')
        response = self.client.get('/auth/signup')
        self.assertEqual(response.status_code,200)
        response = self.client.post('/auth/signup',data={"user_email":'cheemok@gmail.com',"email_password":'Machine81','first_name':'Col','last_name':'will','tos_agreement':True},follow_redirects=True)
        self.assertEqual(response.status_code,200)
        response = self.client.post('/auth/login',data={"user_email":'cheemok@gmail.com',"email_password":'Machine81',"remember_me":True},follow_redirects = True)
        self.assertEqual(response.status_code,200)
        response = self.client.get('/auth/logout',follow_redirects = True)
        self.assertEqual(response.status_code,200)
    
    def test_booking(self):
        print('\n\nbooking test')
        new_u =User(email = 'cfarbatuk@gmail.com',password = 'Machine81',
                        firstName='col',lastName='will',confirmed=True,billingAddress=None,
                        postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)   
        db.session.add(new_u)
        db.session.commit()
        email_found = User.query.filter_by(email='cfarbatuk@gmail.com')
        response = self.client.post('/auth/login',data={"user_email":'cfarbatuk@gmail.com',"email_password":'Machine81',"remember_me":True},follow_redirects = True)
        login_user(email_found,remember=True)
        
        self.assertEqual(response.status_code,200)
        
        print('login')
        response = self.client.post('/auth/book',data={"park":'Porteau Cove',"site":'8','site_type':'Campsite',"campground":'A (Sites 1-37)','inner_campground':None,
                                    'arrival_date':'2023-02-23','arrival_month':'Feb','arrival_day':'23','nights':'2','equiptment':'1 Tent',
                                    'email':'cfarbatuk@gmail.com','password':'frank123','party_size':'4','contact_num':'6046141872'})
        
        self.assertEqual(response.status_code,200)
        print(response.data)
     