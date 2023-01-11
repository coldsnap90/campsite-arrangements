from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager,current_user
from flask_mail import Mail,Message
from flask_moment import Moment
from flask_apscheduler import APScheduler
from flask_migrate import Migrate
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView
from flask_wtf.csrf import CSRFProtect






scheduler = APScheduler()
db = SQLAlchemy()
bcrypt = Bcrypt()
moment = Moment()
mail = Mail()
login_manager = LoginManager()
migrate = Migrate()
admin = Admin()
csrf = CSRFProtect()


