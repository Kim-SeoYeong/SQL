/* Practice05 */
/* 혼합 SQL 과제 */


-- 문제1.
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
-- 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
-- (45건)

select  first_name "이름",
        manager_id "매니저아이디",
        commission_pct "커미션비율",
        salary "월급"
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;



-- 문제2. 
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
-- 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-- -조건절비교 방법으로 작성하세요
-- -급여의 내림차순으로 정렬하세요
-- -입사일은 2001-01-13 토요일 형식으로 출력합니다.
-- -전화번호는 515-123-4567 형식으로 출력합니다.
-- (11건)

-- 1. 각 부서별로 최고의 급여를 조회
select  department_id,
        max(salary)
from employees
group by department_id;

-- 2. 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
-- 전화번호(phone_number), 부서번호(department_id) 를 조회
-- -급여의 내림차순으로 정렬하세요
-- -입사일은 2001-01-13 토요일 형식으로 출력합니다.
-- -전화번호는 515-123-4567 형식으로 출력합니다.
select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        to_char(hire_date, 'YYYY-MM-DD DAY') "입사일",
        replace(phone_number,'.','-') "전화번호",
        department_id "부서번호"
from employees
order by salary desc;

-- 3. 최종 조회
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
-- 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-- -조건절비교 방법으로 작성하세요
select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        to_char(hire_date, 'YYYY-MM-DD DAY') "입사일",
        replace(phone_number,'.','-') "전화번호",
        department_id "부서번호"
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;



-- 문제3
-- 매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-- -통계대상(직원)은 2005년 1월 1일 이후의 입사자 입니다.
-- -매니저별 담당직원들의 평균급여가 5000이상만 출력합니다.
-- -매니저별 담당직원들의 평균급여의 내림차순으로 출력합니다.
-- -매니저별 담당직원들의 평균급여는 소수점 첫째자리에서 반올림 합니다.
-- -출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
-- (9건)

-- 1. 매니저별 담당직원들의 평균급여 최소급여 최대급여 조회
-- -통계대상(직원)은 2005년 1월 1일 이후의 입사자 입니다.
-- -매니저별 담당직원들의 평균급여는 소수점 첫째자리에서 반올림 합니다.
select  emp.manager_id "매니저아이디",
        round(avg(emp.salary),1) "매니저별평균급여",
        min(emp.salary) "매니저별최소급여",
        max(emp.salary) "매니저별최대급여"
from employees emp, employees man
where emp.manager_id = man.employee_id
and emp.hire_date >= '05/01/01'
group by emp.manager_id;

-- 2. 최종 쿼리문을 위해 employees 테이블과 다시 조인
select  manSal."매니저아이디",
        em.first_name "매니저이름",
        manSal."매니저별평균급여" "매니저별평균급여",
        manSal."매니저별최소급여" "매니저별최소급여",
        manSal."매니저별최대급여" "매니저별최대급여"
from (select  emp.manager_id "매니저아이디",
              round(avg(emp.salary),1) "매니저별평균급여",
              min(emp.salary) "매니저별최소급여",
              max(emp.salary) "매니저별최대급여"
      from employees emp, employees man
      where emp.manager_id = man.employee_id
      and emp.hire_date >= '05/01/01'
      group by emp.manager_id) manSal, employees em
where mansal."매니저아이디" = em.employee_id
and mansal."매니저별평균급여" >= 5000
order by mansal."매니저별평균급여" desc;




-- 문제4.
-- 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 
-- 매니저(manager)의 이름(first_name)을 조회하세요.
-- 부서가 없는 직원(Kimberely)도 표시합니다.
-- (106명)
select  emp.employee_id "사번",
        emp.first_name "이름",
        dep.department_name "부서명",
        man.first_name "매니저의이름"
from employees emp
left outer join departments dep on emp.department_id = dep.department_id
inner join employees man on emp.manager_id = man.employee_id;




-- 문제5.
-- 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
-- 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
--1. 2005년 이후 입사한 직원 사번, 이름, 부서명, 급여, 입사일을 조회
select  employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from employees emp, departments dep
where emp.department_id = dep.department_id
and hire_date >= '05/01/01';

--2. rownum으로 순서대로 조회
select  rownum,
        employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from (select  employee_id,
              first_name,
              department_name,
              salary,
              hire_date
      from employees emp, departments dep
      where emp.department_id = dep.department_id
      and hire_date >= '05/01/01') o
order by hire_date asc;

-- 3. 최종 조회
-- 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
-- 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
select  rm,
        employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from (select    rownum as rm,
                employee_id,
                first_name,
                department_name,
                salary,
                hire_date
        from (select  employee_id,
                      first_name,
                      department_name,
                      salary,
                      hire_date
              from employees emp, departments dep
              where emp.department_id = dep.department_id
              and hire_date >= '05/01/01'
              order by hire_date asc) o
        ) result
where rm >= 11
and rm <= 20;




-- 문제6.
-- 가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
select emp.first_name || ' ' || emp.last_name "직원이름",
       emp.salary "연봉",
       dep.department_name "부서이름",
       emp.hire_date
from employees emp, departments dep
where emp.department_id = dep.department_id
and emp.hire_date = (select max(hire_date)
                     from employees);  




-- 문제7.
-- 평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 
-- 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.

-- 1.부서별 평균연봉 조회
select department_id,
       avg(salary) 
