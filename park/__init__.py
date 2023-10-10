from flask import Flask
from .config import Config
from .extensions import db,bcrypt,mail,moment,scheduler,migrate,admin,login_manager,csrf,cache



ENV = ''
def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(Config)
    with app.app_context():
        csrf.init_app(app)
        db.init_app(app)
        login_manager.login_view = 'auth.login'
        login_manager.init_app(app)
        bcrypt.init_app(app)
        mail.init_app(app)
        moment.init_app(app)
        scheduler.init_app(app)
        migrate.init_app(app,db, render_as_batch=True)
        admin.init_app(app)
        cache.init_app(app)
        
        from park.auth import auth as auth_blueprint
        from park.main import main as main_blueprint
    
        app.register_blueprint(auth_blueprint,url_prefix='/auth',templates_folder='templates')
        app.register_blueprint(main_blueprint,url_prefix='/',templates_folder='templates')

        cache.clear()
        db.create_all()
        scheduler.start()
   

    return app