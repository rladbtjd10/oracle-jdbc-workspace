 --1번
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, 순위
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE, RANK() OVER (ORDER BY (SALARY+(SALARY*(NVL(BONUS, 0))))*12 DESC) "순위"
           FROM EMPLOYEE E
           JOIN DEPARTMENT D ON(D.DEPT_ID = E.DEPT_CODE)
           JOIN JOB J ON(J.JOB_CODE = E.JOB_CODE))
WHERE ROWNUM <= 5;

--2번
SELECT DEPT_TITLE, SUM(SALARY)
FROM 





