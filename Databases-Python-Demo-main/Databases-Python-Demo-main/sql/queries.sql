-- 3.1.1.Παρουσίαση λίστας με συνολικό αριθμό δανεισμών ανά σχολείο (Κριτήρια αναζήτησης:έτος, ημερολογιακός μήνας πχ Ιανουάριος).
SELECT s.s_name, count(b.ISBN) FROM school s 
INNER JOIN operator o ON s.school_ID = o.operator_ID 
INNER JOIN book b ON o.operator_ID = b.operator_ID 
INNER JOIN borrows br ON b.ISBN = br.ISBN WHERE MONTH(br.b_date) = 06 AND YEAR(br.b_date) = 2023
GROUP BY s.s_name;

-- 3.1.2.Για δεδομένη κατηγορία βιβλίων (επιλέγει ο χρήστης), ποιοι συγγραφείς ανήκουν σε αυτήν και ποιοι εκπαιδευτικοί έχουν δανειστεί βιβλία αυτής της κατηγορίας το τελευταίο έτος;
SELECT DISTINCT a.Ath_full_name FROM authors a 
INNER JOIN written_by w ON a.Author_ID = w.Author_ID 
INNER JOIN book b ON b.ISBN = w.ISBN 
INNER JOIN belongs_to be ON be.ISBN = b.ISBN 
INNER JOIN category c ON c.c_name = be.c_name WHERE c.c_name = 'Fiction'; 

SELECT DISTINCT t.teacher_first_name, t.teacher_last_name FROM teacher_user t 
INNER JOIN users u ON t.Username = u.Username 
INNER JOIN borrows b ON b.Username = t.Username 
INNER JOIN book bk ON bk.ISBN = b.ISBN 
INNER JOIN belongs_to be ON be.ISBN = bk.ISBN 
INNER JOIN category c ON c.c_name = be.c_name WHERE c.c_name = 'Fiction' and YEAR(b.b_date) = 2023;

-- 3.1.3.Βρείτε τους νέους εκπαιδευτικούς (ηλικία < 40 ετών) που έχουν δανειστεί τα περισσότερα βιβλία και των αριθμό των βιβλίων.
SELECT DISTINCT t.teacher_first_name, t.teacher_last_name, count(br.username) FROM teacher_user t 
INNER JOIN users u ON t.Username = u.Username 
INNER JOIN borrows br ON br.Username = u.Username WHERE t.age<40 GROUP BY br.username;

-- 3.1.4.Βρείτε τους συγγραφείς των οποίων κανένα βιβλίο δεν έχει τύχει δανεισμού.
SELECT DISTINCT ath.Ath_full_name from authors ath 
WHERE ath.Ath_full_name NOT IN 
(SELECT DISTINCT a.Ath_full_name FROM authors a 
INNER JOIN written_by w ON a.Author_ID = w.Author_ID 
INNER JOIN book b ON b.ISBN=w.ISBN 
INNER JOIN borrows br ON br.ISBN = b.ISBN);

-- 3.1.5.Ποιοι χειριστές έχουν δανείσει τον ίδιο αριθμό βιβλίων σε διάστημα ενός έτους με περισσότερους από 20 δανεισμούς;
    
    -- Και εδώ με χρήση του view βρίσκουμε ποιοι Operators έχουν ίσους δανεισμούς.
SELECT o.Operator_first_name AS o1firstname,
o.Operator_last_name AS o1lastname,
 p.Operator_first_name AS o2firstname,
 p.Operator_last_name AS o2lastname,
 o.operator_ID AS operator1_ID, 
p.operator_ID AS operator2_ID
FROM operatorcounts o
JOIN operatorcounts p ON o.count_of_books = p.count_of_books AND o.operator_ID < p.operator_ID;

-- 3.1.6.Πολλά βιβλία καλύπτουν περισσότερες από μια κατηγορίες. Ανάμεσα σε ζεύγη πεδίων (π.χ. ιστορία και ποίηση) που είναι κοινά στα βιβλία, 
    -- βρείτε τα 3 κορυφαία (top-3) ζεύγη που εμφανίστηκαν σε δανεισμούς.

SELECT t1.C_name AS category1, t2.C_name AS category2, COUNT(*) AS category_combination_count
FROM belongs_to t1
JOIN belongs_to t2 ON t1.ISBN = t2.ISBN AND t1.C_name < t2.C_name
GROUP BY t1.C_name, t2.C_name
ORDER BY category_combination_count DESC
LIMIT 3;

-- 3.1.7.Bρείτε όλους τους συγγραφείς που έχουν γράψει τουλάχιστον 5 βιβλία λιγότερα από τον συγγραφέα με τα περισσότερα βιβλία.

    -- Αρχικά θα βρούμε ποιος έχει γράψει τα περισσότερα βιβλία, Voltaire no.48
