-- +goose Up
create table dummy.clicks
(
    date      DateTime,
    user_id   Int64,
    banner_id String
) engine = MergeTree() order by user_id settings index_granularity = 2;

-- +goose Down
drop table dummy.clicks;