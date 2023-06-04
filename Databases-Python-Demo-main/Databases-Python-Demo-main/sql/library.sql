DROP SCHEMA IF EXISTS library;
CREATE SCHEMA library;
USE library;

-- Tables

CREATE TABLE School(
 School_ID INT NOT NULL AUTO_INCREMENT,
 S_Name VARCHAR(255) NOT NULL UNIQUE,
 Adress VARCHAR(50) NOT NULL,
 City VARCHAR(50) NOT NULL,
 Phone_number INT NOT NULL,
 Email VARCHAR(45) NOT NULL,
 P_full_name VARCHAR(100) NOT NULL,
 PRIMARY KEY(School_ID)
);


CREATE TABLE Users(
 Username VARCHAR(20) NOT NULL,
 U_password INT NOT NULL,
 Role_user VARCHAR(20) NOT NULL,
 PRIMARY KEY(Username)
);

CREATE TABLE Administrator(
 Administrator_ID INT NOT NULL AUTO_INCREMENT,
 Adm_first_name VARCHAR(100) NOT NULL,
 Adm_last_name VARCHAR(100) NOT NULL,
 Username VARCHAR(20) NOT NULL,
 PRIMARY KEY(Administrator_ID),
 constraint fk_administrator_username foreign key (Username) references Users (Username) on delete cascade on update cascade
);

CREATE TABLE Operator(
 Operator_ID INT NOT NULL AUTO_INCREMENT,
 Username VARCHAR(20) NOT NULL,
 Administrator_ID INT DEFAULT NULL,
 School_ID INT NOT NULL,
 Operator_first_name VARCHAR(100) NOT NULL,
 Operator_last_name VARCHAR(100) NOT NULL,
 PRIMARY KEY(Operator_ID),
 constraint fk_operator_username foreign key (Username) references Users (Username) on delete cascade on update cascade,
 constraint fk_operator_school_id foreign key (School_ID) references School (School_ID) on delete cascade on update cascade,
 constraint fk_operator_administrator_id foreign key (Administrator_ID) references Administrator (Administrator_ID) on delete cascade on update cascade
);

CREATE TABLE Book(
 ISBN INT NOT NULL,
 Title VARCHAR(50) NOT NULL UNIQUE,
 Publisher VARCHAR(50) NOT NULL,
 Page_number INT NOT NULL check (Page_number > 0),
 Summary VARCHAR(255) NOT NULL,
 Available_copies INT NOT NULL check (Available_copies > -1),
 img VARCHAR(100) NOT NULL,
 B_language VARCHAR(45) NOT NULL,
 Operator_ID INT NOT NULL,
 PRIMARY KEY(ISBN),
 constraint fk_book_operator_ID foreign key (Operator_ID) references Operator (Operator_ID) on delete cascade on update cascade
);


CREATE TABLE Key_words(
  Key_word_ID INT NOT NULL AUTO_INCREMENT,
  ISBN INT NOT NULL,
  Key_word VARCHAR(20) NOT NULL,
  PRIMARY KEY(Key_word_ID),
  constraint fk_key_words_ISBN foreign key (ISBN) references Book (ISBN) on delete cascade on update cascade
);

CREATE TABLE Student_user(
  Student_ID INT NOT NULL AUTO_INCREMENT,
  Username VARCHAR(20) NOT NULL,
  Student_first_name VARCHAR(100) NOT NULL,
  Student_last_name VARCHAR(100) NOT NULL,
  PRIMARY KEY(Student_ID),
  constraint fk_student_user_username foreign key (Username) references Users (Username) on delete cascade on update cascade
);

CREATE TABLE Teacher_user(
  Teacher_ID INT NOT NULL AUTO_INCREMENT,
  Username VARCHAR(20) NOT NULL,
  Teacher_first_name VARCHAR(100) NOT NULL,
  Teacher_last_name VARCHAR(100) NOT NULL,
  Age INT NOT NULL check (Age > 18 and Age < 99),
  PRIMARY KEY(Teacher_ID),
  constraint fk_teacher_user_username foreign key (Username) references Users (Username) on delete cascade on update cascade
);

CREATE TABLE Authors(
 Author_ID INT NOT NULL AUTO_INCREMENT,
 Ath_full_name VARCHAR(100) UNIQUE NOT NULL,
 PRIMARY KEY(Author_ID)
);

CREATE TABLE Category(
 C_name VARCHAR(45) NOT NULL,
 PRIMARY KEY(C_name)
);

CREATE TABLE Reviews(
 Review_ID INT NOT NULL AUTO_INCREMENT,
 Rating INT NOT NULL check (Rating > -1 and Rating < 6),
 Needs_approval BOOLEAN NOT NULL,
 Username VARCHAR(20) NOT NULL,
 ISBN INT NOT NULL, 
 Comments VARCHAR(255) DEFAULT NULL,
 PRIMARY KEY(Review_ID),
 constraint fk_reviews_username foreign key (Username) references Users (Username) on delete cascade on update cascade,
 constraint fk_reviews_ISBN foreign key (ISBN) references Book (ISBN) on delete cascade on update cascade
);

