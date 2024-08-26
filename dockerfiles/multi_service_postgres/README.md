# Multi Service Postgres

This allows a postgres intsance to be shared w/ multiple services while being able to add users w/o having to blow away persisted data from other services.

To add a user, simply run the following:

```sh
docker-compose exec -- postgres create_user.sh <user>
```

This will create a new user as well as a new database with the name given under `<user>`
