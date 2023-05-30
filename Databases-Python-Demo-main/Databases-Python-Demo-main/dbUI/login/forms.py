from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, IntegerField
from wtforms.validators import DataRequired, NumberRange

## when passed as a parameter to a template, an object of this class will be rendered as a regular HTML form
## with the additional restrictions specified for each field
class LoginForm(FlaskForm):
    Username = StringField(label = "Username", validators = [DataRequired(message = "Username is a required field.")])
 
    Password = StringField(label = "Password", validators = [DataRequired(message = "Password is a required field.")])

    Login = SubmitField("Login")