CREATE TABLE Approves_user(
  Username VARCHAR(20) NOT NULL,
  Operator_ID INT NOT NULL,
  Library_card BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY(Username, Operator_ID),
  constraint fk_approves_user_username foreign key (Username) references Users (Username) on delete cascade on update cascade,
  constraint fk_approves_user_operator_id foreign key (Operator_ID) references Operator (Operator_ID) on delete cascade on update cascade
);

CREATE TABLE Written_by(
  ISBN INT NOT NULL,
  Author_ID INT NOT NULL,
  PRIMARY KEY(ISBN, Author_ID),
  constraint fk_written_by_isbn foreign key (ISBN) references Book (ISBN) on delete cascade on update cascade,
  constraint fk_written_by_author_id foreign key (Author_ID) references Authors (Author_ID) on delete cascade on update cascade
);

CREATE TABLE Belongs_to(
  ISBN INT NOT NULL,
  C_name VARCHAR(45) NOT NULL,
  PRIMARY KEY(ISBN, C_name),
  constraint fk_belongs_to_isbn foreign key (ISBN) references Book (ISBN) on delete cascade on update cascade,
  constraint fk_belongs_to_c_name foreign key (C_name) references Category (C_name) on delete cascade on update cascade
);

CREATE TABLE Reserves(
  Username VARCHAR(20) NOT NULL,
  ISBN INT NOT NULL,
  r_date DATE NOT NULL,
  last_update timestamp not null default current_timestamp on update current_timestamp,
  PRIMARY KEY(Username, ISBN),
  constraint fk_reserves_username foreign key (Username) references Users (Username) on delete cascade on update cascade,
  constraint fk_reserves_isbn foreign key (ISBN) references Book (ISBN) on delete cascade on update cascade
);

CREATE TABLE Borrows(
  Username VARCHAR(20) NOT NULL,
  ISBN INT NOT NULL,
  b_date DATE NOT NULL,
  ret_date DATE,
  last_update timestamp not null default current_timestamp on update current_timestamp,
  PRIMARY KEY(ISBN, Username),
  constraint fk_borrows_username foreign key (Username) references Users (Username) on delete cascade on update cascade,
  constraint fk_borrows_isbn foreign key (ISBN) references Book (ISBN) on delete cascade on update cascade
);

-- Views

    -- Εδώ βλέπουμε πόσα βιβλία έχουν δανιστεί χωρισμένα ανά operator. Πχ από τα βιβλία του Operator_1 έχουν δανειστεί τα 6. 
CREATE VIEW operatorcounts AS
SELECT o.operator_ID, o.Operator_first_name, o.Operator_last_name, count(b.ISBN) AS count_of_books from operator o 
INNER JOIN book b ON o.operator_ID=b.operator_ID 
INNER JOIN borrows br ON br.ISBN = b.ISBN
WHERE YEAR(br.b_date) = 2023
GROUP BY o.operator_ID;

    -- Number of books per author
CREATE VIEW num_b_per_auth AS
SELECT a.author_ID, a.Ath_full_name, count(w.ISBN) AS count_of_books FROM authors a 
INNER JOIN written_by w ON w.author_ID = a.author_ID
GROUP BY author_ID
ORDER BY count_of_books DESC;

CREATE VIEW usernameview AS
(SELECT u.username, st.Student_first_name AS First_name, st.Student_last_name AS Last_name FROM users u
INNER JOIN student_user st ON st.username = u.username
UNION
SELECT u.username, t.teacher_first_name AS First_name, t.teacher_last_name AS Last_name FROM users u
INNER JOIN teacher_user t ON t.username = u.username
UNION
SELECT u.username, o.operator_first_name AS First_name, o.operator_last_name AS last_name FROM users u
INNER JOIN operator o ON o.username = u.username
UNION
SELECT u.username, a.adm_first_name AS First_name, a.adm_last_name AS Last_name FROM users u
INNER JOIN Administrator a ON a.username = u.username);

CREATE VIEW late_returns AS
SELECT v.First_name, v.Last_name, DATEDIFF(b.last_update, b.b_date) AS days_late FROM usernameview v 
INNER JOIN borrows b ON b.username = v.username
WHERE b.ret_date IS NULL and DATEDIFF(b.last_update, b.b_date) > 14;

-- Indexes

CREATE index title_index ON book (title); 

CREATE index available_copies_index ON book (Available_copies); 

CREATE index author_index ON authors (Ath_full_name);

CREATE index b_date_index ON borrows (b_date);
