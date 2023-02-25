
from flask import Flask
from .config import Config
from .commands import create_tables
from .extensions import db,bcrypt,mail,moment,scheduler,migrate,admin,login_manager,csrf
import os
from park.models import MyHomeView


ENV = 'Dev'
def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(Config)

    if ENV == 'Dev':

        app.config['SQLALCHEMY_DATABASE_URI'] ='postgres://xqoywsixdkorla:ac760ec6200df59ac4e33e149832a5f7664f3f78de429f22c609722fb9eedf5b@ec2-54-157-79-121.compute-1.amazonaws.com:5432/d9ilpqshnfmtq3'

    else:
        #app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.database'
        app.config['ADMIN_PASS'] = os.environ.get('ADMIN_PASS')
        #app.config['SQLALCHEMY_DATABASE_URI'] ='postgresql//:username:password@hostname:port/database'
    with app.app_context():
        csrf.init_app(app)
        db.init_app(app)
        login_manager.login_view = 'auth.login'
        login_manager.init_app(app)
        bcrypt.init_app(app)
        mail.init_app(app)
        moment.init_app(app)
        scheduler.init_app(app)
        migrate.init_app(app,db)
        admin.init_app(app)
        


        #makes these two blueprints
        
        from park.auth import auth as auth_blueprint
        from park.main import main as main_blueprint
    
        app.register_blueprint(auth_blueprint,url_prefix='/auth',templates_folder='templates')
        app.register_blueprint(main_blueprint,url_prefix='/',templates_folder='templates')
        
        db.create_all()
       
        
        scheduler.start()
        #app.cli.add_command('create_tables')
    return app