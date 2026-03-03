use student_management;

create table class (
	ClassID int not null auto_increment primary key,
	ClassName VARCHAR(60) not null,
	StartDate DATETIME not null,
	Status BIT
)

create table Student (
	StudentId INT not null auto_increment primary key,
	StudentName VARCHAR(30) not null,
	Address VARCHAR(50),
	Phone VARCHAR(50),
	Status BIT,
	ClassID INT not null,
	foreign key (ClassID) references Class (ClassID)
)

create table Subject (
	SubID INT not null auto_increment primary key,
	SubName VARCHAR(30) not null,
	Credit tinyint not null default 1 check (Credit >=1),
	Status BIT default 1
)

create table Mark (
	MarkID INT not null auto_increment primary key,
	SubID INT not null,
	StudentId INT not null,
	Mark FLOAT default 0 check (Mark between 0 and 100),
	ExamTimes tinyint default 1,
	unique (SubID, StudentId),
	foreign key (SubID) references Subject (SubID),
	foreign key (StudentId) references Student (StudentId)
)

INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
 (2, 'C', 6, 1),
 (3, 'HDJ', 5, 1),
 (4, 'RDBMS', 10, 1);

INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
 (1, 2, 10, 2),
 (2, 1, 12, 1);

// Hiển thị danh sách tất cả các học viên
select * from student;

// Hiển thị danh sách các học viên đang theo học.
select * from student where status = true;

// Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
select * from subject where Credit < 10;

// Hiển thị danh sách học viên lớp A1
select S.StudentId, S.StudentName, C.ClassName 
from student S join class C 
on S.ClassID = C.ClassID
where C.ClassName = 'A1';

// Hiển thị điểm môn CF của các học viên.
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId 
join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';

--------------------------------------------------------------
Homework1:

// Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT *
FROM Student
WHERE StudentName LIKE 'h%';

// Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

// Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

// Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

// Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
SELECT S.StudentName, Sub.SubName, M.Mark
FROM Mark M
JOIN Student S ON M.StudentId = S.StudentId
JOIN Subject Sub ON M.SubId = Sub.SubId
ORDER BY M.Mark DESC, S.StudentName ASC;

--------------------------------------------------------------
Homework2:

// Hiển thị số lượng sinh viên ở từng nơi
select Address, count(StudentId) as 'Số lượng sinh viên'
from student group by Address;

// Tính điểm trung bình các môn học của mỗi học viên
select S.StudentId, S.StudentName, AVG(Mark)
from Student S join Mark M on S.StudentId = M.StudentId
group by S.StudentId, S.StudentName

// Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
select S.StudentId, S.StudentName, AVG(Mark)
from Student S join Mark M on S.StudentId = M.StudentId
group by S.StudentId, S.StudentName
having avg(Mark) >=10;

// Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select S.StudentId, S.StudentName, AVG(Mark)
from Student S join Mark M on S.StudentId = M.StudentId
group by S.StudentId, S.StudentName
having avg(mark) >= all (select avg(mark) from Mark group by mark.StudentId);

--------------------------------------------------------------
Homework 3:
// Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from subject 
where credit = (select max(credit) from subject);

// Hiển thị các thông tin môn học có điểm thi lớn nhất.
select distinct SubName
from subject sub
join mark M on M.SubID = sub.SubID
where M.mark = (select max(mark) from mark)

// Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.StudentId, s.StudentName, avg(m.mark) as avgmark
from student s
left join mark m on m.StudentId = s.StudentId 
group by s.StudentId, s.StudentName 
order by avgmark desc;


















































































































