from employees
group by department_id;

-- 2.부서별 가장 높은 평균연봉 조회
select max(avg(salary))
from employees
group by department_id;

--3. 직원번호(employee_id), 이름(firt_name), 
-- 성(last_name)과  업무(job_title), 연봉(salary)을 조회
select employee_id "직원번호",
        first_name "이름",
        last_name "성",
        salary "연봉",
        job_title "업무"
from employees emp, jobs jo
where emp.job_id = jo.job_id;

-- 4. 1+2 내용
select aSal.department_id,
       aSal.avgSal
from (select   department_id,
               avg(salary) avgSal 
      from employees
      group by department_id) aSal, (select max(avg(salary)) maxSal
                                     from employees
                                     group by department_id) mSal
where aSal.avgSal = mSal.maxSal;

-- 5. 최종 조합
select employee_id "직원번호",
        first_name "이름",
        last_name "성",
        salary "연봉",
        job_title "업무"
from employees emp, jobs jo, (select aSal.department_id,
                                     aSal.avgSal
                              from (select department_id,
                                           avg(salary) avgSal 
                                    from employees
                                    group by department_id) aSal, (select max(avg(salary)) maxSal
                                                                   from employees
                                                                   group by department_id) mSal
                              where aSal.avgSal = mSal.maxSal) resultSal
where emp.job_id = jo.job_id
and emp.department_id = resultSal.department_id;




-- 문제8.
-- 평균 급여(salary)가 가장 높은 부서는? 

-- 1. 부서별 평균 급여 조회
select  department_id,
        avg(salary)
from employees
group by department_id;

-- 2. 부서별 평균급여 중 가장 높은 값
select max(avg(salary))
from employees
group by department_id;

-- 3. 1+2 합침
select aSal.department_id,
       aSal.avgSal
from (select  department_id,
              avg(salary) avgSal
      from employees
      group by department_id) aSal, (select max(avg(salary)) maxSal
                                     from employees
                                     group by department_id) mSal
where aSal.avgSal = mSal.maxSal;
-- 4. 부서명 조회
select department_name
from departments;

-- 5. 최종 조회값
-- 평균 급여(salary)가 가장 높은 부서는? 
select dep.department_name
from departments dep, (select aSal.department_id,
                              aSal.avgSal
                       from (select  department_id,
                                     avg(salary) avgSal
                             from employees
                             group by department_id) aSal, (select max(avg(salary)) maxSal
                                                            from employees
                                                            group by department_id) mSal
                       where aSal.avgSal = mSal.maxSal) resultSal
where dep.department_id = resultsal.department_id;



-- 문제9.
-- 평균 급여(salary)가 가장 높은 지역은? 

-- 1. 지역 조회
select region_name
from regions;

-- 2. 지역별 평균급여 조회
select  avg(employees.salary),
        regions.region_name
from employees, departments, locations, countries, regions
where employees.department_id = departments.department_id
and departments.location_id = locations.location_id
and locations.country_id = countries.country_id
and countries.region_id = regions.region_id
group by regions.region_name
order by avg(employees.salary) desc;

-- rownum으로 가장 위에를 조회하자
select  rownum,
        result.region_name
from (select  avg(employees.salary),
              regions.region_name
      from employees, departments, locations, countries, regions
      where employees.department_id = departments.department_id
      and departments.location_id = locations.location_id
      and locations.country_id = countries.country_id
      and countries.region_id = regions.region_id
      group by regions.region_name
      order by avg(employees.salary) desc ) result
where rownum = 1;




-- 문제10.
-- 평균 급여(salary)가 가장 높은 업무는? 
-- 1. 업무명 조회
select job_title, job_id
from jobs;
-- 2. 업무아이디별 평균 급여
select  job_id,
        avg(salary)
from employees
group by job_id;
-- 3. 업무아이디별 가장 높은 평균급여
select max(avg(salary))
from employees
group by job_id;
-- 4. 2 + 3 합치기
select  avgSal.job_id,
        avgSal.aSal
from (select  job_id,
              avg(salary) aSal
      from employees
      group by job_id) avgSal, (select max(avg(salary)) mSal
                                from employees
                                group by job_id) maxSal
where avgSal.aSal = maxSal.mSal;
--5. 최종본 조회
select job_title
from jobs jo, (select  avgSal.job_id,
                       avgSal.aSal
               from (select  job_id,
                             avg(salary) aSal
                     from employees
                     group by job_id) avgSal, (select max(avg(salary)) mSal
                                               from employees
                                               group by job_id) maxSal
               where avgSal.aSal = maxSal.mSal) resultSal
where jo.job_id = resultSal.job_id;

/*---------10번 문제 또다른 방법(rownum)방식으로 풀기-------------*/
-- 1.업무별 평균급여를 내림차순으로 조회함
select  jobs.job_title,
        avg(employees.salary)
from employees, jobs
where employees.job_id = jobs.job_id
group by jobs.job_title
order by avg(employees.salary) desc;

-- 2. rownum을 이용하여 최종값 조회
select  rownum,
        resultSal.job_title
from jobs jo, (select   jobs.job_title,
                        avg(employees.salary)
                from employees, jobs
                where employees.job_id = jobs.job_id
                group by jobs.job_title
                order by avg(employees.salary) desc) resultSal
where rownum = 1;






