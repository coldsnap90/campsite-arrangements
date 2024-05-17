from flask import url_for
from flask_login import UserMixin,login_user,current_user,login_required,logout_user
from park.models import *
from park.extensions import bcrypt,db
import pytest
import pytest_mock



@pytest.mark.paramaterize('email_password,valid',[
        ("Abcde12345", True),
        ("12345Abcde", True),
        ("Abcdefghij", True),
        ("abcde12345", False),
        ("ABCDE12345", False),
        ("12345678", False),
        ("Abc123", False),
    ])



def test_home(app):

            response = app.get(url_for('auth.login'))
            assert response.status_code == 200

            responsed = app.get('/')
            assert b'<title>Home</title>' in responsed.data

def test_register(app):
        with app:
                response = app.get('/auth/login')
                assert response.status_code == 200
                response =  app.post('/auth/signup',data={"user_email":'ccheemok@gmail.com',"email_password":'Machine81','first_name':'Col','last_name':'will','tos_agreement':True},follow_redirects=True)
                assert response.status_code == 200
                try:
                    new_user = User.query().filter_by(email='ccheemok@gmail.com').first()
                finally:
                        assert new_user == 'ccheemok@gmail.com'
def test_user(mocker):
        mocker.patch()           
                
def test_model(app):
        user = User()
        salted_password = bcrypt.generate_password_hash(signUpForm.email_password.data).decode('utf-8')
        new_user = User(email = signUpForm.user_email.data,password = salted_password,
                        firstName=signUpForm.first_name.data,lastName=signUpForm.last_name.data,confirmed=False,billingAddress=None,
                        ostalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None) 
   
