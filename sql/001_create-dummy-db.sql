-- +goose Up
create database if not exists dummy;

-- +goose Down
drop database dummy;
