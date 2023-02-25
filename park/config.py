from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from dotenv import load_dotenv
load_dotenv()
import os


class Config:
    env = 'pro'
    #env = 'dev'
    ADMIN_PASS = os.environ.get('ENV_ADMIN_PASS')
    STRIPE_SECRET_KEY = os.environ.get('ENV_STRIPE_SECRET_KEY')
    STRIPE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_PUBLIC_KEY')
    CSRF_ENABLED = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False  
    SCHEDULER_API_ENABLED = True  
  
    if env == 'pro':
        SERVER_NAME = "webookcamp.herokuapp.com"
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url='sqlite:///db.database')}
        #SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url='postgresql://xqoywsixdkorla:ac760ec6200df59ac4e33e149832a5f7664f3f78de429f22c609722fb9eedf5b@ec2-54-157-79-121.compute-1.amazonaws.com:5432/d9ilpqshnfmtq3')}
    #"sqlite:///db.job"
    elif env == 'dev':
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url='sqlite:///db.database')}
        SERVER_NAME = "127.0.0.1:5000"
  
    SECRET_KEY = os.environ.get('ENV_SECRET_KEY')
    #SECURITY_PASSWORD_SALT = 'SUPER SALTY STRING !@#$%^&*()'
    #SECURITY_PASSWORD_HASH= 'bcrypt'
    MAIL_SERVER = 'smtp.gmail.com'
    #email sent through on your server, 25 or 465
    MAIL_PORT = 587
    #security
    MAIL_USE_TLS = True
    MAIL_USERNAME = ('Campsite.booking.service@gmail.com')
    MAIL_PASSWORD = 'zlqkjylvadcvhacs' 
    MAIL_DEFAULT_SENDER = 'campsite.booking.service@gmail.com'
    MAIL_MAX_EMAILS = 1
    #secure cookies
    #SESSION_COOKIE_SECURE=True
    #SESSION_COOKIE_HTTPONLY=True
    SESSION_COOKIE_SAMESITE='Lax'
    #no file upload
    
