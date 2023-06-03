-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrator` (
  `Administrator_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Adm_first_name` varchar(100) NOT NULL,
  `Adm_last_name` varchar(100) NOT NULL,
  `Username` varchar(20) NOT NULL,
  PRIMARY KEY (`Administrator_ID`),
  KEY `fk_administrator_username` (`Username`),
  CONSTRAINT `fk_administrator_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES (1,'irimaryleo','hmmy','admin');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approves_user`
--

DROP TABLE IF EXISTS `approves_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approves_user` (
  `Username` varchar(20) NOT NULL,
  `Operator_ID` int(11) NOT NULL,
  `Library_card` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Username`,`Operator_ID`),
  KEY `fk_approves_user_operator_id` (`Operator_ID`),
  CONSTRAINT `fk_approves_user_operator_id` FOREIGN KEY (`Operator_ID`) REFERENCES `operator` (`Operator_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_approves_user_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approves_user`
--

LOCK TABLES `approves_user` WRITE;
/*!40000 ALTER TABLE `approves_user` DISABLE KEYS */;
INSERT INTO `approves_user` VALUES ('user10',1,1),('user11',5,1),('user12',7,1),('user13',8,1),('user14',5,1),('user15',6,1),('user16',1,1),('user17',7,1),('user18',7,1),('user19',10,1),('user2',7,1),('user20',2,1),('user21',9,1),('user22',5,1),('user23',5,1),('user24',9,1),('user25',10,1),('user26',6,1),('user27',1,1),('user28',10,1),('user29',2,1),('user3',4,1),('user30',2,1),('user4',6,1),('user41',3,1),('user42',8,1),('user43',4,1),('user44',1,1),('user45',6,1),('user46',3,1),('user47',3,1),('user48',6,1),('user49',6,1),('user5',2,1),('user50',3,1),('user51',5,1),('user52',6,1),('user53',10,1),('user54',3,1),('user55',2,1),('user56',2,1),('user57',5,1),('user58',3,1),('user59',6,1),('user6',4,1),('user60',6,1),('user7',5,1),('user8',1,1),('user9',1,1);
/*!40000 ALTER TABLE `approves_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `Author_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ath_full_name` varchar(100) NOT NULL,
  PRIMARY KEY (`Author_ID`),
  UNIQUE KEY `Ath_full_name` (`Ath_full_name`),
  KEY `author_index` (`Ath_full_name`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (3,'Agatha Christie'),(33,'Albert Camus'),(34,'Aldous Huxley'),(37,'Alexandre Dumas'),(54,'Any Rand'),(17,'Arthur Conan Doyle'),(46,'Ayn Rand'),(12,'Charles Dickens'),(20,'Charlotte Bronte'),(29,'Dante Alighieri'),(45,'E.G. Lovecraft'),(44,'E.M. Forster'),(30,'Edgar Allan Poe'),(52,'Edith Wharton'),(16,'Emily Bronte'),(7,'Ernest Hemingway'),(11,'F. Scott Fitzgerald'),(24,'Franz Kafka'),(58,'G. Eliot'),(23,'Gabriel Garcia Marquez'),(49,'George Bernard Shaw'),(4,'George Orwell'),(26,'H.G. Wells'),(53,'H.P. Lovecraft'),(5,'Harper Lee'),(42,'Henry David Thoreau'),(18,'Herman Melville'),(35,'Homer'),(1,'J.K. Rowling'),(6,'J.R.R. Tolkien'),(38,'James Joyce'),(9,'Jane Austen'),(59,'John Milko'),(51,'John Milton'),(19,'John Steinbeck'),(40,'Joseph Conrad'),(43,'Jules Verne'),(25,'Kurt Vonnegut'),(10,'Leo Tolstoy'),(21,'Lewis Carroll'),(8,'Mark Twain'),(22,'Miguel de Cervantes'),(36,'Nathaniel Hawthorne'),(57,'Nick Bernard Shaw'),(39,'O. Henry'),(15,'Oscar Wilde'),(28,'Ralph Ellison'),(27,'Ray Bradbury'),(32,'Rudyard Kipling'),(2,'Stephen King'),(50,'T.S. Eliot'),(60,'Tesla Wharton'),(41,'Thomas Hardy'),(31,'Victor Hugo'),(13,'Virginia Woolf'),(48,'Voltaire'),(56,'Voltaire Jr'),(47,'Walt Whitman'),(55,'Waltz Whitman'),(14,'William Shakespeare');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `belongs_to`
--

DROP TABLE IF EXISTS `belongs_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `belongs_to` (
  `ISBN` int(11) NOT NULL,
  `C_name` varchar(45) NOT NULL,
  PRIMARY KEY (`ISBN`,`C_name`),
  KEY `fk_belongs_to_c_name` (`C_name`),
  CONSTRAINT `fk_belongs_to_c_name` FOREIGN KEY (`C_name`) REFERENCES `category` (`C_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_belongs_to_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `belongs_to`
--

LOCK TABLES `belongs_to` WRITE;
/*!40000 ALTER TABLE `belongs_to` DISABLE KEYS */;
INSERT INTO `belongs_to` VALUES (978000001,'Cooking'),(978000002,'Science Fiction'),(978000003,'Biography'),(978000003,'Science Fiction'),(978000004,'Mystery'),(978000005,'History'),(978000005,'Science Fiction'),(978000006,'Self-Help'),(978000007,'Biography'),(978000007,'Cooking'),(978000007,'Thriller'),(978000008,'History'),(978000008,'Mystery'),(978000008,'Thriller'),(978000009,'Fiction'),(978000009,'Self-Help'),(978000010,'Cooking'),(978000011,'Biography'),(978000011,'Romance'),(978000012,'Fantasy'),(978000013,'Biography'),(978000013,'Fantasy'),(978000013,'Science Fiction'),(978000014,'Science Fiction'),(978000015,'Romance'),(978000015,'Science Fiction'),(978000015,'Thriller'),(978000016,'Romance'),(978000017,'History'),(978000017,'Science Fiction'),(978000018,'History'),(978000018,'Science Fiction'),(978000019,'Biography'),(978000019,'Cooking'),(978000020,'Fiction'),(978000020,'Romance'),(978000020,'Thriller'),(978000021,'Fantasy'),(978000021,'Science Fiction'),(978000021,'Self-Help'),(978000022,'History'),(978000023,'Thriller'),(978000024,'Cooking'),(978000024,'Fiction'),(978000024,'Self-Help'),(978000025,'Self-Help'),(978000025,'Thriller'),(978000026,'Romance'),(978000027,'Biography'),(978000027,'Fantasy'),(978000027,'Self-Help'),(978000028,'Fantasy'),(978000028,'History'),(978000029,'Biography'),(978000030,'Fiction'),(978000030,'Science Fiction'),(978000031,'Mystery'),(978000031,'Self-Help'),(978000031,'Thriller'),(978000032,'Fiction'),(978000032,'Thriller'),(978000033,'Biography'),(978000033,'Mystery'),(978000033,'Science Fiction'),(978000034,'Biography'),(978000034,'Fantasy'),(978000035,'Cooking'),(978000036,'Romance'),(978000037,'Fiction'),(978000037,'Mystery'),(978000038,'Biography'),(978000038,'Fantasy'),(978000038,'Fiction'),(978000039,'Fantasy'),(978000039,'Mystery'),(978000039,'Romance'),(978000040,'Romance'),(978000041,'Self-Help'),(978000042,'Science Fiction'),(978000042,'Self-Help'),(978000042,'Thriller'),(978000043,'Romance'),(978000044,'Biography'),(978000044,'Cooking'),(978000044,'Thriller'),(978000045,'History'),(978000046,'Fiction'),(978000046,'Romance'),(978000046,'Thriller'),(978000047,'Self-Help'),(978000048,'Cooking'),(978000048,'Mystery'),(978000048,'Thriller'),(978000049,'Biography'),(978000049,'Fiction'),(978000050,'Biography'),(978000050,'Cooking'),(978000050,'Mystery'),(978000051,'Cooking'),(978000052,'Cooking'),(978000053,'Biography'),(978000053,'Self-Help'),(978000054,'Biography'),(978000055,'Cooking'),(978000056,'Biography'),(978000057,'Biography'),(978000058,'Fantasy'),(978000059,'Self-Help'),(978000060,'Cooking'),(978000061,'Biography'),(978000061,'Fantasy'),(978000061,'Mystery'),(978000062,'Mystery'),(978000063,'Mystery'),(978000063,'Self-Help'),(978000064,'Fiction'),(978000064,'History'),(978000065,'Biography'),(978000065,'Science Fiction'),(978000066,'Mystery'),(978000067,'Science Fiction'),(978000067,'Thriller'),(978000068,'Self-Help'),(978000069,'Fantasy'),(978000069,'Self-Help'),(978000070,'Fantasy'),(978000070,'Mystery'),(978000071,'Fantasy'),(978000071,'Science Fiction'),(978000071,'Self-Help'),(978000072,'Fantasy'),(978000072,'Thriller'),(978000073,'Fantasy'),(978000074,'Thriller'),(978000075,'Fantasy'),(978000076,'Cooking'),(978000076,'Fiction'),(978000076,'Thriller'),(978000077,'Fiction'),(978000078,'Cooking'),(978000079,'Biography'),(978000080,'Fantasy'),(978000080,'Thriller'),(978000081,'Cooking'),(978000081,'Thriller'),(978000082,'Fantasy'),(978000083,'Self-Help'),(978000084,'Fiction'),(978000084,'Thriller'),(978000085,'Cooking'),(978000085,'Fiction'),(978000085,'Mystery'),(978000086,'History'),(978000086,'Science Fiction'),(978000086,'Thriller'),(978000087,'Fantasy'),(978000087,'Romance'),(978000088,'Fiction'),(978000089,'Fiction'),(978000089,'Romance'),(978000090,'Fiction'),(978000090,'Science Fiction'),(978000091,'Biography'),(978000092,'Fiction'),(978000092,'Thriller'),(978000093,'Mystery'),(978000094,'Fantasy'),(978000095,'History'),(978000095,'Mystery'),(978000095,'Science Fiction'),(978000096,'History'),(978000097,'Biography'),(978000097,'History'),(978000098,'History'),(978000099,'Fantasy'),(978000099,'Self-Help'),(978000100,'Biography'),(978000100,'Romance');
/*!40000 ALTER TABLE `belongs_to` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `ISBN` int(11) NOT NULL,
  `Title` varchar(50) NOT NULL,
  `Publisher` varchar(50) NOT NULL,
  `Page_number` int(11) NOT NULL CHECK (`Page_number` > 0),
  `Summary` varchar(255) NOT NULL,
  `Available_copies` int(11) NOT NULL CHECK (`Available_copies` > -1),
  `img` varchar(100) NOT NULL,
  `B_language` varchar(45) NOT NULL,
  `Operator_ID` int(11) NOT NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE KEY `Title` (`Title`),
  KEY `fk_book_operator_ID` (`Operator_ID`),
  KEY `title_index` (`Title`),
  KEY `available_copies_index` (`Available_copies`),
  CONSTRAINT `fk_book_operator_ID` FOREIGN KEY (`Operator_ID`) REFERENCES `operator` (`Operator_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (978000001,'The Gt Gatsby','Scribner',180,'A story of the decadent excesses of the Roaring Twenties',5,'https://example.com/book_1.jpg','English',1),(978000002,'To Kill a Mockingbird 2','J. B. Lippincott & Co.',324,'A novel set in the Depression-era Deep South and dealing with themes of racial inequality',0,'https://example.com/book_2.jpg','English',2),(978000003,'One Hundred Years of Solitude','Harper & Row',417,'A landmark novel of the Latin American Boom that tells the story of the Buend├¡a family over seven generations',2,'https://example.com/book_3.jpg','Spanish',3),(978000004,'Stranger','Gallimard',123,'A novel by French author Albert Camus that explores themes of alienation and absurdity',4,'https://example.com/book_4.jpg','French',4),(978000005,'The Wind-Up Bird Chronicle','Shinchosha',607,'A novel by Greek author Haruki Murakami that blends elements of magical realism with historical fiction',4,'https://example.com/book_5.jpg','Greek',5),(978000006,'The Name of the Rose','Adelphi Edizioni',536,'A historical murder mystery set in an Italian monastery in the year 1327',6,'https://example.com/book_6.jpg','Italian',6),(978000007,'The Hitchhiker\"s Guide to the Galaxy','Pan Books',193,'A science fiction comedy that follows the misadventures of an unwitting human and his alien friend as they travel through space',3,'https://example.com/book_7.jpg','English',7),(978000008,'Chronicle of a Death Foretold','La Oveja Negra',120,'A novella by Colombian author Gabriel Garc├¡a M├írquez that explores the events leading up to a murder',2,'https://example.com/book_8.jpg','Spanish',8),(978000009,'The ial','Kurt Wolff Verlag',255,'A novel by Franz Kafka that tells the story of a man who is arrested and put on trial, but is never told what crime he has committed',1,'https://example.com/book_9.jpg','German',9),(978000010,'The Sound and the Fury','Jonathan Cape and Harrison Smith',326,'A novel by William Faulkner that employs a stream-of-consciousness narrative style to tell the story of the Compson family over several decades',4,'https://example.com/book_10.jpg','English',10),(978000011,'Crime and Punishment 2','The Russian Messenger',430,'A novel by Fyodor Dostoevsky that follows the moral dilemmas and consequences of a young man who commits a murder',5,'https://example.com/book_11.jpg','Russian',1),(978000012,'1984','Secker & Warburg',328,'A dystopian novel by George Orwell that depicts a totalitarian society and explores themes of government control and surveillance',4,'https://example.com/book_22.jpg','English',2),(978000013,'The Lord of the Rings','George Allen & Unwin',1178,'A high fantasy novel by J.R.R. Tolkien that follows the quest to destroy the One Ring and defeat the Dark Lord Sauron',3,'https://example.com/book_23.jpg','English',3),(978000014,'The Alchemist 2','HarperCollins',197,'A novel by Paulo Coelho that tells the story of a young Andalusian shepherd on a journey to find his personal legend',6,'https://example.com/book_24.jpg','Portuguese',4),(978000015,'The Littlebig Prince','Reynal & Hitchcock',96,'A novella by Antoine de Saint-Exup├®ry that tells the story of a young prince who travels from planet to planet, learning important life lessons along the way',5,'https://example.com/book_25.jpg','French',5),(978000016,'The Adventures of Tom Sawyer','Chatto & Windus',274,'A novel by Mark Twain that follows the adventures of a young boy named Tom Sawyer in the Mississippi River town of St. Petersburg',7,'https://example.com/book_26.jpg','English',6),(978000017,'Moby-Dick 2','Richard Bentley',585,'A novel by Herman Melville that tells the story of Captain Ahab\"s obsessive quest for revenge against the white whale, Moby Dick',2,'https://example.com/book_27.jpg','English',7),(978000018,'The Count of Monte Cristopher','P├®tion',464,'A novel by Alexandre Dumas that follows the story of Edmond Dant├¿s, who seeks revenge against those who wrongly imprisoned him',4,'https://example.com/book_28.jpg','French',8),(978000019,'Frankenstein 2','Lackington, Hughes, Harding, Mavor & Jones',280,'A novel by Mary Shelley that tells the story of Victor Frankenstein and his creation, often referred to as the Frankenstein monster',3,'https://example.com/book_29.jpg','English',9),(978000020,'The Great Expectations','Chapman & Hall',505,'A novel by Charles Dickens that follows the life of Pip, an orphan who rises through society and faces various challenges along the way',6,'https://example.com/book_30.jpg','English',10),(978000021,'The Kite','Riverhead Books',371,'A novel by Khaled Hosseini that follows the story of Amir, a young boy from Afghanistan, and his journey of redemption',5,'https://example.com/book_31.jpg','English',1),(978000022,'The fChronicles o Narnia','Geoffrey Bles',767,'A series of fantasy novels by C.S. Lewis that takes readers to the magical world of Narnia and follows the adventures of various characters',2,'https://example.com/book_32.jpg','English',2),(978000023,'The Picture Book','Random House',40,'A children\"s picture book that engages young readers with colorful illustrations and simple storytelling',8,'https://example.com/book_33.jpg','English',3),(978000024,'The Girl with the Dragon Tattoo','Norstedts F├Ârlag',672,'A psychological thriller novel by Stieg Larsson that follows investigative journalist Mikael Blomkvist and computer hacker Lisbeth Salander',4,'https://example.com/book_34.jpg','Swedish',4),(978000025,'Hobbit','George Allen & Unwin',310,'A children\"s fantasy novel by J.R.R. Tolkien that follows the adventures of hobbit Bilbo Baggins as he embarks on a quest to reclaim a treasure from a dragon',5,'https://example.com/book_35.jpg','English',5),(978000026,'Harry Potter and the Philosopher\"s Stone','Bloomsbury Publishing',223,'The first book in the Harry Potter series by J.K. Rowling, introducing the young wizard and his journey at Hogwarts School of Witchcraft and Wizardry',7,'https://example.com/book_36.jpg','English',6),(978000027,'The Hunger Games','Scholastic Corporation',374,'The first book in the dystopian trilogy by Suzanne Collins, where teenagers are forced to participate in a televised battle to the death',5,'https://example.com/book_37.jpg','English',7),(978000028,'The Vinci Code','Doubleday',454,'A mystery thriller novel by Dan Brown that follows symbologist Robert Langdon as he unravels a series of clues related to a hidden secret society',3,'https://example.com/book_38.jpg','English',8),(978000029,'The Fault in Our Stars','Dutton Books',313,'A young adult novel by John Green that tells the love story of Hazel and Gus, two teenagers with cancer',6,'https://example.com/book_39.jpg','English',9),(978000030,'A Game of Thrones','Bantam Spectra',694,'The first book in the fantasy series A Song of Ice and Fire by George R.R. Martin, featuring a complex web of political intrigue and power struggles in the fictional land of Westeros',4,'https://example.com/book_40.jpg','English',10),(978000031,'Odyssey','Homer',442,'An ancient Greek epic poem attributed to Homer, telling the story of Odysseus and his ten-year journey back home to Ithaca after the Trojan War',5,'https://example.com/book_31.jpg','Greek',1),(978000032,'The Adventures of Huckleberry Finn','Chatto & Windus',366,'A novel by Mark Twain that follows the adventures of Huckleberry Finn and his friend Jim, an escaped slave, as they travel along the Mississippi River',6,'https://example.com/book_32.jpg','English',2),(978000033,'Crime and Punishment','The Russian Messenger',430,'A novel by Fyodor Dostoevsky that explores the psychological turmoil of Raskolnikov, a poor ex-student who commits a murder and grapples with guilt and punishment',4,'https://example.com/book_33.jpg','Russian',3),(978000034,'The Divine Comedy','Dante Alighieri',798,'An epic poem by Dante Alighieri that presents an allegorical journey through Hell, Purgatory, and Paradise, exploring themes of sin, redemption, and divine love',3,'https://example.com/book_34.jpg','Italian',4),(978000035,'Hundred Years of Solitude','Harper & Row',417,'A novel by Gabriel Garc├¡a M├írquez that tells the multi-generational story of the Buend├¡a family in the fictional town of Macondo, blending elements of magical realism',7,'https://example.com/book_35.jpg','Spanish',5),(978000036,'The Iliad','Homer',683,'An ancient Greek epic poem attributed to Homer, recounting the events of the Trojan War and the rage of Achilles',4,'https://example.com/book_36.jpg','Greek',6),(978000037,'The Canterbury Tales','Geoffrey Chaucer',524,'A collection of stories by Geoffrey Chaucer, written in Middle English, depicting a group of pilgrims traveling to the shrine of Saint Thomas Becket',4,'https://example.com/book_37.jpg','Middle English',7),(978000038,'Wuthering Heights','Thomas Cautley Newby',320,'A novel by Emily Bront├½ that explores the passionate and destructive love story of Catherine Earnshaw and Heathcliff on the Yorkshire moors',6,'https://example.com/book_38.jpg','English',8),(978000039,'Don Quixote','Francisco de Robles',863,'A novel by Miguel de Cervantes that follows the adventures of an eccentric nobleman, Alonso Quixano, who imagines himself to be a knight-errant',3,'https://example.com/book_39.jpg','Spanish',9),(978000040,'The Name of the Rose 2','Adelphi Edizioni',536,'A historical murder mystery set in an Italian monastery in the year 1327',0,'https://example.com/book_6.jpg','Italian',1),(978000041,'The Catcher ','Little, Brown and Company',277,'A novel by J.D. Salinger that follows the story of Holden Caulfield, a teenager navigating his way through adolescence and society',5,'https://example.com/book_41.jpg','English',2),(978000042,'The Thief','Markus Zusak',584,'A historical fiction novel by Markus Zusak set during World War II, narrated by Death and centered around a young girl named Liesel Meminger',6,'https://example.com/book_42.jpg','English',3),(978000043,'To Mockingbird','Harper Lee',324,'A novel by Harper Lee that explores racial injustice and moral development through the eyes of a young girl named Scout Finch in the 1930s Deep South',3,'https://example.com/book_43.jpg','English',4),(978000044,'The Shining','Doubleday',447,'A horror novel by Stephen King that follows the story of Jack Torrance, a writer who becomes the winter caretaker of the isolated Overlook Hotel and descends into madness',2,'https://example.com/book_44.jpg','English',5),(978000045,'The Secret Life of Bees','Viking Press',336,'A novel by Sue Monk Kidd that explores themes of race, family, and female empowerment through the journey of a young girl named Lily Owens in the 1960s American South',7,'https://example.com/book_45.jpg','English',6),(978000046,'The Name of the Wind','DAW Books',662,'The first book in the fantasy series The Kingkiller Chronicle by Patrick Rothfuss, following the story of Kvothe, an orphan with a talent for magic and music',5,'https://example.com/book_46.jpg','English',7),(978000047,'The Road','Alfred A. Knopf',287,'A post-apocalyptic novel by Cormac McCarthy that follows a father and son as they journey across a desolate landscape, facing numerous challenges and moral dilemmas',4,'https://example.com/book_47.jpg','English',8),(978000048,'The Diary of a Young Girl','Contact Publishing',283,'The published diary of Anne Frank, a Jewish girl who went into hiding during the Nazi occupation of the Netherlands and documented her experiences',5,'https://example.com/book_48.jpg','Dutch',9),(978000049,'Brave New World 2','Chatto & Windus',311,'A dystopian novel by Aldous Huxley that depicts a future society where human reproduction is controlled and citizens are kept in a state of superficial happiness',3,'https://example.com/book_49.jpg','English',10),(978000050,'TheWrath','The Viking Press',464,'A novel by John Steinbeck that tells the story of the Joads, a poor family of tenant farmers during the Great Depression, as they migrate from Oklahoma to California',8,'https://example.com/book_50.jpg','English',1),(978000051,'Pride and Prejudice','Thomas Egerton',279,'A novel by Jane Austen that follows the story of Elizabeth Bennet and her complex relationship with the proud Mr. Darcy',3,'https://example.com/book_51.jpg','English',2),(978000052,'Moby-Dick','Richard Bentley',585,'A novel by Herman Melville that tells the story of Captain Ahab and his relentless pursuit of the great white whale',6,'https://example.com/book_52.jpg','English',3),(978000053,'The Great Gatsby 7','Charles Scribner\"s Sons',180,'A novel by F. Scott Fitzgerald set in the Jazz Age, depicting the glamorous and tragic life of Jay Gatsby and his love for Daisy Buchanan',4,'https://example.com/book_53.jpg','English',4),(978000054,'War and Peace','The Russian Messenger',1225,'A novel by Leo Tolstoy that explores the impact of war on society through the intertwining lives of various characters during the Napoleonic era',3,'https://example.com/book_54.jpg','Russian',5),(978000055,'Jane Eyre','Smith, Elder & Co.',594,'A novel by Charlotte Bront├½ that follows the life of Jane Eyre, an orphan who becomes a governess and navigates love, independence, and societal expectations',7,'https://example.com/book_55.jpg','English',6),(978000056,'1982','Secker & Warburg',328,'A dystopian novel by George Orwell that depicts a totalitarian society governed by Big Brother, where individuality and independent thought are suppressed',5,'https://example.com/book_56.jpg','English',7),(978000057,'The Lord and the Rings','George Allen & Unwin',1178,'A fantasy novel by J.R.R. Tolkien that follows the quest to destroy the One Ring and the epic battles between the forces of good and evil in the land of Middle-earth',3,'https://example.com/book_57.jpg','English',8),(978000058,'Anna Karenina','The Russian Messenger',864,'A novel by Leo Tolstoy that explores themes of love, infidelity, and societal norms through the tragic story of Anna Karenina and her affair with Count Vronsky',6,'https://example.com/book_58.jpg','Russian',9),(978000059,'The Alchemist','Editora Rocco',208,'A novel by Paulo Coelho that follows the journey of a young Andalusian shepherd boy named Santiago as he sets out to discover his personal legend',3,'https://example.com/book_59.jpg','Portuguese',10),(978000060,'The Count of Monte Cristo','P├®tion & Cie',1316,'A novel by Alexandre Dumas that tells the story of Edmond Dant├¿s, who, after being wrongfully imprisoned, seeks revenge against those who betrayed him',8,'https://example.com/book_60.jpg','French',1),(978000061,'The Picture of Dorian Gray','Ward, Lock & Co.',254,'A novel by Oscar Wilde that tells the story of a young man named Dorian Gray, who remains eternally young while a portrait of him ages and reflects his hidden sins',5,'https://example.com/book_61.jpg','English',2),(978000062,'The Little Prince','Reynal & Hitchcock',96,'A novella by Antoine de Saint-Exup├®ry that follows the story of a young prince who travels from planet to planet and learns valuable life lessons along the way',6,'https://example.com/book_62.jpg','French',3),(978000063,'The Hobbit','George Allen & Unwin',310,'A fantasy novel by J.R.R. Tolkien that serves as a prequel to The Lord of the Rings, following the adventures of Bilbo Baggins as he embarks on a quest to reclaim the dwarf kingdom of Erebor',3,'https://example.com/book_63.jpg','English',4),(978000064,'Gone with the Wind 2','Macmillan Publishers',1037,'A novel by Margaret Mitchell set during the American Civil War and Reconstruction era, focusing on the life of Scarlett O\"Hara and her love affair with Rhett Butler',3,'https://example.com/book_64.jpg','English',5),(978000065,'The Kite Runner','Riverhead Books',371,'A novel by Khaled Hosseini that explores themes of friendship, betrayal, and redemption through the story of Amir, a young boy from Kabul, and his journey to confront his past',7,'https://example.com/book_65.jpg','English',6),(978000066,'The Odyssey','Homer',442,'An ancient Greek epic poem attributed to Homer, telling the story of Odysseus and his ten-year journey back home to Ithaca after the Trojan War',5,'https://example.com/book_66.jpg','Greek',7),(978000067,'Sherlock Holmes','George Newnes Ltd',307,'A collection of detective stories by Arthur Conan Doyle featuring the iconic character Sherlock Holmes and his loyal companion Dr. John Watson',4,'https://example.com/book_67.jpg','English',8),(978000068,'The Scarlet Letters','Ticknor, Reed & Fields',238,'A novel by Nathaniel Hawthorne set in 17th-century Puritan Boston, exploring themes of sin, guilt, and redemption through the story of Hester Prynne',5,'https://example.com/book_68.jpg','English',9),(978000069,'The Trial 3','Kurt Wolff Verlag',315,'A novel by Franz Kafka that follows the story of Josef K., who is arrested and prosecuted by a mysterious court system, leading him into a surreal and absurd ordeal',3,'https://example.com/book_69.jpg','German',10),(978000070,'The Secret Garden','Frederick Warne & Co.',331,'A novel by Frances Hodgson Burnett that tells the story of Mary Lennox, a young girl who discovers a hidden garden and experiences personalgrowth and healing as she tends to the neglected garden, accompanied by her friend Dickon and her cousin Colin',8,'https://example.com/book_70.jpg','English',1),(978000071,'To Kill 3 Mockingbird','J. B. Lippincott & Co.',281,'A novel by Harper Lee that explores themes of racial injustice and the loss of innocence through the eyes of Scout Finch as she observes her father, Atticus, defending a black man falsely accused of rape',5,'https://example.com/book_71.jpg','English',2),(978000072,'The Catcher of the Rye','Little, Brown and Company',224,'A novel by J.D. Salinger that follows the experiences of Holden Caulfield, a disillusioned teenager, as he navigates the challenges of adolescence and societal hypocrisy',5,'https://example.com/book_72.jpg','English',3),(978000073,'Grapes of Wrath','The Viking Press',464,'A novel by John Steinbeck that portrays the struggles of the Joad family, who are forced to leave their Oklahoma farm during the Great Depression and migrate to California in search of a better life',4,'https://example.com/book_73.jpg','English',4),(978000074,'Frankenstein 9','Lackington, Hughes, Harding, Mavor & Jones',280,'A novel by Mary Shelley that explores themes of creation, identity, and the consequences of unchecked ambition through the story of Victor Frankenstein and the creature he brings to life',3,'https://example.com/book_74.jpg','English',5),(978000075,'The Chronicles of Narnia','Geoffrey Bles',767,'A series of fantasy novels by C.S. Lewis that takes readers to the magical world of Narnia, where they embark on epic adventures alongside various characters, including the Pevensie siblings',6,'https://example.com/book_75.jpg','English',6),(978000076,'A Tale of Two Cities','Chapman & Hall',544,'A novel by Charles Dickens set in London and Paris before and during the French Revolution, weaving together the lives of several characters against the backdrop of political turmoil',5,'https://example.com/book_76.jpg','English',7),(978000077,'The Stranger','Gallimard',123,'A novel by Albert Camus that explores existential themes through the story of Meursault, a detached and indifferent man who becomes embroiled in a murder investigation',4,'https://example.com/book_77.jpg','French',8),(978000078,'The Book Thief','Knopf',584,'A novel by Markus Zusak set in Nazi Germany, following the story of Liesel Meminger, a young girl who steals books and finds solace in literature during a time of war and oppression',6,'https://example.com/book_78.jpg','English',9),(978000079,'The Stranger Beside Me','W. W. Norton & Company',509,'A true crime book by Ann Rule that recounts her personal relationship with the infamous serial killer Ted Bundy and provides insights into his crimes and the investigation',3,'https://example.com/book_79.jpg','English',10),(978000080,'The Da Vinci Code','Doubleday',454,'A mystery thriller novel by Dan Brown that follows the adventure of symbologist Robert Langdon as he unravels a series of clues and puzzles related to a hidden secret involving the Holy Grail and the life of Jesus Christ',8,'https://example.com/book_80.jpg','English',1),(978000081,'Brave New World','Chatto & Windus',311,'A dystopian novel by Aldous Huxley set in a futuristic society that emphasizes conformity, consumerism, and the suppression of individuality',5,'https://example.com/book_81.jpg','English',2),(978000082,'The Old Man and the Sea','Charles Scribner\"s Sons',127,'A novella by Ernest Hemingway that tells the story of an aging fisherman named Santiago and his epic battle with a giant marlin in the Gulf Stream',6,'https://example.com/book_82.jpg','English',3),(978000083,'Fahrenheit 451','Ballantine Books',159,'A dystopian novel by Ray Bradbury that depicts a society where books are banned and burned, and the protagonist, Guy Montag, rebels against the oppressive regime',4,'https://example.com/book_83.jpg','English',4),(978000084,'The Hitchhiker\"s Guide the Galaxy','Pan Books',193,'A comedic science fiction series by Douglas Adams following the adventures of Arthur Dent, who is swept off Earth just before its destruction and travels through space with his alien friend Ford Prefect',3,'https://example.com/book_84.jpg','English',5),(978000085,'Animal Farm','Secker & Warburg',112,'A satirical novella by George Orwell that uses a farm and its animals to allegorically depict the events leading up to the Russian Revolution and the subsequent rise of the Soviet Union',6,'https://example.com/book_85.jpg','English',6),(978000086,'The Picture of Dorian White','Ward, Lock & Co.',254,'A novel by Oscar Wilde where a young man\"s portrait ages while he remains eternally young, leading to a life of debauchery and moral corruption',5,'https://example.com/book_86.jpg','English',7),(978000087,'The Big Prince','Reynal & Hitchcock',96,'A novella by Antoine de Saint-Exup├®ry about a young prince who travels from planet to planet, learning valuable life lessons along the way',4,'https://example.com/book_87.jpg','French',8),(978000088,'The Hobbit 2','George Allen & Unwin',310,'A fantasy novel by J.R.R. Tolkien about the hobbit Bilbo Baggins and his unexpected journey to reclaim the dwarf kingdom of Erebor from the dragon Smaug',6,'https://example.com/book_88.jpg','English',9),(978000089,'Gone with the Wind','Macmillan Publishers',1037,'A novel by Margaret Mitchell set during the American Civil War, following the life of Scarlett O\"Hara as she navigates love, loss, and the changing society of the South',3,'https://example.com/book_89.jpg','English',10),(978000090,'The Great Gatsby','Charles Scribner\"s Sons',180,'A novel by F. Scott Fitzgerald set in the Jazz Age, following the enigmatic millionaire Jay Gatsby and his pursuit of the elusive Daisy Buchanan',4,'https://example.com/book_90.jpg','English',1),(978000091,'The Odyssey of o','Homer',442,'An ancient Greek epic poem attributed to Homer, telling the story of Odysseus and his ten-year journey back home to Ithaca after the Trojan War',5,'https://example.com/book_91.jpg','Greek',2),(978000092,'The Adventures of Sherlock Holmes','George Newnes Ltd',307,'A collection of detective stories by Arthur Conan Doyle featuring the iconic character Sherlock Holmes and his loyal companion Dr. John Watson',4,'https://example.com/book_92.jpg','English',3),(978000093,'The Scarlet Letter','Ticknor, Reed & Fields',238,'A novel by Nathaniel Hawthorne set in 17th-century Puritan Boston, exploring themes of sin, guilt, and redemption through the story of Hester Prynne',6,'https://example.com/book_93.jpg','English',4),(978000094,'The Trial','Kurt Wolff Verlag',315,'A novel by Franz Kafka that follows the story of Josef K., who is arrested and prosecuted by a mysterious court system, leading him into a surreal and absurd ordeal',3,'https://example.com/book_94.jpg','German',5),(978000095,'The Secret Gardens','Frederick Warne & Co.',331,'A novel by Frances Hodgson Burnett that tells the story of Mary Lennox, a young girl who discovers a hidden garden and experiences personal growth and transformation',8,'https://example.com/book_95.jpg','English',6),(978000096,'To Kill a Mockingbird','J. B. Lippincott & Co.',281,'A novel by Harper Lee that explores themes of racial injustice and the loss of innocence through the eyes of Scout Finch as she observes her father, Atticus, defending a black man falsely accused of rape',5,'https://example.com/book_96.jpg','English',7),(978000097,'The Catcher in the Rye','Little, Brown and Company',224,'A novel by J.D. Salinger that follows the experiences of Holden Caulfield, a disillusioned teenager, as he navigates the challenges of adolescence and societal hypocrisy',6,'https://example.com/book_97.jpg','English',8),(978000098,'The Grapes of Wrath','The Viking Press',464,'A novel by John Steinbeck that portrays the struggles of the Joad family, who are forced to leave their Oklahoma farm during the Great Depression and migrate to California in search of a better life',3,'https://example.com/book_98.jpg','English',9),(978000099,'Frankenstein','Lackington, Hughes, Harding, Mavor & Jones',280,'A novel by Mary Shelley that explores themes of creation, identity, and the consequences of unchecked ambition through the story of Victor Frankenstein and the creature he brings to life',2,'https://example.com/book_99.jpg','English',10),(978000100,'Narnia','Geoffrey Bles',767,'A series of fantasy novels by C.S. Lewis that takes readers to the magical world of Narnia, where they embark on epic adventures alongside various characters, including the Pevensie siblings',7,'https://example.com/book_100.jpg','English',1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrows`
--

DROP TABLE IF EXISTS `borrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrows` (
  `Username` varchar(20) NOT NULL,
  `ISBN` int(11) NOT NULL,
  `b_date` date NOT NULL,
  `ret_date` date DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ISBN`,`Username`),
  KEY `fk_borrows_username` (`Username`),
  KEY `b_date_index` (`b_date`),
  CONSTRAINT `fk_borrows_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_borrows_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrows`
--

LOCK TABLES `borrows` WRITE;
/*!40000 ALTER TABLE `borrows` DISABLE KEYS */;
INSERT INTO `borrows` VALUES ('user13',978000001,'2023-03-18','2023-03-20','2023-06-03 14:05:14'),('user20',978000002,'2023-01-12',NULL,'2023-06-03 14:05:14'),('user39',978000004,'2023-06-02','2023-06-09','2023-06-03 14:05:14'),('user8',978000004,'2023-02-06','2023-02-08','2023-06-03 14:05:14'),('user9',978000004,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user7',978000005,'2023-05-14','2023-05-16','2023-06-03 14:05:14'),('user2',978000009,'2023-03-02','2023-03-04','2023-06-03 14:05:14'),('user22',978000018,'2023-03-13','2023-03-15','2023-06-03 14:05:14'),('user48',978000018,'2023-02-07','2023-02-09','2023-06-03 14:05:14'),('user3',978000020,'2023-04-15','2023-04-17','2023-06-03 14:05:14'),('user51',978000022,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user13',978000025,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user42',978000026,'2023-03-14','2023-03-16','2023-06-03 14:05:14'),('user17',978000036,'2023-04-30','2023-05-02','2023-06-03 14:05:14'),('user23',978000036,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user30',978000039,'2023-01-21','2023-01-23','2023-06-03 14:05:14'),('user9',978000040,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user18',978000043,'2023-03-24',NULL,'2023-06-03 14:05:14'),('user6',978000044,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user15',978000045,'2023-04-11','2023-04-21','2023-06-03 14:05:14'),('user44',978000047,'2023-05-08','2023-05-11','2023-06-03 14:05:14'),('user5',978000047,'2023-01-19','2023-01-21','2023-06-03 14:05:14'),('user27',978000048,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user18',978000051,'2023-05-19',NULL,'2023-06-03 14:05:14'),('user6',978000051,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user41',978000052,'2023-05-01','2023-05-03','2023-06-03 14:05:14'),('user48',978000056,'2023-05-21','2023-05-23','2023-06-03 14:05:14'),('user59',978000057,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user53',978000058,'2023-04-29','2023-05-01','2023-06-03 14:05:14'),('user54',978000058,'2023-05-11','2023-05-13','2023-06-03 14:05:14'),('user49',978000060,'2023-01-16','2023-01-18','2023-06-03 14:05:14'),('user12',978000063,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user56',978000067,'2023-04-25','2023-04-27','2023-06-03 14:05:14'),('user24',978000068,'2023-04-25','2023-04-27','2023-06-03 14:05:14'),('user8',978000068,'2023-05-13',NULL,'2023-06-03 14:05:14'),('user38',978000070,'2023-04-20','2023-04-25','2023-06-03 14:05:14'),('user11',978000072,'2023-03-06',NULL,'2023-06-03 14:05:14'),('user50',978000072,'2023-02-02','2023-02-04','2023-06-03 14:05:14'),('user43',978000075,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user2',978000078,'2023-05-12','2023-05-14','2023-06-03 14:05:14'),('user17',978000080,'2023-02-12','2023-02-14','2023-06-03 14:05:14'),('user25',978000082,'2023-01-06','2023-01-08','2023-06-03 14:05:14'),('user15',978000083,'2023-03-30','2023-04-01','2023-06-03 14:05:14'),('user21',978000084,'2023-02-14','2023-02-16','2023-06-03 14:05:14'),('user16',978000085,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user5',978000090,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user3',978000093,'2023-03-28','2023-03-30','2023-06-03 14:05:14'),('user31',978000098,'2023-02-16','2023-02-18','2023-06-03 14:05:14'),('user4',978000098,'2023-06-04',NULL,'2023-06-03 14:05:14'),('user53',978000099,'2023-06-04',NULL,'2023-06-03 14:05:14');
/*!40000 ALTER TABLE `borrows` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER initialsub 
BEFORE INSERT ON borrows
FOR EACH ROW
BEGIN
  IF NEW.ret_date IS NULL
    THEN UPDATE book SET Available_copies = Available_copies-1 WHERE new.isbn = isbn;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `C_name` varchar(45) NOT NULL,
  PRIMARY KEY (`C_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('Biography'),('Cooking'),('Fantasy'),('Fiction'),('History'),('Mystery'),('Romance'),('Science Fiction'),('Self-Help'),('Thriller');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `key_words`
--

DROP TABLE IF EXISTS `key_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `key_words` (
  `Key_word_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ISBN` int(11) NOT NULL,
  `Key_word` varchar(20) NOT NULL,
  PRIMARY KEY (`Key_word_ID`),
  KEY `fk_key_words_ISBN` (`ISBN`),
  CONSTRAINT `fk_key_words_ISBN` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `key_words`
--

LOCK TABLES `key_words` WRITE;
/*!40000 ALTER TABLE `key_words` DISABLE KEYS */;
INSERT INTO `key_words` VALUES (1,978000001,'Music'),(2,978000001,'Mystery'),(3,978000001,'Dystopian'),(4,978000002,'Poetry'),(5,978000002,'Education'),(6,978000003,'Young Adult'),(7,978000004,'Children'),(8,978000005,'Health'),(9,978000005,'True Crime'),(10,978000005,'Autobiography'),(11,978000005,'Crafts'),(12,978000005,'Children'),(13,978000006,'Science Fiction'),(14,978000006,'Memoir'),(15,978000006,'Poetry'),(16,978000007,'True Crime'),(17,978000007,'Science'),(18,978000007,'Biography'),(19,978000007,'Adventure'),(20,978000007,'Science Fiction'),(21,978000008,'Sports'),(22,978000008,'Gardening'),(23,978000008,'Young Adult'),(24,978000008,'Fiction'),(25,978000008,'Suspense'),(26,978000009,'Self-Help'),(27,978000009,'Technology'),(28,978000010,'Humor'),(29,978000010,'Memoir'),(30,978000010,'Romance'),(31,978000010,'Mystery'),(32,978000010,'Business'),(33,978000011,'Sports'),(34,978000011,'Business'),(35,978000011,'Science'),(36,978000012,'Suspense'),(37,978000013,'Crafts'),(38,978000014,'Philosophy'),(39,978000014,'Art'),(40,978000014,'Gardening'),(41,978000015,'Technology'),(42,978000015,'Science'),(43,978000015,'Poetry'),(44,978000016,'Education'),(45,978000016,'Self-Help'),(46,978000016,'Biography'),(47,978000016,'Fiction'),(48,978000017,'Parenting'),(49,978000017,'Mystery'),(50,978000018,'Children'),(51,978000018,'Memoir'),(52,978000018,'Sports'),(53,978000018,'Thriller'),(54,978000019,'Cooking'),(55,978000019,'Philosophy'),(56,978000020,'Memoir'),(57,978000020,'Mystery'),(58,978000020,'Spirituality'),(59,978000020,'Dystopian'),(60,978000021,'Science'),(61,978000021,'Fashion'),(62,978000021,'Supernatural'),(63,978000021,'Dystopian'),(64,978000021,'Fiction'),(65,978000022,'Business'),(66,978000023,'Gardening'),(67,978000023,'Young Adult'),(68,978000023,'Sports'),(69,978000024,'Health'),(70,978000024,'Anthology'),(71,978000024,'Philosophy'),(72,978000025,'Art'),(73,978000026,'Suspense'),(74,978000026,'Art'),(75,978000026,'History'),(76,978000026,'Travel'),(77,978000027,'Anthology'),(78,978000027,'Children'),(79,978000028,'Adventure'),(80,978000028,'Business'),(81,978000028,'True Crime'),(82,978000028,'Self-Help'),(83,978000028,'Sports'),(84,978000029,'Romance'),(85,978000029,'Science Fiction'),(86,978000029,'Fantasy'),(87,978000029,'Poetry'),(88,978000030,'Science Fiction'),(89,978000030,'Thriller'),(90,978000030,'Education'),(91,978000030,'Horror'),(92,978000031,'Parenting'),(93,978000031,'Romance'),(94,978000031,'Technology'),(95,978000032,'Mystery'),(96,978000033,'Philosophy'),(97,978000033,'Education'),(98,978000033,'Technology'),(99,978000033,'Cooking'),(100,978000034,'Fashion'),(101,978000034,'Memoir'),(102,978000034,'Mystery'),(103,978000034,'Dystopian'),(104,978000034,'Autobiography'),(105,978000035,'Fantasy'),(106,978000035,'Children'),(107,978000035,'Anthology'),(108,978000036,'Romance'),(109,978000036,'Supernatural'),(110,978000036,'Young Adult'),(111,978000037,'Romance'),(112,978000037,'Sports'),(113,978000037,'Science Fiction'),(114,978000038,'Horror'),(115,978000038,'Autobiography'),(116,978000038,'Poetry'),(117,978000038,'Fashion'),(118,978000038,'Thriller'),(119,978000039,'Parenting'),(120,978000039,'Young Adult'),(121,978000040,'Fantasy'),(122,978000041,'Science Fiction'),(123,978000041,'Thriller'),(124,978000041,'Crafts'),(125,978000042,'Technology'),(126,978000042,'Psychology'),(127,978000042,'Crafts'),(128,978000043,'Poetry'),(129,978000043,'Memoir'),(130,978000043,'Travel'),(131,978000044,'Science'),(132,978000044,'Dystopian'),(133,978000044,'Business'),(134,978000044,'Biography'),(135,978000044,'Sports'),(136,978000045,'Autobiography'),(137,978000045,'Technology'),(138,978000045,'History'),(139,978000046,'Science Fiction'),(140,978000046,'Cooking'),(141,978000046,'True Crime'),(142,978000047,'Supernatural'),(143,978000047,'Science'),(144,978000047,'Humor'),(145,978000047,'Fantasy'),(146,978000047,'Horror'),(147,978000048,'Travel'),(148,978000049,'Memoir'),(149,978000050,'Education'),(150,978000050,'Fashion'),(151,978000051,'Young Adult'),(152,978000051,'Suspense'),(153,978000052,'Education'),(154,978000052,'Horror'),(155,978000052,'Young Adult'),(156,978000052,'Parenting'),(157,978000053,'Memoir'),(158,978000054,'Fashion'),(159,978000054,'Cooking'),(160,978000055,'Art'),(161,978000055,'Fantasy'),(162,978000056,'True Crime'),(163,978000056,'Self-Help'),(164,978000057,'Biography'),(165,978000057,'Music'),(166,978000058,'History'),(167,978000059,'Fashion'),(168,978000059,'Supernatural'),(169,978000059,'Young Adult'),(170,978000060,'Horror'),(171,978000061,'Fiction'),(172,978000061,'Dystopian'),(173,978000061,'Spirituality'),(174,978000061,'Young Adult'),(175,978000062,'Philosophy'),(176,978000063,'Art'),(177,978000063,'Biography'),(178,978000064,'Cooking'),(179,978000064,'Fashion'),(180,978000064,'Historical Fiction'),(181,978000064,'Horror'),(182,978000064,'Children'),(183,978000065,'True Crime'),(184,978000065,'Anthology'),(185,978000065,'Biography'),(186,978000065,'Technology'),(187,978000065,'Young Adult'),(188,978000066,'Science Fiction'),(189,978000066,'Suspense'),(190,978000067,'Romance'),(191,978000067,'Fantasy'),(192,978000067,'Fiction'),(193,978000067,'Art'),(194,978000068,'Historical Fiction'),(195,978000068,'Suspense'),(196,978000068,'Psychology'),(197,978000068,'Business'),(198,978000069,'Young Adult'),(199,978000070,'Sports'),(200,978000070,'Fiction'),(201,978000070,'Psychology'),(202,978000071,'Children'),(203,978000072,'Spirituality'),(204,978000072,'Self-Help'),(205,978000073,'Historical Fiction'),(206,978000074,'Business'),(207,978000074,'History'),(208,978000074,'Education'),(209,978000074,'Science Fiction'),(210,978000074,'Self-Help'),(211,978000075,'Humor'),(212,978000075,'Gardening'),(213,978000075,'Historical Fiction'),(214,978000075,'Anthology'),(215,978000076,'Historical Fiction'),(216,978000076,'Adventure'),(217,978000076,'Autobiography'),(218,978000077,'Travel'),(219,978000077,'Autobiography'),(220,978000078,'Art'),(221,978000079,'Parenting'),(222,978000080,'Philosophy'),(223,978000080,'Gardening'),(224,978000081,'Humor'),(225,978000082,'Self-Help'),(226,978000082,'Science'),(227,978000082,'Spirituality'),(228,978000082,'Philosophy'),(229,978000083,'Dystopian'),(230,978000083,'Science'),(231,978000083,'Supernatural'),(232,978000083,'Philosophy'),(233,978000084,'Sports'),(234,978000085,'Travel'),(235,978000085,'Fantasy'),(236,978000085,'Art'),(237,978000086,'Gardening'),(238,978000086,'Science Fiction'),(239,978000086,'Supernatural'),(240,978000087,'Art'),(241,978000087,'Children'),(242,978000087,'Fiction'),(243,978000088,'Philosophy'),(244,978000088,'Mystery'),(245,978000088,'Crafts'),(246,978000088,'Art'),(247,978000089,'Thriller'),(248,978000089,'Science'),(249,978000089,'Cooking'),(250,978000089,'Dystopian'),(251,978000089,'Autobiography'),(252,978000090,'Young Adult'),(253,978000091,'Memoir'),(254,978000091,'Technology'),(255,978000091,'Romance'),(256,978000091,'Biography'),(257,978000092,'Anthology'),(258,978000093,'Mystery'),(259,978000093,'Music'),(260,978000093,'Education'),(261,978000093,'Dystopian'),(262,978000093,'Technology'),(263,978000094,'Psychology'),(264,978000094,'Suspense'),(265,978000094,'Spirituality'),(266,978000094,'Business'),(267,978000095,'Fantasy'),(268,978000095,'Sports'),(269,978000095,'Young Adult'),(270,978000095,'Biography'),(271,978000096,'Psychology'),(272,978000096,'Fiction'),(273,978000096,'Art'),(274,978000097,'Crafts'),(275,978000097,'Romance'),(276,978000097,'Business'),(277,978000098,'Fantasy'),(278,978000099,'Fashion'),(279,978000099,'Spirituality'),(280,978000100,'Young Adult'),(281,978000100,'Humor'),(282,978000100,'Mystery'),(283,978000100,'Fantasy'),(284,978000100,'Anthology');
/*!40000 ALTER TABLE `key_words` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `late_returns`
--

DROP TABLE IF EXISTS `late_returns`;
/*!50001 DROP VIEW IF EXISTS `late_returns`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `late_returns` AS SELECT
 1 AS `First_name`,
  1 AS `Last_name`,
  1 AS `days_late` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `num_b_per_auth`
--

DROP TABLE IF EXISTS `num_b_per_auth`;
/*!50001 DROP VIEW IF EXISTS `num_b_per_auth`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `num_b_per_auth` AS SELECT
 1 AS `author_ID`,
  1 AS `Ath_full_name`,
  1 AS `count_of_books` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `operator`
--

DROP TABLE IF EXISTS `operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operator` (
  `Operator_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(20) NOT NULL,
  `Administrator_ID` int(11) DEFAULT NULL,
  `School_ID` int(11) NOT NULL,
  `Operator_first_name` varchar(100) NOT NULL,
  `Operator_last_name` varchar(100) NOT NULL,
  PRIMARY KEY (`Operator_ID`),
  KEY `fk_operator_username` (`Username`),
  KEY `fk_operator_school_id` (`School_ID`),
  KEY `fk_operator_administrator_id` (`Administrator_ID`),
  CONSTRAINT `fk_operator_administrator_id` FOREIGN KEY (`Administrator_ID`) REFERENCES `administrator` (`Administrator_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_operator_school_id` FOREIGN KEY (`School_ID`) REFERENCES `school` (`School_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_operator_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operator`
--

LOCK TABLES `operator` WRITE;
/*!40000 ALTER TABLE `operator` DISABLE KEYS */;
INSERT INTO `operator` VALUES (1,'user31',1,1,'Stefanos',' Souleles'),(2,'user32',1,2,'Eleni',' Anagnou'),(3,'user33',1,3,'Andreas',' Doufexis'),(4,'user34',1,4,'Maria',' Georganta'),(5,'user35',1,5,'Nikos',' Kanavaris'),(6,'user36',1,6,'Georgia',' Kostakou'),(7,'user37',1,7,'Christos',' Tsivikis'),(8,'user38',1,8,'Athina',' Tsika'),(9,'user39',1,9,'Panagiotis',' Vasilakis'),(10,'user40',1,10,'Dimitra',' Kornezou');
/*!40000 ALTER TABLE `operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `operatorcounts`
--

DROP TABLE IF EXISTS `operatorcounts`;
/*!50001 DROP VIEW IF EXISTS `operatorcounts`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `operatorcounts` AS SELECT
 1 AS `operator_ID`,
  1 AS `Operator_first_name`,
  1 AS `Operator_last_name`,
  1 AS `count_of_books` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserves` (
  `Username` varchar(20) NOT NULL,
  `ISBN` int(11) NOT NULL,
  `r_date` date NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Username`,`ISBN`),
  KEY `fk_reserves_isbn` (`ISBN`),
  CONSTRAINT `fk_reserves_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reserves_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserves`
--

LOCK TABLES `reserves` WRITE;
/*!40000 ALTER TABLE `reserves` DISABLE KEYS */;
INSERT INTO `reserves` VALUES ('user35',978000002,'2023-06-04','2023-06-03 14:05:14'),('user35',978000040,'2023-06-05','2023-06-03 14:05:14');
/*!40000 ALTER TABLE `reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `Review_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Rating` int(11) NOT NULL CHECK (`Rating` > -1 and `Rating` < 6),
  `Needs_approval` tinyint(1) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `ISBN` int(11) NOT NULL,
  `Comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Review_ID`),
  KEY `fk_reviews_username` (`Username`),
  KEY `fk_reviews_ISBN` (`ISBN`),
  CONSTRAINT `fk_reviews_ISBN` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reviews_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,0,'user26',978000011,'Kind of disappointing...'),(2,5,1,'user12',978000003,'10/10 would recommend'),(3,4,1,'user59',978000009,NULL),(4,1,0,'user30',978000008,NULL),(5,5,0,'user39',978000068,NULL),(6,4,1,'user47',978000031,NULL),(7,3,1,'user58',978000038,NULL),(8,5,0,'user39',978000013,NULL),(9,5,1,'user50',978000047,NULL),(10,3,0,'user40',978000087,NULL),(11,4,1,'user42',978000052,NULL),(12,5,0,'user22',978000049,NULL),(13,3,1,'user4',978000073,NULL),(14,5,0,'user32',978000070,'Read it immediatly, you wont regret it!'),(15,2,1,'user52',978000001,NULL),(16,4,1,'user46',978000056,NULL),(17,2,1,'user42',978000080,NULL),(18,1,1,'user12',978000040,NULL),(19,5,1,'user44',978000020,NULL),(20,5,1,'user15',978000053,NULL),(21,4,1,'user4',978000008,NULL),(22,1,1,'user48',978000016,NULL),(23,3,0,'user22',978000040,NULL),(24,4,0,'user40',978000063,NULL),(25,3,1,'user52',978000097,NULL),(26,4,1,'user18',978000021,NULL),(27,2,1,'user46',978000030,'Expected more...'),(28,3,0,'user37',978000028,NULL),(29,4,0,'user21',978000083,NULL),(30,2,1,'user13',978000064,NULL),(31,2,0,'user32',978000058,NULL),(32,4,1,'user11',978000083,NULL),(33,4,0,'user31',978000075,NULL),(34,1,1,'user4',978000029,NULL),(35,2,1,'user43',978000053,NULL),(36,1,0,'user31',978000026,NULL),(37,3,1,'user7',978000062,NULL),(38,2,1,'user2',978000094,NULL),(39,3,0,'user22',978000059,NULL),(40,5,1,'user50',978000075,'My favorite one so far'),(41,2,1,'user46',978000077,NULL),(42,3,1,'user19',978000010,NULL),(43,1,1,'user59',978000034,NULL),(44,5,1,'user57',978000041,NULL),(45,5,1,'user6',978000033,NULL),(46,5,1,'user11',978000044,NULL),(47,1,0,'user25',978000013,NULL),(48,1,1,'user2',978000099,NULL),(49,1,1,'user15',978000055,NULL),(50,4,1,'user52',978000100,NULL),(51,2,1,'user3',978000031,NULL),(52,5,0,'user23',978000093,NULL),(53,5,1,'user19',978000085,NULL),(54,1,1,'user41',978000099,'Not what I expected, kinda boring.'),(55,4,0,'user36',978000030,NULL),(56,2,1,'user47',978000085,NULL),(57,3,0,'user36',978000056,NULL),(58,2,1,'user13',978000010,NULL),(59,5,1,'user20',978000060,NULL),(60,4,1,'user3',978000051,NULL),(61,1,1,'user60',978000078,NULL),(62,4,1,'user53',978000020,NULL),(63,2,0,'user37',978000036,NULL),(64,1,1,'user15',978000080,NULL),(65,1,0,'user23',978000081,NULL),(66,1,0,'user29',978000014,NULL),(67,5,0,'user22',978000039,NULL),(68,3,1,'user8',978000036,NULL),(69,2,0,'user25',978000096,NULL),(70,1,0,'user26',978000023,NULL),(71,4,1,'user41',978000016,NULL),(72,5,1,'user50',978000057,NULL),(73,1,1,'user16',978000071,NULL),(74,2,1,'user49',978000038,NULL),(75,4,1,'user15',978000078,NULL),(76,2,1,'user10',978000010,NULL),(77,2,0,'user24',978000012,NULL),(78,2,0,'user40',978000033,NULL),(79,3,1,'user57',978000070,NULL),(80,1,1,'user16',978000096,NULL),(81,3,1,'user42',978000094,NULL),(82,3,1,'user47',978000025,NULL),(83,1,0,'user22',978000006,NULL),(84,4,0,'user33',978000088,NULL),(85,1,0,'user38',978000017,NULL),(86,1,0,'user25',978000059,NULL),(87,4,0,'user29',978000093,NULL),(88,4,1,'user14',978000098,NULL),(89,5,1,'user60',978000016,NULL),(90,5,1,'user42',978000018,NULL),(91,3,0,'user40',978000084,NULL),(92,4,1,'user47',978000050,NULL),(93,2,0,'user37',978000041,NULL),(94,3,1,'user6',978000011,NULL),(95,1,1,'user18',978000026,NULL),(96,5,0,'user34',978000084,NULL),(97,5,1,'user5',978000003,NULL),(98,4,0,'user33',978000063,NULL),(99,3,1,'user57',978000067,NULL),(100,5,1,'user57',978000016,NULL),(101,1,1,'user15',978000055,NULL),(102,1,1,'user6',978000031,NULL),(103,1,1,'user56',978000022,NULL),(104,4,0,'user31',978000013,NULL),(105,3,0,'user37',978000055,NULL),(106,1,0,'user39',978000003,NULL),(107,2,1,'user14',978000064,NULL),(108,1,1,'user6',978000051,'My ex recommended it...'),(109,4,1,'user53',978000051,NULL),(110,3,1,'user52',978000064,NULL),(111,1,1,'user20',978000002,NULL),(112,2,1,'user13',978000053,NULL),(113,4,0,'user34',978000030,NULL),(114,1,1,'user14',978000011,NULL),(115,4,1,'user50',978000020,NULL),(116,3,1,'user16',978000087,NULL),(117,2,0,'user34',978000081,NULL),(118,4,1,'user59',978000069,'I bawled my eyes out.'),(119,1,1,'user49',978000069,NULL),(120,3,0,'user23',978000018,NULL),(121,1,1,'user8',978000045,NULL),(122,2,0,'user25',978000027,NULL),(123,4,1,'user53',978000002,NULL),(124,2,0,'user24',978000020,NULL),(125,1,1,'user19',978000011,'Fell asleep after one page. Rubbish'),(126,2,1,'user52',978000006,NULL),(127,3,1,'user56',978000036,NULL),(128,3,0,'user34',978000011,NULL),(129,3,1,'user13',978000058,NULL),(130,1,1,'user53',978000019,'Only good for toilet break:)'),(131,2,1,'user7',978000052,NULL),(132,4,1,'user56',978000063,NULL),(133,5,1,'user10',978000038,'Sheeesh'),(134,4,0,'user37',978000052,NULL),(135,4,0,'user38',978000099,NULL),(136,3,1,'user51',978000036,NULL),(137,5,1,'user57',978000043,NULL),(138,2,0,'user32',978000038,NULL),(139,5,1,'user43',978000034,'Changed my perspective of life...'),(140,5,1,'user44',978000014,NULL),(141,1,1,'user49',978000093,NULL),(142,2,1,'user12',978000023,NULL),(143,1,1,'user50',978000016,'Didnt even finish it...'),(144,4,1,'user9',978000087,NULL),(145,2,1,'user49',978000050,NULL),(146,4,1,'user43',978000056,NULL),(147,5,1,'user5',978000076,NULL),(148,1,0,'user32',978000063,NULL),(149,3,1,'user7',978000079,NULL),(150,5,1,'user2',978000037,'Perfect');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER reviewtrig 
BEFORE INSERT ON Reviews
FOR EACH ROW
BEGIN
  IF (SELECT Library_card FROM approves_user WHERE new.username = username) = 0
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sorry, You do not have a library card.';
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school` (
  `School_ID` int(11) NOT NULL AUTO_INCREMENT,
  `S_Name` varchar(255) NOT NULL,
  `Adress` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Phone_number` int(11) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `P_full_name` varchar(100) NOT NULL,
  PRIMARY KEY (`School_ID`),
  UNIQUE KEY `S_Name` (`S_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` VALUES (1,'Athens International School','123 Main Street','Athens',1234567890,'info@ais.edu.gr','John Smith'),(2,'Thessaloniki American College','456 Elm Street','Thessaloniki',2147483647,'info@tac.edu.gr','Maria Johnson'),(3,'Patras British School','789 Oak Street','Patras',2147483647,'info@pbs.edu.gr','George Wilson'),(4,'Heraklion International School','321 Pine Street','Heraklion',1357924680,'info@his.edu.gr','Sophia Davis'),(5,'Rhodes International School','654 Maple Street','Rhodes',2147483647,'info@ris.edu.gr','Michael Brown'),(6,'Chania American Academy','987 Cedar Street','Chania',2147483647,'info@caa.edu.gr','Emily Anderson'),(7,'Volos International School','147 Birch Street','Volos',2147483647,'info@vis.edu.gr','Alexander Thompson'),(8,'Larissa British College','369 Walnut Street','Larissa',2147483647,'info@lbc.edu.gr','Olivia Harris'),(9,'Ioannina International Academy','258 Poplar Street','Ioannina',2147483647,'info@iia.edu.gr','Daniel Robinson'),(10,'Kavala American School','741 Spruce Street','Kavala',2147483647,'info@kas.edu.gr','Ava Martinez');
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_user`
--

DROP TABLE IF EXISTS `student_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_user` (
  `Student_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(20) NOT NULL,
  `Student_first_name` varchar(100) NOT NULL,
  `Student_last_name` varchar(100) NOT NULL,
  PRIMARY KEY (`Student_ID`),
  KEY `fk_student_user_username` (`Username`),
  CONSTRAINT `fk_student_user_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_user`
--

LOCK TABLES `student_user` WRITE;
/*!40000 ALTER TABLE `student_user` DISABLE KEYS */;
INSERT INTO `student_user` VALUES (1,'user2','Alexandros','Papadopoulos'),(2,'user3','Dimitris','Papadakis'),(3,'user4','Georgios','Georgiou'),(4,'user5','Nikolaos','Antoniou'),(5,'user6','Andreas','Papadimitriou'),(6,'user7','Maria','Katsarou'),(7,'user8','Eleni','Papadopoulou'),(8,'user9','Panagiotis','Panagiotou'),(9,'user10','Christina','Kostas'),(10,'user11','Konstantinos','Georgiadis'),(11,'user12','Athanasia','Papadopoulou'),(12,'user13','Sofia','Georgiou'),(13,'user14','Ioannis','Tsakalidis'),(14,'user15','Aikaterini','Christodoulou'),(15,'user16','Theodoros','Katsikas'),(16,'user17','Despoina','Papageorgiou'),(17,'user18','Petros','Karamanlis'),(18,'user19','Eirini','Panagiotopoulou'),(19,'user20','Stavros','Antonopoulos'),(20,'user41','Alexandra','Papandreou'),(21,'user42','Nikos','Papadellis'),(22,'user43','Elena','Karagiannis'),(23,'user44','George','Georgiadis'),(24,'user45','Dimitra','Papadopoulou'),(25,'user46','Vasilis','Papageorgiou'),(26,'user47','Georgia','Nikolaou'),(27,'user48','Christos','Papadopoulos'),(28,'user49','Eleni','Georgiou'),(29,'user50','Antonis','Papadopoulos'),(30,'user51','Irene','Katsarou'),(31,'user52','Michael','Papandreou'),(32,'user53','Katerina','Papadaki'),(33,'user54','Panos','Georgopoulos'),(34,'user55','Sophia','Papadopoulou'),(35,'user56','Konstantina','Antoniou'),(36,'user57','Thanos','Papadopoulos'),(37,'user58','Maria','Karamanlis'),(38,'user59','Dimitris','Papageorgiou'),(39,'user60','Evangelia','Antonopoulos');
/*!40000 ALTER TABLE `student_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_user`
--

DROP TABLE IF EXISTS `teacher_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_user` (
  `Teacher_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(20) NOT NULL,
  `Teacher_first_name` varchar(100) NOT NULL,
  `Teacher_last_name` varchar(100) NOT NULL,
  `Age` int(11) NOT NULL CHECK (`Age` > 18 and `Age` < 99),
  PRIMARY KEY (`Teacher_ID`),
  KEY `fk_teacher_user_username` (`Username`),
  CONSTRAINT `fk_teacher_user_username` FOREIGN KEY (`Username`) REFERENCES `users` (`Username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_user`
--

LOCK TABLES `teacher_user` WRITE;
/*!40000 ALTER TABLE `teacher_user` DISABLE KEYS */;
INSERT INTO `teacher_user` VALUES (1,'user21','Stefanos',' Papadopoulos',33),(2,'user22','Eleni',' Antoniou',40),(3,'user23','Andreas',' Papadakis',35),(4,'user24','Maria',' Georgiou',42),(5,'user25','Nikos',' Katsaros',38),(6,'user26','Georgia',' Papadopoulou',45),(7,'user27','Christos',' Papageorgiou',32),(8,'user28','Athina',' Papadeli',39),(9,'user29','Panagiotis',' Karamanlis',36),(10,'user30','Dimitra',' Papandreou',41),(11,'user31','Stefanos',' Souleles',34),(12,'user32','Eleni',' Anagnou',46),(13,'user33','Andreas',' Doufexis',37),(14,'user34','Maria',' Georganta',50),(15,'user35','Nikos',' Kanavaris',31),(16,'user36','Georgia',' Kostakou',48),(17,'user37','Christos',' Tsivikis',44),(18,'user38','Athina',' Tsika',30),(19,'user39','Panagiotis',' Vasilakis',49),(20,'user40','Dimitra',' Kornezou',43);
/*!40000 ALTER TABLE `teacher_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `usernameview`
--

DROP TABLE IF EXISTS `usernameview`;
/*!50001 DROP VIEW IF EXISTS `usernameview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `usernameview` AS SELECT
 1 AS `username`,
  1 AS `First_name`,
  1 AS `Last_name` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `Username` varchar(20) NOT NULL,
  `U_password` int(11) NOT NULL,
  `Role_user` varchar(20) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin',11111,'admin'),('user10',45678,'student'),('user11',34567,'student'),('user12',90123,'student'),('user13',78901,'student'),('user14',56789,'student'),('user15',23456,'student'),('user16',12345,'student'),('user17',90876,'student'),('user18',89012,'student'),('user19',34567,'student'),('user2',67345,'student'),('user20',45678,'student'),('user21',90123,'teacher'),('user22',56789,'teacher'),('user23',67890,'teacher'),('user24',78901,'teacher'),('user25',23456,'teacher'),('user26',12345,'teacher'),('user27',45678,'teacher'),('user28',34567,'teacher'),('user29',90123,'teacher'),('user3',90876,'student'),('user30',67890,'teacher'),('user31',89012,'operator'),('user32',78901,'operator'),('user33',12345,'operator'),('user34',23456,'operator'),('user35',34567,'operator'),('user36',56789,'operator'),('user37',67890,'operator'),('user38',89012,'operator'),('user39',45678,'operator'),('user4',23456,'student'),('user40',90123,'operator'),('user41',78901,'student'),('user42',23456,'student'),('user43',12345,'student'),('user44',34567,'student'),('user45',67890,'student'),('user46',89012,'student'),('user47',90123,'student'),('user48',56789,'student'),('user49',23456,'student'),('user5',78901,'student'),('user50',45678,'student'),('user51',34567,'student'),('user52',12345,'student'),('user53',56789,'student'),('user54',78901,'student'),('user55',89012,'student'),('user56',90123,'student'),('user57',45678,'student'),('user58',34567,'student'),('user59',23456,'student'),('user6',12345,'student'),('user60',12345,'student'),('user7',56789,'student'),('user8',67890,'student'),('user9',89012,'student');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `written_by`
--

DROP TABLE IF EXISTS `written_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `written_by` (
  `ISBN` int(11) NOT NULL,
  `Author_ID` int(11) NOT NULL,
  PRIMARY KEY (`ISBN`,`Author_ID`),
  KEY `fk_written_by_author_id` (`Author_ID`),
  CONSTRAINT `fk_written_by_author_id` FOREIGN KEY (`Author_ID`) REFERENCES `authors` (`Author_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_written_by_isbn` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `written_by`
--

LOCK TABLES `written_by` WRITE;
/*!40000 ALTER TABLE `written_by` DISABLE KEYS */;
INSERT INTO `written_by` VALUES (978000001,22),(978000001,33),(978000002,51),(978000003,44),(978000004,17),(978000005,33),(978000006,19),(978000007,27),(978000007,48),(978000008,3),(978000008,55),(978000009,9),(978000009,21),(978000010,11),(978000010,27),(978000011,60),(978000012,32),(978000012,35),(978000013,24),(978000013,36),(978000014,31),(978000015,17),(978000015,44),(978000016,15),(978000016,23),(978000017,8),(978000018,15),(978000019,46),(978000020,38),(978000020,56),(978000021,26),(978000022,48),(978000023,7),(978000023,58),(978000024,21),(978000024,45),(978000025,25),(978000025,58),(978000026,36),(978000026,52),(978000027,9),(978000027,21),(978000028,2),(978000028,23),(978000029,60),(978000030,42),(978000031,33),(978000032,2),(978000032,54),(978000033,58),(978000034,5),(978000034,57),(978000035,13),(978000035,40),(978000036,20),(978000036,44),(978000037,8),(978000038,34),(978000038,48),(978000039,11),(978000039,15),(978000040,14),(978000041,30),(978000041,44),(978000042,52),(978000043,10),(978000043,45),(978000044,55),(978000045,15),(978000046,23),(978000046,26),(978000047,30),(978000047,58),(978000048,5),(978000048,47),(978000049,35),(978000049,42),(978000050,37),(978000050,42),(978000051,24),(978000052,26),(978000053,55),(978000054,6),(978000054,7),(978000055,45),(978000055,48),(978000056,54),(978000057,4),(978000057,17),(978000058,27),(978000058,39),(978000059,13),(978000060,28),(978000061,43),(978000062,57),(978000063,21),(978000063,45),(978000064,36),(978000064,48),(978000065,3),(978000065,20),(978000066,37),(978000067,21),(978000067,33),(978000068,52),(978000069,4),(978000070,20),(978000071,15),(978000072,36),(978000073,3),(978000073,40),(978000074,30),(978000075,4),(978000075,43),(978000076,22),(978000077,51),(978000078,10),(978000078,37),(978000079,14),(978000079,24),(978000080,18),(978000080,57),(978000081,6),(978000082,9),(978000083,24),(978000083,43),(978000084,28),(978000085,45),(978000086,16),(978000087,2),(978000088,17),(978000089,4),(978000090,17),(978000091,48),(978000092,14),(978000092,20),(978000093,18),(978000093,47),(978000094,46),(978000095,30),(978000095,53),(978000096,36),(978000096,40),(978000097,39),(978000098,3),(978000098,49),(978000099,6),(978000099,60),(978000100,10);
/*!40000 ALTER TABLE `written_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `late_returns`
--

/*!50001 DROP VIEW IF EXISTS `late_returns`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `late_returns` AS select `v`.`First_name` AS `First_name`,`v`.`Last_name` AS `Last_name`,to_days(`b`.`last_update`) - to_days(`b`.`b_date`) AS `days_late` from (`usernameview` `v` join `borrows` `b` on(`b`.`Username` = `v`.`username`)) where `b`.`ret_date` is null and to_days(`b`.`last_update`) - to_days(`b`.`b_date`) > 14 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `num_b_per_auth`
--

/*!50001 DROP VIEW IF EXISTS `num_b_per_auth`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `num_b_per_auth` AS select `a`.`Author_ID` AS `author_ID`,`a`.`Ath_full_name` AS `Ath_full_name`,count(`w`.`ISBN`) AS `count_of_books` from (`authors` `a` join `written_by` `w` on(`w`.`Author_ID` = `a`.`Author_ID`)) group by `a`.`Author_ID` order by count(`w`.`ISBN`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `operatorcounts`
--

/*!50001 DROP VIEW IF EXISTS `operatorcounts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `operatorcounts` AS select `o`.`Operator_ID` AS `operator_ID`,`o`.`Operator_first_name` AS `Operator_first_name`,`o`.`Operator_last_name` AS `Operator_last_name`,count(`b`.`ISBN`) AS `count_of_books` from ((`operator` `o` join `book` `b` on(`o`.`Operator_ID` = `b`.`Operator_ID`)) join `borrows` `br` on(`br`.`ISBN` = `b`.`ISBN`)) where year(`br`.`b_date`) = 2023 group by `o`.`Operator_ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usernameview`
--

/*!50001 DROP VIEW IF EXISTS `usernameview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usernameview` AS select `u`.`Username` AS `username`,`st`.`Student_first_name` AS `First_name`,`st`.`Student_last_name` AS `Last_name` from (`users` `u` join `student_user` `st` on(`st`.`Username` = `u`.`Username`)) union select `u`.`Username` AS `username`,`t`.`Teacher_first_name` AS `First_name`,`t`.`Teacher_last_name` AS `Last_name` from (`users` `u` join `teacher_user` `t` on(`t`.`Username` = `u`.`Username`)) union select `u`.`Username` AS `username`,`o`.`Operator_first_name` AS `First_name`,`o`.`Operator_last_name` AS `last_name` from (`users` `u` join `operator` `o` on(`o`.`Username` = `u`.`Username`)) union select `u`.`Username` AS `username`,`a`.`Adm_first_name` AS `First_name`,`a`.`Adm_last_name` AS `Last_name` from (`users` `u` join `administrator` `a` on(`a`.`Username` = `u`.`Username`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-03 17:08:47
