/*
* rownum 
*/

-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
-- rownum이 order by 보다 먼저 생겨서 번호가 섞인다.
select  rownum,
        employee_id,
        first_name,
        salary
from employees
order by salary desc;

-- 정렬하고 rownum 을 사용
select  rownum,
        o.employee_id,
        o.first_name,
        o.salary
from (select  emp.employee_id,
              emp.first_name,
              emp.salary
      from employees emp
      order by salary desc) o   --> salary로 정렬되어있는 테이블
where rownum >= 1               --> where 절 조건이 2부터 값이 나오지않음.
and rownum <=5;


--일련번호 주고 바로 조건을 판단해서
select  ro.rm,
        ro.employee_id,
        ro.first_name,
        ro.salary
from (select  rownum as rm,
              o.employee_id,
              o.first_name,
              o.salary
      from (select  emp.employee_id,
                    emp.first_name,
                    emp.salary
            from employees emp
            order by salary desc) o
     ) ro
where ro.rm >= 11
and ro.rm <= 20;


-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
-- 1. 07년에 입사한 직원중 급여가 많은 직원
select  hire_date,
        employee_id,
        first_name,
        salary
from employees
where hire_date between '07/01/01' and '07/12/31'
order by salary desc;


-- 2. rownum을 이용해서 일단 순서대로 조회
select  rownum,
        employee_id,
        first_name,
        salary
from (select  hire_date,
              employee_id,
              first_name,
              salary
      from employees
      where hire_date between '07/01/01' and '07/12/31'
      order by salary desc) hire;


-- 3. 최종 조회
-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
select  hirerow.rm,
        hirerow.employee_id,
        hirerow.first_name,
        hirerow.salary,
        hirerow.hire_date
from (select  rownum as rm,
              hire.employee_id,
              hire.first_name,
              hire.salary,
              hire.hire_date
      from (select  emp.employee_id,
                    emp.first_name,
                    emp.salary,
                    emp.hire_date
            from employees emp
            where hire_date between '07/01/01' and '07/12/31'
            order by salary desc) hire 
     ) hirerow
where rm >= 3
and rm <= 7;














