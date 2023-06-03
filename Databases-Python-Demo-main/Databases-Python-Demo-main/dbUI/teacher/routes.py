from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.teacher import teacher
from dbUI.teacher.forms import TeacherForm
from dbUI import app
from dbUI.book import book

@teacher.route("/teacher/<string:username>")
def getTeacher(username):
    try:
        
        cur = db.connection.cursor()
        query = "SELECT b.title, bo.b_date FROM borrows bo INNER JOIN book b ON b.ISBN = bo.ISBN WHERE bo.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        borrows = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = "SELECT b.title, r.r_date FROM reserves r INNER JOIN book b ON b.ISBN = r.ISBN WHERE r.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        reserves = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = ("SELECT Library_card FROM approves_user WHERE username = '{}';".format(username))
        cur.execute(query)
        result = cur.fetchone()
 
        if result is not None:
            library_card = result[0]
            has = 1 if library_card == 1 else 0
        else:
            has = 0
        cur.close()

        return render_template("teacher.html", borrows = borrows, username = username, reserves = reserves, has=has,pageTitle = "Teacher Page")
    except Exception as e:
        abort(500)    

@teacher.route("/teacher/delete/<string:username>", methods=['GET', 'POST'])
def deleteTeacher(username):
    if(request.method == "POST"):
        try:
            query = "SELECT role_user FROM users WHERE username = '{}';".format(username)
            cur = db.connection.cursor()
            cur.execute(query)
            row = cur.fetchone()
            if(row):
                role = row[0]
            if(role == 'operator'):
                raise ValueError("'Operators can't delete themselves'")
            cur.close()
            query = "CALL delete_user('{}');".format(username)
            cur = db.connection.cursor()
            cur.execute(query)
            db.connection.commit()
            cur.close()
            return redirect(url_for("index"))
        except Exception as e:
            abort(500) 

@teacher.route("/teacher/profile/<string:username>", methods=['GET', 'POST'])
def getTeacherProfile(username):

    form = TeacherForm()

    if(request.method == "POST" and form.validate_on_submit()):

        teacherinfo = form.__dict__
        
        if teacherinfo["first_name"].data:
            try:
                query = "UPDATE teacher_user SET teacher_first_name = '{}' WHERE Username = '{}';".format(
                    teacherinfo["first_name"].data,
                    username
                    )
                cur = db.connection.cursor()
                cur.execute(query)
                db.connection.commit()
                cur.close()
            except Exception as e:
                abort(500)

        if teacherinfo["last_name"].data:
            try:
                query = "UPDATE teacher_user SET teacher_last_name = '{}' WHERE Username = '{}';".format(
                    teacherinfo["last_name"].data,
                    username
                    )
                cur = db.connection.cursor()
                cur.execute(query)
                db.connection.commit()
                cur.close()
            except Exception as e:
                abort(500)  

        if teacherinfo["password"].data:
            try:
                query = "UPDATE users SET U_password = '{}' WHERE Username = '{}';".format(
                    teacherinfo["password"].data,
                    username
                    )
                cur = db.connection.cursor()
                cur.execute(query)
                db.connection.commit()
                cur.close()
            except Exception as e:
                abort(500)     

        if teacherinfo["age"].data:
            try:
                query = "UPDATE teacher_user SET age = '{}' WHERE Username = '{}';".format(
                    teacherinfo["age"].data,
                    username
                    )
                cur = db.connection.cursor()
                cur.execute(query)
                db.connection.commit()
                cur.close()

            except Exception as e:
                abort(500)                

    try:
        cur = db.connection.cursor()
        query = "SELECT us.username, u.First_name, u.Last_name, us.u_password, tu.age FROM usernameview u INNER JOIN users us ON u.username = us.username INNER JOIN teacher_user tu ON tu.username = u.username WHERE u.username = '{}';".format(username)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        information = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

    except Exception as e:
        abort(500)      

    return render_template("teacher_profile.html", information=information[0], pageTitle="Teacher Profile", form = form)

