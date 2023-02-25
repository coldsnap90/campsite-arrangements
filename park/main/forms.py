from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField,SubmitField,validators,ValidationError
from wtforms.validators import DataRequired, Length, Email,EqualTo
from park.models import User

#tosform
class TosForm(FlaskForm):
        tos_submit = SubmitField('I Agree')
