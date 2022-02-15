drop database library;
create database library;
use library;
set sql_safe_updates = 0;

create table if not exists student (
	id int(10) not null PRIMARY KEY,
	first_name varchar(1000) not null,
	last_name varchar(1000) not null,
    house varchar(1000) not null,
	phone int(10) not null,
	email varchar(100) not null,
	batch varchar(100)
);

insert into student values (110110101,'Chhavi','Garg','Slytherin',669292600,'cgarg@hogwarts.edu','Winter2021');
insert into student values (110110102,'Megha','Garg','Hufflepuff', 888260754,'mgarg@hogwarts.edu','Spring2021');
insert into student values (110110103,'Achal','Joshi','Gryffindor',669292900,'ajoshi@hogwarts.edu','Winter2021');
insert into student values (110110104,'Nivedita','Thapa','Slytherin',408675912,'nthapa@hogwarts.edu','Fall2020');
insert into student values (110110105,'Yashi','Thapa','Ravenclaw',665732808,'ythapa@hogwarts.edu','Winter2021');
insert into student values (110110106,'Khushboo','Zope','Hufflepuff',669699690,'kzope@hogwarts.edu','Winter2021');
insert into student values (110110107,'Sanjoli','Sirohi','Slytherin',669292990,'ssirohi@hogwarts.edu','Fall2020');
insert into student values (110110108,'Apurva','Rane','Hufflepuff',512090090,'arane@hogwarts.edu','Fall2022');
insert into student values (110110109,'Niyati','Desai','Gryffindor',669699690,'ndesai@hogwarts.edu','Fall2022');
insert into student values (110110110,'Vidisha','Gummadi','Hufflepuff',212171214,'vgummadi@hogwarts.edu','Fall2021');
insert into student values (110110111,'Jay','Kanakiya','Gryffindor',508422444,'jkanakiya@hogwarts.edu','Spring2021');
insert into student values (110110112,'Srihari','Shekhar','Gryffindor',408292900,'sshekhar@hogwarts.edu','Fall2021');
insert into student values (110110113,'Draco','Malfoy','Slytherin',669292391,'dmalfoy@hogwarts.edu','Fall2020');
insert into student values (110110114,'Minerva','McGonagall','Gryffindor',512090092,'mmcgonagall@hogwarts.edu','Fall2022');
insert into student values (110110115,'Cormac','McLaggen','Gryffindor',669699693,'cmclaggen@hogwarts.edu','Fall2022');
insert into student values (110110116,'Graham','Montague','Ravenclaw',212171215,'gmontague@hogwarts.edu','Fall2021');
insert into student values (110110117,'Lee','Jordan','Gryffindor',669006615,'ljordan@hogwarts.edu','Fall2021');
insert into student values (110110118,'Hannah','Abbott','Gryffindor',669292396,'habbott@hogwarts.edu','Fall2020');
insert into student values (110110119,'Seamus','Finnigan','Gryffindor',512090097,'sfinnigan@hogwarts.edu','Fall2022');
insert into student values (110110120,'Gregory','Goyle','Slytherin',669699698,'ggoyle@hogwarts.edu','Fall2022');
insert into student values (110110121,'Angelina','Johnson','Hufflepuff',212171219,'ajohnson@hogwarts.edu','Fall2021');
insert into student values (110110123,'Neville','Longbottom','Gryffindor',508422442,'nlongbottom@hogwarts.edu','Spring2021');
insert into student values (110110124,'Tom','Riddle','Slytherin',669292330,'triddle@hogwarts.edu','Fall2020');
insert into student values (110110125,'Severus','Snape','Slytherin',512094090,'ssnape@hogwarts.edu','Fall2022');
insert into student values (110110126,'Bellatrix','Lestrange','Slytherin',665699690,'blestrange@hogwarts.edu','Fall2022');
insert into student values (110110127,'Remus','Lupin','Ravenclaw',212171614,'rlupin@hogwarts.edu','Fall2021');
insert into student values (110110128,'Lily','Potter','Gryffindor',669002611,'lpotter@hogwarts.edu','Fall2021');
insert into student values (110110129,'Sirius','Black','Ravenclaw',661212390,'sblack@hogwarts.edu','Fall2020');
insert into student values (110110130,'Molly','Weasley','Gryffindor',512690090,'mweasley@hogwarts.edu','Fall2022');
insert into student values (110110131,'Lucius','Malfoy','Slytherin',662499690,'lmalfoy@hogwarts.edu','Fall2022');
insert into student values (110110132,'James','Potter','Gryffindor',212271214,'jpotter@hogwarts.edu','Fall2021');
insert into student values (110110133,'Cho','Chang','Ravenclaw',669004611,'cchang@hogwarts.edu','Fall2021');
insert into student values (110110134,'Rubeus','Hagrid','Gryffindor',503422444,'rhagrid@hogwarts.edu','Spring2021');

