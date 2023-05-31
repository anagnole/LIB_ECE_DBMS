from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
##from dbUI.book import book
from dbUI.bookinfo import bookinfo

@bookinfo.route("/bookinfo/<string:username>/<int:ISBN>")
def getBookInfo(username, ISBN):
    """
    Retrieve a book's info from database
    """
    try:
        cur = db.connection.cursor()
        query = ("SELECT DISTINCT b.ISBN, GROUP_CONCAT(DISTINCT a.Ath_full_name SEPARATOR ', ') AS authors, b.title, b.publisher, GROUP_CONCAT(DISTINCT c.c_name SEPARATOR ', ') AS categories, b.page_number, b.summary, GROUP_CONCAT(DISTINCT k.key_word SEPARATOR ', ') AS keywords, b.available_copies, b.b_language FROM book b \
        INNER JOIN written_by w ON b.isbn = w.isbn \
        INNER JOIN authors a ON a.author_ID = w.author_ID \
        INNER JOIN belongs_to be ON be.isbn = b.isbn \
        INNER JOIN category c ON c.c_name = be.c_name \
        INNER JOIN key_words k ON k.isbn = b.isbn \
        WHERE b.isbn = '{}';").format(ISBN)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        books = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("bookinfo.html", books = books, username = username, isbn = ISBN, pageTitle = "Book Info")
    except Exception as e:
        ## if the connection to the database fails, return HTTP response 500
        flash(str(e), "danger")
        abort(500)
