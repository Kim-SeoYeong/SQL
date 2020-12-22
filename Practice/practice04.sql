/* Practice04 */
/* SubQuery 과제 */


-- 문제1.
-- 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
-- (56건)
-- 1. 평균급여 조회
select avg(salary)
from employees;
-- 2. 6461.83보다 적은 급여를 받는 직원 조회
select  employee_id,
        first_name,
        salary
from employees 
where salary < 6461.83;     --56명

-- 3. 위를 조합해서 최종 인원 조회
select  count(salary)
from employees 
where salary < (select avg(salary)
                from employees);




-- 문제2. 
-- 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
-- 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
-- (51건)
-- 1. 평균급여 이상 월급을 받는 사원 조회(평균급여 6461.83...)
select  employee_id,
        first_name
from employees
where salary >= (select avg(salary)
                 from employees);
-- 2. 최대급여 이하의 월급을 받는 사원 조회 (최대급여 24000)
select  employee_id,
        first_name
from employees
where salary <= (select max(salary)
                 from employees);
-- 3. 평균급여 이상, 최대급여 이하의 월급을 받는 사원 조회
select  employee_id,
        first_name
from employees
where salary >= (select avg(salary)
                 from employees)
and salary <= (select max(salary)
                 from employees);
-- 4. 최종 조합해서 조회한 내용
-- 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
-- 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
-- (6461.83 <= salary <= 240000)
select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        avg(salary) "평균급여",
        max(salary) "최대급여"
from employees
group by employee_id, first_name, salary
having salary >= (select avg(salary)
                 from employees)
and salary <= (select max(salary)
                 from employees)
order by salary asc;




-- 문제3.
-- 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
-- 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
-- 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
-- (1건)

-- 1. 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments) 조회 (location_id가 1700)
select  emp.first_name ,
        emp.last_name ,
        emp.department_id,
        de.department_name,
        de.location_id
from employees emp, departments de
where emp.department_id = de.department_id
and emp.first_name = 'Steven'
and emp.last_name = 'King';
-- 2. location_id가 1700인 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
   -- 도시명(city), 주(state_province), 나라아이디(country_id)을 조회
select  location_id "도시아이디",
        street_address "거리명",
        postal_code "우편번호",
        city "도시명",
        state_province "주",
        country_id "나라아이디"
from locations 
where location_id = 1700;
-- 3. 최종 위의 내용을 조합해서 조회
-- 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
-- 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
-- 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
select  location_id "도시아이디",
        street_address "거리명",
        postal_code "우편번호",
        city "도시명",
        state_province "주",
        country_id "나라아이디"
from locations 
where location_id = (select location_id
                     from employees emp, departments de
                     where emp.department_id = de.department_id
                     and emp.first_name = 'Steven'
                     and emp.last_name = 'King');
-- 또는 from 절에 넣어서 조회하는 방법
select  loc.location_id "도시아이디",
        loc.street_address "거리명",
        loc.postal_code "우편번호",
        loc.city "도시명",
        loc.state_province "주",
        loc.country_id "나라아이디"
from locations loc, (select emp.first_name ,
                            emp.last_name ,
                            emp.department_id,
                            de.department_name,
                            de.location_id
                    from employees emp, departments de
                    where emp.department_id = de.department_id
                    and emp.first_name = 'Steven'
                    and emp.last_name = 'King') emde
where loc.location_id = emde.location_id;




-- 문제5. 
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
-- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
-- 조건절비교, 테이블조인 2가지 방법으로 작성하세요
-- (11건)
-- 1. 각 부서별로 최고의 급여를 받는 사원 조회
select  department_id,
        max(salary)
from employees
group by department_id;
-- 2. 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회
   -- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다
select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        department_id "부서번호"
from employees
order by salary desc;

--3. 최종조회 (방법1 - 조건절비교)
select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        department_id "부서번호"
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;
--3. 최종조회 (방법2 - 테이블조인)
select  emp.employee_id "직원번호",
        emp.first_name "이름",
        emp.salary "급여",
        sal.department_id "부서번호"
from employees emp, (select  department_id,
                             max(salary) salary
                     from employees
                     group by department_id) sal
where emp.department_id = sal.department_id
and emp.salary = sal.salary
order by emp.salary desc;



-- 문제6.
-- 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
-- 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
-- (19건)
-- 1. 업무별로 연봉(salary)의 총합 조회
select  job_id "업무아이디",
        sum(salary) "연봉 총합"
from employees
group by job_id;
-- 2. 업무명(job_title) 조회
select  job_title "업무명",
        job_id "업무아이디"
from jobs;
-- 3. 최종 조합
-- 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
-- 연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
select  job.job_title "업무명",
        job.job_id "업무아이디",
        emp.salary "연봉총합"
from jobs job, (select  job_id,
                        sum(salary) salary
                from employees
                group by job_id) emp
where job.job_id = emp.job_id
order by emp.salary desc;




-- 문제7.
-- 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
-- (38건)
-- 1. 부서별 평균 급여 조회
select  department_id,
        avg(salary)
from employees
group by department_id;
-- 2. 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회
select  employee_id "직원번호",
        first_name "이름",
        salary "급여"
from employees;
-- 3. 최종 정리
-- 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
select  employee_id "직원번호",
        first_name "이름",
        emp.salary "급여"
from employees emp, (select  department_id,
                             avg(salary) salary
                     from employees
                     group by department_id) avgsal
where emp.department_id = avgsal.department_id
and emp.salary > avgsal.salary;







