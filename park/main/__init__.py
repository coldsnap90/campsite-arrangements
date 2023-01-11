from flask import Blueprint


#blueprint instantiation
main = Blueprint('main',__name__)
from park.main import views