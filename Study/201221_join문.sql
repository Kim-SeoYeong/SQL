/*
* join
*/

-- 기본 개념 equi join
select  first_name,
        department_name,
        em.department_id
from employees em, departments de
where em.department_id = de.department_id;


/* 모든 직원이름, 부서이름, 업무명 을 출력하세요 */
select  em.first_name,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id
order by em.job_id;


-- left 조인 (왼쪽 테이블을 기준으로 정렬된다)
select *
from employees em left outer join departments de
on em.department_id = de.department_id;


-- right 조인 (오른쪽 테이블을 기준으로 정렬된다)
select  em.department_id,
        em.first_name,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

-- right 조인 --> left 조인
select *
from departments de left outer join employees em
on de.department_id = em.department_id;


-- full outer join
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em full outer join departments de
on em.department_id = de.department_id;


select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id;
-- where em.deaprtment_id(+) = de.department_id(+) 이렇게 표현하지는 않는다. 오류.


-- alias 
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;


select *
from employees;


select  emp.employee_id, 
        emp.first_name,
        emp.manager_id,
        man.first_name manager
from employees emp, employees man
where emp.manager_id = man.employee_id;


-- 잘못된 사용예 --결과는 나오지만 salary와 location_id의 연관성이 없음.
select *
from employees em, locations lo
where em.salary = lo.location_id;
