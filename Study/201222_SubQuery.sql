-- < 어제 수업 복습내용> --
-- from 절 where 절 표현방법, (+) <- 오라클에서만 쓰는 방법
-- left/right/full outer join ~ on

-- inner join   --> 양쪽이 만족하는 경우(null이 있어서 join이 안되면 그냥 제외시키고 조회함) / null은 제외
-- inner join ~on 

select  first_name,
        em.department_id,
        department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id;

select *  
from employees em inner join departments de
on em.department_id = de.department_id;

-- outer join   --> 기준이 되는 쪽은 null이어도 포함시켜서 조회 / 비교되는 쪽은 null로 표시
-- Left outer join ~ on
-- right outer join ~ on
-- full outer join ~ on

/*
* Sub Query 서브 쿼리
*/

-- 'Den' 보다 급여가 많은 사람의 이름과 급여는?
-- --> 10000보다 급여가 많은 사람의 이름과 급여는?
select  first_name,
        employee_id,
        salary
from employees
where salary > 11000;

-- 'Den' 보다 급여가 많은 사람의 이름과 급여는?
-- 1. 'Den'의 급여
select  employee_id,
        first_name,
        salary
from employees
where first_name = 'Den';

-- 2. 'Den' 급여보다 높은 사람
select  first_name,
        employee_id,
        salary
from employees
where salary > 11000;

-- 위에 2가지를 하나로 합쳐서 1개의 질문으로 해결해줘야함.
select  employee_id,
        first_name,
        salary
from employees
where salary > (select salary
                from employees
                where first_name = 'Den');

-- 예제1)
-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
-- 1. 가장 적은 급여 액수 --> 2100
-- 2. 2100을 받는 직원의 이름, 급여, 사원번호는?

-- 1. 가장 적은 급여 액수 --> 2100
select min(salary)
from employees;

-- 2. 2100을 받는 직원의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from employees
where salary = 2100;

-- 3. 질문 조합
select  first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);

-- 예제2)
-- 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
-- 1. 평균 급여 --> 6461.8317....
-- 2. 급여보다 적게 받는 사람의 이름, 급여는?

-- 1. 평균 급여
select avg(salary)
from employees;

-- 2. 급여보다 적게 받는 사람의 이름, 급여는?
select  first_name,
        salary
from employees
where salary < 6461.8317;

-- 3. 위에 사항들 조합
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);


-- 예제3)
-- 부서번호가 110인 직원의 급여와 같은 모든 직원의
-- 사번, 이름, 급여를 출력하세요
-- 1. 부서번호가 110인 직원의 이름, 급여, ... 리스트
select  first_name,
        salary,
        department_id
from employees
where department_id = 110;

-- 2.  전체직원 중 12008, 8300 인 직원
select *
from employees
where salary = 12008
or salary = 8300;

select  first_name,
        salary,
        department_id
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);

-- 예제4)
-- 각 부서별로 최고급여를 받는 사원을 출력하세요

-- 1. 각 부서별로의 최고급여 조회 (누구인지는 조회하지못함)
select  department_id,
        max(salary)
from employees
group by department_id;

-- 2. 전체사원 테이블에서 부서번호와 급여 같은 사람을 찾는다
-- 부서별 최고 급여 리스트 기준으로
select  first_name,
        employee_id,
        department_id,
        salary
from employees
where department_id = 100;

select  first_name,
        department_id,
        salary
from employees
where (department_id, salary) in (select  department_id,
                                        max(salary)
                                  from employees
                                  group by department_id);
        
-- 예제5)
-- 부서번호가 110인 직원의 급여보다 큰 모든 직원의
-- 사번, 이름, 급여를 출력하세요. (or 연산 --> 8300보다 큰)

select *
from employees
where department_id = 110; -- 12000, 8300

select  employee_id,
        first_name,
        salary
from employees
where salary > 8300;

select  employee_id,
        first_name,
        salary
from employees
where salary >any (select salary
                  from employees
                  where department_id = 110);   -- 12008, 8300

select  employee_id,
        first_name,
        salary
from employees
where salary >all (select salary
                  from employees
                  where department_id = 110);   -- 12008 -- all은 겹치는 부분만 표현한다

-- Sub Query --> 테이블 자리 --> join으로 사용
-- 각 부서별로 최고급여를 받는 사원을 출력하세요
-- 1. 각 부서별로 최고 급여 테이블
select  department_id,
        max(salary)
from employees
group by department_id;

-- 2. 직원테이블 (1)테이블을 join 한다.
select  e.employee_id,
        e.first_name,
        e.salary eSalary,
        e.department_id ed_id,
        s.department_id sd_id,
        s.salary sSalary
from employees e, (select department_id,
                          max(salary) salary
                   from employees
                   group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;





