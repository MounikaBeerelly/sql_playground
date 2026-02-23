1. find first word of the string

select substr('Oracle Corporation India',1, instr('Oracle Corporation India',1,1)-1) from dual;

2. Replace the first occurance of the string

select
    concat(
        replace(substr('madam',1,instr('madam','a',1,1)),'a','i'),
        substr('madam',instr('madam','a',1,1)+1)
    )
    from dual;