CREATE TABLE category(
	id int not null,
    category_name varchar(1000) not null,
    primary key (id)
);

insert into category (id, category_name) values (1, 'Fiction');
insert into category (id, category_name) values (2, 'Sci-Fi');
insert into category (id, category_name) values (3, 'Non-Fiction');
insert into category (id, category_name) values (4, 'Spiritual');

create table if not exists book (
	id int(10) not null,
	title varchar(1000) not null,
	author varchar(1000) not null,
	location_id int(10) not null,
	inventory_id int(10) not null,
	category_id int(10) not null,
	available boolean not null,
	last_update timestamp not null,
	primary key (id),
    constraint book_ibfk_1 foreign key (category_id) 
    references category (id) on delete cascade on update cascade
);

CREATE TABLE inventory(
	id int NOT NULL,
	book_id int NOT NULL,
	number_of_books int,
	book_add_last_update timestamp not null default current_timestamp on update current_timestamp,
	primary key (id),
	key book (id),
	constraint inventory_ibfk_1 foreign key (book_id) references book (id) on delete cascade on update cascade
);

-- Insert the books in inventory table when a book is added to the books table
delimiter #
create trigger upd_book
	after insert on book
	for each row
	begin
	insert into inventory (id, book_id, number_of_books) 
	values (new.inventory_id, new.id, number_of_books+1);
	end #
delimiter ;

INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (1, 'A History of Magic', 'Bathilda Bagshot', 121, 1001, 1, True, '2020-03-02 10:30:22');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (2, 'The Near East: 10,000 Years of History', 'Frederic Brown', 122, 1002, 3, True, '2019-05-03 10:45:21');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (3, 'The Cocoon: A Rest-Cure Comedy', 'Jack London', 123, 1003, 1, True, '2019-09-21 11:21:41');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (4, 'Magical Theory', 'Adalbert Waffling', 124, 1004, 1, True, '2021-01-15 13:51:01');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (5, 'Foundation Series', 'Isaac Asimo', 125, 1005, 2, True, '2021-09-20 14:20:01');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (6, 'Fantastic Beasts and Where to Find Them', 'Newt Scamander', 126, 1006, 1, True, '2021-05-27 17:31:01');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (7, 'The Dark Forces: A Guide to Self-Protection', 'Quentin Trimble', 127, 1007, 3, True, '2021-09-09 16:02:13');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (8, 'Magical Drafts and Potions', 'Arsenius Jigger', 128, 1008, 1, True, '2019-04-25 15:45:15');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (9, 'A Thousand Miles Up the Nile', 'Isaac Asimov', 129, 1009, 2, True, '2020-04-02 16:05:14');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (10, 'Home Life and Social Habits of British Muggles', 'Wilhelm Wigworthy', 130, 1010, 4, True, '2020-08-17 13:05:23');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (11, 'Unfogging the Future ', 'Cassandra Vablatsky', 131, 1011, 2, True, '2021-09-10 12:01:11');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (12, 'The Desert and the Sown', 'Dorothy Canfield', 132, 1012, 1, True, '2019-05-05 09:55:54');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (13, 'A Daughter of the Snows', 'Givoanni Boccaccio', 133, 1013, 3, True, '2020-10-10 11:25:09');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (14, 'Show Boat', 'Virginia Woolf', 134, 1014, 2, True, '2018-08-27 13:00:21');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (15, 'Anna Karenina', 'Leo Tolstoy', 135, 1015, 1, True, '2019-07-21 14:00:15');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (16, 'Madame Bovary', 'Gustav Flaubert', 136, 1016, 2, True, '2018-07-23 13:10:21');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (17, 'War and Peace', 'Leo Tolstoy', 137, 1017, 2, True, '2018-11-24 15:00:52');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (18, 'Lolita', 'Vladimir Nabokov', 138, 1018, 1, True, '2018-12-27 12:00:25');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (19, 'The Adventures of Huckleberry', 'Mark Twain', 139, 1019, 3, True, '2019-02-20 13:00:20');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (20, 'Hamlet', 'William Shakespeare', 140, 1020, 3, True, '2020-11-22 15:03:23');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (21, 'The Great Gatsby', 'F. Scott Fizgerald', 141, 1021, 4, True, '2020-04-12 11:00:31');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (22, 'In Search of Lost Time', 'Marcel Proust', 142, 1022, 4, True, '2021-05-24 13:21:11');
 INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (23, 'The Stories of Anton Chekhov', 'Anton Checkhov', 143, 1023, 1, True, '2021-02-22 16:03:23');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (24, 'Middlemarch', 'George Eliot', 144, 1024, 2, True, '2018-01-22 10:21:02');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (25, 'The History of Tom Jones, a Foundling', 'Henry Fielding', 145, 1025, 2, True, '2019-04-27 13:00:21');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (26, 'Pride and Prejudice', 'Jane Austen', 146, 1026, 3, True, '2021-07-27 11:40:24');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (27, 'David Copperfield', 'Charles Dickens', 147, 1027, 1, True, '2021-05-22 12:23:22');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (28, 'Zero to One', 'Peter Thiel', 148, 1028, 2, True, '2017-01-22 10:23:02');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (29, 'Limitless', 'RamDyal', 149, 1029, 2, True, '2017-04-27 13:00:21');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (30, 'What I know for sure', 'Raju Rastogi', 150, 1030, 3, True, '2020-07-27 11:40:24');
