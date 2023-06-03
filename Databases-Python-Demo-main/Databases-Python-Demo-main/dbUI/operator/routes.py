from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.operator import operator
from dbUI.student.forms import StudentForm
from dbUI.book import book
from datetime import date

def get_date():
    today = date.today()
    todaydate = today.strftime("%Y-%m-%d")
    return todaydate

@operator.route("/operator/<string:username>")
def getOperator(username):
    try:
        cur = db.connection.cursor()
        searchtitle = request.args.get("searchtitle")
        searchcategory = request.args.get("searchcategory")
        searchauthor = request.args.get("searchauthor")
        searchcopies = request.args.get("searchcopies")
        cur = db.connection.cursor()
        query = "SELECT DISTINCT b.title, GROUP_CONCAT(DISTINCT a.Ath_full_name SEPARATOR ', ') AS authors, GROUP_CONCAT(DISTINCT c.c_name SEPARATOR ', ') AS categories FROM book b \
                INNER JOIN written_by w ON w.ISBN = b.ISBN \
                INNER JOIN authors a ON a.author_ID = w.author_ID \
                INNER JOIN belongs_to be ON be.ISBN = b.ISBN \
                INNER JOIN category c ON be.c_name = c.c_name"
        
        conditions = []
        if searchtitle:
            conditions.append(f"b.title LIKE '%{searchtitle}%'")
        if searchcategory:
            conditions.append(f"c.c_name LIKE '%{searchcategory}%'")
        if searchauthor:
            conditions.append(f"a.ath_full_name LIKE '%{searchauthor}%'")
        if searchcopies:
            conditions.append(f"b.Available_copies = {searchcopies}")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        query += " GROUP BY b.title"

        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        books = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        searchfirstname = request.args.get("searchfirstname")
        searchlastname = request.args.get("searchlastname")
        searchdayslate = request.args.get("searchdayslate")
        cur = db.connection.cursor()
        query = "SELECT b.isbn, uv.first_name, uv.last_name, br.b_date FROM usernameview uv \
                INNER JOIN borrows br ON uv.username = br.username \
                INNER JOIN book b ON br.isbn = b.isbn \
                WHERE br.ret_date IS NULL \
                AND DATEDIFF(current_timestamp, br.b_date) > 7"

        conditions = []
        if searchfirstname:
            conditions.append(f"uv.first_name LIKE '%{searchfirstname}%'")
        if searchlastname:
            conditions.append(f"uv.last_name LIKE '%{searchlastname}%'")
        if searchdayslate:
            conditions.append(f"DATEDIFF(current_timestamp, br.b_date) - 7 = {searchdayslate}")

        if conditions:
            query += " AND " + " AND ".join(conditions)

        todaydate = get_date()
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        latereturns = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        
        cur = db.connection.cursor()
        searchusername = request.args.get("searchusername")
        query = "SELECT uv.username, AVG(re.rating) as rating FROM usernameview uv \
                INNER JOIN reviews re ON re.username = uv.username \
                INNER JOIN book b ON re.ISBN = b.ISBN"
        conditions = []
        if searchusername:
            conditions.append(f"uv.username LIKE '%{searchusername}%'")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        query += " GROUP BY uv.username"

        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        usermeanrating = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        cur = db.connection.cursor()
        searchcategory = request.args.get("searchcategory")
        query = "SELECT c.c_name, AVG(re.rating) as rating FROM reviews re \
                INNER JOIN book b ON re.ISBN = b.ISBN \
                INNER JOIN belongs_to be ON be.ISBN = b.ISBN \
                INNER JOIN category c ON c.c_name = be.c_name "
        conditions = []
        if searchcategory:
            conditions.append(f"c.c_name LIKE '%{searchcategory}%'")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        query += " GROUP BY c.c_name"

        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        categorymeanrating = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        return render_template("operator.html", books=books, todaydate=todaydate, username=username, latereturns=latereturns, usermeanrating=usermeanrating, categorymeanrating=categorymeanrating, pageTitle="Operator Page")

    
    except Exception as e:
        print(e)
        abort(500)

@operator.route("/operator/<string:username>/approve")
def getApprove(username):
    try:
        cur = db.connection.cursor()
        query = "SELECT username FROM APPROVES_USER WHERE LIBRARY_CARD = 0;"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        librarycards = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        print(librarycards)
        cur.close()

        cur = db.connection.cursor()
        query = "SELECT username,rating,comments FROM reviews WHERE needs_approval = 1;"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        reviews = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()

        return render_template("approve.html", username=username, librarycards=librarycards, reviews=reviews, pageTitle="Approve Library Cards and Reviews")
    
    except Exception as e:
        print(e)
        abort(500)

@operator.route("/operator/<string:username>/approve/librarycard")
def getCard(username):
    try:
        target_username = request.args.get("username")
        query = "UPDATE APPROVES_USER SET Library_card = 1 WHERE Username = %s"
        cur = db.connection.cursor()
        cur.execute(query, (target_username,))
        db.connection.commit()
        cur.close()

        return redirect(url_for("operator.getApprove", username=username))

    except Exception as e:
        flash(str(e), "danger")
        abort(500)

@operator.route("/operator/<string:username>/approve/review")
def getReview(username):
    try:
        target_username = request.args.get("username")
        query = "UPDATE reviews SET needs_approval = 0 WHERE Username = %s"
        cur = db.connection.cursor()
        cur.execute(query, (target_username,))
        db.connection.commit()
        cur.close()

        return redirect(url_for("operator.getApprove", username=username))

    except Exception as e:
        flash(str(e), "danger")
        abort(500)