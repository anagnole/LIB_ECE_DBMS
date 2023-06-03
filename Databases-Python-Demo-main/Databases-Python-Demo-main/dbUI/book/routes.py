from flask import Flask, render_template, request, flash, redirect, url_for, abort
from flask_mysqldb import MySQL
from dbUI import db ## initially created by __init__.py, need to be used here
from dbUI.book import book
from dbUI.book.forms import BookForm

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

@book.route("/operator/<string:username>/insertbook", methods=["GET", "POST"])
def getInsertBook(username):

    form = BookForm()

    if request.method == "POST" and form.validate_on_submit():
        insertbookinfo = form.__dict__
        query_op = "SELECT Operator_ID FROM operator WHERE username = %s;"
        query_insert_book = "INSERT INTO book (ISBN, Title, Publisher, Page_number, \
                    Summary, Available_copies, img, B_language, Operator_ID) \
                 VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s);"
        query_pick_author = "CALL pick_author(%s, %s);"
        query_insert_category = "INSERT INTO belongs_to (ISBN, C_name) VALUES (%s, %s);"
        selected_categories = form.Category.data
        query_insert_keywords = "INSERT INTO key_words (ISBN, Key_word) VALUES (%s, %s);"

        try:
            cur = db.connection.cursor()

            cur.execute(query_op, (username,))
            row = cur.fetchone()
            opid = row[0]

            cur.execute(
                query_insert_book,
                (
                    insertbookinfo["ISBN"].data,
                    insertbookinfo["Title"].data,
                    insertbookinfo["Publisher"].data,
                    insertbookinfo["Page_number"].data,
                    insertbookinfo["Summary"].data,
                    insertbookinfo["Available_copies"].data,
                    insertbookinfo["img"].data,
                    insertbookinfo["B_language"].data,
                    opid,
                ),
            )

            authors = insertbookinfo["Authors"].data.split(",")
            for author in authors:
                cur.execute(query_pick_author, (insertbookinfo["ISBN"].data, author.strip()))

            for category in selected_categories:
                cur.execute(query_insert_category, (insertbookinfo["ISBN"].data, category.strip()))

            keywords = insertbookinfo["Key_words"].data.split(",")
            for keyword in keywords:
                cur.execute(query_insert_keywords, (insertbookinfo["ISBN"].data, keyword.strip()))

            db.connection.commit()
            cur.close()
            flash("Book created successfully!", "success")
            return redirect(url_for("operator.getOperator", username=username))
        except Exception as e:
            flash(str(e), "danger")
            abort(500)

    return render_template("insertbook.html", username=username, form=form, pageTitle="Insert Book")

@book.route("/update_book/<string:username>")
def getUpdateBook(username):
    try:
        cur = db.connection.cursor()
        search = "SELECT b.ISBN, b.title, b.available_copies FROM book b \
        INNER JOIN operator o ON o.Operator_ID = b.Operator_ID WHERE o.username = '{}';".format(username)
        cur.execute(search)
   
        column_names = [i[0] for i in cur.description]
        books = [dict(zip(column_names, entry)) for entry in cur.fetchall()]
        cur.close()
        return render_template("update_book.html", books = books, username=username, pageTitle = "Update Books")

    except Exception as e:
        ## if the connection to the database fails, return HTTP response 500
        flash(str(e), "danger")
        abort(500)