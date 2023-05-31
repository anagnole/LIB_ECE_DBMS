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
        query = "SELECT b.title, bo.b_date FROM borrows bo INNER JOIN book b ON b.ISBN = bo.ISBN WHERE bo.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        borrows = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = "SELECT b.title, r.r_date FROM reserves r INNER JOIN book b ON b.ISBN = r.ISBN WHERE r.username = '{}';".format(username)
        column_names = [i[0] for i in cur.description]
        reserves = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        return render_template("student.html", borrows = borrows,reserves = reserves, username = username, pageTitle = "Student Page")
    except Exception as e:
        abort(500)    



