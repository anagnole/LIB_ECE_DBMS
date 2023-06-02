from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, IntegerField
from wtforms.validators import DataRequired, InputRequired, NumberRange

## when passed as a parameter to a template, an object of this class will be rendered as a regular HTML form
## with the additional restrictions specified for each field
class SignupForm(FlaskForm):
    First_Name = StringField(label = "First name", validators = [InputRequired(message = "First name is a required field.")])
    Last_Name = StringField(label = "Last name", validators = [InputRequired(message = "Last name is a required field.")])
    Username = StringField(label = "Username", validators = [InputRequired(message = "Username is a required field.")])
    Password = IntegerField(label = "Password", validators = [InputRequired(message = "Password is a required field.")])
    Age = IntegerField(label="Age", validators=[InputRequired(message="Age is a required field."), 
                                                NumberRange(min=18, max=99)])
    Role = SelectField('Role', choices=['student', 'teacher'])
    SignUp = SubmitField("SignUp")

