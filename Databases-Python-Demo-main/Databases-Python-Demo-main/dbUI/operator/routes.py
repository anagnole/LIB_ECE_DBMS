from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.operator import operator
from dbUI.student.forms import StudentForm
from dbUI.book import book

@operator.route("/operator/<string:username>")
def getOperator(username):
    try:
        cur = db.connection.cursor()
        query = "SELECT DISTINCT b.title, GROUP_CONCAT(DISTINCT a.Ath_full_name SEPARATOR ', ') AS authors FROM book b \
        INNER JOIN written_by w ON b.isbn = w.isbn \
        INNER JOIN authors a ON a.author_ID = w.author_ID"
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        books = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("operator.html", books=books, username = username, pageTitle = "Operator Page")
    except Exception as e:
        abort(500)    



