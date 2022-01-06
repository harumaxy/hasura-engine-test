BEGIN;

insert into
    lessons (name, subject_area)
values
    ('テスト授業1', 'japanese'),
    ('テスト授業2', 'math'),
    ('テスト授業3', 'english');

insert into
    courses (course, class_)
values
    ('XXXX', 'AA'),
    ('YYYY', 'BB'),
    ('YYYY', 'CC') on conflict (course, class_) DO NOTHING;

COMMIT;

insert into
    lesson_course (lesson_id, course_id)
values
    (1, 1),
    (1, 2),
    (1, 3) on conflict (lesson_id, course_id) DO NOTHING;