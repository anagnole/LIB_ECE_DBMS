from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
import subprocess
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.operator import operator
from dbUI.admin import admin
from dbUI.admin.forms import AdminForm
from dbUI.admin.forms import Admin2Form
from dbUI.admin.forms import CreateSchool

@admin.route("/admin" ,methods=["GET","POST"])
def getAdmin():
    try:
        if request.method == 'POST':
            if request.form.get('action') == 'backup':
                backup_path = 'sql/backup.sql' 
                backup_command = ['C:/xampp/mysql/bin/mysqldump', '--user=root', 'library', '--result-file=' + backup_path]
                subprocess.run(backup_command)
                return redirect(url_for("admin.getAdmin"))
            
            elif request.form.get('action') == 'restore':
                backup_path = 'sql/backup.sql' 
                restore_command = ['C:/xampp/mysql/bin/mysql', '--user=root', 'library', '-e', 'source {}'.format(backup_path)]
                subprocess.run(restore_command)
                
                return redirect(url_for("admin.getAdmin"))
        return render_template("admin.html", pageTitle = "Admin Page")
    except Exception as e:
        flash(str(e), "danger")
        abort(500)  

@admin.route("/admin/statistics" ,methods = ["GET", "POST"])
def getStatistics():     
    form = AdminForm()
    form2 = Admin2Form()
    try:
        cur = db.connection.cursor()
        query = "SELECT s.s_name, count(b.ISBN) as total FROM school s\
        INNER JOIN operator o ON s.school_ID = o.operator_ID \
        INNER JOIN book b ON o.operator_ID = b.operator_ID\
        INNER JOIN borrows br ON b.ISBN = br.ISBN WHERE MONTH(br.b_date) = 06 AND YEAR(br.b_date) = 2023\
        GROUP BY s.s_name;"
        if(request.method == "POST" and form.validate_on_submit()):
            yearmonth = form.__dict__
            if yearmonth["year"].data:
                query = "SELECT s.s_name, count(b.ISBN) as total FROM school s\
                INNER JOIN operator o ON s.school_ID = o.operator_ID \
                INNER JOIN book b ON o.operator_ID = b.operator_ID\
                INNER JOIN borrows br ON b.ISBN = br.ISBN WHERE MONTH(br.b_date) = {} AND YEAR(br.b_date) = {}\
                GROUP BY s.s_name;".format(yearmonth["month"].data, yearmonth["year"].data)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        schools = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT DISTINCT a.Ath_full_name FROM authors a \
        INNER JOIN written_by w ON a.Author_ID = w.Author_ID \
        INNER JOIN book b ON b.ISBN = w.ISBN \
        INNER JOIN belongs_to be ON be.ISBN = b.ISBN \
        INNER JOIN category c ON c.c_name = be.c_name WHERE c.c_name = 'History'; "
        
        if(request.method == "POST" and form2.validate_on_submit()):
            categ = form2.__dict__
            query = "SELECT DISTINCT a.Ath_full_name FROM authors a \
            INNER JOIN written_by w ON a.Author_ID = w.Author_ID \
            INNER JOIN book b ON b.ISBN = w.ISBN \
            INNER JOIN belongs_to be ON be.ISBN = b.ISBN \
            INNER JOIN category c ON c.c_name = be.c_name WHERE c.c_name = '{}'; ".format(categ['category'].data)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        authors = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        
        cur = db.connection.cursor()
        query = "SELECT DISTINCT t.teacher_first_name, t.teacher_last_name FROM teacher_user t \
        INNER JOIN users u ON t.Username = u.Username \
        INNER JOIN borrows b ON b.Username = t.Username \
        INNER JOIN book bk ON bk.ISBN = b.ISBN \
        INNER JOIN belongs_to be ON be.ISBN = bk.ISBN \
        INNER JOIN category c ON c.c_name = be.c_name WHERE c.c_name = 'History' and YEAR(b.b_date) = 2023;"
        if(request.method == "POST" and form2.validate_on_submit()):
            categ = form2.__dict__
            query = "SELECT DISTINCT t.teacher_first_name, t.teacher_last_name FROM teacher_user t \
            INNER JOIN users u ON t.Username = u.Username \
            INNER JOIN borrows b ON b.Username = t.Username \
            INNER JOIN book bk ON bk.ISBN = b.ISBN \
            INNER JOIN belongs_to be ON be.ISBN = bk.ISBN \
            INNER JOIN category c ON c.c_name = be.c_name WHERE c.c_name = '{}' and YEAR(b.b_date) = 2023;".format(categ["category"].data)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        teachers = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT DISTINCT t.teacher_first_name, t.teacher_last_name, count(*) as total FROM teacher_user t \
        INNER JOIN users u ON t.Username = u.Username \
        INNER JOIN borrows br ON br.Username = u.Username WHERE t.age<40 GROUP BY br.username;"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        young_teachers = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT DISTINCT ath.Ath_full_name from authors ath \
        WHERE ath.Ath_full_name NOT IN \
        (SELECT DISTINCT a.Ath_full_name FROM authors a \
        INNER JOIN written_by w ON a.Author_ID = w.Author_ID \
        INNER JOIN book b ON b.ISBN=w.ISBN \
        INNER JOIN borrows br ON br.ISBN = b.ISBN);"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        authors_no = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT o.Operator_first_name AS o1firstname,\
        o.Operator_last_name AS o1lastname,\
        p.Operator_first_name AS o2firstname,\
        p.Operator_last_name AS o2lastname,\
        o.operator_ID AS operator1_ID, \
        p.operator_ID AS operator2_ID\
        FROM operatorcounts o\
        JOIN operatorcounts p ON o.count_of_books = p.count_of_books AND o.operator_ID < p.operator_ID;"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        operators = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT t1.C_name AS category1, t2.C_name AS category2, COUNT(*) AS category_combination_count\
        FROM belongs_to t1\
        JOIN belongs_to t2 ON t1.ISBN = t2.ISBN AND t1.C_name < t2.C_name\
        GROUP BY t1.C_name, t2.C_name\
        ORDER BY category_combination_count DESC\
        LIMIT 3;"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        categories = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT n.Ath_full_name FROM num_b_per_auth n\
        WHERE count_of_books <= \
        (SELECT count(w.ISBN) AS count_of_books FROM written_by w \
        INNER JOIN authors a ON w.author_ID = a.author_ID\
        GROUP BY a.author_ID \
        ORDER BY count_of_books DESC\
        LIMIT 1)-5;"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        author_5 = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        return render_template("admin_statistics.html",
                                schools = schools,
                                authors = authors,
                                teachers = teachers,
                                authors_no=authors_no,
                                young_teachers = young_teachers,
                                operators = operators,
                                categories = categories,
                                author_5 = author_5,
                                form = form,
                                form2=form2,
                                pageTitle = "Admin Statistics"
                                )
    
    except Exception as e:
        flash(str(e),"danger")
        abort(500) 

