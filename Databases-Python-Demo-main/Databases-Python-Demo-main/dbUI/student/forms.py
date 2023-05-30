from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, IntegerField
from wtforms.validators import DataRequired, InputRequired

## when passed as a parameter to a template, an object of this class will be rendered as a regular HTML form
## with the additional restrictions specified for each field
class StudentForm(FlaskForm):
    username = StringField(label = "username", validators = [InputRequired(message = "Username is a required field.")])
    
    password = StringField(label = "password", validators = [InputRequired(message = "Password is a required field.")])

    submit = SubmitField("Login")
