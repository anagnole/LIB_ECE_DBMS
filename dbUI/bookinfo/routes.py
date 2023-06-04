from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.book import book
from dbUI.bookinfo import bookinfo
from datetime import date
from dbUI.bookinfo.forms import ReviewForm
from dbUI.bookinfo.forms import UpdateBookForm
from dbUI.student import student
from dbUI.teacher import teacher

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
        WHERE b.isbn = {};").format(ISBN)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        books = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        query = "SELECT AVG(rating) as rating FROM reviews WHERE ISBN = {};".format(ISBN)
        cur.execute(query)
        ratings = [dict(zip("rating",cur.fetchone()))]
        cur = db.connection.cursor()
        query = "SELECT username, rating, comments FROM reviews where isbn={} and comments IS NOT NULL AND needs_approval = 0;".format(ISBN)
        cur.execute(query)
        column_names = [i[0] for i in cur.description]
        reviews=[dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("bookinfo.html", books = books,ratings = ratings[0], username = username, reviews=reviews, isbn = ISBN, pageTitle = "Book Info")
    except Exception as e:
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
        return redirect(url_for("bookinfo.getBookInfo", username=username, ISBN=ISBN))

@bookinfo.route("/bookinfo/<string:username>/<int:ISBN>/return", methods=["POST"])
def returnbook(username, ISBN):
    """
    Call the add_copies procedure with username and ISBN as arguments
    """
    try:
        query = ("SELECT role_user FROM users WHERE username = '{}';").format(username)
        cur = db.connection.cursor()
        cur.execute(query)
        row = cur.fetchone()
        if(row):
            role = row[0]
        else: 
            raise ValueError("'Incorrect Username or Password'")
        cur.close()

        cur = db.connection.cursor()
        query = "CALL add_copies({}, '{}');".format(ISBN, username)
        cur.execute(query)
        db.connection.commit()
        cur.close()
        flash("Book returned successfully", "success")
        if (role == 'student'):
            return redirect((url_for("student.getStudent", username = username, ISBN=ISBN)))
        else:
            return redirect((url_for("teacher.getTeacher", username = username, ISBN=ISBN)))
    except Exception as e:
        flash(str(e), "danger")
        if (role == 'student'):
            return redirect((url_for("student.getStudent", username = username, ISBN=ISBN)))
        else:
            return redirect((url_for("teacher.getTeacher", username = username, ISBN=ISBN)))

@bookinfo.route("/bookinfo/<string:username>/<int:ISBN>/cancel", methods=["POST"])
def cancel(username, ISBN):
    try:
        cur = db.connection.cursor()
        query = ("SELECT role_user FROM users WHERE username = '{}';").format(username)
        cur.execute(query)
        row = cur.fetchone()
        if(row):
            role = row[0]
        else: 
            raise ValueError("'User Not Found'")
        cur.close()

        cur = db.connection.cursor()
        query = "DELETE FROM reserves WHERE username = '{}' AND isbn = {};".format(username, ISBN)
        cur.execute(query)
        db.connection.commit()
        cur.close()

        flash("Reservation cancelled successfully", "success")
        if (role == 'student'):
            return redirect((url_for("student.getStudent", username = username, ISBN=ISBN)))
        else:
            return redirect((url_for("teacher.getTeacher", username = username, ISBN=ISBN)))

    except Exception as e:
        flash(str(e), "danger")
        if (role == 'student'):
            return redirect((url_for("student.getStudent", username = username, ISBN=ISBN)))
        else:
            return redirect((url_for("teacher.getTeacher", username = username, ISBN=ISBN)))


@bookinfo.route("/bookinfo/<string:username>/<int:ISBN>/review", methods=["GET", "POST"])
def review(username, ISBN):
    """
    Insert to the review rating, username, ISBN, comments as arguments
    """
    form = ReviewForm()

    if(request.method == "POST" and form.validate_on_submit()):
        reviewData = form.__dict__
        query_approval = ("SELECT role_user FROM users WHERE username = '{}';".format(username))
        try:
            cur = db.connection.cursor()
            cur.execute(query_approval)
            row = cur.fetchone()
            if(row):
                role = row[0] 
            else: 
                raise ValueError("'User Not Found'")
            cur.close()           
            if (role == 'student'):
                needs_approval = 1
            else:
                needs_approval = 0 
        except Exception as e:
            flash(str(e), "danger")

        query = ("INSERT INTO reviews (Rating, Needs_approval, Username, ISBN, Comments) \
                    VALUES ({},{},'{}',{},'{}');"
                    .format(reviewData['Rating'].data,
                    needs_approval,
                    username,
                    ISBN,
                    reviewData['Comments'].data))
        try:
            cur = db.connection.cursor()
            cur.execute(query)
            db.connection.commit()
            cur.close()
            if (role == 'student'):
                flash("Review request submitted!", "success")
            else:
                flash("Review submitted successfully!", "success")
            
            return redirect(url_for("bookinfo.getBookInfo", username = username, ISBN = ISBN))
        except Exception as e:
            flash(str(e), "danger")
    return render_template("review.html", username=username, ISBN=ISBN, pageTitle="Review Page", form=form)

@bookinfo.route("/update_book_info/<int:ISBN>", methods = ["GET", "POST"])
def UpdateBookInfo(ISBN):
    form = UpdateBookForm()

    if (request.method == "POST" and form.validate_on_submit()):
        insertbookinfo = form.__dict__
        query_update_book = "UPDATE book SET Title = %s, Publisher = %s, Page_number = %s, \
                    Summary = %s, B_language = %s  \
                    WHERE ISBN = %s;"
        query_delete_authors = "DELETE FROM written_by where isbn = %s;"
        query_pick_author = "CALL pick_author(%s, %s);"
        query_delete_category = "DELETE FROM belongs_to where isbn = %s;"
        query_insert_category = "INSERT INTO belongs_to (ISBN, C_name) VALUES (%s, %s);"
        selected_categories = form.Category.data
        query_delete_key = "DELETE FROM key_words WHERE ISBN = %s;"
        query_insert_keywords = "INSERT INTO key_words (ISBN, Key_word) VALUES (%s, %s);"

        try:
            cur = db.connection.cursor()
            cur.execute(
                query_update_book,
                (
                    insertbookinfo["Title"].data,
                    insertbookinfo["Publisher"].data,
                    insertbookinfo["Page_number"].data,
                    insertbookinfo["Summary"].data,
                    insertbookinfo["B_language"].data,
                    ISBN
                ),
            )
            if(insertbookinfo["Authors"].data):
                cur.execute(query_delete_authors, (ISBN,))
                authors = insertbookinfo["Authors"].data.split(",")
                for author in authors:
                    cur.execute(query_pick_author, (ISBN, author.strip()))

            if(selected_categories):
                cur.execute(query_delete_category, (ISBN,))
                for category in selected_categories:
                    cur.execute(query_insert_category, (ISBN, category.strip()))

            if(insertbookinfo["Key_words"].data):
                cur.execute(query_delete_key, (ISBN,))
                keywords = insertbookinfo["Key_words"].data.split(",")
                for keyword in keywords:
                    cur.execute(query_insert_keywords, (ISBN, keyword.strip()))

            db.connection.commit()
            cur.close()
            flash("Book updated successfully!", "success")
            return redirect(url_for("bookinfo.UpdateBookInfo", ISBN=ISBN))
        except Exception as e:
            flash(str(e), "danger")

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
        return render_template("update_book_info.html", books = books, ISBN = ISBN, form = form, pageTitle = "Book Info")
    except Exception as e:
        print(e)
        flash(str(e), "danger")
        abort(500)

@bookinfo.route("/update_book_info/add/<int:ISBN>", methods = ["GET", "POST"])
def UpdateBookCopy(ISBN):
        if(request.method == "POST"):
            query = "CALL update_copies(%s);"
            try:
                cur = db.connection.cursor()
                cur.execute(query,(ISBN,))
                db.connection.commit()
                cur.close()
                flash("Added book copy successfully!", "success")
                return redirect(url_for("bookinfo.UpdateBookInfo", ISBN=ISBN))
            except Exception as e:
                flash(str(e), "danger")
                return redirect(url_for("bookinfo.UpdateBookInfo", ISBN=ISBN))
          