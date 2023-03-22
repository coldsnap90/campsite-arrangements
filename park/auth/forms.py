
from flask_wtf import FlaskForm
from pyparsing import alphanums
from wtforms import StringField, PasswordField, BooleanField,SubmitField,validators,ValidationError,SelectField,DateField
from wtforms.validators import DataRequired, Length, Email,EqualTo,NumberRange,InputRequired
from park.models import UserMixin, User
from wtforms_validators import ActiveUrl, Alpha, AlphaDash, AlphaSpace,Integer,AlphaNumeric
from datetime import datetime


#several flask forms for login,booking,signup excetra
class ChoiceForm(FlaskForm):
        park = SelectField('ENTER CAMPGROUND.',choices=['','Alice Lake','Bamberton','Bear Creek','Beatton','Beaumont','Big Bar Lake','Birkenhead Lake','Blanket Creek','Bowron Lake','Bromley Rock',
                           'Carp Lake','Champion Lakes','Charlie Lake','Chiliwack Lake','Cowichan River','Crooked River','Cultus Lake','Dry Gulch','E.C. Manning','Elk Falls','Ellison','Englishman River Falls','Fillongley',
                           'Fintry','French Beach','Gladstone','Golden Ears','Gordon Bay','Green Lake','Herald','Horsefly Lake','Inland Lanke','Juan de Fuca','Juniper Beach',
                           'Kekuli Bay','Kentucky Alleyne','Kettle River','Kikomun Creek','Kleanza Creek','Kokanee Creek','Kootenay Lake',' Lac La Hache','Lac Le Jeune','Lakelse Lake','Liard River Hot Springs','Little Qualicum Falls',
                           'Lov  land Bay','Mabel Lake','Martha Creek','McDonald Creek','Meziadin Lake','Miracle Beach','Moberly Lake','Monck','Montague Harbour Marine','Morton Lake','Mount Fernie','Mount Robson','Moyie Lake','Nairn Falls',
                           'Newcastle Island Marine','North Thompson River','Okanagan Lake North','Okanagan Lake South','Otter Lake','Paarens Beach','Paul Lake','Porpoise Bay','Porteau Cove','Premier Lake','Prudhomme Lake','Purden Lake',
                           'Rathtrevor Beach','Red Bluff','Rolley Lake','Rosebery','Saltery Bay','Sasquatch','Shuswap Lake','Silver Lake','Skagit Valley','Smelt Bay','Sowchea Bay','Sproat Lake','Stamp River','Stemwinder','Strathcona',
                           'Summit Lake','Swan Lake','sw̓iw̓s (Haynes Point)','sx̌ʷəx̌ʷnitkʷ (Okanagan Falls)','Syringa','Ten Mile Lake','Tweedsmuir South','Tyhee Lake','Tā Ch’ilā (Boya Lake)','Wasa Lake','Wells Gray','Whiskers Point'],
                           validators=[DataRequired()],render_kw={'style': 'width: 28ch'})
        sites = SelectField('Enter Site #. ',choices=[''],validators=[],render_kw={'style': 'width: 28ch'})
        site_type = SelectField('Enter Site Type. ',choices=['','Campsite','Cabin','Group','Backcountry'],validators=[DataRequired()],render_kw={'style': 'width: 28ch'})
        campground = SelectField('Enter Outer Campground . ',choices=[''],validators=[],render_kw={'style': 'width: 28ch'})
        inner_campground = SelectField('Enter inner Campground. ',choices=[''],validators=[],render_kw={'style': 'width: 28ch'})
        arrival_date = DateField('Enter Date (YYYY-MM-DD)', format='%Y-%m-%d',validators = [DataRequired()],render_kw={'style': 'width: 28ch'})
        contact_num = StringField('Enter Contact number.',validators = [DataRequired(),Length(min=10,max=10,message= '10 digit phone number'),Integer()],render_kw={'style': 'width: 28ch'})
        nights = StringField('NIGHTS, 14 MAX.',validators = [DataRequired(),Length(min=1,max=2,message= 'The value should between 1 & 14'),Integer()],render_kw={'style': 'width: 28ch'})
        equiptment = SelectField('ENTER EQUIPTMENT.',choices=['','1 Tent','2 Tents','3 Tents','Van/Camper','Trailer up to 18ft','Trailer or RV up to 32ft','Trailer or RV over 32ft'],validators = [DataRequired()],render_kw={'style': 'width: 28ch'})
        postal_code = StringField('ENTER POSTAL CODE.',validators =[DataRequired(), Length(min=6,max=6,message= 'The value should be in  A1A 1A1 format'),AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        billing_address = StringField('ENTER BILLING ADDRESS',validators = [DataRequired()],render_kw={'style': 'width: 28ch'})
        city = StringField('ENTER CITY',validators=[DataRequired(),Alpha()],render_kw={'style': 'width: 28ch'})
        province = StringField('ENTER PROVINCE',validators = [DataRequired(),Alpha()],render_kw={'style': 'width: 28ch'})
        country =StringField('ENTER COUNTRY',validators = [DataRequired(),Alpha()],render_kw={'style': 'width: 28ch'})
        email = StringField('ENTER EMAIL.',validators = [DataRequired(),Email()],render_kw={'style': 'width: 28ch'})
        password = StringField('ENTER PASSWORD.',validators = [DataRequired(),Length(min=1,max=64)],render_kw={'style': 'width: 28ch'})
        party_size = StringField('ENTER NUMBER IN PARTY',validators = [DataRequired(),Length(min=1,max=8)],render_kw={'style': 'width: 28ch'})
        card  = StringField('ENTER CARD NUMBER.',validators = [DataRequired(),Length(min=16,max=16),Integer()],render_kw={'style': 'width: 28ch'})
        card_name = StringField('ENTER NAME ON CARD.',validators = [DataRequired(),AlphaSpace()],render_kw={'style': 'width: 28ch'})
        mm = StringField('ENTER EXPIRY MONTH.',validators = [DataRequired(),Length(min=2,max=2),Integer()],render_kw={'style': 'width: 28ch'})
        yy = StringField('ENTER EXPIRY YEAR.',validators = [DataRequired(),Length(min=4,max=4,message="4 digit expiry year, ex 2023"),Integer()],render_kw={'style': 'width: 28ch'})
        code = StringField('ENTER SECURITY CODE.',validators = [DataRequired(),Length(min =3,max=4,message="3-4 digit CVV code."),Integer()],render_kw={'style': 'width: 28ch'})
        occupant = BooleanField('CLICK IF NOT OCCUPANT')
        occupant_first_name = StringField('ENTER OCCUPANT FIRST NAME.',validators = [Alpha()],render_kw={'style': 'width: 28ch'})
        occupant_last_name  = StringField('ENTER OCCUPANT LAST NAME.',validators = [Alpha()],render_kw={'style': 'width: 28ch'})
        occupant_postal_code  = StringField('ENTER OCCUPANT POSTAL CODE.',validators = [AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        occupant_address  = StringField('ENTER OCCUPANT ADDRESS.',validators = [AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        occupant_phone_num  = StringField('ENTER OCCUPANT PHONE NUM.',validators = [AlphaNumeric(),Length(10,10)],render_kw={'style': 'width: 28ch'})
        submit = SubmitField('Submit')

        def validate_date(self,arrival_date):
                if arrival_date < datetime.now().date():
                        return False
                else:
                       return True      
      
class cancelBookingForm(FlaskForm):
       
       park = StringField('ENTER Park.',validators = [Alpha(),DataRequired()],render_kw={'style': 'width: 28ch'})
       camp = StringField('ENTER Camp.',validators = [Alpha(),DataRequired()],render_kw={'style': 'width: 28ch'})
       site = StringField('ENTER Site.',validators = [Alpha(),DataRequired()],render_kw={'style': 'width: 28ch'})
       submit = SubmitField('Submit')
class fakeForm(FlaskForm):
        occupant = SelectField('Enter occpant #. ',choices=['','True','False'],validators=[],render_kw={'style': 'width: 28ch'})
        occupant_first_name = StringField('ENTER OCCUPANT FIRST NAME .',validators = [Alpha()],render_kw={'style': 'width: 28ch'})
        occupant_last_name  = StringField('ENTER OCCUPANT LAST NAME .',validators = [Alpha()],render_kw={'style': 'width: 28ch'})
        occupant_postal_code  = StringField('ENTER OCCUPANT LAST NAME .',validators = [AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        occupant_address  = StringField('ENTER OCCUPANT LAST NAME .',validators = [AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        occupant_phone_num  = StringField('ENTER OCCUPANT LAST NAME .',validators = [AlphaNumeric(),Length(10,10)],render_kw={'style': 'width: 28ch'})
        submit = SubmitField('Submit')
class LoginForm(FlaskForm):
        email = StringField('Email',validators=[DataRequired(),Length(1,64),Email()])     
        email_password = PasswordField('Password',validators = [DataRequired()]) 
        remember_me = BooleanField('Keep me logged in.')
        account_submit = SubmitField('Log in')
        

class testForm(FlaskForm):
        postal_code = StringField('ENTER POSTAL CODE.',validators =[ Length(min=6,max=6,message= 'The value should be in  A1A 1A1 format'),AlphaNumeric()])
        billing_address = StringField('ENTER BILLING ADDRESS',validators = [])
        province = StringField('ENTER COUNTRY Province',validators = [Alpha()])
        country =StringField('ENTER ',validators = [])
        email = StringField('ENTER EMAIL.',validators = [Email()])
        card  = StringField('ENTER CARD NUMBER.',validators = [Length(min=16,max=16)])
        card_name = StringField('ENTER NAME ON CARD.',validators = [AlphaSpace()])
        mm = StringField('ENTER EXPIRY MONTH.',validators = [Length(min=2,max=2)])
        yy = StringField('ENTER EXPIRY YEAR.',validators = [Length(min=2,max=2),])
        code = StringField('ENTER SECURITY CODE.',validators = [Length(min =3,max=4)])
        submit = SubmitField('Submit')
class adminForm(FlaskForm):
        email = StringField('Email',validators=[DataRequired(),Length(1,64),Email()])     
        email_password = PasswordField('Password',validators = [DataRequired()]) 
        account_submit = SubmitField('Log in')
class LoginForm(FlaskForm):
        email = StringField('Email',validators=[DataRequired(),Length(1,64),Email()])     
        email_password = PasswordField('Password',validators = [DataRequired()]) 
        remember_me = BooleanField('Keep me logged in.')
        account_submit = SubmitField('Log in')
class signupForm(FlaskForm):
        user_email = StringField('Email',validators=[DataRequired(),Length(1,64),Email()])
        email_password = PasswordField('Password',validators = [DataRequired(),Length(1,64)])
        first_name = StringField('First Name',validators=[DataRequired(),Length(1,64)])
        last_name = StringField('Last Name',validators=[DataRequired(),Length(1,64)])
        update_account = SubmitField('Update Account.')
        tos_agreement = BooleanField('You have read and agree to TOS.')
        create_account = SubmitField('Create account.')
        
        def validate_email(self,user_email):
                user_email = User.query.filter_by(user_email = user_email.data).first()
                if user_email:
                        raise ValidationError('email already registered.')
class updateForm(FlaskForm):
        email = StringField('Email',validators=[Length(1,64),Email()],render_kw={'style': 'width: 28ch'})
        password = PasswordField('Password',validators = [Length(1,64)],render_kw={'style': 'width: 28ch'})
        re_password = PasswordField('Re-enter Password',validators=[Length(1,64),EqualTo(password)],render_kw={'style': 'width: 28ch'})
        first_name = StringField('First Name',validators=[Length(1,64)],render_kw={'style': 'width: 28ch'})
        last_name = StringField('Last Name',validators=[Length(1,64)],render_kw={'style': 'width: 28ch'})
        address = StringField('Street Address',validators=[Length(1,64),AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        city= StringField('City',validators=[Length(1,64),Alpha()],render_kw={'style': 'width: 28ch'})
        province= StringField('Province',validators=[Length(1,64),Alpha()],render_kw={'style': 'width: 28ch'})
        country = StringField('Country',validators=[Length(1,64),Alpha()],render_kw={'style': 'width: 28ch'})
        postal_code = StringField('Postal Code',validators = [Length(min=6,max=6),AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        phone_num = StringField('Phone number',validators=[Length(10,10),AlphaNumeric()],render_kw={'style': 'width: 28ch'})
        update_account = SubmitField('Update Account.')     
class cancelForm(FlaskForm):
        cancel = StringField('Cancel account',validators=[EqualTo('cancel')])
        cancel_account = SubmitField('Cancel Account')          

class requestResetForm(FlaskForm):
    reset_email = StringField('Enter Email',
                        validators=[DataRequired(), Email()])
    submit = SubmitField('Request Password Reset')

    def validate_email(self, email):
        user = User.query.filter_by(email=email).first()
        if user is None:
            raise ValidationError('There is no account with that email. You must register first.')
           
        else:
                return True

class passwordResetForm(FlaskForm):
        password = PasswordField('Password', validators=[DataRequired()])
        confirm_password = PasswordField('Confirm Password', validators=[DataRequired(), EqualTo('password')])
        submit = SubmitField('Reset Password ')


class productForm(FlaskForm):
        iann_mem_bronze = SubmitField('Subscribe')
        jann_mem_silver = SubmitField('Subscribe')
        kann_mem_gold = SubmitField('Subscribe')
        lann_mem_plat = SubmitField('Subscribe')
        emon_mem_bronze = SubmitField('Subscribe')
        fmon_mem_silver = SubmitField('Subscribe')
        gmon_mem_gold = SubmitField('Subscribe')
        hmon_mem_plat = SubmitField('Subscribe')
        asingle_bronze = SubmitField('Subscribe')
        bsingle_silver = SubmitField('Subscribe')
        csingle_gold = SubmitField('Subscribe')
        dsingle_plat =  SubmitField('Subscribe')
class redirectForm(FlaskForm):
        returning = SubmitField('return', render_kw={'formnovalidate': True})