@admin.route("/admin/operator", methods = ["GET", "POST"])
def pickOperator():
    try:
        cur = db.connection.cursor()
        query = "Select u.username, t.first_name, t.last_name from users u INNER JOIN approves_user ap\
              ON ap.username = u.username INNER JOIN usernameview t ON t.username = u.username \
        WHERE Role_user = 'teacher';"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        teachers = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
    except Exception as e:
        flash(str(e),"danger")
        abort(500) 
    return render_template("pick_operator.html", teachers = teachers, pageTitle="Pick Operator")


@admin.route("/admin/school/<string:username>" ,methods = ["GET", "POST"])
def addSchool(username): 
    form3 = CreateSchool()
    if (request.method == "POST" and form3.validate_on_submit()):
        schoolinfo = form3.__dict__
        try:
            cur = db.connection.cursor()
            query = "CALL add_school('{}','{}','{}',{},'{}','{}','{}')".format(
                schoolinfo["s_name"].data,
                schoolinfo["address"].data,
                schoolinfo["city"].data,
                schoolinfo["phone_number"].data,
                schoolinfo["email"].data,
                schoolinfo["p_full_name"].data,
                username
            )
            cur.execute(query)
            db.connection.commit()
            cur.close()
            flash("Successful School Insertion")
            return redirect(url_for("admin.getAdmin"))
        except Exception as e:
            flash(str(e),"danger")

    return render_template("school.html", form = form3, pageTitle = "Create School")
