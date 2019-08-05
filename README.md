# Dockerized Sixpack server, for a/b-testing

The Docker container contains sixpack and sixpack-web server environment.

## Deploying
Preparing a network for our environmet

* `docker network create net`


You need Redis

* `docker run --network net --name some-redis -d redis`


* Run `docker build --build-arg WEB=yes --build-arg API=yes --build-arg API=yes -t sixpack-full .`
* Run `docker run -t --name sixpack-full --network net -e SIXPACK_CONFIG_REDIS_HOST=some-redis -p 5000:5000 -p 5001:5001 sixpack-full`

or 

* Run `docker build --build-arg WEB=yes --build-arg API=no -t sixpack-api .`
* Run `docker build --build-arg WEB=no --build-arg API=yes -t sixpack-web .`
* Run `docker run -t --name sixpack-api --network net -e SIXPACK_CONFIG_REDIS_HOST=some-redis -p 5000:5000 sixpack-api`
* Run `docker run -t --name sixpack-web --network net -e SIXPACK_CONFIG_REDIS_HOST=some-redis -p 5001:5001 sixpack-web`


## Resources

* [Introduction page](http://sixpack.seatgeek.com)
* [Sixpack repo](https://github.com/seatgeek/sixpack)
