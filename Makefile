run0:
	docker run --name mongo0 --network cluster --publish 27017:27017 -v `pwd`/db0:/data/db -v `pwd`/conf:/data/conf -d mongo:3.6.3-jessie --config /data/conf/mongod.conf
	
run1:	
	docker run --name mongo1 --network cluster --publish 27018:27017 -v `pwd`/db1:/data/db -v `pwd`/conf:/data/conf -d mongo:3.6.3-jessie --config /data/conf/mongod.conf

run2:
	docker run --name mongo2 --network cluster --publish 27019:27017 -v `pwd`/db2:/data/db -v `pwd`/conf:/data/conf -d mongo:3.6.3-jessie --config /data/conf/mongod.conf

run3:
	docker run --name mongo3 --network cluster --publish 27020:27017 -v `pwd`/db3:/data/db -v `pwd`/conf:/data/conf -d mongo:3.6.3-jessie --config /data/conf/mongod.conf

clean:
	docker rm -f mongo0 mongo1 mongo2 mongo3
	docker network rm cluster

build:
	GOOS=linux GOARCH=amd64 go build -o app main.go
	docker build -t app:latest .
	docker run --network cluster app:latest

setup:
	docker network create cluster	