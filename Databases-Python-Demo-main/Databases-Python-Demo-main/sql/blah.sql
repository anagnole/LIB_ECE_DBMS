--Procedure insertuser (username, u_password, role_user, first_name, last_name, age)
CALL insertuser ('user62', 12345, 'student', 'Giovani', 'Papardela', 15);

--Procedure new_borrow (ISBN, username, b_date)
CALL new_borrow (978000009, 'user5', '2023-05-28');

--Procedure add_copies(ISBN, username, ret_date)
CALL add_copies(978000009, 'user33', '2023-05-27'); 

--Procedure add_school(s_name, adress, city, phone_number, email, p_full_name, username) 
CALL add_school('Chania College', 'Megalonhsos 50', 'Chania', '2302838490', 'info@reth.gr', 'Konstantinos Vasilakis', 'user60');

--Procedure approve_operator(username)
CALL approve_operator('user60');

--Procedure Library_card_approval(usernameU, operator_ID)
CALL Library_card_approval('user62', 2);

--Procedure pick_author(ISBN, Ath_full_name)
CALL pick_author(978000010, 'Test Author');

--Procedure check_reserves()
CALL check_reserves();

--Procedure approve_reviews(username, isbn)
CALL approve_reviews('user12', 978000003);

SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sorry, there is no available copy at the time. You have entered the reservation list.';

if request.form.get('action') == 'backup':
                cursor = db.connection.cursor()
                cursor.execute('SHOW TABLES;')
                table_names = []
                for record in cursor.fetchall():
                    table_names.append(record[0])
  
                backup_dbname = db + '_backup'
                try:
                    cursor.execute(f'CREATE DATABASE {backup_dbname}')
                except:
                    pass
  
                cursor.execute(f'USE {backup_dbname}')
  
                for table_name in table_names:
                    cursor.execute(f'CREATE TABLE {table_name} SELECT * FROM {db}.{table_name}')
                return 'Backup created successfully!'