SELECT a.author_ID, a.Ath_full_name, count(w.ISBN) AS count_of_books FROM authors a 
INNER JOIN written_by w ON w.author_ID = a.author_ID
GROUP BY author_ID
ORDER BY count_of_books DESC
LIMIT 1;


SELECT n.Ath_full_name FROM num_b_per_auth n
WHERE count_of_books <= 
(SELECT count(w.ISBN) AS count_of_books FROM written_by w 
INNER JOIN authors a ON w.author_ID = a.author_ID
GROUP BY a.author_ID 
ORDER BY count_of_books DESC
LIMIT 1)-5;


-- 3.2.1.Παρουσίαση όλων των βιβλίων κατά Τίτλο, Συγγραφέα (Κριτήρια αναζήτησης: τίτλος/κατηγορία/ συγγραφέας/ αντίτυπα).
SELECT b.title, a.Ath_full_name FROM book b 
INNER JOIN written_by w ON w.ISBN = b.ISBN 
INNER JOIN authors a ON a.author_ID = w.author_ID
WHERE b.title LIKE "%mock%";

SELECT b.title, a.Ath_full_name, c.c_name FROM book b 
INNER JOIN written_by w ON w.ISBN = b.ISBN 
INNER JOIN authors a ON a.author_ID = w.author_ID
INNER JOIN belongs_to be ON be.ISBN = b.ISBN
INNER JOIN category c ON be.c_name = c.c_name 
WHERE c.c_name LIKE "%...%";

SELECT b.title, a.Ath_full_name FROM book b 
INNER JOIN written_by w ON w.ISBN = b.ISBN 
INNER JOIN authors a ON a.author_ID = w.author_ID
WHERE a.Ath_full_name LIKE "%vo%";

SELECT b.title, a.Ath_full_name FROM book b 
INNER JOIN written_by w ON w.ISBN = b.ISBN 
INNER JOIN authors a ON a.author_ID = w.author_ID
WHERE b.Available_copies = 3;

-- 3.2.2.Εύρεση όλων των δανειζόμενων που έχουν στην κατοχή τους τουλάχιστον ένα βιβλίο και έχουν καθυστερήσει την επιστροφή του. 
-- (Κριτήρια αναζήτησης: Όνομα, Επώνυμο, Ημέρες Καθυστέρησης).

SELECT First_name, Last_name FROM late_returns WHERE First_name LIKE "%a%";
SELECT First_name, Last_name FROM late_returns WHERE Last_name LIKE "%papa%";
SELECT First_name, Last_name FROM late_returns WHERE days_late = 134;

-- 3.2.3.Μέσος Όρος Αξιολογήσεων ανά δανειζόμενο και κατηγορία (Κριτήρια αναζήτησης: χρήστης/ κατηγορία)

    -- Per user
SELECT uv.username, avg(re.rating) FROM usernameview uv 
INNER JOIN reviews re ON re.username = uv.username
INNER JOIN book b ON re.ISBN = b.ISBN
GROUP BY uv.username HAVING uv.username LIKE '%user5%';

    -- Per category
SELECT c.c_name, avg(re.rating) FROM reviews re 
INNER JOIN book b ON re.ISBN = b.ISBN
INNER JOIN belongs_to be ON be.ISBN = b.ISBN
INNER JOIN category c ON c.c_name = be.c_name
GROUP BY c.c_name HAVING c.c_name LIKE '%th%';

--3.3.1.Όλα τα βιβλία που έχουν καταχωριστεί (Κριτήρια αναζήτησης: τίτλος/ κατηγορία/ συγγραφέας), 
--δυνατότητα επιλογής βιβλίου και δημιουργία αιτήματος κράτησης.
SELECT DISTINCT title, Available_copies from book
WHERE title LIKE "%mock%";

SELECT DISTINCT b.title, b.Available_copies FROM book b 
INNER JOIN written_by w ON w.ISBN = b.ISBN 
INNER JOIN authors a ON a.author_ID = w.author_ID
INNER JOIN belongs_to be ON be.ISBN = b.ISBN
INNER JOIN category c ON be.c_name = c.c_name 
WHERE c.c_name LIKE "%fi%";

SELECT DISTINCT b.title, b.Available_copies FROM book b 
INNER JOIN written_by w ON w.ISBN = b.ISBN 
INNER JOIN authors a ON a.author_ID = w.author_ID
WHERE a.Ath_full_name LIKE "%vo%";

-- 3.3.2.Λίστα όλων των βιβλίων που έχει δανειστεί ο συγκεκριμένος χρήστης.
SELECT u.username, b.title from book b 
INNER JOIN borrows br ON br.ISBN = b.ISBN 
INNER JOIN users u ON u.username = br.username
WHERE u.username = 'user53';