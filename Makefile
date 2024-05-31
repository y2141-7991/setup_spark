Arguments := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

%::
	@true

clean:
	docker container rm -f ${shell docker ps -aq --filter name=setup_spark-spark-worker-*}
	docker rm -f da-spark-history
	docker rm -f da-spark-master

build:
	docker build -t da-spark-image .

# build-nc:
# 	docker-compose build --no-cache

# build-progress:
# 	docker-compose build --no-cache --progress=plain

run:
	docker compose up

run-scaled:
	docker compose up --scale spark-worker=$(Arguments)

submit:
	docker exec da-spark-master spark-submit --master spark://spark-master:7077 --deploy-mode client ./apps/$(app)

hello:
	@echo "Hello, $(Arguments)!"