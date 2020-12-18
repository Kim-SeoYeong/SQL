/*
*그룹함수
*/

-- 오류발생 --> first_name은 하나의 raw에 담을 수 없어서 사용불가
/*이렇게 표현하지 못한다.
select  avg(salary),
        first_name
from employees;
*/

--그룹함수 avg()
select avg(salary)
from employees;

-- 그룹함수 count()
select count(*) -- 전체 조회
from employees;

select count(commission_pct)    -- commission_pct 컬럼의 null은 포함되지 않은 갯수
from employees;

select count(*)   --조건절 추가
from employees
where salary > 16000;

--그룹함수 sum()
select sum(salary), count(salary)  
from employees;


--그룹함수 - avg() null일때 0으로 변환
select  count(*), 
        sum(salary), 
        avg(salary)
from employees;

select  count(*),
        sum(salary),
        avg(nvl(salary, 0))
from employees;

--그룹함수 - max() / min()
select max(salary)
from employees;

select min(salary)
from employees;

-- 정렬이 필요한 경우 많은 연산을 수행해야 한다.
select  max(salary),
        min(salary),
        count(*)
from employees;


/*
* group by 절
*/

select  department_id,      
        avg(salary)     --오류, 잘못된 쿼리
from employees;


select  department_id,
        avg(salary)
from employees
group by department_id;

--GROUP BY 절 - 자주하는 오류
select  department_id,
        count(*),       --정상적인 쿼리
        sum(salary),
from employees
group by department_id;

/*
select  department_id,
        count(*),
        sum(salary),       --잘못된 쿼리, job_id는 그룹지어져있지 않아서 구할 수 없음.
        job_id
from employees
group by department_id;
*/

select  department_id,
        job_id,
        count(*),
        sum(salary),
        avg(salary)
from employees
group by department_id, job_id --department_id가 대분류, job_id가 소분류
order by department_id asc;

--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select  department_id,
        count(*),
        sum(salary)             --오류! group by 절에는 where문을 사용할 수가 없다.
from employees
where sum(salary) >= 20000;
group by department_id


--having 절
select  department_id,
        count(*),
        sum(salary)
from employees              -- having 절에는 그룹함수와 group by에 참여한 컬럼만 사용 가능.
group by department_id
having sum(salary) >= 20000
and department_id = 100;


/****
* case ~ end
****/
select  employee_id,
        salary,
        job_id,
        case when job_id = 'AC_ACCOUNT' then salary * 0.1
             when job_id = 'SA_REP' then salary * 0.2
             when job_id = 'ST_CLERK' then salary * 0.3
             else salary * 0
        end bonus   --별명지어준는 것
from employees;


select  employee_id,
        salary,
        job_id,
        decode( job_id, 'AC_ACCOUNT', salary * 0.1,
                        'SA_REP', salary * 0.2,
                        'ST_CLERK', salary * 0.3,
                        salary * 0 
              ) bonus
from employees;


--직원의 이름, 부서, 팀을 출력하세요.
--팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’ 
--60~100이면 ‘B-TEAM’  110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select  first_name,
        department_id,
        case when department_id between 10 and 50 then 'A-TEAM'
             when department_id between 60 and 100 then 'B-TEAM'
             when department_id between 110 and 150 then 'C-TEAM'
             else '팀없음'
        end as "팀"
from employees;


select  first_name,
        department_id,
        decode( department_id, 10 , 'A-TEAM', 20 , 'A-TEAM', 30 , 'A-TEAM', 40 , 'A-TEAM', 50 , 'A-TEAM',
                               60 , 'B-TEAM', 70 , 'B-TEAM', 80 , 'B-TEAM', 90 , 'B-TEAM', 100 , 'B-TEAM',
                               110, 'C-TEAM',  120, 'C-TEAM', 130, 'C-TEAM', 140, 'C-TEAM', 150, 'C-TEAM',
                               '팀없음'
              ) as "팀"
from employees;
