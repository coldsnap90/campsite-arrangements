import unittest
from park import create_app,db,scheduler
from park.auth.views import schedule_site
from park.models import User,BookingData
from park.extensions import bcrypt
from flask import current_app
import os

from flask_login import current_user,login_user
#os.environ['DATABASE_URL']='sqlite://'

class FlaskClientTestCase(unittest.TestCase):
    def setUp(self):
        self.app = create_app()
        self.app.config['WTF_CSRF_ENABLED'] = False
        self.app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.test'
      
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
        response = self.client.get('/')
        self.assertEqual(response.status_code,200)

    def test_signup_and_login(self):
        response = self.client.get('/auth/signup')
        self.assertEqual(response.status_code,200)
        response = self.client.post('/auth/signup',data={"user_email":'cheemok@gmail.com',"email_password":'Machine81','first_name':'Col','last_name':'will','tos_agreement':True},follow_redirects=True)
        self.assertEqual(response.status_code,200)

        with self.client:
            response = self.client.post('/auth/login',data={"user_email":'cheemok@gmail.com',"email_password":'Machine81',"remember_me":True},follow_redirects = True)
            self.assertEqual(response.status_code,200)
            email_found = User.query.filter_by(email='cheemok@gmail.com').first()
            login_user(email_found)
            response = self.client.get('/auth/logout',follow_redirects = True)
            self.assertEqual(response.status_code,200)

    @unittest.expectedFailure
    def test_fail(self):
        with self.client:
            email_found = User.query.filter_by(email='cheemok@gmail.com').first()
            self.assertIsNone(email_found)
            booking = BookingData.query.all()
            self.assertIsNone(booking)

    def test_booking(self):
        with self.client:
            response = self.client.post('/auth/signup',data={"user_email":'cheemok@gmail.com',"email_password":'Machine81','first_name':'Col','last_name':'will','tos_agreement':True},follow_redirects=True)
            self.assertEqual(response.status_code,200)
            
            response = self.client.post('/auth/login',data={"user_email":'cheemok@gmail.com',"email_password":'Machine81',"remember_me":True},follow_redirects = True)
            self.assertEqual(response.status_code,200)

            email_found = User.query.filter_by(email='cheemok@gmail.com').first()
            login_user(email_found)
            self.assertTrue(current_user.firstName == 'Col')
            self.assertIsNot(email_found,None)
      
            email_found.confirmed = True
            db.session.commit()
            email_found.cId = 'cus_NWQdnEeYLYrw0p'
            db.session.commit()
            email_found.subscription = 'iann_mem_bronze'
            db.session.commit()
      
            response = self.client.get('/auth/book',follow_redirects = True)
            self.assertEqual(response.status_code,200)
         
           
            response = self.client.post('/auth/book',data={"park":'Porteau Cove',"sites":'8','site_type':'Campsite',"campground":'A (Sites 1-37)','inner_campground':None,
                                        'arrival_date':'2023-02-23','nights':'2','equiptment':'1 Tent','postal_code':'v2v3a3','province':'B.C','card_name':'Col Will','card':'4242424242424242','mm':'11','yy':'2026','code':'359',
                                        'email':'cheemok@gmail.com','password':'frank123','party_size':'4','city':'langley','country':'canada','billing_address':'33259 Rob','contact_num':'6046141872','logged':False,'booked':False,'occupant':False,'user_id':{email_found.id}},follow_redirects = True)
            booking = BookingData.query.all()
            self.assertEqual(response.status_code,200)
            self.assertIsNot(booking,None)

            test_user = User.query.filter_by(email='cheemok@gmail.com').first()
            booking = BookingData.query.filter_by(user_id=test_user.id).first()
            job_added = scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[test_user.id,booking], id=f'{test_user.id}-{booking.park}-{booking.campground}-{booking.site}-{booking.arrival_date}',minutes =2,max_instances =1)
            self.assertIsNotNone(job_added)
            scheduler.remove_all_jobs()
            self.assertTrue(len(scheduler.get_jobs()) == 0)
     