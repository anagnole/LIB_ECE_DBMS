from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.student import student
from dbUI.student.forms import StudentForm
from dbUI.book import book

@student.route("/student/<string:username>")
def getStudent(username):
    try:
        cur = db.connection.cursor()
        query = "SELECT bo.ret_date, b.title, bo.b_date FROM borrows bo INNER JOIN book b ON b.ISBN = bo.ISBN WHERE bo.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        borrows = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = "SELECT b.title, r.r_date FROM reserves r INNER JOIN book b ON b.ISBN = r.ISBN WHERE r.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        reserves = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("student.html", borrows = borrows, username = username, reserves = reserves, pageTitle = "Student Page")
    except Exception as e:
        abort(500)    

@student.route("/student/profile/<string:username>", methods=['GET', 'POST'])
def getStudentProfile(username):
    form = StudentForm()
    if(request.method == "POST" and form.validate_on_submit()):
        studentinfo = form.__dict__
    try:
        cur = db.connection.cursor()
        query = "SELECT * FROM usernameview u INNER JOIN users us ON u.username = us.username WHERE u.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        information = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

    except Exception as e:
        abort(500)      

    return render_template("student_profile.html", information=information[0], pageTitle="Student Profile", form = form)



