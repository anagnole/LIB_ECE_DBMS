from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.student import student

@student.route("/student/<string:username>")
def getStudent(username):
    try:
        cur = db.connection.cursor()
        query = "SELECT bo.ret_date, b.title, bo.b_date FROM borrows bo INNER JOIN book b ON b.ISBN = bo.ISBN WHERE bo.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        borrows = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = "SELECT b.title, r.r_date FROM reserves r INNER JOIN book b ON b.ISBN = r.ISBN WHERE r.username = '{}';".format(username)
        column_names = [i[0] for i in cur.description]
        reserves = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("student.html", borrows = borrows, username = username, reserves = reserves, pageTitle = "Student Page")
    except Exception as e:
        abort(500)    

@student.route("/student/profile/<string:username>"  ,methods=['GET', 'POST'])
def getStudentProfile(username):
    try:
        cur = db.connection.cursor()
        query = "SELECT * FROM usernameview WHERE username = '{}';".format(username)

        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        information = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

    except Exception as e:
        abort(500)      
    button_pressed = False  # Initialize button_pressed with a default value
    if request.method == 'POST':
        button_pressed = request.form.get('button_pressed')

    return render_template("student_profile.html", information=information[0], button_pressed=button_pressed, pageTitle="Student Profile")

    

##
 ##   if(request.method == 'POST'):
 ##       return render_template("student_profile.html", information = information[0], button_pressed = button_pressed, pageTitle = "Student Profile")
 ##   button_pressed = request.form.get('button_pressed') 
 ##   return render_template("student_profile.html", information = information[0], button_pressed = False, pageTitle = "Student Profile")
##


