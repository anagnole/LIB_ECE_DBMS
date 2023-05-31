from flask import Flask, render_template, request, flash, redirect, url_for, abort, get_flashed_messages
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.login import login
from dbUI.student import student
from dbUI.teacher import teacher
from dbUI.login.forms import LoginForm

@login.route("/login",methods = ["GET", "POST"])
def getLogin():
    
    form = LoginForm() 

    if(request.method == "POST" and form.validate_on_submit()):
        logininfo = form.__dict__
        query = ("SELECT role_user FROM users WHERE username = '{}' AND U_password = '{}';").format(logininfo['username'].data, logininfo['password'].data) 
        try:
            cur = db.connection.cursor()
            cur.execute(query)
            row = cur.fetchone()
            if(row):
                role = row[0]
            else: 
                raise ValueError("'Incorrect Username or Password'")
            cur.close()
            
            if (role == 'student'): 
                return redirect((url_for("student.getStudent", username = logininfo['username'].data)))
            if (role == 'teacher'): 
                return redirect((url_for("teacher.getTeacher", username = logininfo['username'].data)))
            if (role == 'operator'): 
                return redirect((url_for("operator")))
            if (role == 'admin'): 
                return redirect((url_for("admin")))
            else:
                raise ValueError("'Incorrect Username or Password'") 
                
        except Exception as e: ## OperationalError
            flash(str(e), "danger")    
        
    return render_template("login.html", form = form, pageTitle = "Login Page")


