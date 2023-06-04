from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, IntegerField
from wtforms.validators import DataRequired, InputRequired, NumberRange, Optional

## when passed as a parameter to a template, an object of this class will be rendered as a regular HTML form
## with the additional restrictions specified for each field
class AdminForm(FlaskForm):
    year = IntegerField('year', validators=[Optional(), NumberRange(min = 2021, max = 2023)])
    month = SelectField('month', choices=['01', '02', '03','04','05','06','07','08','09','10','11','12'], validators=[Optional()])
    search = SubmitField("search")

class Admin2Form(FlaskForm):
    category = SelectField("category",
        choices=[
            "History",
            "Cooking",
            "Fantasy",
            "Fiction",
            "Biography",
            "Mystery",
            "Romance",
            "Science Fiction",
            "Self-Help",
            "Thriller"],
        validators=[Optional()])
    search = SubmitField("search")

class CreateSchool(FlaskForm):
    s_name = StringField(label = "s_name", validators = [DataRequired(message = "School Name is a required field.")])
    
    address = StringField(label = "address", validators = [DataRequired(message = "Address is a required field.")])

    city = StringField(label = "city", validators = [DataRequired(message = "City is a required field.")])

    phone_number = IntegerField("phone_number", validators = [DataRequired(message = "Phone number is a required field.")])

    email = StringField(label = "email", validators = [DataRequired(message = "Email is a required field.")])

    p_full_name = StringField(label = "p_full_name", validators = [DataRequired(message = "Priniciple Full Name is a required field.")])

    enter_school = SubmitField("enter")



