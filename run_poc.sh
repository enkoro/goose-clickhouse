#!/bin/bash
docker compose up -d --no-deps --build && docker compose rm -fsv
