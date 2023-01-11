from apscheduler.jobstores.sqlalchemy import SQLAlchemyJobStore
from dotenv import load_dotenv
load_dotenv()
import os


class Config:
 
    ADMIN_PASS = os.environ.get('ENV_ADMIN_PASS')
    STRIPE_SECRET_KEY = os.environ.get('ENV_STRIPE_SECRET_KEY')
    STRIPE_PUBLIC_KEY = os.environ.get('ENV_STRIPE_PUBLIC_KEY')
    CSRF_ENABLED = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False  
    SCHEDULER_API_ENABLED = True  
    #SERVER_NAME = "localhost:5000"
    SCHEDULER_JOBSTORES = {"default": SQLAlchemyJobStore(url="sqlite:///db.job")}
    SQLALCHEMY_DATABASE_URI = 'sqlite:///db.database'
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
    
