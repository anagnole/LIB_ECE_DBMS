from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.book import book
from dbUI.bookinfo import bookinfo
from datetime import date
from dbUI.reviews.forms import ReviewForm

def get_date():
    today = date.today()
    todaydate = today.strftime("%Y-%m-%d")
    return todaydate

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

@bookinfo.route("/bookinfo/<string:username>/<int:ISBN>/borrow", methods=["POST"])
def borrow(username, ISBN):
    """
    Call the borrow procedure with username and ISBN as arguments
    """
    try:
        cur = db.connection.cursor()
        todaydate = get_date()
        query = "CALL new_borrow({}, '{}','{}');".format(ISBN, username, todaydate)
        cur.execute(query)
        db.connection.commit()
        cur.close()
        flash("Borrow request successful", "success")
        return redirect(url_for("bookinfo.getBookInfo", username=username, ISBN=ISBN))
    except Exception as e:
        # If the connection to the database fails, return HTTP response 500
        flash(str(e), "danger")
        abort(500)

@bookinfo.route("/bookinfo/<string:username>/<int:ISBN>/review", methods=["GET", "POST"])
def review(username, ISBN):
    """
    Insert to the review rating, username, ISBN, comments as arguments
    """
    form = ReviewForm()

    if(request.method == "POST" and form.validate_on_submit()):
        reviewData = form.__dict__
        query = ("INSERT INTO reviews (Rating, Username, ISBN, Comments) \
                    VALUES ({},'{}',{},'{}');"
                    .format(reviewData['Rating'].data,
                    username,
                    ISBN,
                    reviewData['Comments'].data))
        try:
            cur = db.connection.cursor()
            cur.execute(query)
            db.connection.commit()
            cur.close()
            return render_template("review.html", username = username, ISBN = ISBN, pageTitle = "Review Page", form = form)
        except Exception as e:
            flash(str(e), "danger")
            abort(500)
    return render_template("review.html", username=username, ISBN=ISBN, pageTitle="Review Page", form=form)

## META TO REVIEW ΓΥΡΙΖΕΙ ΠΙΣΩ?????????????? 