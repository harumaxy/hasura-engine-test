CREATE TYPE subject_area AS ENUM (
    'japanese',
    'math',
    'english',
    'science',
    'social_studies'
);

CREATE TYPE live_status AS ENUM ('ready', 'started', 'stopped');

-- 授業
create table lessons(
    id serial primary key,
    name text not null,
    subject_area subject_area not null,
    start_at timestamp not null default now(),
    end_at timestamp not null default now() + cast('1 hours' as interval),
    live_status live_status not null default 'ready'
);

-- コース & クラス
create table courses(
    id serial primary key,
    course text not null,
    class_ text not null,
    unique(course, class_)
);

-- Many to Many Relation
create table lesson_course(
    lesson_id integer not null,
    course_id integer not null,
    foreign key (lesson_id) references lessons(id),
    foreign key (course_id) references courses(id),
    unique (lesson_id, course_id),
    primary key (lesson_id, course_id)
);

create view lesson_course_junction as
SELECT
    l.id as id,
    name,
    subject_area,
    start_at,
    end_at,
    live_status,
    course,
    class_
from
    lessons as l
    JOIN lesson_course as lc on l.id = lc.lesson_id
    JOIN courses as c on lc.course_id = c.id