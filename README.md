
# JAX-RS - MySQL - Tomcat #
Sample REST service  running as docker container 

## Docker Compose
```
docker-compose up : to start
docker-compose down : to start

```

docker run -i -t --rm --name server --link db:db jrsaravanan/server

## Test application 

```
http://localhost:9090/person/

http://localhost:9090/person/service/v1/persontest

curl -i -H "Accept: application/json" http://localhost:9090/person/service/v1/persontest

curl -i -H "Accept: application/json" http://localhost:9090/person/service/v1/persontest/1
```

