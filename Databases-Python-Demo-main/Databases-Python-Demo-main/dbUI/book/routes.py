from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.book import book

@book.route("/book/<string:username>")
def getBook(username):
    """
    Retrieve books from database
    """
    try:
        search = request.args.get("search")
        cur = db.connection.cursor()
        if search:
            search = f"SELECT ISBN, title, available_copies FROM book WHERE title LIKE '%{search}%'"
        else:
            search = "SELECT ISBN, title, available_copies FROM book"
           
        cur.execute(search)
        column_names = [i[0] for i in cur.description]
        books = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("book.html", books = books, username=username, pageTitle = "Books")

    except Exception as e:
        ## if the connection to the database fails, return HTTP response 500
        flash(str(e), "danger")
        abort(500)
