
create table members(
    id varchar2(20),
    pwd varchar2(20),
    email varchar2(50)
);
insert into members values('user1', 'user1', 'user1@email.com');
commit;

select*from members;