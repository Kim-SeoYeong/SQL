/*
DCL/DDL/DML/Sequence 연습하기(과제1)
*/

-- 사용자 삭제
drop user webdb cascade; -- 기존에 webdb가 있었어서 일단 지웠음

-- 사용자 생성
create user webdb identified by webdb;

-- 접속권한 부여
grant resource, connect to webdb;

-- 사용자 비밀번호 변경
alter user webdb identified by webdb;


