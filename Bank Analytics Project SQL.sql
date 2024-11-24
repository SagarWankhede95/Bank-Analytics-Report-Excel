create database bank_analytics;
use bank_analytics;
select *from finance_1;
select *from finance_2;
select count(*) As total_count_of_Member from finance_1;
select count(*) As total_count_of_Member from finance_2;

# KPI-1 year wise loan amount
select year(issue_D) As year_of_issue_D, sum(loan_amnt) as total_loan_amount  from finance_1
group by year_of_issue_D
order by year_of_issue_D;

# KPI-2 GRADE AND SUB GRADE WISE REVOL_BAL
select
grade,sub_grade, sum(revol_bal) as total_Revol_bal
from finance_1  inner join finance_2
on (finance_1.id = finance_2.id)
group by grade,sub_grade
order by grade, sub_grade;

# KPI-3 TOTAL PAYMENT FOR VERIFIED STATUS AND NON VERIFIED STATUS
select verification_status, 
concat("$",format (round(sum(total_pymnt)/10000000,2),2),"M") as totol_payment
from finance_1  inner join finance_2
on (finance_1.id = finance_2.id)
group by verification_status;

# KPI-4 STATE WISE AND LAST_CREDIT_PULL_D WISE LOAN STATUS
select addr_state, last_credit_pull_d, loan_status
from finance_1  inner join finance_2
on (finance_1.id = finance_2.id)
group by addr_state, last_credit_pull_d, loan_status
order by last_credit_pull_d;


# KPI-5 HOME OWENERSHIP VS LAST PAYMENT DATE STATUS

select home_ownership,last_pymnt_d, 
concat("$",format (round(sum(last_pymnt_amnt)/10000,2),2),"K") as totol_Amount
from finance_1  inner join finance_2
on (finance_1.id = finance_2.id)
group by home_ownership,last_pymnt_d
order by home_ownership desc,last_pymnt_d desc;
