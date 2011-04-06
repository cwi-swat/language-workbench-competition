
create table Car2 (
  _id int primary key,
  make varchar ,
  org varchar ,
  bla int foreign key references Car2(_id)
)

create table Car3 (
  _id int primary key,
  make varchar ,
  model varchar 
)

