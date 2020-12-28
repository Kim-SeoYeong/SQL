-- 혹시 모르니 미리 drop을 실행해준 후 작업함
drop table book;
drop table author;
drop sequence seq_book_id;
drop sequence seq_author_id;

-- author 테이블 생성
create table author(
    author_id number(10),       --primary key 기본키
    author_name varchar2(100) not null,
    author_desc varchar2(500), 
    primary key (author_id)
);

-- author 시퀀스 생성
create sequence seq_author_id
increment by 1
start with 1;

-- book 테이블 생성
create table book(
    book_id number(10),         --primary key 기본키
    title varchar2(100),
    pubs varchar(100),
    pub_date date,
    author_id number(10),       --foreign key 외래키
    primary key(book_id),
    constraint book_fk foreign key (author_id)
    references author(author_id)
);

-- book 시퀀스 생성
create sequence seq_book_id
increment by 1
start with 1;

-- 시퀀스 조회(이부분은 임의로 추가해봄)
select * from user_sequences;

-- author 데이터 insert
insert into author
values (seq_author_id.nextval, '이문열', '경북 영양');

insert into author
values (seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values (seq_author_id.nextval, '김영하', '알쓸신잡');

-- author 테이블 조회 (이부분은 임의로 넣어봄)
select *
from author;

-- book 데이터 insert
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);

-- book 테이블 조회 (이부분은 임의로 넣어봄)
select *
from book;

-- 최종 commit을 해주자
commit;

-- 예제(강풀 정보 변경)
-- 1. 강풀의 author_desc 정보를 '서울특별시'로 변경해 보세요
update author
set author_desc = '서울특별시'
where author_id = 5
and author_name = '강풀';

-- 2. author 테이블에서 기안84 데이터를 삭제해보세요.
-- 바로 delete하려고하면 book테이블에서 author 테이블을 참조하고 있기때문에 에러가남.
-- book에 기안84와 관련된 데이터를 삭제 후 author 테이블에서 삭제를 해야함.

delete book
where author_id = 4;

delete author
where author_id = 4
and author_name = '기안84';

-- 3. 각 테이블을 다시 select 해보자
select * from author;

select * from book;

-- 4. 두 테이블 합침
select  book.book_id,
        book.title,
        book.pubs,
        book.pub_date,
        book.author_id,
        author.author_name,
        author.author_desc
from author, book
where author.author_id = book.author_id;


















