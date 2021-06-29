--DDL 이외의 쿼리 작성 금지 부탁드립니다--
--drop table DDL--
drop table recipe_item;

drop sequence stored_item_seq;
drop table stored_item;

drop sequence storage_seq;
drop table storage;

drop table item;

drop table category;

drop table saved_recipe;

drop table recipe_content;

drop table review;

drop sequence recipe_seq;
drop table recipe;

drop table authorities;

drop table member;

--create table DDL--
--1
create table member(
	member_id varchar2(100) primary key,
	password varchar2(100) not null,
	email varchar2(100) not null unique,
	name varchar2(100) not null,
	nick varchar2(100) not null
)

--2
create table authorities(
	member_id varchar2(100) not null,
	authority varchar2(30) not null,
	constraint fk_authorities foreign key(member_id) references member(member_id),
	constraint pk_member_authorities primary key(member_id,authority)
)

--3
create sequence recipe_seq
create table recipe(
	recipe_no NUMBER primary key,
	member_id varchar2(100) not null,
	recipe_name varchar2(100) not null,
	write_date DATE not null,
	modify_date DATE,
	category varchar2(100) not null,
	hits NUMBER not null,
	constraint fk_recipe foreign key(member_id) references member(member_id)
)

--4
create table review(
	member_id varchar2(100) not null,
	recipe_no NUMBER not null,
	review_comment blob,
	grade NUMBER not null,
	review_date DATE not null,
	constraint fk_review_member foreign key(member_id) references member(member_id),
	constraint fk_review_recipe foreign key(recipe_no) references recipe(recipe_no),
	constraint pk_member_review primary key(member_id, recipe_no)
)

--5
create table recipe_content(
	recipe_no NUMBER not null,	
	step_no NUMBER not null,
	step_title varchar2(100) not null,
	content blob not null,
	image_path blob,
	constraint fk_recipe_content foreign key(recipe_no) references recipe(recipe_no),
	constraint pk_recipe_step primary key(recipe_no,step_no)
)

--6
create table saved_recipe(
	member_id varchar2(100) not null,
	recipe_no number not null,
	saved_date DATE not null,
	constraint fk_saved_member foreign key(member_id) references member(member_id),
	constraint fk_saved_recipe foreign key(recipe_no) references recipe(recipe_no),
	constraint pk_member_recipe primary key(member_id,recipe_no)
)

--7
create table category(
   category_name varchar2(100) primary key,
   storage_time varchar2(100)  not null
);

--8
create table item(
   item_name varchar2(100) primary key,
   category_name varchar2(100) not null,
   constraint fk_item foreign key(category_name) references category(category_name)
);

--9
create table storage(
   storage_no number primary key,
   member_id varchar2(100) not null,
   type varchar2(100) not null,
   location_no number not null,
   constraint fk_storage foreign key(member_id) references member(member_id)
);
create sequence storage_seq;

--10
create table stored_item(
   stored_item_no number primary key,
   storage_no number not null,
   item_name varchar2(100) not null,
   expiry_date date, 
   stored_date date,
   qty varchar2(30),
   constraint fk_stored_storage foreign key (storage_no) references storage(storage_no),
   constraint fk_stored_item foreign key (item_name) references item(item_name)
);
create sequence stored_item_seq;


--11
create table recipe_item(
	item_name varchar2(100) not null,
	recipe_no number not null,
	qty varchar2(30),
	constraint fk_recipe_item_item foreign key(item_name) references item(item_name),
	constraint fk_recipe_item_recipe foreign key(recipe_no) references recipe(recipe_no),
	constraint pk_item_recipe primary key(item_name,recipe_no)
)
-------------------------------------------------------------------------------




