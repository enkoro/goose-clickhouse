-- +goose Up
insert into dummy.clicks (date, user_id, banner_id) values
    (now(), 0, 'qwe'),
    (now(), 1, 'asd'),
    (now(), 2, 'zxc'),
    (now(), 3, 'wer'),
    (now(), 4, 'sdf'),
    (now(), 5, 'xcv'),
    (now(), 6, 'rty'),
    (now(), 7, 'fgh'),
    (now(), 8, 'vbn'),
    (now(), 9, 'qaz');

-- +goose Down
truncate table dummy.clicks; 