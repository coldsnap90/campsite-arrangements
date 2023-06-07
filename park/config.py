from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from dotenv import load_dotenv
load_dotenv()
import os




class Config:
    #env = 'pro'
    env = 'devpro'
    ADMIN_PASS = os.environ.get('ENV_ADMIN_PASS')
    STRIPE_LIVE_SECRET_KEY = os.environ.get('ENV_STRIPE_SECRET_KEY')
    STRIPE_LIVE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_PUBLIC_KEY')
    CSRF_ENABLED = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False  
    SCHEDULER_API_ENABLED = True  
  
    if env == 'pro':
        STRIPE_LIVE_SECRET_KEY = os.environ.get('ENV_STRIPE_LIVE_SECRET_KEY')
        STRIPE_LIVE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_LIVE_PUBLIC_KEY')
        SERVER_NAME = "webookcamp.herokuapp.com"
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url='postgresql://tymepwkuzahvve:0686a22d893f8b58c085d79f37af138c242ec3e4e00373d513530f8d17fe3f96@ec2-54-173-77-184.compute-1.amazonaws.com:5432/d473d2peg0efp6')}
    #"sqlite:///db.job"
    elif env == 'dev':
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url='sqlite:///db.database')}
        SERVER_NAME = "127.0.0.1:5000"

        STRIPE_LIVE_SECRET_KEY = os.environ.get('ENV_STRIPE_SECRET_KEY')
        STRIPE_LIVE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_PUBLIC_KEY')
    elif env == 'devpro':
        SERVER_NAME = "127.0.0.1:5000"
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url='postgresql://tymepwkuzahvve:0686a22d893f8b58c085d79f37af138c242ec3e4e00373d513530f8d17fe3f96@ec2-54-173-77-184.compute-1.amazonaws.com:5432/d473d2peg0efp6')}
  
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
'''
class TestingConfig(Config):
    TESTING = True
    WTF_CSRF_ENABLED = False


config = {
    'testing':TestingConfig
}
'''
