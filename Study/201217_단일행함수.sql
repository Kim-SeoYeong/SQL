/*단일형 함수*/

--문자함수 - INITCAP(컬럼명)
select  email,
        initcap(email),
        department_id
from employees
where department_id = 100;

--문자함수 - Lower(컬럼명) / Upper(컬럼명)
select  first_name,
        lower(first_name),
        upper(first_name)
from employees
where department_id = 100;

--문자함수 - SUBSTR(컬럼명, 시작위치, 글자수)
select  first_name,
        substr(first_name, 2, 6),
        substr(first_name, -3, 3),
        substr(first_name, 3)
from employees
where department_id = 100;

--문자함수 - LPAD(컬럼명, 자리수, '채울문자') / RPAD(컬럼명, 자리수, '채울문자')
select  first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')
from employees;

--문자함수 - REPLACE(컬럼명, 문자1, 문자2)
select  first_name,
        replace(first_name, 'a', '**'),
        department_id
from employees
where department_id = 100;


-- 함수 조합
select  first_name,
        replace(first_name, 'a', '*'),
        substr(first_name, 2, 3),
        replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;


-- 숫자함수 - ROUND(숫자, 출력을 원하는 자리수)
select  round(123.454, 2) r2,
        round(123.656, 0) r0,
        round(123.456, -1) "r-1"
from dual;

select  salary,
        round(salary, -3) sR2
from employees;


-- 숫자함수 - TRUNC(숫자, 출력을 원하는 자릿수)
select  trunc(123.456, 2) as r2,
        trunc(123.456, 0) as r0,
        trunc(123.456, -1) as "r-1"
from dual;


-- 날짜함수 - SYSDATE
select sysdate
from dual;

select  sysdate,
        first_name
from employees;


-- 날짜함수 - MONTH_BETWEEN(d1, d2)
select  sysdate,
        hire_date,
        months_between(sysdate, hire_date) as "workMonth"
from employees
where department_id = 100;


select  sysdate,
        hire_date,
        months_between(sysdate, hire_date) as "workMonth",
        trunc(months_between(sysdate, hire_date), 0) "근무개월"
from employees
where department_id = 100;


--날짜함수 - LAST_DAY(d1)
select last_day('20/06/06')
from dual;


--변환함수
--TO_CHAR(숫자, '출력모양') 숫자형 -> 문자형으로 변환하기
select  first_name,
        salary,
        salary*12,
        to_char(salary*12, '$999,999,999.00'),
        to_char(salary*12, '999,999.00'),
        to_char(salary*12, '999,999'),
        to_char(salary*12, '099,999'),
        to_char(salary*12, '999999')
from employees
where department_id = 100;


--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select  sysdate,
        to_char(sysdate ,'YYYY') year,
        to_char(sysdate, 'YY') YY,
        to_char(sysdate, 'MM') month,
        to_char(sysdate, 'MONTH'),
        to_char(sysdate, 'DD') DD,
        to_char(sysdate, 'DAY') DAY,
        to_char(sysdate, 'HH') HH,
        to_char(sysdate, 'HH24') HH24,
        to_char(sysdate, 'MI') MI,
        to_char(sysdate, 'SS') SS
from dual;

--년월일 시분초
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD'),
        to_char(sysdate, 'YYYY"년"MM"월"DD"일"'),
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;

select  first_name,
        hire_date,
        to_char(hire_date, 'YYYY-MM-DD HH24:MI:SS')
from employees;


--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select  first_name,
        commission_pct,
        NVL(commission_pct, 0), --null이면 0 null이 아니면 기존값 유지
        NVL2(commission_pct, 100, 0)    --null이면 0으로 바뀌고 null이 아니면 100으로 바꿈
from employees;

















