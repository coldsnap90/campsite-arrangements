from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from apscheduler.executors.pool import ThreadPoolExecutor, ProcessPoolExecutor
from dotenv import load_dotenv
load_dotenv()
import os




class Config:
    env = ''
    ADMIN_PASS = os.environ.get('ENV_ADMIN_PASS')
    STRIPE_LIVE_SECRET_KEY = os.environ.get('ENV_STRIPE_SECRET_KEY')
    STRIPE_LIVE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_PUBLIC_KEY')
    ENDPOINT_SECRET = os.environ.get("ENV_ENDPOINT_SECRET")
    CSRF_ENABLED = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False  
    SCHEDULER_API_ENABLED = True  
  
    if env == 'pro_env':
        ADMIN_PASS = os.environ.get('ADMIN_PASS')
        SQLALCHEMY_DATABASE_URI = os.environ.get('ENV_DATABASE_CONNECT')
        STRIPE_LIVE_SECRET_KEY = os.environ.get('ENV_STRIPE_LIVE_SECRET_KEY')
        STRIPE_LIVE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_LIVE_PUBLIC_KEY')
        SERVER_NAME = "webookcamp.herokuapp.com"
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url=os.environ.get('ENV_DATABASE_CONNECT'))}
        SCHEDULER_EXECUTORS = {'default': ThreadPoolExecutor(3),'processpool': ProcessPoolExecutor(3)}
    elif env == 'dev_env':
        ADMIN_PASS = os.environ.get('ADMIN_PASS')
        SQLALCHEMY_DATABASE_URI = os.environ.get("ENV_LOCAL_DB")
        SERVER_NAME = "127.0.0.1:5000"
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url=os.environ.get('ENV_LOCAL_DB'))}
        SCHEDULER_EXECUTORS = {'default': ThreadPoolExecutor(3),'processpool': ProcessPoolExecutor(3)}
    elif env == 'prod_env':
        SQLALCHEMY_DATABASE_URI = os.environ.get('ENV_DATABASE_CONNECT')
        SERVER_NAME = "webookcamp.herokuapp.com"
        SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url=os.environ.get('ENV_DATABASE_CONNECT'))}
        SCHEDULER_EXECUTORS = {'default': ThreadPoolExecutor(3),'processpool': ProcessPoolExecutor(3)}
    
    SECRET_KEY = os.environ.get('ENV_SECRET_KEY')
    STRIPE_LIVE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_PUBLIC_KEY')
    MAIL_SERVER = 'smtp.gmail.com'
    #email sent through on your server, 25 or 465
    MAIL_PORT = os.environ.get("ENV_MAIL_PORT")
    MAIL_USE_TLS = True
    MAIL_USERNAME = ('Campsite.booking.service@gmail.com')
    MAIL_PASSWORD = os.environ.get("ENV_MAIL_PASSWORD")
    MAIL_DEFAULT_SENDER = 'Campsite.booking.service@gmail.com'
    MAIL_MAX_EMAILS = 1
    SESSION_COOKIE_SAMESITE='Lax'
    CACHE_TYPE = 'SimpleCache'


 
    #secure cookies
    #SESSION_COOKIE_SECURE=True
    #SESSION_COOKIE_HTTPONLY=True
   

