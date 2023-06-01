from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, SelectField, IntegerField
from wtforms.validators import DataRequired, Email, NumberRange, Optional

class ReviewForm(FlaskForm):  
    Comments = StringField(label="Comments", validators=[Optional()])
    Rating = IntegerField(label="Rating", validators=[DataRequired(message="Rating is a required field."), NumberRange(min=0, max=5)])
    submit = SubmitField("Submit")