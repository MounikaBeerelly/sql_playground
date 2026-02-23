## Functions

1. **Single Row**
    1. **Numeric Functions** : accept only numerics as input
        1. `CEIL` 
            - accept decimal value as input and returns nearest smallest integer which is greaterthan or equal to the given value.
            - ceil(n)
        2. `FLOOR` 
            - accept decimal value as input and returns nearest largest integer which is lessthan or equal to the given value.
            - floor(n)
        3. `MOD`
            - find the reminder
            - mod(n1,n2)
        4. `ROUND`
            - Rounding the values to the specified number of decimal positions.
            - round(n,position)
            - round(22.346,2) => 22.35
        5. `TRUNC`
            - similar to Round function. But after the position value is greater than 5, it won't add any value.
            - trunc(n,position)
            - trunc(22.346,2) => 22.34
        6. `SQRT`
            - sqrt(n)
        7. `POWER`
            - power(n1,n2)
    2. **Char functions** : accept only characters as input
        1. `LOWER` 
            - convert data into lowercase
            - lower(data)
        2. `UPPER` 
            - convert data into uppercase
            - upper(data)
        3. `INITCAP` 
            - convert first letter to uppercase.
            - initcap(data)
        4. `SUBSTR`
            - substr(str,m,n)
                - str - actual string
                - m - starting position
                - n - number of characters to display
                - select substr('mounika',2,3) from dual;
        5. `INSTR` - find the particular character position
            - instr(str,char,m,n)
                - str : actual string
                - char : which character you want to search
                - m - from which position you want to search
                - n - which occurance you want 
            - select instr('oracle corporation','or',2,2) from dual;
        6. `REPLACE` - replace one word with another
            - replace(str,'str1','str2')
            - select replace('Mounika','k','c') from dual;
            -  select 'Mounika' OrgStr,     replace('Mounika','k','c') Replace from dual;
        7. `LPAD and RPAD` - adds extra characters to the string
            - lpad(str1, n,str2)
                - str1 - actual string
                - n - length
                - str2 - adding characters
            - select lpad('mounika',10,'*') from dual; // ***mounika
            - select rpad('mounika',10,'*') from dual; //mounika***
        8. `LTRIM, RTRIM and TRIM` - removing the characters
            - LTRIM - trim left side
            - RTRIM - trim right side
            - TRIM - trim both sides
            - LTRIM(char/string, set)
                - char/string - actual string
                - set - which characters want to remove
            - select LTRIM('xyxyz','xy') from dual; // z
            - select RTRIM('xyxyz','xy') from dual; // z
            - select TRIM(leading 's' from 'smiths') from dual;
            select TRIM(trailing 's' from 'smiths') from dual;
            - select TRIM(both 's' from 'smiths') from dual;
        9. `CONCAT` - Merge two strings as one string
            - concat(str1, str2)
            - select CONCAT('Mounika','Beerelly') from dual;
            - select 'oracle' || ' ' || 'corporation' from dual;
        10. `LENGTH` - find the number of characters
            - length(str)
            - select LENGTH('Mounika Beerelly') from dual; // 16
    3. **Date Functions** : accept only dates as input
        - `sysdate`: Gives today's date. It adds days to the date.
            - select sysdate from dual;
            - `select sysydate+1 from dual;` 
                - adds one day to the date.
        - `ADD_MONTHS`: Adding months to the date
            - select sysdate Today, ADD_MONTHS(sysdate,3) "3 months" from dual;
        - `MONTHS_BETWEEN`: find the months between two dates.
            - select '01-JAN-25' Today, '10-SEP-24' Past, MONTHS_BETWEEN('01-JAN-25','10-SEP-24') Months
             from dual;
        - `NEXT_DAY`: find the next day, when next sunday become we can use this function.
            - select sysdate today, NEXT_DAY(sysdate,'SUN') "SUNDAY" from dual;
        - `LAST_DAY`: print last day of month of the given date.
            - select sysdate Today, LAST_DAY(sysdate) Lastday from dual;
    4. **Conversion Functions** : converting one format to another format.
        - **to_char:** converting number to character
            - Representing the data in more effective way.
            - Reporting is very easy.
            - select 2000 val, to_char(2000,'9,999') from dual;
            -  select empno, ename, to_char(sal,'9,999') from emp;
            - select 2000, to_char(2000,'9,999.99') from dual;
        - `G,D:` Group seperator, Decimal Seperator
            - select 2000, to_char(2000,'9G999D99') from dual;
            - select TO_CHAR(2000-3000, '9,999MI') from dual;
        - `date conversions`:
            - D - day in a week
            - DD - Day in the month 
            - DDD - Day in the year
            - DY - short format of day spelling
            - DAY - Full day
            - W - week in the month, 
            - WW - week in the year, 
            - MM - month number,
            - MON - short format of month spelling
            - MONTH - month full spelling
            - Q - Quarter
            - YY- short form of year, 
            - YYYY - year
            - YEAR - 
            - HH - 
            - HH24 - 
            - MI - 
            - SS -
            - AM -
            - select sysdate, to_char(sysdate, 'MM/DD/YY') from dual;
            - RN - for converting number to Roman numbers
    - **to_number**: convert into number format.
        - select to_number('2,000','9,999') from dual;
        -  select '1,432.00INR' num1, '3,123.00INR' num2,to_number( '1,432.00INR','9G999D99L', 'NLS_CURRENCY = INR') + to_number( '3,123.00INR', '9G999D99L', 'NLS_CURRENCY = INR') Result from dual;
            - G - group seperator
            - D -  Decimal seperator
            - C - currency
    - **to_date**: convert date to default format.
        - select to_date('2025-09-15','yyyy-mm-dd') from dual;
2. **Multiple Row** - these functions takes multiple rows as input and gives as single output.
    1. **Min** - find the minimum value from all the rows
    2. **Max** - maximum value
    3. **Sum** - Finding sum
    4. **Avg** - finding average
    5. **Count** - counting how many values are there
        - It will not calculate null values. It calculates actual values only.
    - **group by Clause** - According to the input it make the groups.
        - `select max(sal) from emp group by deptno;`
    - **having** - 
        - select deptno,max(sal) from emp group by deptno having max(sal)>=3000;
    - **order by** -  order the data
        - select * from emp order by sal;
        -  select * from emp order by sal desc;
3. **General Functions**