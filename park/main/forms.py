from flask_wtf import FlaskForm
from wtforms import SubmitField


#tosform
class TosForm(FlaskForm):
        tos_submit = SubmitField('I Agree')
