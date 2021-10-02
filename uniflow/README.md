# uniflow with MySQL

Starts uniflow with MySQL as database.

Default admin account is  

- email : `admin@uniflow.io`
- password: `admin`

## Start

To start uniflow with MySQL simply start docker-compose by executing the following
command in the current folder.

```
./install.sh
```

## Configuration

The default name of the database, user and password for MySQL can be changed in the [`api/.env`](api/.env) file in the current directory.