INSERT INTO book (id, title, author, location_id, inventory_id, category_id, available, last_update) 
VALUES (31, 'Success', 'Funsuk Wangdu', 151, 1031, 1, True, '2021-03-03 12:23:22');

UPDATE inventory SET number_of_books = 5 where book_id = 1;
UPDATE inventory SET number_of_books = 12 where book_id = 3;
UPDATE inventory SET number_of_books = 23 where book_id = 4;
UPDATE inventory SET number_of_books = 42 where book_id = 5;
UPDATE inventory SET number_of_books = 13 where book_id = 6;
UPDATE inventory SET number_of_books = 12 where book_id = 7;
UPDATE inventory SET number_of_books = 4 where book_id = 8;
UPDATE inventory SET number_of_books = 23 where book_id = 10;
UPDATE inventory SET number_of_books = 31 where book_id = 11;
UPDATE inventory SET number_of_books = 33 where book_id = 12;
UPDATE inventory SET number_of_books = 25 where book_id = 13;
UPDATE inventory SET number_of_books = 6 where book_id = 14;
UPDATE inventory SET number_of_books = 13 where book_id = 15;
UPDATE inventory SET number_of_books = 13 where book_id = 16;
UPDATE inventory SET number_of_books = 15 where book_id = 17;
UPDATE inventory SET number_of_books = 12 where book_id = 18;
UPDATE inventory SET number_of_books = 23 where book_id = 19;
UPDATE inventory SET number_of_books = 41 where book_id = 20;
UPDATE inventory SET number_of_books = 30 where book_id = 21;
UPDATE inventory SET number_of_books = 41 where book_id = 22;
UPDATE inventory SET number_of_books = 23 where book_id = 23;
UPDATE inventory SET number_of_books = 3 where book_id = 24;
UPDATE inventory SET number_of_books = 5 where book_id = 30;
UPDATE inventory SET number_of_books = 3 where book_id = 29;
UPDATE inventory SET number_of_books = 6 where book_id = 31;

CREATE TABLE staff(
	id int PRIMARY KEY,
    first_name varchar(1000) not null,
    last_name varchar(1000) not null
);

