
from flask import Flask
from .config import Config
from .commands import create_tables
from .extensions import db,bcrypt,mail,moment,scheduler,migrate,admin,login_manager,csrf
import os
from park.models import MyHomeView


ENV = ''
def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(Config)

    if ENV == 'Dev':
        app.config['DATABASE_URL'] ='postgres://bjpvjcjrblhewe:b607e31ec5c79adf08f4b03eb882c2560750487c1deeb879d1eb469f1aa2c1ea@ec2-34-234-240-121.compute-1.amazonaws.com:5432/d2392a684obolf'
        x = 'postgresql-colorful-60964'
    else:
        #app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.database'
        app.config['ADMIN_PASS'] = os.environ.get('ADMIN_PASS')
        #app.config['SQLALCHEMY_DATABASE_URI'] ='postgresql//:username:password@hostname:port/database'5432
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