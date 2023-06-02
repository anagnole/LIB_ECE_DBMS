from flask import Flask, render_template, request, flash, redirect, url_for, abort, get_flashed_messages
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.signup import signup
from dbUI.student import student
from dbUI.signup.forms import SignupForm

@signup.route("/signup",methods = ["GET", "POST"])
def getSignup():
    
    form = SignupForm() 

    if(request.method == "POST" and form.validate_on_submit()):
        signupinfo = form.__dict__
        query = "CALL insertuser('{}',{},'{}','{}','{}',{})".format(
            signupinfo['Username'].data,
            signupinfo['Password'].data,
            signupinfo['Role'].data,
            signupinfo['First_Name'].data,
            signupinfo['Last_Name'].data,
            signupinfo['Age'].data
            ) 
        try:
            cur = db.connection.cursor()
            cur.execute(query)
            db.connection.commit()
            cur.close()
            if signupinfo['Role'].data == 'student':
                return redirect(url_for("student.getStudent", username = signupinfo['Username'].data))
            else:   
                return redirect(url_for("teacher.getTeacher", username = signupinfo['Username'].data))
                
        except Exception as e: ## OperationalError
            flash("Sorry, Username already taken.", "danger")    

    return render_template("signup.html", form = form, pageTitle = "Sign Up Page")


