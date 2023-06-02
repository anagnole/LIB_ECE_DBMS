from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.teacher import teacher

@teacher.route("/teacher/<string:username>")
def getTeacher(username):
    try:
        cur = db.connection.cursor()
        query = "SELECT b.title, bo.b_date FROM borrows bo INNER JOIN book b ON b.ISBN = bo.ISBN WHERE bo.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        borrows = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = "SELECT b.title, r.r_date FROM reserves r INNER JOIN book b ON b.ISBN = r.ISBN WHERE r.username = '{}';".format(username)
        column_names = [i[0] for i in cur.description]
        reserves = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        return render_template("teacher.html", borrows = borrows,reserves = reserves, pageTitle = "Teacher Page")
    except Exception as e:
        abort(500)    

@teacher.route("/teacher/delete/<string:username>", methods=['GET', 'POST'])
def deleteTeacher(username):
    if(request.method == "POST"):
        try:
            query = "CALL delete_user('{}');".format(username)
            cur = db.connection.cursor()
            cur.execute(query)
            db.connection.commit()
            cur.close()
            return redirect(url_for("index"))
        except Exception as e:
            abort(500)  