INSERT INTO staff(id, first_name, last_name) VALUES (12121, 'Obito', 'Uchiha');
INSERT INTO staff(id, first_name, last_name) VALUES (12122, 'Naruto', 'Uzumaki');
INSERT INTO staff(id, first_name, last_name) VALUES (12123, 'Sherlock', 'Holmes');
INSERT INTO staff(id, first_name, last_name) VALUES (12124, 'Shikamaru', 'Nara');
INSERT INTO staff(id, first_name, last_name) VALUES (12125, 'Bruce', 'Wayne');
INSERT INTO staff(id, first_name, last_name) VALUES (12126, 'Clark', 'Kent');
INSERT INTO staff(id, first_name, last_name) VALUES (12127, 'Bruce', 'Banner');
INSERT INTO staff(id, first_name, last_name) VALUES (12128, 'Peter', 'Parker');
INSERT INTO staff(id, first_name, last_name) VALUES (12129, 'Natasha', 'Romanoff');
INSERT INTO staff(id, first_name, last_name) VALUES (12130, 'Madara', 'Uchiha');

CREATE TABLE issue(
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    issue_date datetime NOT NULL,
    inventory_id int DEFAULT NULL,
    student_id int,
    staff_id int,
    last_update datetime,
    due_time datetime,
    constraint issue_ibfk_1 foreign key (student_id) references student (id) on delete cascade on update cascade,
    constraint issue_ibfk_2 foreign key (staff_id) references staff (id) on delete cascade on update cascade,
    constraint issue_ibfk_3 foreign key (inventory_id) references inventory (id) on delete cascade on update cascade
);

-- Update the number of books in inventory table when a book is issued to a student.
delimiter #
create trigger upd_book_count after insert on issue
	for each row	
	begin
	update inventory set inventory.number_of_books = inventory.number_of_books - 1
	where id = new.inventory_id and number_of_books > 0;
	end#
delimiter ;

-- Trigger to update the availability status in book table when it is updated in the inventory table
delimiter #
create trigger upd_book_available before update on inventory
	for each row	
	begin
	if new.number_of_books = 0 then
		update book set book.available = False where inventory_id = old.id;
	end if;
	if new.number_of_books > 0 then
	update book set book.available = True where inventory_id = old.id;
	end if;
end#
delimiter ;

INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (111, '2021-05-03', 1006, 110110124, 12121, '2021-05-03', '2021-05-10');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (112, '2021-06-23', 1004, 110110124, 12122, '2021-06-23', '2021-06-30');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (113, '2021-08-11', 1006, 110110103, 12123, '2021-08-11', '2021-08-18');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (114, '2021-07-02', 1004, 110110132, 12122, '2021-07-02', '2021-07-09');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (115, '2021-02-07', 1007, 110110103, 12124, '2021-02-07', '2021-02-14');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (116, '2021-02-26', 1006, 110110112, 12124, '2021-03-26', '2021-04-03');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (117, '2021-01-21', 1009, 110110132, 12127, '2021-01-21', '2021-01-28');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (118, '2021-08-13', 1007, 110110124, 12128, '2021-08-13', '2021-08-20');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (119, '2021-04-15', 1011, 110110124, 12128, '2021-04-15', '2021-04-22');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (120, '2021-11-12', 1006, 110110104, 12121, '2021-11-12', '2021-11-19');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (121, '2021-10-04', 1007, 110110112, 12122, '2021-10-04', '2021-10-11');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (122, '2021-03-01', 1014, 110110112, 12121, '2021-03-01', '2021-03-08');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (123, '2020-05-03', 1008, 110110112, 12121, '2020-05-03', '2021-05-10');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (124, '2021-04-23', 1006, 110110101, 12122, '2021-04-23', '2021-04-30');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (125, '2021-01-11', 1006, 110110127, 12123, '2021-01-11', '2021-01-18');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (126, '2021-04-02', 1011, 110110112, 12122, '2021-04-02', '2021-04-09');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (127, '2020-02-07', 1007, 110110104, 12124, '2020-02-07', '2021-02-14');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (128, '2021-05-26', 1008, 110110104, 12124, '2021-05-26', '2021-05-03');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (129, '2021-03-23', 1009, 110110112, 12127, '2021-03-23', '2021-03-30');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (130, '2021-02-14', 1010, 110110104, 12128, '2021-02-14', '2021-02-21');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (131, '2021-04-13', 1011, 110110101, 12128, '2021-04-13', '2021-04-20');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (132, '2021-12-12', 1012, 110110112, 12121, '2021-12-12', '2021-12-19');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (133, '2021-11-06', 1006, 110110126, 12122, '2021-11-06', '2021-11-13');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (134, '2021-03-02', 1008, 110110101, 12121, '2021-03-02', '2021-03-09');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (135, '2021-11-13', 1008, 110110127, 12121, '2021-11-12', '2021-11-19');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (136, '2021-10-02', 1029, 110110129, 12122, '2021-10-04', '2021-10-11');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (137, '2021-02-05', 1031, 110110112, 12121, '2021-03-01', '2021-03-08');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (138, '2020-01-03', 1007, 110110127, 12121, '2020-05-03', '2021-05-10');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (139, '2021-05-21', 1008, 110110106, 12122, '2021-04-23', '2021-04-30');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (140, '2021-03-09', 1031, 110110124, 12123, '2021-01-11', '2021-01-18');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (141, '2021-02-03', 1006, 110110128, 12122, '2021-04-02', '2021-04-09');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (142, '2020-09-01', 1030, 110110103, 12124, '2020-02-07', '2021-02-14');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (143, '2021-11-30', 1029, 110110101, 12124, '2021-05-26', '2021-05-03');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (144, '2021-02-22', 1003, 110110106, 12127, '2021-03-23', '2021-03-30');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (145, '2021-04-08', 1030, 110110126, 12128, '2021-02-14', '2021-02-21');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (146, '2021-05-13', 1002, 110110128, 12128, '2021-04-13', '2021-04-20');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (147, '2020-12-13', 1030, 110110129, 12121, '2021-12-12', '2021-12-19');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (148, '2021-11-13', 1029, 110110112, 12122, '2021-11-06', '2021-11-13');
INSERT INTO issue (id, issue_date, inventory_id, student_id, staff_id, last_update, due_time) VALUES (149, '2021-07-02', 1006, 110110129, 12121, '2021-03-02', '2021-03-09');

-- Stored Procedure to display all information of a student.
delimiter $$
create procedure display_all_records(argument int)
   begin
      select s.id, s.first_name, s.last_name, s.phone, s.email, s.batch, i.issue_date, i.due_time, b.title, b.author, c.category_name from student s
      INNER JOIN issue i ON i.student_id = s.id
      INNER JOIN inventory inv ON inv.id = i.inventory_id
      INNER JOIN book b on inv.book_id = b.id
      INNER JOIN category c on c.id = b.category_id
      where s.id = argument;
   end $$
delimiter ;

call display_all_records('110110124');

-- 
select b.title, count(i.student_id) from book b
      INNER JOIN inventory inv ON inv.book_id = b.id
      INNER JOIN issue i ON inv.id = i.inventory_id
      GROUP BY i.inventory_id
      ORDER BY count(i.student_id) DESC;

-- Question: How many students have not issued any books. List their First name and Last name.
select student.first_name, student.last_name from student
left join issue on student.id = issue.student_id
where issue.student_id is null;

-- To calculate number of books in each category
SELECT category.category_name, count(category.id) FROM book
INNER JOIN category ON book.category_id=category.id
GROUP BY category.category_name;

-- How many books have been issued by students, list their first name and last name as well
select issue.student_id, student.first_name, student.last_name, count(issue.id) from issue 
left join student
on student.id = issue.student_id
group by issue.student_id
order by count(issue.id) DESC;

-- List all students name, surname, the name of the issued book, the issued date, the book's category and the name of the author
Select student.first_name, student.last_name, book.title, book.author, category.category_name, issue.issue_date
from student 
join issue on student.id = issue.student_id
join inventory on issue.inventory_id = inventory.id 
join book on book.id = inventory.book_id
join category on book.category_id = category.id
order by concat(student.first_name, student.last_name);