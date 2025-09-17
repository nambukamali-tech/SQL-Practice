use practiceDemo;
go

create or alter procedure dbo.get_Info
@Enrollment varchar(100) =  null,
@Subject_code varchar(100) = null
as
begin

set @Enrollment = nullif(LTRIM(RTRIM(@Enrollment)),'');
set @Subject_code = nullif(LTRIM(RTRIM(@Subject_code)),'');


select distinct sd.Register_No as Enrollment , sd.Student_Name , m.Mark, sb.Subject_code , sb.Subject_Name as paper_name,
case when m.Mark >= 70
then 'pass'
else 'fail'
end result

from Student sd inner join Mark m on sd.Register_No = m.Register_No
inner join Subject sb on m.Subject_code = sb.Subject_code
where (@Enrollment   is null or sd.Register_No  = @Enrollment)
      and (@Subject_code is null or sb.Subject_Code = @Subject_code)
	  
    order by sd.Register_No, sb.Subject_Code;
end;
go

exec dbo.get_Info;

exec dbo.get_Info @Enrollment = '1523314012' , @Subject_code = '318';