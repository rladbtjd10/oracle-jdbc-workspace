
  
 --1번
 SELECT STUDENT_NO "학번", STUDENT_NAME "이름", ENTRANCE_DATE "입학년도"
 FROM TB_STUDENT
 WHERE DEPARTMENT_NO = '002'
 ORDER BY ENTRANCE_DATE;
 
 --2번
 SELECT PROFESSOR_NAME, PROFESSOR_SSN
 FROM TB_PROFESSOR
 WHERE LENGTH(PROFESSOR_NAME) != 3;
 
  select * from TB_CLASS;
  select * from TB_CLASS_PROFESSOR;
  select * from TB_DEPARTMENT;
  select * from TB_GRADE;
  select * from TB_PROFESSOR;
  select * from TB_STUDENT;
 --3번
 SELECT PROFESSOR_NAME "교수이름", PROFESSOR_SSN "나이"
 FROM TB_PROFESSOR
 WHERE PROFESSOR_NAME LIKE '남자';
 

 
 
 
 
 
 
 
 
 
 
 